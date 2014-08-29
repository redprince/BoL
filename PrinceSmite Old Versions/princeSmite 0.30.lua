_G.PRINCESMITEVERSION = 0.30
_G.PRINCESMITEUPDATE = true

--[[
    Thanks to Husky for jungle map position and eXtragoZ for selective mobs config
    
    Features
    - high precision, 0 delay (at least I hope)
    - lightweight as much as possible
    - lag free circle
    - customizable
    
    Changelog
    
    0.30
    - Added update checker
    - Draw a line with smite damage on mobs hp bar
    - Selective configuration based on current map
    - More default quality to smite range
    
    0.20
    - Performance improvement: do nothing if you don't have smite
    - Performance improvement: do nothing if we are in a not supported map
    - Draw smite range only if my char is on screen
    - Better camp names on config
    - Added opacity config for smite range
    
    0.10
    - First working version of script
    
    ToDo
    - Updater switch from manual to automatic
    - Improve the logic to limit checks if inside or outside the jungle
    - Add some spells to calculation with projectile speed
    - Put the damage calculation outside, doing that just twice per second
    - Add line drawing on mob healthbar for manual smite
    - Add an option to draw smite on every mob instead of only activated from config
--]]

-- this script won't do anything if you don't have smite
if GetSpellData(SUMMONER_1).name:lower() ~= "summonersmite" and GetSpellData(SUMMONER_2).name:lower() ~= "summonersmite" then return end

-- or if map is not supported
if GetGame().map.index ~= 1 and GetGame().map.index ~= 2 and GetGame().map.index ~= 10 then return end

--[[ CONSTANTS ]]--
local mapID = GetGame().map.index
local jungle = { --[[ polygons credits 100% to Husky, thanks! --]]
    topLeftOuterJungle     = Polygon(Point(1477, 4747),  Point(1502, 11232), Point(5951, 7201),   Point(3169, 4379)),
	topRightOuterJungle    = Polygon(Point(7001, 7957),  Point(2883, 12752), Point(9465, 12832),  Point(9830, 11003)),
	bottomLeftOuterJungle  = Polygon(Point(4112, 3575),  Point(6969, 6416),  Point(10922, 1920),  Point(4486, 1784)),
	bottomRightOuterJungle = Polygon(Point(12552, 3442), Point(8192, 7207),  Point(10693, 10119), Point(12610, 9769)),
}

--[[ VARIABLES ]]--
local checkInJungle = 0
local damage = 390
local finalupdate = false
local smiteSkill = nil
local jungleMobs = minionManager(MINION_JUNGLE, 15000)

--[[ USER CONFIGURATION MENU ]]--
PrinceSmite = scriptConfig("PrinceSmite ".._G.PRINCESMITEVERSION, "PrinceSmite")
PrinceSmite:addParam("keyToggle", "Key to toggle on/off autosmite", SCRIPT_PARAM_ONKEYTOGGLE, false, GetKey("J"))
PrinceSmite:addParam("keyHold", "Key to hold to autosmite", SCRIPT_PARAM_ONKEYDOWN, false, GetKey("K"))
PrinceSmite:addSubMenu("Draw smite on healthbar", "hpbar")
    PrinceSmite.hpbar:addParam("draw", "Draw smite line on mob Hp Bar", SCRIPT_PARAM_ONOFF, true)
    PrinceSmite.hpbar:addParam("color", "Color of the circle", SCRIPT_PARAM_COLOR, {255, 255, 255, 255}) -- white
PrinceSmite:addSubMenu("Draw range", "range")
    PrinceSmite.range:addParam("draw", "Draw smite range", SCRIPT_PARAM_LIST, 2, {"never","when active","always"}) -- 1 = never, 2 = when active, 3 = always
    PrinceSmite.range:addParam("quality", "Quality of the circle", SCRIPT_PARAM_SLICE, 30, 3, 50, 0)
    PrinceSmite.range:addParam("width", "Width of the circle", SCRIPT_PARAM_SLICE, 2, 1, 10, 0)
    PrinceSmite.range:addParam("color", "Color of the circle", SCRIPT_PARAM_COLOR, {255, 255, 0, 255}) -- pink
    PrinceSmite.range:addParam("opacity", "Opacity of the circle", SCRIPT_PARAM_SLICE, 150, 0, 255, 0)
