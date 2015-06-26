--[[
__________        .__                   __________                __  .__                          
\______   \_______|__| ____   ____  ____\______   \_____    _____/  |_|  |__   ____  ____   ____   
 |     ___/\_  __ \  |/    \_/ ___\/ __ \|     ___/\__  \  /    \   __\  |  \_/ __ \/  _ \ /    \  
 |    |     |  | \/  |   |  \  \__\  ___/|    |     / __ \|   |  \  | |   Y  \  ___(  <_> )   |  \ 
 |____|     |__|  |__|___|  /\___  >___  >____|    (____  /___|  /__| |___|  /\___  >____/|___|  / 
                          \/     \/    \/               \/     \/          \/     \/           \/  

--]] 

local AutoUpdate = true
_G.PrincePantheonVersion = 5.12

if myHero.charName ~= "Pantheon" then return end

assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("TGJHOMJNNFM") 

local LoadedMessage = "Version ".._G.PrincePantheonVersion.." loaded. "
local FARMING, HARASSING, IDLE = 1,2,3
local TIAMAT, HYDRA = 3077, 3074
local VP, Sac, Mma, SxOrbw = nil, false, false, false
local RangeQ, ReadyQ =  600, false
local RangeW, ReadyW =  600, false
local RangeE, ReadyE =  600-100, false
local RangeR, ReadyR = 5500, false
local RangeHydra, ReadyHydra = 350, false
local timers = {checkSpells = 0, checkItems = 0}
local enemies = GetEnemyHeroes()
local allies = GetAllyHeroes()
local curManaPct = 0
local StopMovements = false
local igniteSlot, HydraSlot = nil, nil
local curStatus = IDLE
local myTS

function ActivateScript()
    PrincePantheon = scriptConfig("PrincePantheon","PrincePantheon")
    PrincePantheon:addParam("autoIgnite", "Autocast ignite when killable", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon:addSubMenu("Poke Settings (during farm)", "poke")
    PrincePantheon.poke:addParam("enabled", "Autocast Q on enemy when farming", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon.poke:addParam("manaQ", "But only if mana above (%)", SCRIPT_PARAM_SLICE, 50, 1, 100, 0)
    PrincePantheon:addParam("IvImode", "1v1 mode", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon:addSubMenu("Harass Settings (normal)", "harass")
    PrincePantheon.harass:addParam("startQ", "Start with Q", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon.harass:addParam("useW", "Then jump", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon.harass:addParam("useE", "And use E", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon.harass:addParam("useQ", "Always cast Q above (%)", SCRIPT_PARAM_SLICE, 25, 15, 100, 0)
    PrincePantheon.harass:addParam("manaE", "Don't cast E if mana below (%)", SCRIPT_PARAM_SLICE, 35, 1, 100, 0)
    PrincePantheon.harass:addParam("hydra", "Use Tiamat/hydra", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon:addSubMenu("Harass Settings (1v1)", "IvI")
    PrincePantheon.IvI:addParam("key", "Key to hold for 1v1 mode (default spacebar)", SCRIPT_PARAM_ONKEYDOWN, false, GetKey("J"))
    PrincePantheon.IvI:addParam("smartW", "Optimize W to block most", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon.IvI:addParam("pctQ", "Always cast Q above (%)", SCRIPT_PARAM_SLICE, 25, 15, 100, 0)
    PrincePantheon.IvI:addParam("manaE", "Don't cast E if mana below (%)", SCRIPT_PARAM_SLICE, 35, 1, 100, 0)
    PrincePantheon.IvI:addParam("hydra", "Use Tiamat/hydra", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon:addSubMenu("Drawings", "drawings")
    PrincePantheon.drawings:addParam("showQWR", "Show Q/W/R range", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon.drawings:addParam("QWRcolor", "Q/W/R range color", SCRIPT_PARAM_COLOR, {155, 0, 255, 0})
    PrincePantheon.drawings:addParam("showR", "Show R range", SCRIPT_PARAM_ONOFF, true)
    PrincePantheon.drawings:addParam("Rcolor", "R range color", SCRIPT_PARAM_COLOR, {155, 0, 200, 200})
    PrincePantheon:addSubMenu("Orbwalker", "orbwalker")
    myTS = TargetSelector(TARGET_LESS_CAST_PRIORITY, RangeQ, DAMAGE_PHYSICAL)
    PrincePantheon:addTS(myTS)
    
    DetectOrbWalker()
    TargetSelectorPriorities()
    HookPackets()
    
    AddDrawCallback(function() MyOnDraw() end)
    AddProcessSpellCallback(function(unit, spell) MyOnProcessSpell(caster,spell) end)
    AddTickCallback(function() MyOnTick() end)
    AddAnimationCallback(function(unit, animation) MyOnAnimation(unit, animation) end)
    AddSendPacketCallback(function(p) MyOnSendPacket(p) end)
end

function OnLoad()
    -- Autoupdate
    if AutoUpdate then
        local ToUpdate = {}
        ToUpdate.Version = _G.PrincePantheonVersion
        ToUpdate.UseHttps = true
        ToUpdate.Host = "raw.githubusercontent.com"
        ToUpdate.VersionPath = "/redprince/BoL/master/PrincePantheon.version"
        ToUpdate.ScriptPath =  "/redprince/BoL/master/PrincePantheon.lua"
        ToUpdate.SavePath = SCRIPT_PATH..GetCurrentEnv().FILE_NAME
        ToUpdate.CallbackUpdate = function(NewVersion,OldVersion) print("<font color=\"#FF794C\"><b>PrincePantheon: </b></font> <font color=\"#FFDFBF\">Updated from "..OldVersion.." to "..NewVersion..". </b></font>") end
        ToUpdate.CallbackNoUpdate = function(OldVersion) print("<font color=\"#FF794C\"><b>PrincePantheon: </b></font> <font color=\"#FFDFBF\">"..LoadedMessage.."</b></font>") end
        ToUpdate.CallbackNewVersion = function(NewVersion) print("<font color=\"#FF794C\"><b>PrincePantheon: </b></font> <font color=\"#FFDFBF\">New Version found ("..NewVersion.."). Please wait until its downloaded</b></font>") end
        ToUpdate.CallbackError = function(NewVersion) print("<font color=\"#FF794C\"><b>PrincePantheon: </b></font> <font color=\"#FFDFBF\">Error while Downloading. Please try again.</b></font>") end
        ScriptUpdate(ToUpdate.Version,ToUpdate.UseHttps, ToUpdate.Host, ToUpdate.VersionPath, ToUpdate.ScriptPath, ToUpdate.SavePath, ToUpdate.CallbackUpdate,ToUpdate.CallbackNoUpdate, ToUpdate.CallbackNewVersion,ToUpdate.CallbackError)
    end
    
    -- Auth
    local thisScript = "pp"
    local HWID = Base64Encode(tostring(os.getenv("PROCESSOR_REVISION")..os.getenv("USERNAME")..os.getenv("PROCESSOR_IDENTIFIER")..os.getenv("COMPUTERNAME")..os.getenv("PROCESSOR_LEVEL")))
    local myUs = Base64Encode(GetUser():lower())
    local vipZ = nil
    if VIP_USER then vipZ = "1" else vipZ = "0" end
    
    SxWebResult('princeview.com', '/auth1/auth.php?a='..HWID..'&b='..myUs..'&c='..vipZ..'&d='..thisScript, 
        function(result)
            if result == "AUTH_FREE" then
                ActivateScript()
                PrincePantheon:permaShow('IvImode')
                SxWebResult('princeview.com', '/auth1/message.php?status=ok&script='..thisScript, function(result) print(result) end)
            elseif result == "AUTH_FAIL" then
                SxWebResult('princeview.com', '/auth1/message.php?status=no&script='..thisScript, function(result) print(result) end)
            end
        end
    )
    
    if myHero:GetSpellData(SUMMONER_1).name:lower():find("summonerdot") then 
        igniteSlot = SUMMONER_1
    elseif myHero:GetSpellData(SUMMONER_2).name:lower():find("summonerdot") then 
        igniteSlot = SUMMONER_2
    end
    
    if not ReadyQ and myHero:GetSpellData(_Q).currentCd == 0 then ReadyQ = true end
    if not ReadyW and myHero:GetSpellData(_W).currentCd == 0 then ReadyW = true end
    if not ReadyE and myHero:GetSpellData(_E).currentCd == 0 then ReadyE = true end
    if not ReadyR and myHero:GetSpellData(_R).currentCd == 0 then ReadyR = true end
end

function DetectOrbWalker()
    if _G.Reborn_Loaded and not _G.Reborn_Initialised then
        DelayAction(DetectOrbWalker, 1)
    elseif _G.Reborn_Initialised and not Sac then
        Sac = true
        PrincePantheon:addParam("orb","Using SAC as orbwalker", SCRIPT_PARAM_INFO, "")
        LoadedMessage = LoadedMessage .."Using SAC as orbwalker."
    elseif FileExist(LIB_PATH .. "SxOrbWalk.lua") and not SxOrbw then 
        require("SxOrbWalk") 
        SxOrbw = true
        LoadedMessage = LoadedMessage .."Using SxOrb as orbwalker."
        SxOrb:LoadToMenu(PrincePantheon.orbwalker, false)
        DelayAction(function() if SxOrb.Version < 2.44 then print("Your SxOrbWalk library is outdated, please get the latest version!") end end, 5)
    elseif _G.MMA_Loaded and not Mma then
        Mma = true
        PrincePantheon:addParam("orb","Using MMA as orbwalker", SCRIPT_PARAM_INFO, "")
        LoadedMessage = LoadedMessage .."Using MMA as orbwalker"
    end
end
DelayAction(DetectOrbWalker, 4)

function MyOnDraw()
    if not myHero.dead then
        if PrincePantheon.drawings.showQWR and ReallyOnScreen(myHero.pos) then 
            DrawCircle3D(myHero.x, myHero.y, myHero.z, RangeQ, 2, configToColor(PrincePantheon.drawings.QWRcolor), 30) 
        end
        if PrincePantheon.drawings.showR then
            DrawCircle3D(myHero.x, myHero.y, myHero.z, RangeR, 1, configToColor(PrincePantheon.drawings.Rcolor), 30) 
            DrawCircleMinimap(myHero.x, myHero.y, myHero.z, RangeR, 1, configToColor(PrincePantheon.drawings.Rcolor), 50)
        end
    end
end

function MyOnAnimation(unit, animation)
    if unit.networkID == myHero.networkID and animation == "Spell3" then
        DelayAction(function() StopMovements = false end, 1.5)
    end
end

function MyOnSendPacket(p)
    if p.header == 0x0067 and StopMovements then
        p:Block()
    end
end

function MyOnTick()
    if timers.checkSpells < os.clock() then
        UpdateValues()
        curStatus = UpdateStatus()
        
        local myTarget = GetMyTarget()
        if myTarget then
            if StopMovements and not ValidTarget(myTarget, RangeE) then
                StopMovements = false
            end
            
            -- poke mode
            if not StopMovements and PrincePantheon.poke and curStatus == FARMING and curManaPct > PrincePantheon.poke.manaQ then
                if ReadyQ and ValidTarget(myTarget, RangeQ) then
                    CastSpell(_Q, myTarget)
                end
            end
            
            -- harass mode
            if curStatus == HARASSING then
                -- auto igniteSlot
                if PrincePantheon.autoIgnite and igniteSlot and ValidTarget(myTarget, 600) and myHero:CanUseSpell(igniteSlot) == READY then
                    CastSpell(igniteSlot, myTarget)
                end
            
                -- check kill with Q
                if myHero:GetSpellData(_E).level > 0 and ValidTarget(myTarget, RangeQ) and ReadyQ then
                    if myTarget.health / myTarget.maxHealth < 0.15 and getDmg("Q", myTarget, myHero) * 2 > myTarget.health then
                        CastSpell(_Q, myTarget)
                    elseif getDmg("Q", myTarget, myHero) > myTarget.health then
                        CastSpell(_Q, myTarget)
                    end
                end
                    
                if PrincePantheon.IvImode then
                    -- 1v1 mode
                    if not StopMovements and ReadyQ and ValidTarget(myTarget, RangeQ) and curManaPct > PrincePantheon.IvI.pctQ then
                        CastSpell(_Q, myTarget)
                    end
                    
                    if not StopMovements and ReadyW and ValidTarget(myTarget, RangeW) then
                        if PrincePantheon.IvI.smartW then
                            if GetDistance(myHero, myTarget) > 300 or UnitHasBuff("pantheonpassiveshield", myHero) == false then
                                CastSpell(_W, myTarget)
                            end
                        else
                            if ValidTarget(myTarget, RangeW) then
                                CastSpell(_W, myTarget)
                            end
                        end
                    end
                    
                    if not StopMovements and PrincePantheon.IvI.hydra and HydraSlot and ReadyHydra and ValidTarget(myTarget, RangeHydra) then
                        CastSpell(HydraSlot)
                    end
                    
                    if ReadyE and ValidTarget(myTarget, RangeE) and curManaPct > PrincePantheon.IvI.manaE then
                        StopMovements = true
                        DelayAction(function() StopMovements = false end, 1.5)
                        CastSpell(_E, myTarget)
                    end
                else
                    -- normal harass
                    if not StopMovements and PrincePantheon.harass.startQ and ReadyQ and ValidTarget(myTarget, RangeQ) and curManaPct > PrincePantheon.harass.useQ then
                        CastSpell(_Q, myTarget)
                    end
                    
                    if not StopMovements and PrincePantheon.harass.useW and ReadyW and ValidTarget(myTarget, RangeW) then
                        CastSpell(_W, myTarget)
                    end
                    
                    if not StopMovements and PrincePantheon.harass.hydra and HydraSlot and ReadyHydra and ValidTarget(myTarget, RangeHydra) then
                        CastSpell(HydraSlot)
                    end
                    
                    if PrincePantheon.harass.useE and ReadyE and ValidTarget(myTarget, RangeE) then
                        StopMovements = true
                        DelayAction(function() StopMovements = false end, 1.5)
                        CastSpell(_E, myTarget)
                    end
                end
            end
        end
        
        timers.checkSpells = os.clock() + 0.1
    end
    
    if timers.checkItems < os.clock() then
        local tmp = HydraSlot
        HydraSlot = GetInventorySlotItem(HYDRA) and GetInventorySlotItem(HYDRA) or GetInventorySlotItem(TIAMAT)
        
        if tmp ~= HydraSlot then ReadyHydra = true end
        
        timers.checkItems = os.clock() + 1
    end
end

function UpdateStatus()
    if Sac then
        if _G.AutoCarry.Keys.MixedMode or _G.AutoCarry.Keys.LastHit or _G.AutoCarry.Keys.LaneClear then
            return FARMING
        elseif _G.AutoCarry.Keys.AutoCarry then
            return HARASSING
        else
            return IDLE
        end
    elseif Mma then
        if _G.MMA_LaneClear or _G.MMA_LastHit or _G.MMA_HybridMode then
            return FARMING
        elseif _G.MMA_Orbwalker then
            return HARASSING
        else
            return IDLE
        end
    elseif SxOrbw then
        if SxOrb.IsLaneClear or SxOrb.IsLastHit then
            return FARMING
        elseif SxOrb.IsHarass or SxOrb.IsFight then
            return HARASSING
        else
            return IDLE
        end
    else 
        return IDLE
    end
end

function UpdateValues()
    curManaPct = (myHero.mana / myHero.maxMana) * 100
    
    if not ReadyQ and myHero:GetSpellData(_Q).currentCd == 0 then ReadyQ = true end
    if not ReadyW and myHero:GetSpellData(_W).currentCd == 0 then ReadyW = true end
    if not ReadyE and myHero:GetSpellData(_E).currentCd == 0 then ReadyE = true end
    if not ReadyR and myHero:GetSpellData(_R).currentCd == 0 then ReadyR = true end
    
    myTS:update()
end

function MyOnProcessSpell(caster,spell)
    if caster and caster.valid and caster.networkID == myHero.networkID then
        if     spell.name == "PantheonQ" then
            ReadyQ = false
        elseif spell.name == "PantheonW" then
            ReadyW = false
        elseif spell.name == "PantheonE" then
            ReadyE = false
        elseif spell.name == "PantheonRJump" then
            ReadyR = false
        elseif HydraSlot and spell.name == "ItemTiamatCleave" then
            ReadyHydra = false
            DelayAction(function() ReadyHydra = true end, 10.5)
        end
    end
end

function GetMyTarget()
    if Sac then
        return _G.AutoCarry.Crosshair:GetTarget()
    elseif Mma then
        return _G.MMA_ConsideredTarget()
    elseif SxOrbw then
        SxOrb:ForceTarget(myTS.target)
        return myTS.target
    else
        return myTS.target
    end
end

function UnitHasBuff(name, unit)
    for i = 1, unit.buffCount do
        local buff = unit:getBuff(i)
        if (buff.valid and BuffIsValid(buff) and (buff.name:lower() == name:lower())) then
            return true
        end
    end
    return false
end

local roles = {
    ADC = {
        "Ashe", "Caitlyn", "Corki", "Draven", "Ezreal", "Graves", "Jayce", "Jinx", "Kalista", "KogMaw", "Lucian", "MasterYi",
        "MissFortune", "Pantheon", "Quinn", "Shaco", "Sivir", "Talon", "Tryndamere", "Tristana", "Twitch", "Urgot",
        "Varus", "Vayne", "Yasuo", "Zed"
    },
    AP = {
        "Annie", "Ahri", "Akali", "Anivia", "Annie", "Azir", "Brand", "Cassiopeia", "Diana", "Evelynn", "FiddleSticks", 
        "Fizz", "Gragas", "Heimerdinger", "Karthus", "Kassadin", "Katarina", "Kayle", "Kennen", "Leblanc", "Lissandra",
        "Lux", "Malzahar", "Mordekaiser", "Morgana", "Nidalee", "Orianna", "Ryze", "Sion", "Swain", "Syndra", "Teemo", 
        "TwistedFate", "Veigar", "VelKoz", "Viktor", "Vladimir", "Xerath", "Ziggs", "Zyra"
    },
    Support = {
        "Alistar", "Bard", "Braum", "Blitzcrank", "Janna", "Karma", "Leona", "Lulu", "Nami", "Nunu", "Sona", "Soraka", 
        "Taric", "Thresh", "Zilean"
    },
    OffTank = {
        "Aatrox", "Darius", "Elise", "Fiora", "Gangplank", "Garen", "Gnar", "Irelia", "JarvanIV", "Jax", "Khazix", "LeeSin",
        "Nocturne", "Olaf", "Poppy", "RekSai", "Renekton", "Rengar", "Riven", "Rumble", "Shyvana", "Trundle", "Udyr", "Vi", 
        "MonkeyKing", "XinZhao"
    },
    Tank = {
        "Amumu", "Chogath", "DrMundo", "Galio", "Hecarim", "Malphite", "Maokai", "Nasus", "Rammus", "Sejuani", "Nautilus",
        "Shen", "Singed", "Skarner", "Volibear", "Warwick", "Yorick", "Zac"
    }
}

function TargetSelectorPriorities()
    if #enemies > 5 then
        for i, enemy in ipairs(enemies) do
            if inTable(roles.ADC, enemy.charName) then
                TS_SetHeroPriority(1, enemy.charName)
            elseif inTable(roles.AP, enemy.charName) then
                TS_SetHeroPriority(2, enemy.charName)
            elseif inTable(roles.Support, enemy.charName) then
                TS_SetHeroPriority(3, enemy.charName)
            elseif inTable(roles.OffTank, enemy.charName) then
                TS_SetHeroPriority(4, enemy.charName)
            elseif inTable(roles.Tank, enemy.charName) then
                TS_SetHeroPriority(5, enemy.charName)
            else
                PrintChat("Failed to set role on "..enemy.charName..". Please report to RedPrince.")
            end
        end
    end
end

function inTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then return true end
    end
    return false
end

function GetAlliesNear(target, distance)
    local count = 0
    for i, ally in ipairs(allies) do
        if GetDistance(target.pos, ally.pos) < distance then
            count = count + 1
        end
    end
    return count
end

function GetEnemiesNear(target, distance)
    local count = 0
    for i, enemy in ipairs(enemies) do
        if GetDistance(target.pos, enemy.pos) < distance then
            count = count + 1
        end
    end
    return count
end

function GetNearestEnemy()
    local distance = math.huge
    local nearest = nil
    for i, enemy in ipairs(enemies) do
        if GetDistance(myHero.pos, enemy.pos) < distance then
            nearest = target
        end
    end
    return nearest
end

function configToColor(color)
    return ARGB(color[1], color[2], color[3], color[4])
end

function ReallyOnScreen(pos)
    if not pos.z then
        pos.z = pos.y
        pos.y = myHero.y
    end
    local scrPos = WorldToScreen(D3DXVECTOR3(pos.x, pos.y, pos.z))
    if OnScreen({ x = scrPos.x, y = scrPos.y }, { x = scrPos.x, y = scrPos.y }) then
        return true
    else
        return false
    end
end

class "SxWebResult"
function SxWebResult:__init(Host, Path, Callback)
    self.Host = Host
    self.Path = Path
    self.Callback = Callback
    self.LuaSocket = require("socket")

    self.Socket = self.LuaSocket.connect(Host, 80)
    self.Socket:send("GET "..self.Path.."&rand="..math.random(99999999).." HTTP/1.0\r\nHost: "..Host.."\r\n\r\n")
    self.Socket:settimeout(0, 'b')
    self.Socket:settimeout(99999999, 't')
    self.LastPrint = ""
    self.File = ""
    AddTickCallback(function() self:GetResult() end)
end

function SxWebResult:GetResult()
    if self.Status == 'closed' then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)

    if self.Receive then
        if self.LastPrint ~= self.Receive then
            self.LastPrint = self.Receive
            self.File = self.File .. self.Receive
        end
    end

    if self.Snipped ~= "" and self.Snipped then
        self.File = self.File .. self.Snipped
    end
    if self.Status == 'closed' then
        local HeaderEnd, ContentStart = self.File:find('\r\n\r\n')
        if HeaderEnd and ContentStart then
            self.Callback(self.File:sub(ContentStart + 1))
        else
            print('Error: Could not get end of Header')
        end
    end
end

class "ScriptUpdate"
function ScriptUpdate:__init(LocalVersion,UseHttps, Host, VersionPath, ScriptPath, SavePath, CallbackUpdate, CallbackNoUpdate, CallbackNewVersion,CallbackError)
    self.LocalVersion = LocalVersion
    self.Host = Host
    self.VersionPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..VersionPath)..'&rand='..math.random(99999999)
    self.ScriptPath = '/BoL/TCPUpdater/GetScript'..(UseHttps and '5' or '6')..'.php?script='..self:Base64Encode(self.Host..ScriptPath)..'&rand='..math.random(99999999)
    self.SavePath = SavePath
    self.CallbackUpdate = CallbackUpdate
    self.CallbackNoUpdate = CallbackNoUpdate
    self.CallbackNewVersion = CallbackNewVersion
    self.CallbackError = CallbackError
    AddDrawCallback(function() self:OnDraw() end)
    self:CreateSocket(self.VersionPath)
    self.DownloadStatus = 'Connect to Server for VersionInfo'
    AddTickCallback(function() self:GetOnlineVersion() end)
end

function ScriptUpdate:print(str)
    print('<font color="#FFFFFF">'..os.clock()..': '..str)
end

function ScriptUpdate:OnDraw()
    if self.DownloadStatus ~= 'Downloading Script (100%)' and self.DownloadStatus ~= 'Downloading VersionInfo (100%)'then
        DrawText('Download Status: '..(self.DownloadStatus or 'Unknown'),50,10,50,ARGB(0xFF,0xFF,0xFF,0xFF))
    end
end

function ScriptUpdate:CreateSocket(url)
    if not self.LuaSocket then
        self.LuaSocket = require("socket")
    else
        self.Socket:close()
        self.Socket = nil
        self.Size = nil
        self.RecvStarted = false
    end
    self.LuaSocket = require("socket")
    self.Socket = self.LuaSocket.tcp()
    self.Socket:settimeout(0, 'b')
    self.Socket:settimeout(99999999, 't')
    self.Socket:connect('sx-bol.eu', 80)
    self.Url = url
    self.Started = false
    self.LastPrint = ""
    self.File = ""
end

function ScriptUpdate:Base64Encode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x)
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

function ScriptUpdate:GetOnlineVersion()
    if self.GotScriptVersion then return end

    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading VersionInfo (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</s'..'ize>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading VersionInfo ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading VersionInfo (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.File:find('<scr'..'ipt>')
        local ContentEnd, _ = self.File:find('</sc'..'ript>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            self.OnlineVersion = (Base64Decode(self.File:sub(ContentStart + 1,ContentEnd-1)))
            self.OnlineVersion = tonumber(self.OnlineVersion)
            if self.OnlineVersion > self.LocalVersion then
                if self.CallbackNewVersion and type(self.CallbackNewVersion) == 'function' then
                    self.CallbackNewVersion(self.OnlineVersion,self.LocalVersion)
                end
                self:CreateSocket(self.ScriptPath)
                self.DownloadStatus = 'Connect to Server for ScriptDownload'
                AddTickCallback(function() self:DownloadUpdate() end)
            else
                if self.CallbackNoUpdate and type(self.CallbackNoUpdate) == 'function' then
                    self.CallbackNoUpdate(self.LocalVersion)
                end
            end
        end
        self.GotScriptVersion = true
    end
end

function ScriptUpdate:DownloadUpdate()
    if self.GotScriptUpdate then return end
    self.Receive, self.Status, self.Snipped = self.Socket:receive(1024)
    if self.Status == 'timeout' and not self.Started then
        self.Started = true
        self.Socket:send("GET "..self.Url.." HTTP/1.1\r\nHost: sx-bol.eu\r\n\r\n")
    end
    if (self.Receive or (#self.Snipped > 0)) and not self.RecvStarted then
        self.RecvStarted = true
        self.DownloadStatus = 'Downloading Script (0%)'
    end

    self.File = self.File .. (self.Receive or self.Snipped)
    if self.File:find('</si'..'ze>') then
        if not self.Size then
            self.Size = tonumber(self.File:sub(self.File:find('<si'..'ze>')+6,self.File:find('</si'..'ze>')-1))
        end
        if self.File:find('<scr'..'ipt>') then
            local _,ScriptFind = self.File:find('<scr'..'ipt>')
            local ScriptEnd = self.File:find('</scr'..'ipt>')
            if ScriptEnd then ScriptEnd = ScriptEnd - 1 end
            local DownloadedSize = self.File:sub(ScriptFind+1,ScriptEnd or -1):len()
            self.DownloadStatus = 'Downloading Script ('..math.round(100/self.Size*DownloadedSize,2)..'%)'
        end
    end
    if self.File:find('</scr'..'ipt>') then
        self.DownloadStatus = 'Downloading Script (100%)'
        local a,b = self.File:find('\r\n\r\n')
        self.File = self.File:sub(a,-1)
        self.NewFile = ''
        for line,content in ipairs(self.File:split('\n')) do
            if content:len() > 5 then
                self.NewFile = self.NewFile .. content
            end
        end
        local HeaderEnd, ContentStart = self.NewFile:find('<sc'..'ript>')
        local ContentEnd, _ = self.NewFile:find('</scr'..'ipt>')
        if not ContentStart or not ContentEnd then
            if self.CallbackError and type(self.CallbackError) == 'function' then
                self.CallbackError()
            end
        else
            local newf = self.NewFile:sub(ContentStart+1,ContentEnd-1)
            local newf = newf:gsub('\r','')
            if newf:len() ~= self.Size then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
                return
            end
            local newf = Base64Decode(newf)
            if type(load(newf)) ~= 'function' then
                if self.CallbackError and type(self.CallbackError) == 'function' then
                    self.CallbackError()
                end
            else
                local f = io.open(self.SavePath,"w+b")
                f:write(newf)
                f:close()
                if self.CallbackUpdate and type(self.CallbackUpdate) == 'function' then
                    self.CallbackUpdate(self.OnlineVersion,self.LocalVersion)
                end
            end
        end
        self.GotScriptUpdate = true
    end
end
