-- @module sounds
-- Audio management tables
local streamtable = {}
local active_group = 1

-- foreground sounds system
local window_has_focus = true

-- Group audio IDs for management
local group_sounds = {}



-- Helper function to cleanup finished sounds from a group
local function cleanup_group(group)
  if not streamtable[group] then
    return
  end

  for i = #streamtable[group], 1, -1 do
    local sound_data = streamtable[group][i]
    if sound_data.stream then
      local status = sound_data.stream:IsActive()
      -- Remove streams that are stopped (0) - keep playing (1), stalled (2), paused (3)
      if status == 0 then
        -- Properly free the BASS stream resource
        sound_data.stream:Free()
        table.remove(streamtable[group], i)
      end
    else
      -- Remove entries with invalid streams
      table.remove(streamtable[group], i)
    end
  end

  -- Remove empty groups
  if #streamtable[group] == 0 then
    streamtable[group] = nil
  end
end


function find_sound_file(file)
  local path = require("pl.path")
  local sound_dir = config:get("SOUND_DIRECTORY")
  local file_base, ext = path.splitext(file)

  -- Check if the file already exists as-is
  if path.isfile(sound_dir .. file) then
    return sound_dir .. file
  end

  -- Check if the base filename already ends with a number
  local has_number = string.match(file_base, "%d+$")
  if has_number then
    return nil -- Don't randomize numbered files that don't exist
  end

  -- Use utils.readdir to find files with wildcards
  local search_pattern = sound_dir .. file_base .. "*" .. ext
  local search = utils.readdir(search_pattern)

  if search and type(search) == "table" and next(search) then
    local files = {}
    for filename, metadata in pairs(search) do
      if not metadata.directory then
        -- Store the full path to the file
        local full_path = sound_dir .. path.dirname(file)
        if path.dirname(file) ~= "." then
          full_path = full_path .. "/"
        end
        table.insert(files, full_path .. filename)
      end
    end

    if #files > 0 then
      -- Pick a random file from the list and return its full path
      return files[math.random(#files)]
    end
  end

  return nil
end

function play(file, group, interrupt, pan, loop, slide, sec, ignore_focus)
  local path = require("pl.path")
  group = group or "other"
  sec = tonumber(sec) or 1 -- 1 second fadeout by default

  if config:is_mute() then
    return -- Audio is muted.
  end -- if

  -- foreground sounds: check foreground sounds mode
  if not window_has_focus and not ignore_focus then
    local fsounds_option = config:get_option("foreground_sounds")
    local fsounds_enabled = fsounds_option.value or "yes"
    if fsounds_enabled == "yes" then
      -- When foreground sounds is enabled, don't play any new sounds when not in focus (except ignore_focus bypass)
      return
    elseif group == "ambiance" then
      -- When foreground sounds is disabled, still don't start new ambience when not in focus
      return
    end -- if
  end -- if

  local sfile
  local original_file = file

  -- Try classic audio first if enabled
  if config:get_option("classic_audio_mode").value == "classic" then
    local classic_file = string.gsub(file, SOUNDPATH, "classic_miriani/")
    sfile = find_sound_file(classic_file)
  end

  -- If no classic sound found, try the default path
  if not sfile then
    sfile = find_sound_file(original_file)
  end

  if not sfile then
    -- Fallback for the case where the file passed from mplay has the classic path already
    if string.find(original_file, "classic_miriani/") then
      local modern_file = string.gsub(original_file, "classic_miriani/", SOUNDPATH)
      sfile = find_sound_file(modern_file)
    end
  end

  if not sfile then
    if config:get_option("debug_mode").value == "yes" then
      notify("important", string.format("Unable to find audio file: %s", original_file))
    end
    return
  end

  -- Handle interrupt - stop all sounds in group if needed
  if interrupt and is_group_playing(group) then
    -- For ambiance, only interrupt if it's a different sound
    if group == "ambiance" then
      local should_interrupt = false
      if streamtable[group] then
        for _, sound_data in ipairs(streamtable[group]) do
          if sound_data.file ~= sfile then
            should_interrupt = true
            break
          end
        end
      end
      if should_interrupt then
        stop(group) -- Stop all sounds in the group
      end
    else
      -- For non-ambiance groups, always interrupt
      stop(group) -- Stop all sounds in the group
    end
  end

  -- Clean up finished sounds before adding new one
  cleanup_group(group)

  -- Get volume and pan from config for this group
  local vol = config:get_attribute(group, "volume") or 100
  local group_pan = config:get_attribute(group, "pan") or 0

  -- Use provided pan or group pan
  local final_pan = pan or group_pan

  -- Convert loop parameter
  local loop_mode = loop and 1 or 0

  -- Convert volume to decimal
  local volume = vol / 100.0

  -- Verify file exists before attempting to play
  if not path.isfile(sfile) then
    notify("important", string.format("Audio file not found: %s", sfile))
    return
  end

  -- Add loop flag if needed
  local flags = Audio.CONST.stream.auto_free
  if loop then
    -- Check if loop constant exists, otherwise use a common BASS loop flag
    local loop_flag = Audio.CONST.stream.loop or 4 -- BASS_SAMPLE_LOOP = 4
    flags = flags + loop_flag
  end

  local stream = BASS:StreamCreateFile(false, sfile, 0, 0, flags)

  -- Validate stream creation
  if type(stream) == "number" then
    notify("important", string.format("BASS audio failed to play: %s (error code %d)", sfile, stream))
    return
  end

  -- Set volume for this group
  stream:SetAttribute(Audio.CONST.attribute.volume, volume)

  -- Only set pan if it's not zero (avoid unnecessary panning)
  if final_pan ~= 0 then
    stream:SetAttribute(Audio.CONST.attribute.pan, final_pan / 100.0) -- Convert to -1 to 1 range
  end

  -- Play the stream
  stream:Play()

  -- Track the stream for group management
  add_stream(group, stream, original_file)


end -- play

function stop(group, option, slide, sec)
  sec = tonumber(sec) or 1 -- 1 second fade out

  if not streamtable then
    return 0
  end

  local streams = {}
  if not group then
    -- Stop all groups
    for g, files in pairs(streamtable) do
      for _, sound_data in ipairs(files) do
        streams[#streams + 1] = sound_data
      end
      streamtable[g] = nil
    end
  else
    -- Stop specific group
    if streamtable[group] then
      for _, sound_data in ipairs(streamtable[group]) do
        streams[#streams + 1] = sound_data
      end
      if option == 1 then
        -- Remove only the last sound
        table.remove(streamtable[group])
      else
        -- Remove all sounds from group
        streamtable[group] = nil
      end
    end
  end

  -- Stop the BASS streams
  for _, sound_data in ipairs(streams) do
    if sound_data.stream then
      if slide then
        -- Fade out (BASS doesn't have built-in fadeout, so just stop)
        sound_data.stream:Stop()
      else
        -- Stop immediately
        sound_data.stream:Stop()
      end
      -- Properly free the BASS stream resource
      sound_data.stream:Free()
    end
  end

  return 1
end -- stop

function add_stream(group, stream, file, volume)
  if not streamtable[group] then
    streamtable[group] = {}
  end

  streamtable[group][#streamtable[group] + 1] = {
    stream = stream,
    file = file
  }

  -- Cap at 10 sounds per group
  if #streamtable[group] > 10 then
    local old_sound = table.remove(streamtable[group], 1)
    if old_sound.stream then
      old_sound.stream:Stop()
      -- Properly free the BASS stream resource
      old_sound.stream:Free()
    end
  end
end -- add_stream

function is_group_playing(group)
  if not streamtable[group] then
    return 0
  end

  -- Clean up finished sounds
  cleanup_group(group)

  -- Check again after cleanup since cleanup_group might set streamtable[group] to nil
  if not streamtable[group] then
    return 0
  end

  return #streamtable[group] > 0 and 1 or 0
end -- is_group_playing

function slide_group(group, attr, value, time_ms)
  if not streamtable[group] then
    return
  end

  time_ms = time_ms or 1000

  -- Apply changes to all currently playing streams in this group
  for _, sound_data in ipairs(streamtable[group]) do
    if sound_data.stream then
      if attr == "volume" then
        sound_data.stream:SetAttribute(Audio.CONST.attribute.volume, value / 100.0)
      elseif attr == "pan" then
        sound_data.stream:SetAttribute(Audio.CONST.attribute.pan, value / 100.0)
      end
    end
  end
end -- slide_group

-- Focus handling functions

function pause_all_sounds()
  window_has_focus = false
  local fsounds_option = config:get_option("foreground_sounds")
  local fsounds_enabled = fsounds_option.value or "yes"

  -- Clean up finished streams first
  for group, _ in pairs(streamtable) do
    cleanup_group(group)
  end

  -- Always pause ambience when losing focus (regardless of foreground sounds setting)
  if streamtable["ambiance"] then
    for _, sound_data in ipairs(streamtable["ambiance"]) do
      if sound_data.stream then
        sound_data.stream:Pause()
      end
    end
  end

  if fsounds_enabled == "yes" then
    -- When foreground sounds is enabled, also stop all other sounds permanently
    for group, sounds in pairs(streamtable) do
      if group ~= "ambiance" then
        -- Stop all non-ambience sounds permanently
        for _, sound_data in ipairs(sounds) do
          if sound_data.stream then
            sound_data.stream:Stop()
            -- Properly free the BASS stream resource
            sound_data.stream:Free()
          end
        end
        streamtable[group] = nil -- Clear the group since sounds are stopped
      end
    end
  end
  -- When foreground sounds is disabled, only ambience is paused, other sounds continue playing
end

function resume_all_sounds()
  window_has_focus = true
  
  -- Always resume paused ambience when window regains focus (regardless of foreground sounds setting)
  if streamtable["ambiance"] then
    for _, sound_data in ipairs(streamtable["ambiance"]) do
      if sound_data.stream then
        sound_data.stream:Play()
      end
    end
  end
  -- Other sounds: when foreground sounds is off, they were never stopped so nothing to resume
  -- When foreground sounds is on, they were stopped permanently so nothing to resume
end

-- Global cleanup function for proper resource management
function cleanup_all_streams()
  for group, sounds in pairs(streamtable) do
    for _, sound_data in ipairs(sounds) do
      if sound_data.stream then
        sound_data.stream:Stop()
        sound_data.stream:Free()
      end
    end
  end
  streamtable = {}
end

-- Audio group management for volume controls
function forward_cycle_audio_groups()
  local groups = config:get_audio_groups()
  if type(groups) == "table" and #groups > 0 then
    active_group = active_group + 1
    if active_group > #groups then
      active_group = 1
    end
    local group_name = groups[active_group]
    local volume = config:get_attribute(group_name, "volume") or 0
    mplay("misc/mouseClick")
    Execute(string.format("tts_interrupt %s %d%%", group_name, volume))
  end
end

function previous_cycle_audio_groups()
  local groups = config:get_audio_groups()
  if type(groups) == "table" and #groups > 0 then
    active_group = active_group - 1
    if active_group < 1 then
      active_group = #groups
    end
    local group_name = groups[active_group]
    local volume = config:get_attribute(group_name, "volume") or 0
    mplay("misc/mouseClick")
    Execute(string.format("tts_interrupt %s %d%%", group_name, volume))
  end
end

function increase_attribute(attribute)
  local groups = config:get_audio_groups()
  if type(groups) == "table" and #groups > 0 then
    local group = groups[active_group]
    local current_val = config:get_attribute(group, attribute) or 0
    local new_val = math.min(current_val + 5, 100)
    config:set_attribute(group, attribute, new_val)

    -- Apply volume change to currently playing sounds in this group
    if attribute == "volume" then
      slide_group(group, "volume", new_val)
    elseif attribute == "pan" then
      slide_group(group, "pan", new_val)
    end

    if attribute == "volume" then
      Execute(string.format("tts_interrupt %s %d%%", group, new_val))
      mplay("misc/volume")
      -- Notify other plugins about volume change
      BroadcastPlugin(999, "audio_volume_changed|" .. group .. "," .. new_val)
    else
      notify("info", string.format("%s %s: %d", group, attribute, new_val))
    end
  end
end

function decrease_attribute(attribute)
  local groups = config:get_audio_groups()
  if type(groups) == "table" and #groups > 0 then
    local group = groups[active_group]
    local current_val = config:get_attribute(group, attribute) or 0
    local new_val = math.max(current_val - 5, 0)
    config:set_attribute(group, attribute, new_val)

    -- Apply volume change to currently playing sounds in this group
    if attribute == "volume" then
      slide_group(group, "volume", new_val)
    elseif attribute == "pan" then
      slide_group(group, "pan", new_val)
    end

    if attribute == "volume" then
      Execute(string.format("tts_interrupt %s %d%%", group, new_val))
      mplay("misc/volume")
      -- Notify other plugins about volume change
      BroadcastPlugin(999, "audio_volume_changed|" .. group .. "," .. new_val)
    else
      notify("info", string.format("%s %s: %d", group, attribute, new_val))
    end
  end
end

function toggle_mute()
  -- Check current mute state first
  local was_muted = config:is_mute()

  if was_muted then
    -- If currently muted, unmute first then play click
    local result = config:toggle_mute()
    mplay("misc/mouseClick", "notification")
    -- Restore current group volumes when unmuting (in case they changed while muted)
    for group, sounds in pairs(streamtable) do
      local current_group_volume = config:get_attribute(group, "volume") or 100
      for _, sound_data in ipairs(sounds) do
        if sound_data.stream then
          sound_data.stream:SetAttribute(Audio.CONST.attribute.volume, current_group_volume / 100.0)
        end
      end
    end
  else
    -- If currently unmuted, play click then mute by setting volume to 0
    mplay("misc/mouseClick", "notification")
    local result = config:toggle_mute()
    -- Set volume to 0 for all currently playing sounds when muting (they continue playing silently)
    for group, sounds in pairs(streamtable) do
      for _, sound_data in ipairs(sounds) do
        if sound_data.stream then
          sound_data.stream:SetAttribute(Audio.CONST.attribute.volume, 0.0)
        end
      end
    end
  end

  local status = config:is_mute() and "muted" or "unmuted"
  notify("info", "Audio " .. status)
end

function pause_group(group)
  if not streamtable[group] then
    return
  end

  for _, sound_data in ipairs(streamtable[group]) do
    if sound_data.stream then
      sound_data.stream:Pause()
    end
  end
end

function resume_group(group)
  if not streamtable[group] then
    return
  end

  for _, sound_data in ipairs(streamtable[group]) do
    if sound_data.stream then
      sound_data.stream:Play()
    end
  end
end

