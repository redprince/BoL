_G.PRINCESMITE = 1.0

--[[ CONSTANTS ]]--
local TYPE_SKILLSHOT, TYPE_TARGET, TYPE_ACTIVE = 1, 2, 3
local SMITE_RANGE = 750
local ITEM_SPIRIT_STONE = 1080
local ITEM_SPIRIT_ELDER_LIZARD = 3209
local ITEM_SPIRIT_SPECTRAL_WRAITH = 3206
local Q,W,E,R = 0,1,2,3

--[[ VARIABLES ]]--
local smiteSkill = nil
local smiteDamage = 
    function(target)
        if smiteSkill and myHero:CanUseSpell(smiteSkill) then 
            return myHero:GetSpellData(smiteSkill).currentCd > 0 and 0 
            or math.max(370 + (20 * myHero.level), 330 + (30 * myHero.level), 240 + (40 * myHero.level), 100 + (50 * myHero.level))
        else
            return 0
        end
    end
local spellDamage = function(target) return 0 end
local spellSlot = nil
local casted_one = false
local casted_two = false
local smiteReady = false
local spellReady = false
local nasusQStacks = 0
local monstersTable = {}
local smiteOn = true

--[[ CALLBACKS ]]--
Callback.Bind('Load', function()
    Callback.Bind('GameStart', OnGameStart)
end)


