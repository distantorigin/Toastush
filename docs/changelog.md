# Miriani-Next Changelog

## Version 4.2.16 (In Progress)

### Fixed
- Add commas and periods to the room name regular expression so places like "Outreach; The Outside World Communications Superstore, Starship Registry" would get caught.
- Trimmed silence from the beginning of the shake social sound.

### New
- Added a sound for when you listen to a fountain.
- Added two new robot dance sounds.

## Version 4.2.15

### New
- Added a sound for when babies are trapped in a container that is not a sling or other conveyance.
- Added sounds for when babies manage to escape confinement.

### Fixed
- Numbered sounds selected in `conf mutes` are now saved and muted individually instead of being combined under the unnumbered sound name.
- Sounds added by themes now respect mutes like any other sound.
- Fixed a crash that could happen while freeing finished audio streams, along with position tracking that was left behind for streams that had already gone away.
- `lg find` no longer locks up the client while it reads through old logs. It now works through them in chunks and reports results when it finishes.
- Channel history tracks unsaved messages by message instead of by position, so messages are saved in the right order and none are dropped once the in-memory window fills up. Memory-only mode also stops queueing saves it will never make.
- Older channel history loads again after a restart. Startup was wiping the bookkeeping that the database load had just filled in.
- Saving repeatedly in an external editor no longer drops saves to the debounce window.
- Closing an editor no longer leaves its file watcher running.
- The updater now downloads to a temporary file and checks that it is a real Windows executable before it replaces update.exe. A failed or truncated download leaves the existing updater alone, and the download gives up after two minutes instead of hanging.

### Changed
- Used some creative sound design to enhance sounds/misc/baby/babyMuffled to its full potential.
- Turning off "Keep channel history indefinitely" in conf buffers now asks for confirmation first.

## Version 4.2.14

### New
- Added a system for per-player text tones. Text tones allow you to set a custom sound that replaces the sound used for speech or private comms on an individual basis for each player. If you wish to add new sounds, create an "alternate" folder inside sounds/ and add them there; the in-client browser will see them. They must be formatted as Ogg Vorbis (.ogg). Type 'conf tones' to begin.
- Text tones now apply to OOC, SOOC, and ROOC. The communicator tone plays on top of the normal OOC sound instead of replacing it.

## Version 4.2.13

### New
- Added two new escalator ambiances.
- Moved the new wake up and disconnected sounds out of memescape to the main pack.

### Changed
- Exclude dances from the all socials menu in 'conf socials'.

## Version 4.2.12
### New
- Play a sound when a target ship moves from locked coordinates. (Thanks Emily!)
- Added sound support for the push (and by extention the shove) social.

### Changed
- Trimmed silence from socials/neuter/pimp2.

## Version 4.2.11

### New
- Added a begawk sound.
- Added some new dance sounds.

### Changed
- Quiet updates (via idle detection and upon login) no longer pop open the changelog when "Automatically open changelog after updates" is enabled.

### Removed
- Pulled newPost8 as it was meant to be in the memescape, which it already was. No need for duplicate sounds around here. No sir. Not us.
- Removed ship/combat/hullCritical and ship/combat/componentCritical sounds as they were identical to alarm/criticalHull and alarm/criticalComp.

## Version 4.2.10

### New
- Added sounds for viewing the starmap.
- Airlock elevator music lines are now gagged when the reduce flavor text option is on.

### Changed
- Airlock cycle start/complete messages are now treated like regular computer announcements.

## Version 4.2.09

### New
- Added a sound for glasses shattering when flipped off of a table.
- Added 'update reset', which deletes the local manifest and re-runs the updater to rebuild it.

## Version 4.2.08

### New
- Starmap filters now accept full names with the SM command, not just letters immediately after SM. This allows for things like sm debris or sm deb to see debris.
- Starmap filters now allow you to provide an optional filter after the type of object that will be applied to the category. For example, 'sm ships praelor' will filter starships down to ships with Praelor in the name.

### Fixed
- Sm.help no longer lists d = Debris as a shortcut. 'smd' has been the direction command for a while and never actually filtered debris.
- Ship enter/exit text is only gagged for your own actions now; other people's enter/exit lines are always shown regardless of the reduce flavor text setting (broken on June 5, 2026 in 04c01a8, when the reduce flavor text option was added to ship exit). Thanks to Mark for reporting this.

## Version 4.2.07

### New
- Added a pair of new boogie dance sounds at Gage's request.
- Added an Advanced options submenu at the bottom of the themes menu with two power-user toggles:
  - All themes mode: every discovered theme is treated as enabled, and any new theme folders you drop in are picked up automatically without needing to toggle them individually.
  - Force additive theme mode: replace-mode themes stop overriding the base pack and instead have their sounds pooled into the random shuffle alongside it.

### Changed
- Update-related settings have been moved out of General into their own category, sitting right after Auto Login in the main menu or via 'conf updates'.
- Renamed General Settings to General Options so it matches the other Option categories.

### Fixed
-In some possibilities where you had airlock cycle music, you were able to not get the end trigger and the music would go on indeffinitly. I added a timer to this music so that way if the trigger didn't appear after 20 seconds, the song would end.

## Version 4.2.06

### New
- Themes can declare their own socials in theme.json via a "socials" block, with optional "social_aliases" for shorthand action names. A theme can now register a categorized, toggleable social the base pack doesn't ship, without needing a Lua edit.
- Updated the sample theme with an example of the new socials block.
- Socials.lua no longer requires manual definition of genders; the scripts will automatically match to the correct gender if it's available in the corresponding socials/<gender> folder.

### Changed
- Moved socials with no audio files in the main sound set out of the base registry and into whichever theme actually provides the sound:
  - Music-only: bustamove, dust, handshake, jazzhands, lean, mash, shrug, smack, stroke.
  - Memescape-only: bawl, blubber, boggle, chuckle, drool, eep, flap, flip, grabfriendandshrieklikegirls, headscratch, hi5, itsatrap, jiggle, khan, mlaugh, mock, noogie, please, roar, spoon, twitch, weep, worship, yodel.
  - Declared in both themes: devil, flex, insult, jig, orgasm, what, why.
  - Aliases moved to memescape: gfas, gfaslg, gfs, gfslg, scratch, nosescratch.

### Fixed
-In some possibilities where you had airlock cycle music, you were able to not get the end trigger and the music would go on indeffinitly. I added a timer to this music so that way if the trigger didn't appear after 20 seconds, the song would end.
- Restored the noo social from the main sound pack for male and female characters. Its declared genders didn't match the files on disk, so gender-specific lookups missed the only file, which lives in the neuter folder.
- Gender-specific social sounds now fall back to neuter when no matching file exists in the main pack or any enabled theme.
- Cleaned up the same declaration mismatch on chuckle, eep, boggle, hi5, orgasm, and why.
- Fixed a bug where the "Automatically open changelog after updates" conf option would unreliably open the changelog.

## Version 4.2.05

### New
- Added sounds for the boogaloo, breakdance, grind and waltz dances.
- Added sound support for apartment buzzers. At the moment it uses the house doorbell sound but it can be changed if desired.
- Possibly made autoupdater not steal focus when it updates the soundpack when idle. This is lightly tested and might break things. There is also a new config option in General for those who want the client to auto restart or get nagged to restart when you return from being idle.
- On the dev channel, the soundpack now checks for updates via the updater binary on connect (debounced to once every 5 minutes) instead of waiting for the out-of-band "outdated" tag from the game, so fresh dev pushes are picked up right away. Stable users still rely on the OOB tag.
- Documented the 'update quietly' and 'update quietly <notify|auto>' in the update help commands list so people can call them at will. It should be noted that by using the commands, you forgo a yes/no prompt so make sure you truly want to update before typing them. We take no responsibility for what happens to you if you update in a bad area.
- Successful updates on the dev branch now have a shorter dedicated sound instead of theme music.

### Fixed
- Boosted the volume of the sound that plays when entering a nebula.
- The post-update plugin reload no longer fails to trigger in secondary sessions when multiple clients are running.

## Version 4.2.04

### New
- Added a sound for doorbells.
- The sound variants menu now indicates when a sound is being replaced by an enabled replace-mode theme, both in the variant list and on the per-sound selection dialog.
- Added a sound for failed handheld planetary survey scans.
- Added a Dances social category for the various in-game dance socials. Sound files will live under sounds/miriani/dances/.
- Added several sounds for dances.

### Fixed
- Replace-mode themes now always take precedence over variant preferences. Previously, sounds with a built-in default variant (such as the Santa box jingle bell) skipped the theme and played the base sound instead.
- The sound for drifting off to sleep no longer plays when Do Not Disturb is enabled.
- Yelling no longer prints twice.

## Version 4.2.03

### New
- Shouts from speakers whose name is colored red now play the announcement sound instead of the usual shout sound. In theory, this should help pick out host shouts from regular ones.
- Added a brand new theme, Music. It is a replacement-style theme and has a variety of different music cues to augment social and other sounds.
- Added a "View sounds" option to each theme's detail panel that shows every sound file the theme provides in a notepad window.
- Added an "Open folder" option to each theme's detail panel that opens the theme's directory in Windows Explorer.

## Version 4.2.02

### New
- Added new bulge, yess and noo sounds.
- Added a new ground Praelor explosion sound.
- Added sounds for turning on lamps/lights/flashlights/etc.

### Fixed
- Cleaned up a few sound files to remove silence from the front end.
- Properly exit the menu when choosing View Changelog in a theme after navigating to it via the menu.

### Changed
- Renumbered a few sounds.

### Removed
- Removed another duplicate sound.

## Version 4.2.01

### New
- Added a sound for the squeal social.
- Added more meme sounds for the Memescape theme.
- Added Stellar Surge, a small reflex minigame to kill time. Run 'ssurge' to play, and use 'ssurge help' for help. You can see overall progress with 'ssurge progress'. Warning: The majority of this was written by AI with minimal testing.

### Fixed
- Baby sounds no longer play when a player social (squeal, mainly) produces a visible line that matches a baby trigger.
- Made it so that any nonfunctional drive due to sensor interference should now play a sound.
- Fixed log manager not launching your text editor in certain cases.