PrinceSmite:addSubMenu("Autosmite Mobs", "mobs") --[[ credits to eXtragoZ for this section ]]--
if mapID == 1 or mapID == 2 then
    PrinceSmite.mobs:addParam("Worm", "Baron", SCRIPT_PARAM_ONOFF, true)
    PrinceSmite.mobs:addParam("Dragon", "Dragon", SCRIPT_PARAM_ONOFF, true)
    PrinceSmite.mobs:addParam("AncientGolem", "Ancient Golem", SCRIPT_PARAM_ONOFF, true)
    PrinceSmite.mobs:addParam("LizardElder", "Lizard Elder", SCRIPT_PARAM_ONOFF, true)
    PrinceSmite.mobs:addParam("GiantWolf", "Giant Wolf", SCRIPT_PARAM_ONOFF, false)
    PrinceSmite.mobs:addParam("GreatWraith", "Great Wraith", SCRIPT_PARAM_ONOFF, false)
    PrinceSmite.mobs:addParam("Wraith", "Wraith", SCRIPT_PARAM_ONOFF, false)
    PrinceSmite.mobs:addParam("Golem", "Golem", SCRIPT_PARAM_ONOFF, false)
elseif mapID == 10 then
    PrinceSmite.mobs:addParam("TTSpiderboss", "TT Spiderboss", SCRIPT_PARAM_ONOFF, true)
    PrinceSmite.mobs:addParam("TTNGolem", "TT Golem", SCRIPT_PARAM_ONOFF, true)
    PrinceSmite.mobs:addParam("TTNWolf", "TT Wolf", SCRIPT_PARAM_ONOFF, true)
    PrinceSmite.mobs:addParam("TTNWraith", "TT Wraith", SCRIPT_PARAM_ONOFF, true)
end

--[[ CUSTOM CALLBACKS ]]
AddGameOverCallback(function() finalupdate = true end)

--[[ BUILT-IN FUNCTIONS ]]
function OnLoad()
    if     myHero:GetSpellData(SUMMONER_1).name == "summonersmite" then smiteSkill = SUMMONER_1
    elseif myHero:GetSpellData(SUMMONER_2).name == "summonersmite" then smiteSkill = SUMMONER_2
    end
    
    if _G.PRINCESMITEUPDATE then
        CheckUpdate('https://raw.githubusercontent.com/redprince/BoL/master/princeSmite.version')
    end
    
    PrintChat("<font color=\"#F244E4\">[PrinceSmite ".._G.PRINCESMITEVERSION.."] Script loaded</font>")
end

function OnTick()
    if (PrinceSmite.keyHold or PrinceSmite.keyToggle) -- active
    and checkInJungle < os.clock() -- inside jungle or tick not limited (next check ready)
    then
        if insideJungle() then -- here the magic happens
            -- update jungle mobs status
            jungleMobs:update()
            
            -- now search for valid mobs inside smite range
            for i, mob in pairs(jungleMobs.objects) do
                if GetDistance(mob) < 750 -- first check if mob is in range. In most cases we will stop here, using less resources
                and not mob.dead -- mob must be alive
                and PrinceSmite.mobs[mob.charName:gsub("_", "")] -- mob must be activated from our config
                then
                    -- calculate smite damage now that is needed
                    if     myHero.level > 13 then damage = 100 + (myHero.level * 50)
                    elseif myHero.level >  8 then damage = 240 + (myHero.level * 40)
                    elseif myHero.level >  3 then damage = 330 + (myHero.level * 30)
                    elseif myHero.level >  1 then damage = 370 + (myHero.level * 20)
                    end
            
                    if mob.health <= damage then -- mob must have less health than our smite damage
                        CastSpell(smiteSkill, mob) -- checks passed, let's smite!
                    end
                end
            end
        else -- tick limiter
            checkInJungle = os.clock() + 0.3 -- check again in 0.3 seconds
        end
    end
end

function OnDraw()
    -- return if game is over
    if finalupdate then return end
    
    -- draw smite range (~750)
    if PrinceSmite.range.draw == 3 -- draw always
    or (PrinceSmite.range.draw == 2 and (PrinceSmite.keyHold or PrinceSmite.keyToggle)) -- draw when active
    then
        if ReallyOnScreen(myHero.pos) then -- only if my hero is on screen (will also avoid glitches)
            DrawCircle3D(myHero.x, myHero.y, myHero.z, 750, PrinceSmite.range.width, configToColor(PrinceSmite.range.color, PrinceSmite.range.opacity), PrinceSmite.range.quality)
        end
    end
    
    -- draw smite line
    if PrinceSmite.hpbar.draw then
        for i, mob in pairs(jungleMobs.objects) do
            if GetDistance(mob) < 750 -- first check if mob is in range. In most cases we will stop here, using less resources
            and PrinceSmite.mobs[mob.charName:gsub("_", "")] -- mob must be activated from our config
            then
                local barPos, distance = GetBarInfo(mob)
                local damageDistance = damage / (mob.maxHealth / distance)
                -- draw the line
                DrawRectangleAL(barPos.x + damageDistance, barPos.y, 2, 4, configToColor(PrinceSmite.hpbar.color))
                
                -- draw the outline
                if mob.health < damage then
                    OutLineBar(barPos.x, barPos.y, configToColor(PrinceSmite.hpbar.color))
                end
            end
        end
    end