--[[ CALLBACKS FUNCTIONS ]]--
function OnGameStart()
    PrinceSmite = MenuConfig("PrinceSmite")
    PrinceSmite:Icon("fa-flash")
	
    PrinceSmite:KeyBinding("keyToggle", "Key to toggle on/off", "J")
    PrinceSmite.keyToggle:Toggle(true)
    
    PrinceSmite:KeyBinding("keyHold", "Key to hold to activate", "K")
    PrinceSmite.keyHold:Toggle(false)
    PrinceSmite:Boolean("draw", "Draw smite range", true)
	
    PrinceSmite:Menu("hpbar", "Drawings")
    PrinceSmite.hpbar:Boolean("draw", "Draw smite line on mob hp bar", true)
	
    PrinceSmite:Menu("acs", "AutoCast Spells")
    PrinceSmite.acs:Boolean("nunuQ", "Nunu Q", true)
    PrinceSmite.acs:Boolean("choR", "ChoGat R", true)
    PrinceSmite.acs:Boolean("eliseQ", "Elise Q", true)
    PrinceSmite.acs:Boolean("kayleQ", "Kayle Q", true)
    PrinceSmite.acs:Boolean("luxR", "Lux R", true)
    PrinceSmite.acs:Boolean("voliW", "Volibear W", true)
    PrinceSmite.acs:Boolean("wwQ", "Warwick Q", true)
    PrinceSmite.acs:Boolean("nasusQ", "Nasus Q", true)
    PrinceSmite.acs:Boolean("olafE", "Olaf E", true)
    PrinceSmite.acs:Boolean("shacoE", "Shaco E", true)
    PrinceSmite.acs:Boolean("viE", "Vi E", true)
    PrinceSmite.acs:Boolean("panthQ", "Pantheon Q", true)
    PrinceSmite.acs:Boolean("yiQ", "Master Yi Q", true)
    PrinceSmite.acs:Boolean("wuQ", "Wukong Q", true)
    PrinceSmite.acs:Boolean("khaQ", "Kha'Zix Q", true)
    
	PrinceSmite:Separator()
	
    PrinceSmite:Menu("mobs", 'Monsters')
    
    PrinceSmite.mobs:Section("SR", 'Summoner Rift')
    PrinceSmite.mobs:Boolean("Worm", "Baron", true)
    PrinceSmite.mobs:Boolean("Dragon", "Dragon", true)
    PrinceSmite.mobs:Boolean("AncientGolem", "Ancient Golem", true)
    PrinceSmite.mobs:Boolean("LizardElder", "Lizard Elder", true)
    PrinceSmite.mobs:Boolean("GiantWolf", "Giant Wolf", false)
    PrinceSmite.mobs:Boolean("GreatWraith", "Great Wraith", false)
    PrinceSmite.mobs:Boolean("Wraith", "Wraith", false)
    PrinceSmite.mobs:Boolean("Golem", "Golem", false)
    
    PrinceSmite.mobs:Section("TT", 'Twisted Treeline')
    PrinceSmite.mobs:Boolean("TT_Spiderboss", "Vilemaw", true)
    PrinceSmite.mobs:Boolean("TT_NGolem", "Golem", true)
    PrinceSmite.mobs:Boolean("TT_NWolf", "Wolf", true)
    PrinceSmite.mobs:Boolean("TT_NWraith", "Wraith", true)
    
    if     myHero:GetSpellData(Game.Slots.SUMMONER_1).name:lower() == "summonersmite" then smiteSkill = Game.Slots.SUMMONER_1
    elseif myHero:GetSpellData(Game.Slots.SUMMONER_2).name:lower() == "summonersmite" then smiteSkill = Game.Slots.SUMMONER_2
    end

    -- this script won't do anything if you don't have smite or a supported skill
    if not smiteSkill
    and myHero.charName ~= "Nunu" 
    and myHero.charName ~= "Chogath" 
    and myHero.charName ~= "Elise" 
    and myHero.charName ~= "Lux" 
    and myHero.charName ~= "Kayle"
    and myHero.charName ~= "Volibear"
    and myHero.charName ~= "Warwick"
    and myHero.charName ~= "Nasus"
    and myHero.charName ~= "Olaf"
    and myHero.charName ~= "Shaco"
    and myHero.charName ~= "Vi"
    and myHero.charName ~= "Pantheon"
    and myHero.charName ~= "MasterYi"
    then return end
    
    --[[ CHARACTER DEPENDANT SPELLS ]]--
    if myHero.charName == "Nunu" then
        spellSlot = Q
        spellDamage = function(target) return 250 + (150 * myHero:GetSpellData(spellSlot).level) end
        spellRange = 125 +20 -- not true, is 125, but without this he doesn't cast it from AA range
        spellType = TYPE_TARGET
    elseif myHero.charName == "Chogath" then
        spellSlot = R
        spellDamage = function(target) return 1000 + (myHero.ap * 0.7) end
        spellRange = 175
        spellType = TYPE_TARGET
    elseif myHero.charName == "Elise" then -- todo add spider/human damage distinction
        spellSlot = Q
        spellDamage = function(target) return 5 + (35 * myHero:GetSpellData(spellSlot).level) + (math.min(target.health * 0.08, 25 + (25*myHero:GetSpellData(spellSlot).level))) end
        spellRange = 475
        spellType = TYPE_TARGET
    elseif myHero.charName == "Kayle" then
        spellSlot = Q
        spellDamage = function(target) return 10 + (50 * myHero:GetSpellData(spellSlot).level) + (myHero.ap * 0.6) end
        spellRange = 650
        spellType = TYPE_TARGET
    elseif myHero.charName == "Lux" then
        spellSlot = R
        spellDamage = function(target) return 200 + (100 * myHero:GetSpellData(spellSlot).level) + (myHero.ap * 0.75) end
        spellRange = 3340
        spellType = TYPE_SKILLSHOT
    elseif myHero.charName == "Volibear" then
        spellSlot = W
        spellDamage = function(target) return 35 + (45 * myHero:GetSpellData(spellSlot).level) + ((myHero.maxHealth - ((440 + 86 * myHero.level) * 1.03)) * 0.15) * (1 + (target.maxHealth - target.health) / target.maxHealth) end
        spellRange = 400
        spellType = TYPE_TARGET
    elseif myHero.charName == "Warwick" then
        spellSlot = Q
        spellDamage = function(target) return 25 + (50 * myHero:GetSpellData(spellSlot).level) + myHero.ap end
        spellRange = 400
        spellType = TYPE_TARGET
    elseif myHero.charName == "Nasus" then
        spellSlot = Q
        spellDamage = function(target) return 10 + (20 * myHero:GetSpellData(spellSlot).level) + myHero.damage + myHero.addDamage + nasusQStacks end
        spellRange = 100
        spellType = TYPE_ACTIVE
    elseif myHero.charName == "Olaf" then
        spellSlot = E
        spellDamage = function(target) return 25 + (45 * myHero:GetSpellData(spellSlot).level) + ((myHero.damage + myHero.addDamage) * 0.4) end
        spellRange = 325
        spellType = TYPE_TARGET
    elseif myHero.charName == "Shaco" then
        spellSlot = E
        spellDamage = function(target) return 10 + (40 * myHero:GetSpellData(spellSlot).level) + myHero.addDamage + myHero.ap end
        spellRange = 625
        spellType = TYPE_TARGET
    elseif myHero.charName == "Vi" then
        spellSlot = E
        spellDamage = function(target) return -10 + (15 * myHero:GetSpellData(spellSlot).level) + (myHero.addDamage * 0.15) + (myHero.ap * 0.7) end
        spellRange = 600
        spellType = TYPE_TARGET
    elseif myHero.charName == "Pantheon" then
        spellSlot = Q
        spellDamage = 
            function(target) 
                if target.health < (target.maxHealth * 0.15) and myHero:GetSpellData(_E).level > 0 then
                    return 2 * (25 + (40 * myHero:GetSpellData(spellSlot).level) + (myHero.addDamage * 1.4))
                else
                    return 25 + (40 * myHero:GetSpellData(spellSlot).level) + (myHero.addDamage * 1.4)
                end
            end
        spellRange = 600
        spellType = TYPE_TARGET
    elseif myHero.charName == "MasterYi" then
        spellSlot = Q
        spellDamage = function(target) return 40 + (60 * myHero:GetSpellData(spellSlot).level) + myHero.addDamage end
        spellRange = 600
        spellType = TYPE_TARGET
    elseif myHero.charName == "MonkeyKing" then
        spellSlot = Q
        spellDamage = function(target) return (30 * myHero:GetSpellData(spellSlot).level) + (myHero.addDamage * 1.1) end
        spellRange = 100 + 50 -- not true, untested, may not cast without this addition
        spellType = TYPE_ACTIVE
    elseif myHero.charName == "KhaZix" then -- todo add evolution damage
        spellSlot = Q
        spellDamage = function(target) return 45 + (25 * myHero:GetSpellData(spellSlot).level) + (myHero.addDamage * 1.2) end
        spellRange = 325
        spellType = TYPE_TARGET
    end
    
    for i = 0,Game.ObjectCount() do
        local minion = Game.Object(i)
        if minion and minion.valid and minion.type == "obj_AI_Minion" then
            if not minion.dead and minion.team == 300 then
                table.insert(monstersTable, minion)
            end
        end
    end

    Callback.Bind('RecvPacket', OnRecvPacket)
    Callback.Bind('Tick', OnTick)
    Callback.Bind('Draw', OnDraw)
    Callback.Bind('CreateObj', OnCreateObj)
    Callback.Bind('DeleteObj', OnDeleteObj)
    
    Game.Chat.Print("<font color=\"#FFD51C\">[PrinceSmite ".._G.PRINCESMITE.."] Script loaded</font>")
