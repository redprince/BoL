_G.PRINCEVERSION = 7.80
_G.PRINCEAUTOUPDATE = true

_G.HiddenObjects_forceDisable = false
_G.Waypoints_forceDisable = false
_G.CooldownTracker_forceDisable = false
_G.SideHud_forceDisable = false
_G.MinimapSS_forceDisable = false
_G.CloneRevealer_forceDisable = false
_G.RecallAlert_forceDisable = false
_G.TurretRanges_forceDisable = false
_G.MinimapTimers_forceDisable = false
_G.ExpDrawing_forceDisable = false
_G.LasthitHelper_forceDisable = false
_G.NotificationSystem_forceDisable = false
_G.TimedDrawings_forceDisable = false

--[[
    Features
    - (Vip) Jungle timers
    - (Vip) Enemy recall alerter + recall progress
    - (Vip) Autoping SS, configurable per-champion
    - See hidden objects (traps and wards)
    - Show ally/enemy waypoints
    - Adds a timer for SS in the minimap (enable "minimap hack" from BoL client to see champs portraits beside numbers)
    - Mark real enemies if they can clone (leblanc, wukong, yorick, shaco)
    - Towers ranges: simple tower ranges using nolag circles and supporting turret states for VIPs (turrets changes colour based on aggro)
    - Draws experience range inside wich you gain exp from minion kills
    - Real-time spell and skills cooldown tracker near healthbars
    - Side HUD that shows health, ultimates and summoner skills cooldowns
    - Last hit helper (draws a line on minion hp bars where you can last hit a minion and outlines the health bar when last-hittable)
    - Inhibitors respawn timers
    - Light as hell: I've spent a lot of time in optimizing cycles, drawings, access times etc
    - Highly customizable: every feature can be disabled easily from menu without impact on CPU and FPS
    - Cross map compatibility: it loads on every map, autodisabling useless functions depending on map
    - Show date/time/latency near FPS
    - Save chat in txt files, one file for every new match
    - Fullscreen notification system with queue for messages
    - Timers for spells duration like akali bubbles and kayle/trynda ultimates
    
    Changelog
    
    7.80
    - Removed RefsPlea.se sponsor message due to refs system changes
    
    7.75
    - Fixed autoupdater
    
    7.70
    - Fixes for 4.19 patch
    
    7.60
    - Fixed improved recall detection and recall on Dominion
    
    7.50
    - Maybe finally fixed freezes for many users
    
    7.45
    - Fixed teleport bar loading forever
    
    7.40
    - Fixed recall exploit and other minor issues with patch 4.18
    - Other code clean
    - Updated chogat, kogmaw and leesin side hud icons (need download sprites)
    
	7.30
	- Removed Ascension-related code
	
	7.20
	- Completely removed movement limiter
	
    7.10
    - Performance improvement: check if enemy clone-able hero is inside screen before drawing the clone marker circle
    - Performance improvement: less variable allocations during OnTick()
    - Clicking on the side HUD will now trigger a sprites refresh (atm I'm trying to select the clicked enemy other than reloading sprites)
    - Fixed round number function returning string instead of number, should fix something, but don't know what exactly.
    - Fixed death timer huge negative number when reloading script while enemies are dead (it will show "0" instead)
    
    7.00
    - Added a reset sprites button, configurable (default "L")
    
    6.90
    - Performance improvement: now hidden objects will be drawn only when inside screen (I missed a check before..)
    - Other checks trying to remove ghost ward projectile bug
    - Added option to hide/show drawings while scoreboard is open
    - Side HUD and minimap related things are normally rendered even with scoreboard open in any case
    
    6.80
    - Added autoupdater (that will work from next version obviously)
    
    6.72
    - Hotfix "is teleporting" on ascension doing a really bad drawing
    
    6.71
    - Some nexus ranges fixes were missing (forgot some cases in the code), now it's ok
    
    6.70
    - Hide towers with 100% health from minimap
    - Added an option (default off) to show towers hp on minimap
    
    6.66
    - Da devil version (yes, now I'm happy lol)
    
    6.65
    - Stop drawings while holding the scoreboard key (so you can read things in a more clear way)
    - Added minimap tower health percentages
    
    6.64
    - Slight performance improvement on drawing tower ranges
    - Fixed nexus laser radius indicator
    - Removed tower ranges from dominion map (was showing only 2 decorative towers at spawn)
    
    6.63
    - Recall messages now includes also numeric hp values
    - Hotfixed a stupid encryption error
    - Fixed health percentage when enemies are recalling
    - Faster loading and reloading (2-3 seconds instead of 40-50). Had to remove statistics that was causing this issue.
    
    6.51
    - Fixed ward creator for free user when detected by spell cast 
    
    6.50
    - Better handling of OnObjectCreate(), may fix ghost wards properly now
    - As requested, recalling infos are now with health informations
    - Added ascension respawn timers for relics (both on minimap and on the ground)
    
    6.40
    - Added RefsPlease sponsor message
    - Probably fixed the "ghost wards" appearing rarely as missiles from random people
    
    6.30
    - Hotfixed surrend status (it was not printed in chat)
    - Fixed chat logs were stored in separated files when reloading. Now there should be 1 file per match.
    
    6.21
    - Added Azir sprite
    
    6.20
    - Added GP ult to timed spells
    - Config check for timed spells was totally missing. Added now.
    - Removed debug mode and created a bugsplat report
    
    6.10
    - Now when debug mode is OFF, txt file is not even created/used/closed
    - Fixed karthus ult notify timer, it was literally spamming
    - Movement limiter VIP check moved inside function instead of outside script
    
    6.00
    - Added a debug mode OFF by default to help localizing freeze / crash issues
    - Added surrender answers to chat and logchat
    - Gnar image on side HUD is updated with big gnar while enraged
    - If you use karthus, enemy killable by ulti will be shown on notify system
    - Significantly reduced gank alerts
    - Added sound configuration to buff camp spawn and karthus ulti notification
    - Disabled gank ping/alerts on maps different from summoner rift
    
    5.90
    - Fixed a null variable after reload that sometimes was causing error spam until enemies were visible
    - More friendly declaration of constants (does not affect the script)
    
    5.80
    - Updated Vayne/Shyvana champion pictures (sprites need to be updated)
    - Fixed errors from 4.15 patch changes
    - Moved Draw Experience Range on "Others" submenu
    - Added a general toggle for "Other drawings" like real life infos and draw exp range
    
    5.70
    - Added location to SS extra awareness (it will not print "SS mid" or "SS bot" or "SS top")
    - Added spam-checks to SS extra awareness (SS in a zone -mid,bot,top- will not be notified more than once every 6 seconds)
    - Improved the gank prediction AI to avoid useless notifications
    - Added pantheon and twisted fate ultimates to spell timer drawings
    
    5.60
    - Added drawings on the ground for some spells (akali bubble, thresh lantern, trynda/kayle ult)
    - Fixed jungle buff pinging at first spawn (not needed)
    - Added pantheon ulti to the list of timer spells to draw
    - Added "SS extra awareness" on the notification system (it will print for example "SS MID" when your mid uses SS ping)
    - Added small part of mapPosition code directly inside the script to don't require the lib. Thanks to Husky for the great code
    
    5.50
    - Variables compression, small code optimization and clarification
    - Renamed general toggles to "Quick toggles", with a single row of info
    - Added blue/red respawn to the notification system
    - Added gank alerter to the notification system
    
    5.40
    - Added customization for drawings of jungle camps, now you can choose which respawn timers you want to see on every map
    - Initialized a variable previously not initialized, it may have caused errors at script load
    - Added a new, shiny notification system for extra awareness. You'll love this!
    - Added dragon/baron/vilemaw respawn to the notification system
    
    5.30
    - Fixed a case of ward detection from OnProcessSpell (ward networkid was wrongly set)
    - Fixed a case of minion last hit helper that interrupted drawings of other functions
    - Improved jungle respawn times of enemy blue/red/baron checking buffs start time and calculating camp respawn from it
    
    5.20
    - Added heal pads respawn timers for dominion map
    - Fixed TP cooldown timer not setting to 300 when enemy teleports from FOW
    - Ward placement detected inside a "wall" will now try to find its real position, when possible
    - Changed update checker, using powershell to avoid bugsplats
    - Added this script to http://bol.b00st.eu/
    
    5.10
    - Added "reconnecting" status to the side HUD, showing three orange dots when someone previously dc is reconnecting
    - "Disconnected" red X is now bigger and should fill the entire image to be more evident
    - Fixed setting to 0 jungle time when a spot respawn
    
    5.00
    - Added sliders to customize the position of real time infos (date-time-fps)
    - Added a teleport bar similar to recall bar (but increasing) to increase enemy teleporting awareness
    - Added a movement packet limiter to be safe with too many movement packets being sent from orbwalkers and move-to-mouse scripts
    - Added support to the movement packet limiter for Evadee, Freaking Good Evade and Ezvade, so they are not blocked while evading
    
    4.90
    - Performance improvement: now all the functions uses just a single variable for limiters based on timers
    - Improved timing for timed things(like wards and cooldowns)
    
    4.80
    - Fixed jungle pings always enabled, even if disabled from config
    - Fixed waypoints spam of "for must be number" error
    - Fixed the collapsing position of summoner skills cooldown timers on side HUD
    
    4.72
    - Hotfix, disables waypoints (causing error spam)
    
    4.71
    - Hotfix to remove a debug string "NO MANA" spammed like no tomorrow
    
    4.70
    - Added security checks to avoid "obfuscated.lua pairs&ipairs" errors when Sprites are missing
    - Fixed side HUD healthbar overextending
    - (VIP) added enemy teleport detection from FOW, updated side HUD cooldown with this info
    - added summoner rift (autumn variant) to recognized map ids for jungle timers
    - added disconnected/reconnected status on side HUD
    
    4.60
    - Fixed FOW Recall exploit
    - Fixed inhibitor respawn time
    
    4.50
    - Added options outside the script to force disable selective functions in case something bugsplats/freezes during loading
    - Added sprites check for newest version to avoid bugsplats
    - Added Gnar sprites
    
    4.40
    - Autoping will work only on EarlyGame (EarlyGame timer is configurable on "Other" section)
    - Performance improvement: again, other calculations reduced for HUD things, should improve FPS
    - Side HUD SS and respawn colors are now configurable from menu
    
    4.40
    - Autoping will work only on EarlyGame (EarlyGame timer is configurable on "Other" section)
    - Performance improvement: again, other calculations reduced for HUD things, should improve FPS
    - Side HUD SS and respawn colors are now configurable from menu
    
    4.30
    - Added ultimate cooldown and state to side HUD
    - Fixed "dead" state having less priority than "missing" state
    - Fixed dynamic color of latency number
    
    4.20
    - Added "seconds to respawn" to side HUD (BoL bugged - manual calculations from http://leagueoflegends.wikia.com/wiki/Death )
    - Enemies in the side HUD will be grey when in SS (this brings also a better readibility of SS timer)
    - Performance improvement: pruned some calculations for side HUD and cooldown tracker, more will come
    - Added toggleable option to show summoner skills (not spells) cooldowns in the side hud
    
    4.10
    - Added enemy status to side HUD (dead, missing + timer)
    - Dynamically colored healthbars on side HUD (green -> red) based on health left
    
    4.00
    - Fixed spam of "ping not declared" problem for freeusers
    - Waypoints crosses options for allies/enemies are more clear now
    - Added basic Side HUD with enemy champions picture and health
    
    3.90
    - Stop cooldown drawings on own hero's death
    - Don't draw cooldowns if own hero is not on the screen
    - Added customization colors on cooldown trackers for spell not learned or not enough mana
    - Adjusted cooldown text on summoner skills
    - Reduced height of summoner spells cd rectangles
    
    3.80
    - Added color config for text/spell-cd/spell-ready on cooldown tracker
    - Adjusted position of self cooldown tracker
    - Cooldown tracker is now on top of other drawings (turrets and objects were having more priority)
    - Fixed red/green color states for spells on cooldown tracker 
    
    3.71
    - Hotfix to spam error when draw self summoner skills cooldowns was activated
    
    3.70
    - Many fixes to cooldown tracker, now is ready to be released
    - Added cooldown tracker option also for player champ, useful for cd-intensive champs like Lee Sin / Udyr
    - (VIP) When an enemy recalls, SS timer is reset to 0 so the AutoSS pings correctly after the config time
    
    3.60
    - Added basic cooldown tracker, near enemy/ally HP bars
    - Performance improvement: smart CPU usage for minimap SS timers calculation
    - Performance improvement: fixed a missing tick calculations limiter, now this script is lighter than ever
    
    3.50
    - Added more options to last hit helper
    - Added Heimerdinger's turrets as traps tracked by hidden object drawer
    - Fix: hidden objects not on screen were not drawed on minimap
    - Attempt to fix random wards generated from particles (rare but happens)
    
    3.40
    - Removed donator check, old donator features are now available to everyone under "Other" menu
    - Removed a debug function that printed all your buffs in chat when pressing the custom ward key (I love the old-way debug)
    
    3.31
    - Updated by Bilbao, removed donator features and changed "script loaded" message
    
    3.30
    - Added support on lasthit helper for Draven-Vayne-Jinx Q. More will come later. (First i need to find which other spells ahah)
    - Drastical performance improvement: draw things only when needed (if they are not on your screen, now they won't be drawed)
    - Performance improvement: stop drawings after a nexus is destroyed
    - Better position to draw date/time/ping for donators
    
    3.20
    - New function: lasthit helper. It draws a small line on minions healthbars where you can hit to lasthit. Draw also borders when last-hittable.
    - "Update available" message is now colored (what a useless new thing!)
    - "Script Loaded" message implemented. Donators can hide it.
    
    3.10
    - Fixed lag on nexus destroyed
    - Some gifts to donators:
        Store chat in separated files, one for each game. You can find them in Script/Chat folder
        Draw date, time and latency number in the top-right corner, below FPS
    
    3.00
    - Removed bot of doom mode(well not removed but renamed with "Mark all enemy heroes")
    - Rewrite of a huge part of the code: wards casted from enemies in FOW should now be detected 100% of the times for both free and vip users
    - No more random wards drawings on objects like projectiles and other random objects
    - Zyra Seeds should now be detected as traps
    - Better accuracy when drawing ward creator (free users will have "Ward" written as creator when an enemies places it from FOW)
    - Hidden objects ranges (circular) are now shown also in minimap when holding "N" key
    - Fix error spam with turret ranged for free-users
    - Many other small fixes
    
    2.90
    - Fix error messages when playing aram due to jungle packets
    
    2.80
    - Bugfix: Syndra's balls are not considered pink wards anymore
    - Bugfix: wards from Sightstones are not anymore considered pink
    - Bugfix: wards not placed anymore randomly outside the map
    - Zyra's plants are not recognized anymore until new fix (this was causing syndra's balls bug)
    
    2.75
    - Bugfix by Bilbao: no more LIB error (huge thanks!)
    
    2.70
    - Added Auto SS with configurable missing time and single champions to ping (recommended above 10 seconds to avoid spam)
    - Auto SS improvement: never ping SS for enemy jungler and enemies respawned from death
    - Auto SS improvement: never ping SS for enemies which last seen position is near their base
    - Auto SS improvement: ping in a random small distance from his last position to don't be too obvious to other BoL users
    - (VIP) Auto SS improvement: don't call SS on a recalling enemy, instead wait if he stops recalling, then call SS
    - (VIP) Auto SS improvement: if an enemy completes a recall, he is not considered anymore in SS so no need to ping him
    - Fixed obfuscated error and spam when enabling "Draw ally waypoints". This script should now work for everyone
    
    2.60
    - Check for VIP status before pinging to avoid bugsplats for free users
    - Added an option to draw a recall sprite on recalling enemies (not accurate of course, it uses last known position)
    - Solved a bug that in some cases enemy wards were not detected (placed from someone in FOW mainly)
    
    2.50
    - Added custom key to toggle vision of objects instead of hold
    - Splitted configuration of waypoint colors in allied/enemies
    - Added an "Early game" timer configurable in minutes, draw exp range will be autodisabled after that
    - Fixed first spawn time of jungle camps
    - Added custom quality option for experience range circle
    
    2.40
    - Added an option to ping serverside or clientside when red/blue/dragon/baron/vilemaw respawns
    - Traps color is not changed when expiring anymore (only wards can have the "expiring" status)
    - Fixed obfuscated.lua error when using Prodiction in some other script
    
    2.30
    - Added Inhibitors respawn timer on minimap (Free and VIPs)
    - All functions for VIPs are now hidden in menu for free users
    - Added option to draw waypoints also on minimap
    - Autoupdater changed to manual (it will only show an advice to download the new version from forum)
    
    2.20
    - Fixed recall bar position on top of the screen
    - Performance improvement when jungle timers are disabled from general toggle
    - Removed useless second toggle inside exp draw menu
    - Fixed rare overlapping of wards created by objectCreate and packet ones
    
    2.10
    - Fixed turret ranges not drawing for a bug
    - Fixed jungle timers (timers were delayed)
    - "has recalled" message now only appear when general toggle is enabled
    - Recall Alert general toggle is now true by default
    
    2.00
    - Stronger algorythm to detect hidden objects
    - Added jungle timers. Supports Summoner Rift and Twisted Treeline. Again, big thanks to Jorj for packets code.
    
    1.80
    - (VIP ONLY) Added Recall Bar - BIG THANKS to Jorj for sending me his packet code for doing this
    - Support for transparency on drawing tower ranges
    - Fix Maokai saplings drawings not deleted when they explodes
    - Added draw experience range circle, default OFF, with width and colour customization (no-lag circle)
    
    1.70
    - Added tower ranges draw type "Precise" (default ON), switchable with old "circular" type from config menu
    - Added support for Zyra's plants as traps
    
    1.60
    - Clone marker for Bot of Doom mode -> simply put a circle on every enemy. Copies are not marked.
    - Better drawing of hidden objects ranges while in bushes
    
    1.50
    - Workaround (but working) solution to delete traps on trigger (teemo, nidalee and cait are supported atm)
    - Fix for autoupdater, now it should work even with encrypted code
    - Fix for turret states
    - Changed default key to see objects ranges to "N", FPS drop should be gone now
    - Fixed color and duration of Quill Coat / Ancient Golem ward (10 minutes, red => 3 minutes, green)
    
    1.40
    - Added turret ranges with nolag circles (VIP users can change color based on aggro/danger/safe)
    - Custom key to remove objects now removes all types of objects, not only custom wards
    
    1.30
    - Added support for OnCreateObject, detection type priority is now 1)packet, 2)spellcast, 3)objectcreate
    - Fixed LagFree Quality option, it was always set to 30
    - Key to hold to draw hidden objects ranges is now customizable
    
    1.20
    - Added Clone Revealer function
    - Tweaked the experimental drawing. Now it is more precise and works also from the bush. Small imprecisions still occurring
    - Added an experimental drawing method with obstacles/brushes for hidden objects ranges (thanks Hellsinger for the code)
    
    1.10
    - Performance improvement: less checks when searching for hidden objects near mouse
    - Performance improvement: added choice of cross type for waypoint, including a light one
    
    1.00
    - Performance improvement: changed to lag-free circles
    - Color customization for hidden objects (green, pink, trap, custom)
    - Color customization for cross and lines color (waypoints)
    - Color customization for SS timer on minimap
    - Changed config in SS timer on minimap to seconds
    - Change color for expiring wards (you can choose which color and time in seconds)
    - Support for custom minimap ratio on hidden objects sprites drawing (more accurate position)
    
    0.60
    - Support for Traps and Vision delete on destroy/trigger
    - Changed Nidalee's traps from 4 to 2 minutes
    
    0.50
    - Fixed support for onProcessSpell with creator's name
    - Added support for single objects text color
    - Don't draw allied hidden objects on map
    
    0.40
    - Added Waypoints system (credits to Dienofail)
    - Added minimap SS timer

    0.30
    - Added AutoUpdater
    - Splitted config in wards and traps and also in teams

    0.20
    - Added Maokai sproutling to traps
    - Added Quill Armor ward

    0.10
    - First release
    - Show hidden objects (credits to Jorj)
    - Keys to add and remove custom wards
    
    ToDo
    - serialize hidden objects on map to support reload without loosing them
    - mark the ground where a teemo is standing hidden with his passive, just like an hidden object
    - reset to "false" every champ toggle of the autoping at every game start and remove the toggle for autoping
    - add a minion balance-bar
    - side HUD size scalable from options
    - add objects placed limit to remove wards (3 green wards, 1 pink ward, heim turret limit, 3 cait traps etc etc)
    - add support for force respawn timer blue/red on other maps (atm only summoner rift is supported)
]]