### Removed
- Removed a few duplicate social sounds.

## Version 4.2.00

### New
- Added a sound for subwarp drive being nonfunctional due to sensor interference.
- Added a getting started wizard that runs automatically for new users. Currently, it walks through auto-login, social sounds, themes, volume, ambiance, screen reader settings, keybindings, and updates. You can run it again anytime with the 'setup' command or 'next:wizard'. Existing users will also be prompted with the wizard, but this should only happen once.
- Configuration is now stored in MUSHclient plugin state instead of .conf files, reverting to how Toastush originally stored settings before 4.0. The separate .conf files didn't offer much practical benefit. Legacy .conf files are automatically migrated and deleted on first load, and config is serialized into a variable automatically.
- Added a conf reset command to reset all settings to defaults.
- Added inline value setting for config options (e.g., 'conf room ambiance focused' to set ambiance to focused mode immediately).
- Updated the README to account for all changes and additions since Version 4.1.00.
- Added a sound theme system. Themes go in sounds/themes/ and can overlay or replace sounds from the base set. Two modes are supported: additive themes will pool their sounds with the defaults for random selection, and replace themes substitute matching sounds entirely. Toggle themes on and off from conf themes.
- Added a Memescape theme, Maintained by Jason Harkness with input from the community. This theme contains numerous meme-inspired and over-the-top sounds migrated out of the base set. Please provide feedback on what sounds may or may not belong in this theme! Enable with 'conf theme meme'.
- Selecting a theme in conf themes now opens a detail panel showing author, description, mode, and file count with size before you toggle it.
- Themes can include enable and disable sounds that play as feedback when you toggle them. Numbered variants are supported (enable1.ogg, enable2.ogg, etc.).
- Themes can include a changelog viewable from the detail panel; add changelog.md to a theme's directory.
- The theme detail panel now shows when the theme was last updated, based on the most recently modified file in its directory.
- Themes can override the disconnect sound (yawn+collapse) by providing their own disconnected sound files.
- Added "drifts off to sleep" to the disconnect trigger.
- Added a sample theme with a README explaining how to create your own.
- Added new meme headshake sound.
- Added enable and disable sounds for the Memescape theme.
- Added a sound file browser for navigating the sounds directory level by level from dialog menus.
- Added per-sound muting. Browse and select individual sounds to mute or unmute with conf mutes. Muting a sound silences all of its variants.
- Added smd command to show starships with relative direction (e.g. 3E 2S 1D).
- Added a Memescape changelog.

### Fixed
- The lg command will now respect the text editor set in 'conf gen editor'.
- Fixed dialog input leaking to the MUD when a conf or other dialog menu was active. Rewrote the input handler to use a single alias with a negative lookahead instead of the keep_evaluating + consumer alias approach that MUSHclient wasn't always evaluating in the same cycle.
- conf theme followed by a name now opens the detail panel instead of immediately toggling.
- Themes marked as hidden in their theme.json no longer show up in the conf menu.
- Sound variant preferences (conf sound variants) now take priority over replace-mode themes. If you've picked a specific variant for a sound, themes won't override it.

### Changed
- Sound groups and ignored sounds are now stored in the main config instead of separate files.
- The changelog (whatsnew / F2) now opens as a read-only document.
- Moved all meme and novelty social sounds out of the base set and into the Memescape theme. Remaining base sounds are renumbered to stay contiguous.
- Added a new "reaction" social category (approval, disapproval, confusion) containing: applaud, boggle, boo, clap, cower, golfclap, headdesk, headshake, hi5, mock, oic, oicic, ponder, twitch, and worship.
- Replaced an invalid command sound with a less abrasive one.

### Removed
- 'smd' no longer matches to debris.

## Version 4.1.35

### New
- Added new male giggle and ponder sounds.
- Added duck and goose sounds.
- Changed hum sound in preparation for sound theming.

### Fixed
- Fixed sound file matching so that socials with similar names (e.g. jig/jiggle, noo/noogie) no longer randomly play each other's sounds.

## Version 4.1.34

### Fixed
- Added the GFAS alias in the code to trigger a sound on the GRABFRIEND social.
- Relocated  slime machine sounds that were in the wrong place and fixed corresponding code.
- Reverted disconnect change to the original sound sequence for the time being.
-- Fixed the new disconnect sounds not playing, so they are now live.

### New
- Added sounds for the blubber, noogie, panic, prance, weep and worship socials.
- Added a new scream sound.
- Added a new male sneeze sound.
- Rather than playing a yawn then collapse sound when another player disconnects, the soundpack should choose from a disconnected sound.

## Version 4.1.33

### New
- Added sounds for the tap, bawl,  orgasm,and cower socials.
- Added a new whistle sound.
- Added sounds for throwing items from sent dispensers.
- Added a few new wake up sounds.
- Added new drool, flex, flip, jig and jiggle social sounds.
- Added new sounds for the what and scream socials.
- Added sounds for the drool and grabfriendandshrieklikegirls socials.
- Replaced all of the female moan sounds.

## Version 4.1.32

### New
- Added sounds for the highfive social.
- Replaced the old male chortle sound. I can revert if need be.
- Reverted male chortle sound back to the original.
- Moved new male chortle sound to mlaugh social.
- Added a sound for the new what social.

### Fixed
- In theory, a sound should play when you try to move an already moving ship, both in manual navigation and autopilot. Please call out if something seems off.

## Version 4.1.31
### New
- Added female ponder sound
- Added sounds for boggle social in both genders
- Replaced the female ponder sound due to multiple complaints of it sounding erotic.
- Added sounds for headshake, roll and shake socials.
- Added a sound for when the ship is already moving per Roran's request.

## Version 4.1.30

### New
- Added a socials volume control to the F10 volume cycling (master, sounds, environment, socials).
- Added an option under 'conf gen' to trim trailing spaces from input commands. For example, with this option enabled, "sc art " would become "sc art" before it was sent to the game.

## Version 4.1.29

### New
- Added a sound for diving air compressors completing the fill process.

## Version 4.1.28

### New
- Added sounds for sensor interruption pulses firing (and being hit by one).
- Added a sound for being hit by a disarmament pulse.
- Added distinct sounds for pulse weapons locking onto a target.
- Added a low oxygen warning sound for divers. (Thanks Mark!)
- After several months of testing, SSL is now enabled by default using port 1443 for new installs. To enable encrypted connections, you can press alt+enter to get to World Properties and on the IP address pane, change the port to 1443, checking the "Use SSL/TLS Encryption" checkbox that follows. Proxiani users need not change this, as the proxy already uses TLS.

### Fixed
- CDP, immobilization, and disarmament pulse firing triggers now respect the reduce spam option. Previously they always gagged the original text.

## Version 4.1.27

### New
- Added an alert sound for hull integrity compromise warnings. When hull is compromised but components are undamaged, the "no damage" sound is replaced by the hull warning alert.

### Changed
- The archaeology depth tracker now shows "dug" or "remaining" after the depth. If you walk to an artifact using the directional scanner and start digging without scanning again, it counts up (e.g., "0.50 feet dug"). If you scan at the dig site to get the actual depth, it counts down instead (e.g., "0.60 feet remaining"). You can scan at any point to switch.
- Note: Directional archaeology scanners no longer provide exact coordinates, only a direction. This was a server-side change, not a soundpack bug. The coordinates were never intended to be sent to players. As a result, the sound that played when arriving at the destination room will no longer trigger.

### Fixed
- The archaeology depth tracker extra now activates when arriving at artifact coordinates via the directional scanner. Previously, digging with a shovel, brush, pickaxe, or apparatus would not announce depth until manually scanning again.
- Fixed archaeology depth tracker showing 0.00 feet on every dig when arriving via the directional scanner due to a room tracking issue.

## Version 4.1.26

### Changed
- Raised volume on nebula detection sound.

### Fixed
- Fixed tradesman market trigger not firing for expired sales.