end

function OnCreateObj(object)
    Utility.DelayAction(function() DelayedObjectCreation(object) end, 50)
end

function OnDeleteObj(object)
    if object and object.valid and object.type == "obj_AI_Minion" then
        if object.team == 300 then
            for i, mob in pairs(monstersTable) do
                if mob.networkID == object.networkID then
                    table.remove(monstersTable, i)
                end
            end
        end
    end
end

function DelayedObjectCreation(object)
    if object and object.valid and object.type == "obj_AI_Minion" then
        if not object.dead and object.team == 300 then
            table.insert(monstersTable, object)
        end
    end
end

function OnTick()
    smiteOn = PrinceSmite.keyHold:IsPressed() or PrinceSmite.keyToggle:IsPressed()
    
    if smiteOn then
        -- now search for valid mobs
        for i, mob in pairs(monstersTable) do
            CheckSmiteAndSpell(mob)
        end
    end
end

function OnRecvPacket(p)
    if p.header == 254 and p.size == 12 and myHero.charName == "Nasus" then
        p.pos = 1
        local networkID = p:Decode4()
        if(myHero.networkID == networkID) then
            p.pos = 8
            local tmp = p:Decode4()
            if (tmp == nasusQStacks + 3) or (tmp == nasusQStacks + 6) then
                nasusQStacks = tmp
            end
        end
    end
    if p.header == 101 and smiteOn then
        p.pos = 1
        local networkID = p:Decode4()
        local mob = Game.ObjectByNetworkId(networkID)
        CheckSmiteAndSpell(mob)
    end
end

function OnDraw()
    -- draw smite range
    if smiteOn then -- and ReallyOnScreen(myHero.pos) then
        Graphics.DrawCircle(myHero.pos.x, myHero.pos.y, myHero.pos.z, SMITE_RANGE, Graphics.ARGB(255, 255, 0, 255))
    end
    
    -- draw smite line
    if PrinceSmite.hpbar.draw:Value() then
        for i, mob in pairs(monstersTable) do
            if mob and mob.valid and mob.visible and not mob.dead and CheckMobEnabled(mob.charName) -- mob must be activated from our config
            and ((myHero:DistanceTo(mob) < SMITE_RANGE * 2) or (spellRange and myHero:DistanceTo(mob) < spellRange)) -- check for distance, in most cases we will stop here consuming less cpu
            then 
                Graphics.DrawCircle(mob.pos.x, mob.pos.y, mob.pos.z, 300, Graphics.ARGB(255, 255, 0, 0))
                
                if mob.health < mob.maxHealth then
                    if smiteSkill and myHero:GetSpellData(smiteSkill).currentCd < 0.01  and myHero:DistanceTo(mob) < SMITE_RANGE then
                        local smiteRange = ((mob.health - smiteDamage(mob)) * 300) / (mob.maxHealth )
                        Graphics.DrawCircle(mob.pos.x, mob.pos.y, mob.pos.z, math.min(300, 300 - smiteRange), Graphics.ARGB(255, 255, 0, 255))
                    elseif spellDamage(mob) > 0 and myHero:GetSpellData(spellSlot).currentCd < 0.01 and myHero:CanUseSpell(spellSlot) and checkAutoCast() then  
                        local spellRange = ((mob.health - adjustDmg(spellDamage(mob))) * 300) / (mob.maxHealth )
                        Graphics.DrawCircle(mob.pos.x, mob.pos.y, mob.pos.z, math.min(300, 300 - spellRange), Graphics.ARGB(255, 0, 255, 255))
                    end
                end
            end
        end
    end