end

--[[ CUSTOM FUNCTIONS ]]

-- return true if own hero is inside jungle, false if not
function insideJungle()
    return jungle['topLeftOuterJungle']:contains(Point(myHero.pos.x, myHero.pos.z)) or
           jungle['topRightOuterJungle']:contains(Point(myHero.pos.x, myHero.pos.z)) or
           jungle['bottomLeftOuterJungle']:contains(Point(myHero.pos.x, myHero.pos.z)) or
           jungle['bottomRightOuterJungle']:contains(Point(myHero.pos.x, myHero.pos.z))
end

-- converts a color from config to a color in ARGB
function configToColor(color, opacityOverwrite)
    if opacityOverwrite then
        return ARGB(opacityOverwrite, color[2], color[3], color[4])
    else
        return ARGB(color[1], color[2], color[3], color[4])
    end
end

-- check if a position is inside the current screen
function ReallyOnScreen(pos)
    local scrPos = WorldToScreen(D3DXVECTOR3(pos.x, pos.y, pos.z))
    if OnScreen({ x = scrPos.x, y = scrPos.y }, { x = scrPos.x, y = scrPos.y }) then
        return true
    else
        return false
    end
end

-- get hpbar info of a mob
function GetBarInfo(mob)
    local barPos = GetUnitHPBarPos(mob)
    local distance = 62
    
    if mob.charName == "Dragon" then
        barPos.x = barPos.x - 31
        barPos.y = barPos.y - 7
        distance = 124
    elseif mob.charName == "Worm" then
        barPos.x = barPos.x - 31
        distance = 124
    elseif mob.charName == "TT_Spiderboss" then
        barPos.x = barPos.x - 31
        distance = 124
    else
        barPos.x = barPos.x - 32
    end
    
    return barPos, distance
end

-- from Honda7 proTracker script
function OutLineBar(x, y, color)
    DrawRectangleAL(x, y - 3, 64, 1, color) -- Top
    DrawRectangleAL(x, y + 2, 64, 1, color) -- Bottom
    DrawRectangleAL(x, y, 1, 5, color) -- Left
    DrawRectangleAL(x + 63, y, 1, 5, color) -- Right
end

-- from Honda7 proTracker script
function DrawRectangleAL(x, y, w, h, color)
    local Points = {}
    Points[1] = D3DXVECTOR2(math.floor(x), math.floor(y))
    Points[2] = D3DXVECTOR2(math.floor(x + w), math.floor(y))
    DrawLines2(Points, math.floor(h), color)
end

-- print that an update has been found
function printUpdateFound(sv)
    local updateMsg = "<font color=\"#FFD51C\">[PrinceSmite] Update found. Get it on the forum! (</font>"
    updateMsg = updateMsg .. "<font color=\"#D13917\">".._G.PRINCESMITEUPDATE.."</font>"
    updateMsg = updateMsg .. "<font color=\"#FFD51C\"> => </font>"
    updateMsg = updateMsg .. "<font color=\"#1DB31D\">"..sv.."</font>"
    updateMsg = updateMsg .. "<font color=\"#FFD51C\">)</font>"
    PrintChat(updateMsg)
end

-- check for updates and print in chat if found
function CheckUpdate(url, file_exist, lenght)
    if not file_exist then
        if FileExist(LIB_PATH.."PrinceSmiteVersion") then os.remove(LIB_PATH.."PrinceSmiteVersion") end
        os.executePowerShellAsync([[$webClient = New-Object System.Net.WebClient;$webClient.DownloadFile(']]..url..[[', ']]..LIB_PATH.."PrinceSmiteVersion"..[[');exit;]])
        DelayAction(function() CheckUpdate(url, true, 0) end)
    else
        if FileExist(LIB_PATH.."PrinceSmiteVersion") then
            FileOpen = io.open(LIB_PATH.."PrinceSmiteVersion", "r")
            FileContent = FileOpen:read("*a")
            FileOpen:close()
            if #FileContent > 0 and #FileContent == lenght then
                os.remove(LIB_PATH.."PrinceSmiteVersion")
                local server_version = tonumber(FileContent)
                if server_version ~= nil and _G.PRINCEVERSION ~= nil then
                    if server_version > _G.PRINCEVERSION then
                        printUpdateFound(tostring(server_version))
                    end
                end
            else
                DelayAction(function() CheckUpdate(url, true, #FileContent) end, 0.2)
            end
        else
            DelayAction(function() CheckUpdate(url, true, 0) end)
        end
    end
end