## Version 4.1.25
### New
- Added a new sm.count command, in line with what the sm.help command said should have been there. (Pull #5 - thanks Daniel!)

### Changed
- Changed the sound for entering a nebula.

## Version 4.1.24
### New
- Trimmed silence from a couple sounds.
- Boosted volume on bolt sound.
- Replaced spit sound so it's not so over the top.

### Changed
- "There are no damaged components." is now gagged when reduce spam mode is enabled.

## Version 4.1.23
### New
- Added a bolt sound for bolting items down.

### Fixed
- Properly updated certificate market rejex for starting a sale.

## Version 4.1.22
### New
- Added sounds for punching bags.
- Added code for the communicator linkConfirmed sound.
- Rewrote MushReader to help speech output. This is change 1 of 2 for testing. As this is the primary file for screen reader output, please report any changes, and expect odd behaviors. While I am fully confident it is foolproof tested, if you have speech that is not spoken, enormous amounts of continuing lag, or other issues that don't feel like regular trigger bugs, please ask Derrick over Miriani next metaf
- Updated to MUSHclient version 5.07+distantorigin.5:
  - Dramatically improved performance when receiving large blocks of output (e.g. room descriptions, status or cargo reports, long lists). The accessible output viewer now batches rapid lines together and updates the display once, instead of updating after every single line. In benchmarks, 200 lines of output went from taking ~1.9 seconds to ~0.14 seconds --  about 13x faster. This should noticeably reduce lag and speech delays when the server sends a lot of text at once.
  - Fixed the main window briefly flashing at default size before restoring to its saved position/maximized state on  startup.
- Replaced the ocean ambiance sound with a longer version.
- Added indoor ambiance for corridors and levels.

### Fixed
- Archaeology scanners detecting no nearby objects should now print this fact to the user.
- Archaeology tools should no longer give you negative numbers when your digging would in theory give you them. Miriani doesn't show you negatives, we won't either.
- Fixed the CHECK and ETA commands not playing the computer sound after we updated the eta to calculate correctly.
- Fixed highly decorative skeeball machines not playing sounds
- Tightened the internal camera feed trigger to avoid false matches on lines like math expressions.

## Version 4.1.21
### New

- Added game sounds for the rock machine.
- Added sounds for the grunt social.
- Added sounds for the bustamove social.

### Fixed
- Fixed hauling completion double trigger. It should now fire only once.
- Fixed socials like insult and flirt not showing their target when communication shortening is enabled.
- Fixed the repair ETA timer not updating when the repair time changes mid-repair.

## Version 4.1.20
### New
- Added sounds for the dunk tank game found on Venus.
- Added sounds for the hum social.
- Replace the "Your soundpack has been updated to version 'x.y.z'! You can download it here: ..." text with something more relevant to Miriani-Next users.
- Added a Mentions buffer for messages directly said to you.

### Fixed
- Fixed various regressions, like direct says, that would have previously broken through foreground sounds mode but no longer did.

## Version 4.1.19
### New
- Give up on Git-Cliff for now and make CI use the release notes from the changelog instead.

### Changed
- Shorten communication option now also applies to buffer history.
- Update many sound paths to point at their reorganized counterparts.

## Version 4.1.18

### New
- Added all new Chicken Chase arcade sounds. Thanks to Mark for requesting. This one was fun.
- Added two NPC voice prompts for Plump Paul
- Added ambiance for ferries.

### Changed
- Updated games.lua to reflect accurate sound path following misc sound re-organization
- Moved other game-related triggers to games.lua
- Set the infamous "say" trigger to continue evaluating. This allows for continued scripting with other triggers. Report anything going horribly wrong.

### Fixed
- Fixed disabling separate metafrequency buffers causing duplicate messages in the metaf buffer.

## Version 4.1.17
### Fixed
- Fix ambiance not immediately following power or config changes.

## Version 4.1.16
### New
- Added a zap for witnessing someone pick up a sanitation drone. Now it literally hurts to watch.
- Added AI generated NPC voices to NPCs on Acrylon, Angelus and Outreach
- Bump to MUSHclient version distantorigin.4:
    - Forward accelerator keys from the accessible output window to the companion world. This means that things like perusing history will work while focused on the output field.
  - Restore cursor position after Find dialog in output viewer.

### Changed
- Background ambiance (conf room 3) is now a tri-state setting: Off, Focused (default, previous behavior), or Always (keeps playing when the window is backgrounded).
- Anchored the trigger line for picking up a sanitation drone so no one can attempt spoofing it.

### Fixed
- Fixed the shorten communication option not working for ROOC and SOOC messages.
- Fixed scanning stations with parenthesized names like "Pax (Neutral Docking Station)" producing no output.
- Bump MUSHclient to version distantorigin.3, fixing the find dialog in the accessible output window to instantiate once again.

## Version 4.1.15
### New
- Quick buffers now support backward cycling with Alt+Shift+Q; Ctrl+Alt+Q is now used to add/remove them.
- Added a short range communication buffer.
- Added 'vol prev' command to cycle backward through volume categories, matching the existing 'vol next'.
- Hull damage and average component damage are now saved when scanning ships. Press Ctrl+H to repeat the last hull damage and Ctrl+D for component damage.
- Added sound for picking up sanitation drones.
- Play distinct sounds when scanning Krenelia (friendly) vs Ontanka (enemy) ships.
- Play error sound indiscriminately when a piped computer announcement contains "has been interrupted", hopefully covering all GATE/NAVI messages that may result.

### Changed
- Moved Do Not Disturb from Ctrl+D to Ctrl+Shift+D.

### Fixed
- Fixed cries and cry so they both call the cry sound
- Fixed up the permissiveness of the computer trigger so metafrequency transmissions (and other things) won't trigger holographic avatars.

## Version 4.1.14
### New
- Mute and speech are now reset when reloading the scripts, similarly to Do Not Disturb.
- Update MUSHclient to version distantorigin.2:
  - Added dark mode support for most of the UI. (Preferences coming soon!)
  - Added MCCP4 (Zstandard) compression support (telopt 88).
  - Upgraded accessible output viewer to RichEdit 4.1 for better performance.
  - Added a new shriek sound (Contributed by Gage)
- Added another male shriek sound.
- Added the computer warning sound when wavewarping stars.

### Fixed
- Fixed scan output showing "1 units away" instead of "1 unit away" when an object is exactly 1 unit away.
- Fixed scan misidentifying planets (e.g. Class Marine) as stars when their classification began with a star classification letter.

## Version 4.1.13
### New
- Boosted volume on quarters ambiance.
- Removed rocky5 and rocky6 ambiances as they were identical to other ones.
- Added exiting from a ship into space airlock exit sound
- Added more types for slime launchers
- Added sound for whimper.
- Added new scream sound and two wink sounds.
- Added sound for whine social.
- Removed a bunch of duplicate sounds. Thanks Mark for taking one for the team and seeing which ones were identical to others.

### Fixed
- Possibly fixed autoupdating and ctrl+U updating on windows to work more consistently from inside the client.
- Trimmed excess silence from flirt and why social sounds.
- Trimmed silence from wink1.

## Version 4.1.12
### New
- By request, added pizza song social
- Added yodel sound by request.
- Pointed a bunch of aliases for vomit to play the vomit sound.
- Added print_airlock_chime config option to control whether the airlock chime text is printed.
- Added sound variants for radio receiver transmission detected.
- Added option under conf gags to gag messages when others pilot in the room, independent of artifact hunting mode.
- Ported baby wail sounds to the wail social. Because they make me happy that's why.
- Added two new theme songs.
- Added sound for devil social.
- Added flirt and insult sounds.
- Removed yodel3 as it was the same as 1.

### Fixed
- Updated tradesman marketplace to support names like McKnight so sounds would play. Also updated the display to match the new rejex patterns, and tightened things up just a bit. I tested most things but stuff might be odd so if something is, please post on metaf.
- Fixed internal camera feed pattern.
- Fixed drawing and holstering with holsters that start with An instead of A.
- Fixed message board readers to play sounds for custom board readers.

## Version 4.1.11

### New
- Added sound for cake social.
- Added sound for pirate social.
- Added a new airlock chime sound variant and gagged the text output. The new variant is set as the default.
- Added songs category for social sounds (bears, cake, fire, horses, pirate). This category is disabled by default.

## Version 4.1.10

### New
- Added sound for air fresheners.
- Added sounds for choke and strangle.
- Boosted the volume of ship corridor ambiance.
- Added sounds for twirl social.
- Added a new invalid command sound.
- Pointed frenchkiss, makeout, smooch and snog socials to the kiss social sounds.
- Added I love Horses song for the horses social.
- Added sound for server shutdown announcements.
- Added sounds for the fire and bears song socials.

### Fixed
- Play the debris and blockade destroyed sounds when debris and blockades are destroyed.
- Sector notifications for unrecognized objects (like debris) now play a fallback computer sound.

## Version 4.1.09

### New
- Starship hits now count as activity for Artifact Hunting Mode.
- Added new sound for retch social.
- Add "Shorten repetitive computer announcements" option under conf gag. When enabled, verbose computer announcements are transformed into shorter forms: "Scans reveal the debris to be X." becomes "Salvaged X.", repair time estimates are simplified, and weapons locking onto empty space becomes "Nothing targeted." Disabled by default.
- Repairing components via unknown starships will now play the repair sound.
- Rename "Spam and Gag Filters" to "Gags and Substitutions" in conf.
- Component manifests and commodity listings emerging from consoles will now play the print sound.
- Added sound for pant social.

### Fixed
- Differentiate sound when your ship transmits or broadcasts a message.

## Version 4.1.08

### New
- Artifact Hunting Mode now plays audio feedback when engine silencing activates or deactivates. You'll hear a sound when the mode kicks in after inactivity and another when you start piloting again.
- Artifact Hunting Mode now prints "Engines silenced" when silencing activates.
- Add the hush command to immediately enter engine silence mode while in Artifact Hunting Mode. This is useful when you want to silence engines without waiting for the timeout.
- Add option to autosilence engines when the window loses focus in Artifact Hunting Mode. Configure with conf ship autosilence.

### Fixed
- Fix computer messages in pipe mode so the content after Control room reports triggers appropriate sounds.
- Play the correct transmit sound when your ship transmits a message over General Sector Communication.
- Fix camera feed corruption when messages contain parentheses.
- No longer print a message multiple times if it contains a URL.

### Removed
- Hyperlink_url2.xml plugin

## Version 4.1.07

### Fixed
- Fix critical damage sound playing on various other output like the CHARGE command.

## Version 4.1.06

### New
- Add coordinate formatting option to display space-separated coordinates (e.g., "3 3 3" instead of "3, 3, 3"). Enabled by default. Configure with conf ship 2.
- Add shower sounds (entering shower, water running, turning off).
- Add a Proxiani bypass commands option. Using this, you can configure a comma-separated list of commands (e.g., "atsm,pc") that will automatically be sent with a "px pass" prefix when Proxiani is detected. Configure with conf gen proxiani.
- Suppress repeated piloting action messages in artifact hunting mode. Messages like "Person inputs a series of commands into a navigation console" and "Person flicks a switch" are now suppressed for 30 seconds after the last occurrence. The cooldown resets on each repeat message and is per-person.
- Add keyboard typing sounds to weapon lock announcements.
- Add new weapons locked sound variant (now the default). The original sound is available as variant 1 in conf sound variants.
- Add option to vary hit sound volume based on Praelor ship class (smaller ships = quieter hits). Disabled by default. Configure with conf ship class.
- Add a potentially useless option under conf gen to sync random sounds using a time-based seed--everyone hears the same sound if the option is on. Disabled by default. You probably don't want to turn this on.
- Add hull and component critical sounds when viewing damage report. Plays when damage is between 80 and 99 percent.

### Changed
- Increase artifact hunting timeout to 150 seconds (approx. 2 and a half minutes).
- 1-unit range beep now plays when using scan filters (sch, sca, sco, etc.).

### Fixed
- Fix coordinate formatting not being applied to scan TTS interrupt.
- Fix metafrequency buffer names getting corrupted when messages contain brackets.
- Fix social hooks not playing for pluralized social names (e.g., "screams", "belches").

## Version 4.1.05

### Fixed
- Artifact hunting mode is now less invasive.
- Artifact hunting mode will now disable engine and drive sounds after 60 seconds instead of 30.
- Scanning while using all caps will no longer break scan formatting.
- Others walking after the soundpack freshly reloads will no longer fail to play step sounds.


## Version 4.1.04

### Fixed
- Don't intercept menu numbres in conf and other menus.

## Version 4.1.03

### New
- Play the scan sound for scan all.
- Add a sound for NAVI being aborted due to interdiction.
- Play targetDestroyed sound when the computer reports another ship has been destroyed.
- Add option to gag holographic avatar names in computer announcements (conf gag holo). This is disabled by default, so custom holographic avatar names will now be visible in computer announcements.
- Add self-destruct countdown sequence sounds (60s, 30s, 10s, 5-4-3-2-1, goodbye).
- Add Artifact Hunting Mode (conf ship artifact). When enabled, gags engine sounds (acceleration, deceleration, subwarp, slip, wavewarp, bias drive) unless you've been actively piloting or gunning in the last 30 seconds. Activity is detected from movement commands, targeting, weapon firing, and red alerts.
- Raise partial hit volume by 10%.

### Changed
- Wake on Red now also triggers on blue, purple, and orange alerts.
- Change locked on nothing sound.

### Fixed
- Handheld planetary surveyors that start with "an" will now play the correct sound upon being used.
- Partial hit sound now plays.
- Peering into another room no longer changes the background ambiance.

## Version 4.1.02

### New
- Update Bass to 2.4.18. Consequently, audio will now correctly follow the default device set in Windows.
- 'lg import' now supports time and date-based logs from VIP Mud.
- 'lg import' will fall back to modified date if it can't match a known pattern in the file name.
- Added sounds for eep, pose, jig and tapdance socials.
- Shortened several sounds that were on the longer side. The original versions will be reinstalled in version 4.2 with the optional memescape version of the pack.
- Update MUSHclient to version distantorigin.1.
- MUSHclient window will now size itself correctly when automatically opening the accessible output window.
- Formatted scan output for artifacts now includes the Type field, if applicable.
- Added repair timer notifications: get notified when repairs complete while outside engineering (conf ship repair). Press Ctrl+E to check the timer.
- Shiny new website at https://distantorigin.github.io/miriani-next/

### Changed
- Reorganized scan filter shortcuts: sca is now Average Component Damage, scc is Coordinates, scp is Identifiable Power Sources, scs is Cargo. Removed scf, scg, and scv.

### Fixed
- Planetary mining scan sound now stops if the drone isn't being held.
- Fixed wormhole speech interrupt not working due to curly braces in object name.

## Version 4.1.01

### New
- Added an 'lg import' command to import and rename log files from any client to match the Miriani Next naming convention (DD Month YYYY.txt). To use, copy your old log .txt files into the log directory shown when running the command, then run 'lg import' to scan and rename them. The importer recognizes dates from filenames in various formats: YYYY-MM-DD, DD-MM-YYYY, YYYYMMDD, month names (December 14 2025), and underscores instead of spaces. For files that only have a day number (like Proxiani's "9th, on port 1234.txt"), the year and month are extracted from the parent directory structure (e.g., 2025/01/).
- Added support for MCP local edit. This is primarily used by hosts for building and programming operations.
- Expose the client and its known version via the MCP client package.
- Play a random hop social if your walk style is set to hop or leap, similar to bounce.
- Add 'conf gen editor' to set your default text editor. By default, this is set to 'notepad.exe'.
- Boosted volume on frog social plus two oops sounds.
- Add 7 new footsteps for ducts and crawlspaces.
- Ambiances for prison cells and apartments.
- Ambiances should now be more resilient to reloads, stun time, DND, etc.
- You can now press CTRL+Shift+V to paste the contents of the clipboard with linebreaks turned into spaces.
- The Updater plugin now uses curl (instead of DoAsyncRequest) to reinstall the updater via the 'update reinstall' command. This mandates you have Windows 10 1804, released in April of 2018.
- Bump Updater to version 1.4.5 and begin including an app manifest to ensure Windows doesn't raise error 740 when not being run as admin.

## Version 4.1.00

### New
- Comprehensive README rewrite with improved organization, clearer installation instructions, and expanded documentation for all features. You can view the README at https://github.com/distantorigin/miriani-next/
- Complete overhaul of the ambiance system with a new rooms.lua module:
  - Three-tier room matching system: exact room names are checked first, then pattern matching, then fallback to room type from the game's environment flags.
  - Added documentation in rooms.lua explaining how to add new ambiances.
- New option to disable theme music at startup (conf gen theme).
- New option to shorten communication by removing verbs, e.g. "Player says" becomes "Player:" (conf gag short).
- Over 40 new ambiance sound files:
  - Starship rooms with variants: Bridge/Control Room (3 new variants), Engineering (3 new variants), Quarters (3 variants), Medical (2 variants), Escalator (2 variants).
  - Praelor ship rooms: 5 unique ambiance variants for Potateotons.
  - New location-specific ambiances: ACV cockpit, asteroid rover, asteroid surface, bias drive housing, combat drone bay, common area, crawlspace, deck, decontamination chamber, Deneii areas, dig site, docking bay, duct, hostile environment, mission rooms, pilot's lounge, generic planet surface, repair and rearm, salvager cockpit, Shadius station, simulation shop, spacesuit/EVA, and volcano/moon surface.
- New female social sounds: 8 laugh variants, 2 lol variants, 3 rofl variants.
- CI now builds offline installers by embedding the release ZIP into the launcher, giving us an automatically compiled binary for every release.
- Release artifacts and installer filenames now include version numbers. Dev builds use commit SHA for identification.
- Automatic changelog generation for releases using git-cliff.
- The updater is now open source and builds itself on GitHub using GitHub Actions: https://github.com/distantorigin/next-launcher

### Changed
- Consolidated direction sound mappings into rooms.lua.
- Direct conf commands that toggle options no longer display the menu afterward.

### Removed
- boggle and ponder social sounds for females.
- Secondary ship relay sound.
- fuzzyDeath4
## Version 4.0.17
### New
- Began work on automated GitHub builds and releases.
- Add airlock cycling music.
- Include "You notify flight control..." messages in spam reduction mode.
- Remove the config alias for conf.
- Added pimpslap and new hoot sounds.
- Added new squeak sound.
- Changed the wording on the intro message slightly in regard to watching development.
- Add Do not Disturb (DND) mode, which will disable all incoming sounds and speech. Toggle by typing 'dnd' or pressing CTRL+D.
- Add Wake on Red (conf gen wake) which will automatically turn off DND mode if the ship goes to red alert.
- Add a sound for GMU detecting stars.
- Add more LRScan sounds from the VIP Mud scripts
- Add salvagre power low and salvager power critical sounds.
- Boosted volume on low and critical salvager alerts.
- Added dedicated planetary survey start and complete sounds.
- Added sounds for please social.
- Added a new socials framework. See conf socials to control all aspects of social sounds. For those that want to add new socials, please review lua/miriani/scripts/socials.lua for details.
- Include volume, pan, and group in the sounds buffer.
- Added sound file updates to include pop, q and others.
- Added sounds for OIC and OICIC socials. These are in neuter until I can find ones to match to proper genders.
- Added a couple of requested gags for bulk salvaging
- Added sounds for bite, bap, howl, lick, thump and blink socials. 
- Added scream sounds back in since they can now be toggled on and off.
- Modified the ammo from containers trigger to support ones bought from Ceridwen and to support other custom ammo containers.
- Added new sound for noo social and one for squish.
- Added an option under 'conf buffers' to disable history persistence through restarts.
- Always play poke and nudge. Require_target option has been removed from socials.
- Replaced the handheld planetary surveyor start sound with the original MT Miriani version.
- Boosted volume on a few social sounds.
- Removed relay1, boosted volume on remaining relay.

### Fixed
- Properly import timestamps from the database so older messages don't show up as "Just now".
- Fix metafrequency labels to not break when other non-word symbols were added, such as hyphens or parentheses.
- Intelligently play a single anomaly sound even if you have GMU notifications enabled while using NAVI. (Previously this would play two alert sounds.)
- Delete buffers that are disabled from within conf buffers.

## Version 4.0.16
### New
- Channel history is now infinite, automatically saving and reloading through restarts. Buffer orderings are automatically saved and restored. Up to 10,000 messages are loaded into each buffer at startup, at which point messages beyond that will be lazy-loaded as you browse. Messages are saved to a channel_history_<world-id>..db file in your main MUSHclient directory. Bugs are sure to be afoot. Consider this to be entirely experimental.
- Added memory only mode for channel history that will always bypass the database.
- Added sounds to an action figure machine on Templar
- Added sound for bongo social
- Added sounds for quiet mode.
- Added spacesuit jet end sound.
- Gag soundpack ping spam in even more places for purposes of logging.

### Changed
- Changed spacesuit jet start sound.

## Version 4.0.15
### New
- Added sounds to a new action figure prize machine on NegraCaja.
- Added experimentalTLS support to MUSHclient. Enable it from the world preferences connection screen.
  - To enable, check the TLS Encryption checkbox and change the port from 1234 to 1443. Proxiani users should change the hostname to toastsoft.net.
- Added a new lg command interface to control the log manager plugin:
  - lg view opens today's log in your text editor
  - lg view <days> opens the log from N days ago
  - lg find <text> searches all logs with paginated, selectable results
  - lg stats shows log statistics (file count, size, lines, date range)
  - lg toggle enables/disables logging
- Added an RP buffer, which currently stores emotes and custom socials.
- Clean up baby triggers.
- Add originating_from_emote, which is used to check if a sound or line of text is originating from an emote.
- Emotes no longer trigger sounds.

### Fixed
- Updated the code so mission counters actually increases the number of missions instead of staying at absolute 0. I may also make it actually tell you it increases, but right now you can see total number of missions with the counters command
- Restored the ability to 'Find Output' in the accessible output window.
- The accessible output window will now relay events to its associated world while its in focus. This addresses the commonly seen problem where ambiance and other things wouldn't stop when moving away from the window if the output window was the current tab.
- The Lore import sound will now play when you have multiple files waiting.

### Removed
- Vlog alias

## Version 4.0.14

### New
- Added the notification of the Dev Metaf channel to the launch notifications of the soundpack. As mentioned in the message, this channel is for dev chatter only and will be changed if used for anything other than discussions of code or dev work. If you are interested in deving for the SP, this is also a good channel to express interest.

### Fixed
- Fixed sounds for archaeology when using directional, and non-directional scanners, especially in places where the sound wouldn't play if the artifact had a remote possibility or some variant of the fact of being nearby.
- Fixed storage bags for diving gear, armor storage, and spacesuit bags so they have a sound when wearing and removing. Note this won't work for custom items at this time.
- Fixed the point calculator helper for point units that don't have "portable point unit" in the name.

## Version 4.0.13

### Fixed
- Changed storage bag use to actually play a sound if the color was prefixed by an rather than just a.

### New
- Disable the autosay keyboard shortcut by default (Ctrl+Shift+A).
- Moved chuckle sound to socials/male and added a chuckle to socials/female.
- Added second female chuckle sound

### Fixed
- Call buffercheck() when moving to the top or bottom of a buffer. This will resolve issues where moving to the end of history and then backward might result in random placement instead of the item you expect.
- Fixed an issue where no artifact nearby would not play a sound due to an invalid trigger.
- Fixed an issue where launching atmospheric salvagers, among other things, would play the ship exit sound.

## Version 4.0.12

### New
- Omit soundpack_ping hooks from logs.
- Began adding sounds for air hockey. Right now they are copied from VIPMud but this will change on a future update.
- Sound for itsatrap and why socials.
- Play cannon sounds for gumdrop launchers.

### Fixed
- Fixed a bug where the airlock chime would play the ship enter sector sound when someone entered the airlock
- Fixed a sound error that was displayed to all users when Cert orders were completed on the marketplace.
- Made the its a trap social not play the sector exit sound when typing "itsatrap me"
- Fixed an error where the sound wouldn't play for Gadzook ships entering and leaving the sector

## Version 4.0.11

### New
- Add sounds for the green Santa Box (red alert jingle bells). You can set which version you hear from within the sound variants menu by typing conf variant.
- The accessible output window now properly associates to each world.
- The accessible output window now shows the world's name in the title.
- The accessible output window can no longer be closed and will hide itself instead upon users pressing CTRL+F4 (similarly to tabbing out of it).
- The accessibel output window now automatically instantiates itself.
- Added an option to clear the accessibel output window from the menu bar.
- Added new shock and headshake sounds, changed beep3 to bonk.
- Boosted the volume of mlaugh1 and added flap sound.
- Removed roundTime2 sound, as people were complaining about it.
- Added a new roundtime sound.
- Added new male giggle sound and two new theme music sounds.
- Moved scream sounds out of neuter and renamed them to various shrieks because I didn't account for people being obnoxious screaming on channels.
- Added new fart, poke and nudge sounds.
- Added new rountime and failed command sounds.
- Swapped the hoot sound for a much shorter one.
- Added new stun baton sounds and a new message board post sound.
- Added new beep sound and new oops sound.
- Added airguitar and new quack sounds.

### Fixed
- CTRL+Tab now works (regardless of your conf gen tab settings).
- The option to automatically launch the accessible output window has been inverted to toggle whether we *do not* open the output window.

### Changed
- The changelog will no longer prompt to save when it's closed.

## Version 4.0.10

### New
- Added bounce social sounds.
- Added sounds for the beep social as requested by Gage.
- Over a dozen new social sounds, added new fuzzy creature death screams, modified the ship relay channel sound to not be the same used for direct say, plus a bit of housekeeping.
- Social sounds for khan, spoon, frog, and no.
- Sound for toilets flushing.
- Sound for things being removed from you.
- Sound for leaving someone behind (You seem to have left X behind!)
- Sound for receiving coal from Santa.
- Sound for announcements from hosts.
- Sounds for fuzzy creatures slinking, being hit, and being killed.
- Sound for tunnel rats being shot.

### Changed
- The male snicker sound has been updated.

### Fixed
- The sound for another ship landing in front of you will now be played while on an asteroid.

## Version 4.0.09

### New
- Add find functionality (ctrl+f, f3, shift+f3) to the accessible output window. Regular expression searching is currently a work-in-progress.
- Added a label for the regexp help button in the default MUSHclient find dialog.

### Fixed
- Don't disable ECO_AUTOVSCROLL in the accessibel output window. This may address some of the selection issues some have been having.
- Add an extra clause for "into the airlock" to ensure follow directional audio says out instead of enter.

## Version 4.0.08

###new
- Added a buffer option for the Newbie channel.
- Properly categorize carbon dioxide as a gas for purposes of counting. (Thanks Rose for catching this!)
- Add atmospheric debris transfer messages to the reduce spam option.
- Add a new option to 'conf gen' to make alt+space show exits instead of current history item. (Defaults to on)
- Record the exits in each room for use in things such as alt+space.
- Added sounds for the headdesk and mock socials.
- Moved some more baby sounds under the babies audio group.

### Fixed
- Fixed the asteroid hauling counter.

### Changed
- Alert klaxons are no longer completely suppressed when reduce flavor text is enabled. The text will always be gagged by default, and will play its corresponding sound.

## Version 4.0.07

### New
- Private comms from link recipients (mainly names containing "service" or "recipient") now play a different sound instead of the standard private comm sound. Examples include: Auction Service, combat mission notification service, communication loopback recipient, etc.
- Added an option under 'conf general' to control whether service comms bypass foreground sounds (defaults to off). Service comms now respect the foreground sounds setting by default, unlike regular private comms.
- Social sounds for screech, slowclap, and golfclap. (Thanks Jason!)

### Changed
- Alternate audio detection is now automatic. The soundpack checks for the `sounds/alternate/` folder at startup and uses alternate sounds when available, eliminating the need for manual configuration. The "Access alternative audio files" option has been removed.

### Fixed
- Fixed counters reset to properly display output.

## Version 4.0.06

### New
- Expanded the counters system (as seen in archaeology) to track multiple activities: spatial artifacts, asteroids hauled, missions completed, debris salvaged (atmospheric, space, aquatic, and gas variants), and planetary mining expeditions.
- Added a counters command for easy access: 'counters' displays all activity counters, 'counters reset' resets all counters, 'counters reset <name>' resets a specific counter.
- Added an option to toggle whether counter values are displayed when the activity completes (defaults to off).
- Added an option to reset all counters upon startup or updating (defaults to on).
- Added a sound for snatching artifacts from space.

## Version 4.0.05

### New
- Asteroid mining manufacturing facilities now have a sound for completing things. (Thanks Mark!)
- Added a new lift ambience.
- Private organization and courier channels now have buffers.
- Added history buffer aliases: spr (read), spc (copy), sps (switch), and SPHB (buffer back/forward, among other things). Primarily added for VIP Mud soundpack compatibility and user-friendliness.
- Added relativity drive frequency option under 'conf ship'.
- Added various batch scripts for developers.

## Version 4.0.04

### New
- You can now add a file to the sounds/miriani/comm/ directory that will be played for a particular metafrequency channel. Name the file using either the channel's given label, or the frequency number without periods, and it will be played instead of the standard metaf.ogg. For example, 707.ogg will be played for channel 7.07. 50000.ogg would be played for 500.00, etc. If you have channel 7.07 labeled soundpack, you could also use soundpack.ogg instead of 707.ogg.
- We now automatically set your courier company when viewing output from the INFO command, and the courier channel will now play a sound accordingly.
- SOOC now has a dedicated sound.
- Users on the dev channel will now see the updated files in addition to the main changelog if 'conf gen 4' is enabled.
- Changelog is now available in markdown.
- Scanning now plays a sound for starships being on the surface of an asteroid.

### Fixed
- The sound trigger for last stun shot (eject).

## Version 4.0.03

### New
- Added atmospheric vehicle descent trigger sound.
- Added air pocket trigger - "You are thrown back against your seat as the craft hits an air pocket in the atmosphere and then breaks free." now plays a wind sound effect.
- Complete updater system overhaul - now uses an external update.exe binary written in Golang instead of the LuaJit-based system:
  - Simplified update commands: just type 'update' to check and install, or press CTRL+U.
  - Channel switching support: 'update switch dev' or 'update switch stable'. For an up-to-date list of channels, type 'update switch' by itself to be sent to a menu-based interface
  - Automatic updater installation and manifest generation if missing
  - The updater can also act as an installer, allowing you to download the latest version of a stable or dev build on a new machine.
- Plugin requirements system - automatically loads and manages required plugins. Missing plugins show with clickable links to enable them. Required plugins are re-added upon the plugin list changing, ensuring a unified set of core plugins.
  - Reinstall latest version of the updater with 'update reinstall'.
- Added an admin message sound.
- Added ice water crystals sound effect for Santa boxes.
- Added the directional TTS audio files from the Miriani Soundpack for VIP Mud, which get played when you follow someone.
- Added conf gen 8, to control follow directional audio.
- Developer plugin with 'spreload' command to quickly reload all plugins.
- A brand new accessible output window, built directly into MUSHclient. Type 'conf gen 11' or press tab to learn more.
  - Note: This feature is compiled directly into MUSHclient and is controlled via the ActivateAccessibelOutput() scripting function. It is intended to bridge the gap on VIP Mud functionality that simply cannot be replicated via plugins, such as typing directly into the output notepad. More work on this is ongoing.

### Changed
- Improved trigger patterns for better name matching in various events (standing, sitting, group actions, etc).
- Debris impacting the hull now plays youHit6.ogg instead and shows the corresponding message.

### Fixed
- Aquatic salvagre stop.
- Planetary mining infinite loop when finding mineral pockets.
- Alternate audio variant selection now works correctly.
- Organization channel detection works properly again with tr channels.
- Info bar no longer clears unexpectedly.
- Asteroid mining warnings detect more accurately.
- Interrupt on follow (in conf reader) now works correctly, and also works for being dragged.
- Lore printing sound.
- Blade unsheath sound.

### Removed
- Legacy index-v5.manifest and old Lua-based updater system.

## Version 4.0.02

Note: This release was initially going to be the debut for the new updater, but I'm pushing this ahead of time to get some bug fixes and nice-to-have features out there. Lots of work is going on behind the scenes on:
- Brand new updater that runs outside of MUSHclient, coming in version 4.0.03. Much more stable and quick.
- Socials framework
- Splitting all extras into MUSHclient plugins
- And more! Primarily, lots of technical debt catchup and reorganization of files.

### New
- Added sounds for various RP Shenanigans (credit to the Miriani Soundpack for VIP Mud):
  - Blade combat sounds: unsheathing, sheathing, stabbing, swiping, slashing, blocking, and wiping blades clean
  - Slime machine/puddle interaction sounds: slime hits and puddle splats
  - Paint canister explosion sounds
- Added missing theme music and cleared out the mission music files for mission complete.
- Added MUSHclient builtin help to the default world file. You may access it with the 'mchelp' command.
- URLs will now become visually clickable with the mouse in the primary world tab.
- Sound variant selection system that let's you set the variant for a sound. These are different versions of a sound that may either be legacy or preferred by certain users. The sounds that you can set initially include shipa ccelerate, ship decelerate, and archaeology artifact detected.
- Added 2 new accelerate and decelerate sounds for ships.
- Added back old archaeology artifact sound as a variant option
- Added flight control sector number substitution option (migrated from VIP Mud soundpack). Enable under "conf helpers" to show sector numbers instead of sector names in flight control messages (e.g., "Flight control in sector 15" instead of Miriani.)
- Added an experimental, potentially useless option in conf gen to make the tab key shift focus to the output window. There are some caveats, which may or may not have resolution in the future:
  - This overrides tab autocomplete, and there's no way to map another key to do that instead.
  - MUSHclient doesn't provide a way to intercept keys when focused on a notepad, which makes it impossible for us to bind to tab or shift+tab in this area. Thus, once you've pressed tab, you'll need to press ctrl+1 or ctrl+tab to snap back to the input field.
  - This requires a full client restart when enablign and disabling the option.
- Got rid of the announcement in MUSH Reader that mentions speech being initialized.
- New sound for asteroid hauling begin, line start, line end, anchor start, anchor end, and ship anchor. Reworked gagging of lines a bit here as well.
- The output tab is now read only by default.
- The installer executable now looks for Dropbox and forces the install to go to local documents instead, similarly to OneDrive.
- If escape is set to send @abort to the game, it will now send 0 when in conf and other menus. This has the side effect of resulting in an invalid selection if there's nothing to go back to, but it's all the same in the end, really.
- Design channel sounnd.
- Output will now automatically truncate ~40% once it reaches around 1 MB in size.
- Add log_manager, a plugin I've written that sets up sane logging defaults:
  - All logs go to a logs\WorldName folder
  - Under each world, logs are organized under year\month\day.txt.
  - For example, my Miriani log for today is under: logs\miriani\2025\10\19 October 2025.txt.
  - Normally, MUSHclient will log an entire session to the same log file, never reopening the log when the date changes until you close the entire client. This can easily become useless when you stay connected for multiple days, since MUSHclient will never try to write a new dated file (if you have it set up this way, which most do not). To combat this, we ensure the log file is rotated exactly at midnight via timers, closing it and reopening the new file.
  - Basic alias: vlog to open the current log, vlog <number of days ago> to open the log from <x> days ago. This will also force the current log to be written to disk.
  - Closes the log file when you disconnect, reopens it when you reconnect.
- Add several new rocky planet ambiances.
- Add a lift ambiance (thanks Mark for the sound suggestion and Claude Code for various audio editing shenanigans)
- Added a basic archaeology artifact counter. More to come for other activities soon.
- You can now press Ctrl+F8 to toggle whether the client speaks incoming text while the world is out of focus.

### Changed
- The output tab will no longer promtp you to save when you close it.
- MUSHclient will no longer prompt you to "Save internal variables" when you close the world. Saving is now automatic.
- MUSHclient will no longer prompt you to save the world file separtely from the internal variables. Instead, the only prompt you will receive is if all worlds have been closed and you're attempting to close MUSHclient itself.
- The point calculator should now save through reloads. (We're just saving in variables here, so if it's not saving, you should ensure MUSHclient's worlds\plugins\state folder is populating with data.)
- Moved flight control scanner trigger from communication.lua to devices.lua.
- Debris impacting the hull now plays youHit6.ogg instead and shows the corresponding message.
- You can now use F8 to toggle speech, instead of Ctrl+Shift+F12
- Disabled some of the babywave triggers until I finish the big socials update.

### Fixed
- Re-added aquatic salvager move sound.
- Reloading toastush.xml while logged in will no longer result in the URL catcher being disabled. Primarily seen when updating via the updater.
- Archaeology nothing nearby sound now plays.
- Conf now matches correctly to some of the newer menus.
- Triggers for tubing and cabling in asteroi dmining should be slightly more reliable.

## Version 4.0.01

### New
- Reorganized configuration menu with new "Helpers and Extras" category:
  - Moved archaeology helper options (buried artifact depth tracker and direction calculator) from general category to helpers
  - Moved point calculator from general category to helpers
- Added additional asteroid mining sounds:
  - Cable and tubing attachment/detachment sounds
  - Reactor activation/deactivation sounds
  - Additional drill sounds
  - Additional micro sealer sound
  - Warning sounds for equipment failures (coolant leaks, drill bit issues, contamination)
  - Ramp end sound
- Reset scan filter capture when you move, to prevent oddities where the state might get stuck. (Commonly seen when duplicate lines appear.)
- Archaeology directional helper now plays artifactHere sound when you arrive at the artifact coordinates.
- SMC <ship class> now gets handled by Miriani-Next if Proxiani isn't being used, since the in-game version doesn't support arguments.
- If .run_updater is present in the main directory, we now run the updater at startup. Primarily used by the installer to prompt an update at first run.
- Play cancel sound when conf matches fail.
- Enable Camera buffer by default for new users.
- Replicate external camera and droid camera lines, as to trigger on them as if the action happened in your own room. This is a way to both get the camera sound and reliably trigger on things performed via camera, rather than needing custom triggers for each action or loosening up regular expressions.
- Disable keypad in world preferences by default.

### Changed
- Suppress the source from external camera and droid messages in output. The location is still included in the mesage when reviewed in the camera buffer.
- Replaced the archaeology artifact found sound.

### Fixed
- Don't perform any parsing before printing and storing say messages.
- Menus now play the prompt sound when matching to multiple items.
- GMU notifications now play if there is only one of a thing detected.
- Conf no longer errors upon not being able to match to an option name.

### Removed
- Jumpgate sounds that were too long or too short.

## Version 4.0.beta.6

### New
- Replaced the dialog-based configuration system with a new menu-based one. This menu behaves in the same manner as any menu on Miriani itself--it supports number-based selection, entering part of the name of a selection, or @abort to back out.
- Removed most of the volume categories from the settings available in F10. Now, volume is split among the following groups:
  - Master: Influences all volumes. Other volume groups are multiplied by this value.
  - Sounds: All sound effects throughout.
  - Environment: Ambiences, loops, potentially other things in the future.
- Added automatic login feature with dedicated configuration category. Configure username and password under conf AUTO LOGIN, then enable auto login to automatically connect when you see the "Username:" prompt. Automatically selects character 1 from the menu. MUSHclient already has auto login, but there was no way to ensure the soundpack would be registered before it fired, so here we are.
- Added sound offsets for various categories. Currently these are hardcoded, although they could become configurable later:
  - Computer: -5% from default volume
  - Notifications: -15% from default volume
  - Combat: -5% from default volume
- Point tracking for license, combat, and organization points; enable under conf gen.
- Tracking system for starship contributions:
  - Tracks contributions received from players with name, amount, and frequency
  - CONTRIBS command displays sorted list of contributors (highest to lowest)
  - CONTRIBS CLEAR resets all contribution data
  - Plays sound when receiving contributions
  - Contributions buffer enabled by default to track all received contributions
- Sound for receiving credits from another player.
- You can now toggle various sound categories on and off from within the configuration menu. Keep in mind that this list populates as sounds play, so if a category you expect isn't there, try playing a sound that might be in the corresponding category first.
- Shift+escape now resets the info bar in addition to its existing functionality.
- Overhauled the configuration system to write to worlds/settings/toastush.conf rather than saving the configuration as a variable in MUSHclient's state. This will allow you to easily transfer configurations between clients or backup a known good config for later.
- Added optional, experimental formatting of scan output, which allows you to filter scans to be shown on a single line, similarly to the VIP Mud soundpack. Off by default, you can enable this under the ship category in config.
- Replaced the scu alias. Now, this will force a single-line scan on demand if you choose to keep the option disabled.
- Added a buffer for recent scans. Using a scan filter alias will not add to this buffer, only initiating a scan with the sc/scan command.
- Added 'sca' alias for atmospheric composition and 'scn' for natural resources on planets.
- Shift+escape resets scan state.
- Upgrade binary to MUSHclient 5.07-pre, based off of the tip of the current MUSHclient release tree (last updated in Aug 2025). Updater users will not receive this as part of the update process, and are encouraged but do not need to download the new executable from https://github.com/nickgammon/mushclient/releases, under the latest_commit (release) section.
- Added grand total to contribs.
- Added scan sounds from Miriani 7.
- Add background1 through background5.ogg, which get played when FTL and jumpgate jumps complete and the ship finishes launching. (Previously jumpgates played the move decelerate sound.)
- Add 29 new beep sounds.
- Add experimental code to the updater that will automatically reload any file that gets updated if the file is located under worlds\plugins. This will only work for updates moving forward after you've installed this version.
- Add baby sounds. (Credit goes to the Miriani Soundpack for VIP MUD. This is a direct migration and should operate the same.)
- Bias drive now has sounds.
- Added a sound for auction bids and add bids to an Auction history buffer. Sales will happen as soon as I have a sound.
- Add a sound for attempting to use a drive while it's still recharging.
- Add four new FTL and jumpgate sounds.
- Added wind sound for atmospheric instability.
- Migrate master volume and mute to the config file.
- Press F2 to open the changelog.
- Added whisper support with dedicated sounds (whisperSent.ogg for sending whispers, whisperTo.ogg for receiving whispers directed at you).
- Added optional whisper buffer to track whispers separately (disabled by default, enable in conf BUFFERS).

### Changed
- Renamed the toastush:config command to just conf, or config. (toastush:config still works for now, but will be removed later.)
- Remove variable-based config migration code.
- Master volume now initializes at 60% instead of 100.
- No longer play a sound when in the middle of a wormhole. This was previously ship/move/flash.ogg.
- Enable a wider swath of history buffers by default.
- Standardized the grammar in the configuration menu labels.
- Update metafrequency to 7.07 instead of 0.07, for Toastush-NG users to report bugs.
- Lower asteroid rover ramp sounds by 25%.
- Anomaly detection sound reverted to older version from Miriani 7.
- The sound for being out of range has been reverted to the VIP Mud sound.
- Interrupt on scan coordinates now provides three options: everything, only for starships, or off. We default to starships.
- Remove "Launch complete." from spam reduction mode and replace it with the background sound and a random beep.

### Fixed
- Contribs no longer greedily eats any other contribution commands.
- Require baby names to be alphanumeric, as to prevent communicators from triggering baby sounds. (This still won't stop it from triggering for players, though. Don't be that guy. Or do. No judgment.)
- No longer try to play the weapon action sound if the outcome was unknown.
- Starmap filters work once again.
- Info bar now resets in more places.
- Ship locked on has been reverted to the classic sound. I accidentally wiped it out when merging classic in with main. Hurray regressions!
- Set the minimum number of shots to 7 instead of 8 for the bardenium counter, which should, in theory, fix the double shot remaining on the ravager.
- Fish warning in aquatic salvager now plays warning instead of scoop.
- Using scan filter commands without arguments will now properly filter after choosing a target from the menu.
- Scan filter commands are now case insensitive.
- More say fixes, I'm not really sure anymore...
- The Lore Computer print sound now works for any kind of paper.
- Checking coordinates no longer throws an error.
- Heartbeat stun sound ends properly.

### Removed
- Interrupt on focus screen reader option.
- Computer voice files and the corresponding option.

## Version 4.0.beta.5

### New
- Aquatic salvaging sounds for movement, scoop, fish encounters and probably more at the current time of writing.
- Enhanced Channel History plugin with quick buffer system:
  - Alt+Q: Cycle through favorited buffers endlessly
  - Alt+Shift+Q: Add/remove current buffer from favorited buffers/quick list
  - Quick list persists across client restarts
- Add planetary mining triggers. Credit for tunnel rats goes to the pull request here: https://github.com/PsudoDeSudo/Toastush/issues/5
- Add sound for drifting off to sleep (disconnecting while on the ground and/or furniture).
- Removed classic mode and merged all classic sounds with the Toastush default.
- Delete classic_miriani directory at startup.
- Added automatic detection and cleanup of conflicting sound files (removes non-numbered when numbered variants exist).
- Improved audio device switching with proactive health monitoring and automatic recovery.

### Fixed
- Audio device switching now uses position-based detection to catch stuck playback and WASAPI output issues.
- Fixed the say trigger to match on names with mixed capitalization beyond the first letter (i.e. Cedric McKinley)
- Properly format says that are in all uppercase.
- Don't play weapon firing sound for empty space when using the ravager's laser turret.
- Don't play weapon firing if you only have a single laser turret (probably related to the above change).
- OICIC <person> no longer gets caught by the shout trigger.
- Force all sounds to stereo (again). This flag got removed in the audio system overhaul. Ahem.

### Changed
- Updated poke/nudge triggers to play sound when it's you performing the social.

## Version 4.0.beta.4

### New
- Rewrite computer announcement handling to exist in a single trigger, using a table for the various strings that should be matched.
- Shortened "Shots remaining" in the bardenium counter to just "Shots" and experimentally made it display before the firing announcement, rather than after.
- Added 10 more keyboard and announcement sounds.
- Added separate sounds for the computer reporting things. Previously this just used the announcement sound.
- Play the punch sound for sock/slug/hit.
- Add weapon power up/power down to classic Miriani sounds.
- Add new display sounds that get used by the records, ships, cargo, damage, arsenal, and status commands.
- New connect sound.
- Play collapse/yawn socials when somebody disconnects.
- Sanitation drone sounds.
- Use weapon soundpack hooks instead of matching on messages manually. This should hopefully make them much more reliable for any kind of weapon, regardless of its name.
- Added static sounds for communicators and metafrequencies.

### Changed
- Shorten private comms to only say [Player Name] instead of [Private | Player Name].
- Poke/nudge socials will only trigger when you've been targeted.

### Fixed
- Show "Person yells" instead of "Person yell" and add support for the shout/holler versions.
- Don't trigger say on flirt.
- Clear focus and scan from info bar on launch/land. Previously this only cleared upon FTL, and unreliably so.
- Say history, OOC, and other channels will no longer trigger the speech routine.
- Say trigger now gets caught when seen via camera or droid remote.
- Malformed say messages appearing in the say buffer.
- "Asks you" will now trigger the direct say sound.
- Bardenium counter no longer announces twice.

## Version 4.0.beta.3

### New
- Rewrite bardenium shot counter by dynamically dividing available bardenium by the number of cannons announced in the firing message. Bugs are sure to be afoot with this one.
- Added a debug mode to subject yourself to spammy debug messages and errors. Enable under 'toastush:config general'
- Organization name is now gathered dynamically to trigger properly on the channel name. To set your org name, type 'tr channels' and it'll be set for you automatically.

### Fixed
- Org sound now plays for messages that don't contain text (i.e. comm socials).
- Completely rewrote say triggers to be more robust; also fixes a scripting error.

### Changed
- Canceled the experiment and reverted classic engine sounds to the V7 version

## Version 4.0.beta.2

### New
- Enable gag flavor text by default.
- Enable Cannon shot counter by default.
- Enable archaeology digging tracker by default.
- Added cease digging sound
- Replace requesting clearance to land/launch in classic mode.
- Added message board sound triggers and imported missing message board sound files (NewPost1-7.ogg, UnreadPosts.ogg).
- Message board notifications now play random new post sounds (NewPost1-7.ogg) when receiving new messages.
- Urgent message board notifications now play UnreadPosts.ogg for multiple unread messages when logging in.
- Began work on a script to generate the manifest out of MUSHclient, which should make life a lot easier.

### Changed
- Experimentally change relativity sounds in classic mode to V6.

### Fixed
- Suppress unable to play audio messages, need to add a debug mode to reenable them.
- Pickaxe now uses shovel sound and properly counts depth when tracking artifacts.

## Version 4.0 (Initial Release)

### New
- Rewritten audio system, featuring smarter muting, foreground sound support, dynamic category adding, and more.
- Foreground Sounds (fsounds), a mode that will force sounds to only play while the session is foregrounded. You can enable this by typing fsounds, through toastush:config, or by pressing ctrl+F9.
- Allow certain high priority sounds through fsounds mode. Currently these are private comms and direct says.
- Aaaannnnd...added a new sound for says that are targeted directly at you.
- Play the say sound for targeted says that aren't sent to you.
- Add targeted says to the say buffer, even if they aren't specifically at you.
- Plugins can now broadcast various messages to create, remove, or modify audio groups from within Toastush itself.
- Enabled automatic device switching for audio devices via Audio.CONST.config.device_default.
- Flight control messages now use soundpack hooks to properly clean message formatting. Flight announcements like "A flight monitor announces, Ship detected" are now cleaned to just show "Ship detected".
- Fixed classic_miriani sound randomization to properly handle numbered variants (laser1-laser30, etc).
- Improved sound file finding to prevent randomization on already-numbered files. This would often manifest in things like unable to play insect2.ogg messages.
- Volume adjusting now has a sound.
- Audio mute now has a sound.
- Printing files from a Lore computer now has a sound.
- Players connecting, disconnecting, or reconnecting in the room now has a sound.
- Audio Style preference, available under toastush:config general or by typing toastush:classic. The only two preferences are Modern or Classic. Classic captures many of the old sounds from the circa 2012 era and earlier, restoring things such as: channel sounds, starship engine sounds, the multitudes of laser sounds, cannon sounds, target lock and many Lore computer sounds.
- (output_functions.xml) Re-added the boundary sound when the start or end of history is reached.
- (channel_history.xml) Add support for buffer names containing numbers.
- (channel_history.xml) Alt+Enter: Open a URL in the current message if there is one, otherwise open world configuration.
- (channel_history.xml) Alt+Shift+1-0: Jump to first through tenth buffer.
- (channel_history.xml) Alt+Shift+` (grave accent, also works without shift): If you have text typed in the command window, try to jump to a buffer starting with that text. Press the command with an empty window to return to where you were before the last jump, effectively allowing you to flip between two buffers.
- (channel_history.xml) Alt+Backslash: If you have text typed in the command window, searches toward the bottom of the current buffer for that text. Add Shift to search toward the top of the buffer. If a match is found, focus jumps to that message.
- (channel_history.xml) Alt+Shift+Enter: Copy current buffer to a notepad.
- (channel_history.xml) Alt+Shift+T: Toggle timestamp announcements.
- Optimized audio cleanup routines, which should hopefully make sounds a little bit more snappy.
- Enhanced audio resource management with proper stream cleanup and memory optimization.
- Forced laser and cannon sounds to pan randomly.
- Added automatic ASCII character translation to prevent MOO server from dropping non-ASCII characters. Smart quotes, dashes, ellipsis, and non-breaking spaces are automatically converted to ASCII equivalents when sending commands.
- Enhanced direct say trigger to handle "says to you" syntax in addition to existing "[to you]" format.
- Added an option under 'toastush:config reader' to interrupt speech for scan coordinates. This will reintroduce the old functionality found in many soundpacks where scanning anything would be interrupted almost immediately to read the coordinates. A 100ms delay has been added, which should allow most speech systems to read part of the name of the item before jumping to the coordinates themselves. These values may be tweaked.
- Added an option under buffer config to separate metafrequency channels into a buffer for each frequency.
- Added a sound for successful soundpack registration.
- Escape to @abort (rather than clear input).
- Stop all sounds immediately with shift+escape.
- Added pulse emitter sounds (LoadEMPulse1-3.ogg, EmptyEmitter.ogg) for loading energy packs and empty pulse emitters.
- Added triggers for pulse emitter loading and emptying sounds.
- Added "There are no damaged components" sound.
- Enhanced direct say triggers to support "asks you", "exclaims to you", and complex formats like "hesitates briefly before saying to you".
- General communication channels now display as [General] instead of [General Communication] for cleaner output.
- Added focus coordinates and last scanned coordinates to the status bar. Focus coordinates show "Focus: x,y,z (Target Name)" and scan coordinates show "Scan: x,y,z" in the info bar (Alt+Shift+I).
- Added destination finder coordinates to the status bar. Shows "Dest: x,y,z" when using destination finder commands.
- Destination coordinates automatically clear from status bar when ship finishes jumping (wormhole/relativity) or landing.

### Changed
- Changed plugin name to toastush_ng, bumped version to 4.0, and now register soundpack as Toastush-NG.
- (updater.xml) Update URL now points at Toastush-NG repository.
- Migrated alt+shift+A to ctrl+L. With auto device switching, this keystroke should largely be a thing of the past, however.
- Alt+F10 (toggle sound mute) is now F9.
- Settings variable renamed from "secret_settings" to "toastush_settings".
- Starship relay messages now consistently show as [shipname] format instead of [Starship | shipname].

### Fixed
- Don't show Short-range Communication as "Short".
- Clear focus from info bar when we see the ship is no longer in the sector.
- Bardenium shot counter now works correctly in all weapon configurations.
- Spellchecker now plays the prompt sound.

### Removed
- Removed aliases 'smc' and 'sma' from starmap filters, as these are now commands inside the game.
- @paste alias
- worlds/plugins/ClientLock.xml
- worlds/plugins/Text_To_Speech.xml
- worlds/plugins/timer.xml
- worlds/plugins/Timestamps.xml
- worlds/plugins/gmcp_handler.xml
- worlds/plugins/local_edit.xml

## Version 3.1.74

### New
- Added spooky Halloween morphing sound!
- Nonbinary socials will now have a 50% chance at playing from the binary genders.
- Various RP related sounds. Mostly pertaining to water.
- Added the ability for Toastush to prompt you with the update command when outdated. Should hopefully keep people informed about updates.
- Added a special ambiance for the awkward moments you are stunned and helpless.
- Added the paralyzed clock to the info bar--or status bar. For screen reader users, press alt+shift+I to view.
- Renamed all misc/cash.ogg files to be lowercase. Not sure how they became capitalized.
- More RP sounds.
- Added a sound for long range beacons detected by ship.
- Various RP-related sounds.

### Changed
- Fixed the cannon shot tracker so that it rounds up to the nearest integer. This should solve odd-numbered cannon rooms. Per usual, use the weapon command in any cannon room to set the shots.
- Fixed starship relay buffer capturing only name.
- Fixed stun/healing weapons firing at 100% volume.
- Removed audio options prompting for stereo or mono. Audio is now always stereo.

### Fixed
- toastush:changes should now properly open the changelog.
- Fixed bug with initializing MCP. Apparently it exists after all!
- F1 now pulls up Toastush settings.
- Updated MCP implementation-- despite the fact that Miri doesn't seem to utilize it anymore. Its the thought that counts.
- Various RP-related sounds.
- Fixed various triggers in misc dealing with general sounds that did not work after a change of directories.
- Updated menu and prompt strings to trigger sound.
- Increased priority level of public address communication trigger to avoid conflicts with the "say" trigger.
- Bumped minor version number due to non-compatibility with version 3.0.

## Version 3.0

### Changed
- Edit updater code in various locations so that it indexes individual files without erroneously creating directories.
- Update constants.lua values to point to proper directories. There goes those bugs I was afraid of.
- Update the say trigger in `communication.lua` to be more forgiving. More importantly, text with certain punctuation that has been long lost to my failing memory will no longer cause a recursion depth error.
- Various organizational changes. Let's hope nothing weird breaks.

## Version 2.8

### Fixed
- Fixed old combat sounds playing at 100% volume. Thanks to Taylor Simon for reporting!
- Hopefully fixed issue that muted the pack when updating.
- Fixed bug with ship relay.

## Version 2.7

### New
- Added key binding: ALT+SHIFT+I to read out the info bar.
- Added the key bind: ALT+SHIFT+A to initialize (or reload) audio settings. This is helpful in cases where the soundcard or device changes.
- Added a minimal mode. Minimal mode deactivates the majority of triggers, leaving only communications and configurable gags. Type Toastush:minimal to toggle it.
- Added three new audio groups: ship, computer, vehicle.
- Added the @paste/@post alias for pasting blocks of text.
- New sounds for footsteps and various RP things.
- Fixed regular laser/cannon sounds that broke with pirate day filter update. Hee hee!
- Let computer announcement work with pirate day filters.
- Long awaited HG lift.
- Fixed bugs with footstep and added transporter sounds.
- Some pool related RP sounds.
- Suborbital pods.
- Various new ambiances.
- Fixed the world's oldest bug with festive lasers.
- Pulse weaponry sounds.
- Various RP enhancing sounds.
- SHIFT+F10 cycles back through audio buffers.
- Let certain events appear properly in the log.
- Sounds for gas and aquatic salvaging.
- Fixed no sound with multiple certificate purchases.
- Activity sounds for asteroid mining.
- Set the ability to specify different file extensions for alternate sound files. Adjust the variable named ALT_EXTENSION in plugins/Miriani/constants.lua accordingly.

### Changed
- Edited the config menu significantly. Users should go through the menu and adjust settings accordingly. Split options into different categories, added a new option for printing the word 'unchanged' before coordinates.
- Separated audio for ship-based combat to the ship audio buffer. Renamed the previous combat buffer to melee to denote the difference.
- Added one option for downloading updates while idle.

### Fixed
- Fixed sound not playing with starships exiting sectors.
- Possibly fixed an issue with Jaws echoing text that is presented on white on black. Changed the default color for it. Users should change default foreground and background if they're having similar issues.
- Patched bug that played social after social volume was lowered to 0%. Thanks to Cody Ley for reporting!
- Enabling proxiani will now disable Toastush starmap commands.
- Patched bug with socials not playing properly on metafs.
- Fixed bug that occasionally dropped audio after changing audio devices.
- Fixed minor bug with cannons.
- Fixed bugs with atmo combat vehicles.
- Fixed bug with sound not playing for characters with double capitalizations in their surnames.
- Minor changes to the feel of config menu.

## Version 2.6

### New
- Disabled the F1 windows help keystroke (There's no real reason to keep this enabled while Microsoft no longer supports it.)
- Configurable hyperlink colors.
- Configurable colors for the infobar.
- Added star wave-warped sound.
- Added hooks buffer (Possibly useful for developers).
- Added various configurable colors through the config menu.
- Added the ability to go back in the config menu with escape.
- Buckling sounds.
- Reinstated handheld radio sounds. Not sure how they got lost again.
- Added some more socials.
- Jetting in space sounds.
- Added the ability to access alternate audio files for any given sound trigger. Simply create the sounds/alternate directory and locate any files there.
  - Note that the file must be named exactly to the one indicated in the soundpack and the file extension must match that of the given soundpack extension, (as of this time .ogg).
- Atmo sounds.
- Added sounds for Praelor boarding.
- Added sounds for various Praelor lifeforms.
- Added sounds for lifts. Only the most important changes.
- Added a new audio group for loops (separate from ambiances).
- Added optional alerts for stores, dig sites, and pending updates. See Toastush:config audio.
- Added a buffer for the design channel.
- Added the alias Toastush:updater-reload to easily reload the updater.
- Added the alias Toastush:register to reissue registration command.
- Added the macro ALT+SHIFT+U to open recent URLs.
- Renamed link buffer to URL (It's more intuitive).
- Reset the ping timer for the info-bar.

### Changed
- Computer detection sounds for wormholes, anomalies, and nebulae.
- Patch for updater to create new directories properly.
- Added sounds for Praelor boarding.
- Added sounds for various Praelor lifeforms.

### Fixed
- Fixed relay sound/buffer.
- Minor bug fix with archaeology.
- Fixed bug with lowered/raised sales in the tradesman market.
- Various fixes to the updater where capitalization kept files from being recreated.
- Increased index manifest version.
- Added clean-up code for version 2.6.2 and below in janitor code.
- Patched bug with indexer that didn't hash files. Whoops.
- Fixed a bug with the updater that sometimes failed to create directories.

## Version 2.5

### New
- Updated manifest version, no longer using v2.
- Added marine planet underwater ambiance and water airlock sounds.
- Added some asteroid ambiance.
- Added some station ambiances.

### Fixed
- Fixed indexer bug that concatenated bad links for sounds depending on capitalization.
- Various bug fixes with archaeology.

### Added
- Added ambiance for starship rooms.

## Version 2.2

### New
- Added the framework for playing ambiance. Sounds to come.
- Added the Toastush option to open the changelog in a notepad after applying updates.
- Added the alias Toastush:changes to open the changelog directly.

### Changed
- Changed the wording (minimally) of secondary lock options to be less confusing.
- Changed computer voice and roundtime options to be under audio options. (It just makes more sense this way.)

## Version 2.0

### New
- Official release.

### Changed
- Various bug fixes from version 1.2 (too numerous to list).
- Added the option to initialize audio as either stereo or mono.
- Allow audio groups to be configured outside of secretpack.