end

--[[ CUSTOM FUNCTIONS ]]--
function CheckMobEnabled(mobname)
    if mobname == "Worm" and PrinceSmite.mobs.Worm:Value()
    or mobname == "Dragon" and PrinceSmite.mobs.Dragon:Value()
    or mobname == "AncientGolem" and PrinceSmite.mobs.AncientGolem:Value()
    or mobname == "LizardElder" and PrinceSmite.mobs.LizardElder:Value()
    or mobname == "GiantWolf" and PrinceSmite.mobs.GiantWolf:Value()
    or mobname == "GreatWraith" and PrinceSmite.mobs.GreatWraith:Value()
    or mobname == "Wraith" and PrinceSmite.mobs.Wraith:Value()
    or mobname == "Golem" and PrinceSmite.mobs.Golem:Value()
    or mobname == "TT_Spiderboss" and PrinceSmite.mobs.TT_Spiderboss:Value()
    or mobname == "TT_NGolem" and PrinceSmite.mobs.TT_NGolem:Value()
    or mobname == "TT_NWolf" and PrinceSmite.mobs.TT_NWolf:Value()
    or mobname == "TT_NWraith" and PrinceSmite.mobs.TT_NWraith:Value()
    then 
        return true
    else 
        return false
    end
end

-- smite core
function CheckSmiteAndSpell(mob)
    if mob and mob.valid and mob.type == "obj_AI_Minion" and not mob.dead and CheckMobEnabled(mob.charName)
    and ((myHero:DistanceTo(mob) < SMITE_RANGE * 2) or (spellRange and myHero:DistanceTo(mob) < spellRange))
    then
        smiteReady = false
        spellReady = false
        
        -- check for smite ready
        if smiteSkill and myHero:GetSpellData(smiteSkill).currentCd < 0.01  and myHero:DistanceTo(mob) < SMITE_RANGE then
            smiteReady = true
        end
        
        -- check for spell ready
        if spellDamage(mob) > 0 and myHero:GetSpellData(spellSlot).currentCd < 0.01 and myHero:CanUseSpell(spellSlot) and checkAutoCast() then
            spellReady = true
        end
        
        -- case 1: most important, if smite is ready, and enemy is killable with smite, then smite it
    
        if smiteReady and mob.health < smiteDamage(mob) then
            princeCastSmite(mob)
        end
        -- case 2: check for spell
        if spellReady and ((myHero:DistanceTo(mob) < spellRange + mob.boundingRadius) or TYPE_ACTIVE) then
            -- two subcases here
            if smiteReady then -- if smite is ready then check for smite damage + spell damage
                if mob.health < smiteDamage(mob) + adjustDmg(spellDamage(mob)) then
                    princeCastSpell(mob)
                end
            else -- if smite is not ready, check if we can last hit the mob with spell
                if mob.health < adjustDmg(spellDamage(mob)) then
                    princeCastSpell(mob)
                end
            end
        end
    end
end

-- check if we can autocast a spell
function checkAutoCast()
    if myHero.charName == "Nunu" and PrinceSmite.acs.nunuQ then
        return true
    elseif myHero.charName == "Chogath" and PrinceSmite.acs.choR then
        return true
    elseif myHero.charName == "Elise" and PrinceSmite.acs.eliseQ then
        return true
    elseif myHero.charName == "Kayle" and PrinceSmite.acs.kayleQ then
        return true
    elseif myHero.charName == "Lux" and PrinceSmite.acs.luxR then
        return true
    elseif myHero.charName == "Volibear" and PrinceSmite.acs.voliW then
        return true
    elseif myHero.charName == "Warwick" and PrinceSmite.acs.wwQ then
        return true
    elseif myHero.charName == "Nasus" and PrinceSmite.acs.nasusQ then
        return true
    elseif myHero.charName == "Olaf" and PrinceSmite.acs.olafE then
        return true
    elseif myHero.charName == "Shaco" and PrinceSmite.acs.shacoE then
        return true
    elseif myHero.charName == "Vi" and PrinceSmite.acs.viE then
        return true
    elseif myHero.charName == "Pantheon" and PrinceSmite.acs.panthQ then
        return true
    elseif myHero.charName == "MasterYi" and PrinceSmite.acs.yiQ then
        return true
    elseif myHero.charName == "MonkeyKing" and PrinceSmite.acs.wuQ then
        return true
    elseif myHero.charName == "KhaZix" and PrinceSmite.acs.khaQ then
        return true
    else
        return false
    end
end

-- General cast
function princeCastSmite(target)
    if not casted_one then
        --Allclass.Cast(smiteSkill, target)
        myHero:CastSpell(smiteSkill, target)
        casted_one = true
        Utility.DelayAction(function() casted_one = false end, 5000)
    end
end

function princeCastSpell(target)
    if not casted_two then
        if spellType == TYPE_SKILLSHOT then
            --Allclass.Cast(spellSlot, Vector2(target.pos.x, target.pos.z), true)
            myHero:CastSpell(spellSlot, target.pos.x, target.pos.z)
        elseif spellType == TYPE_TARGET then
            --Allclass.Cast(spellSlot, target, true)
            myHero:CastSpell(spellSlot, target)
        elseif spellType == TYPE_ACTIVE then
            --Allclass.Cast(spellSlot, myHero, true)
            myHero:CastSpell(spellSlot, myHero)
        end
        casted_two = true
        Utility.DelayAction(function() casted_two = false end, 5000)
    end
end

-- check for bonus damage to monsters from items
function adjustDmg(spellDamage)
    local dmg = spellDamage
    if myHero.GetInventorySlot(myHero, ITEM_SPIRIT_STONE) then
        dmg = spellDamage + (spellDamage * 0.2)
    elseif myHero.GetInventorySlot(myHero, ITEM_SPIRIT_ELDER_LIZARD) then
        dmg = spellDamage + (spellDamage * 0.2)
    elseif myHero.GetInventorySlot(myHero, ITEM_SPIRIT_SPECTRAL_WRAITH) then
        dmg = spellDamage + (spellDamage * 0.3)
    end
    return spellDamage -- instead of dmg, tempfix until function fixed
end

-- rounds a number
function round(num, dec)
    return string.format("%." .. (dec or 0) .. "f", num)
end

function isJungleMob(mob)
    if mob and mob.valid and mob.health > 0 and not mob.dead and mob.visible and mob.isTargetable and mob.team ~= 100 and mob.team ~= 200 then
        return true
    else
        return false
    end
end

-- check if a position is inside the current screen
function OnScreen(x, y) --Accepts one point, two points (line) or two numbers
    local typex = type(x)
    if typex == "number" then 
        return x <= WINDOW_W and x >= 0 and y >= 0 and y <= WINDOW_H
    elseif typex == "userdata" or typex == "table" then
        local p1, p2, p3, p4 = {x = 0,y = 0}, {x = WINDOW_W,y = 0}, {x = 0,y = WINDOW_H}, {x = WINDOW_W,y = WINDOW_H}
        return OnScreen(x.x, x.z or x.y) or (y and OnScreen(y.x, y.z or y.y) or 
            IsLineSegmentIntersection(x,y,p1,p2) or IsLineSegmentIntersection(x,y,p3,p4) or 
            IsLineSegmentIntersection(x,y,p1,p3) or IsLineSegmentIntersection(x,y,p2,p4))
    end
end

local function IsClockWise(A,B,C)
    return VectorDirection(A,B,C)<=0
end

local function IsCounterClockWise(A,B,C)
    return not IsClockWise(A,B,C)
end

function IsLineSegmentIntersection(A,B,C,D)
    return IsClockWise(A, C, D) ~= IsClockWise(B, C, D) and IsClockWise(A, B, C) ~= IsClockWise(A, B, D)
end

function VectorDirection(v1, v2, v)
    return ((v.z or v.y) - (v1.z or v1.y)) * (v2.x - v1.x) - ((v2.z or v2.y) - (v1.z or v1.y)) * (v.x - v1.x) 
end

-- check if a position is inside the current screen
function ReallyOnScreen(pos)
    local scrPos = Graphics.WorldToScreen(pos)
    if OnScreen({ x = scrPos.x, y = scrPos.y }, { x = scrPos.x, y = scrPos.y }) then
        return true
    else
        return false
    end
end