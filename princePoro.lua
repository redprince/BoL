--[[ PrincePoro ]]
local poroVersion = 1.0

-- Are you trying to search poroes elsewhere from howling abyss? Nope. YOU FOOL!
if GetGame().map.index ~= 12 then return end

-- create some messages (feel free to add your own messages here)
local messages = {
"Poro is now fed. Mission accomplished.",
"PoroFirst!",
"I fed a poro, now I can go AFK",
"Poro fed. GG.",
"Who the hell fed that poro?!",
}
-- special messages
if myHero.charName=="Darius" then
    messages[#messages +1] = "PoroDunked!"
elseif myHero.charName=="Braum" then
    messages[#messages +1] = "Eat, eat and grow strong."
    messages[#messages +1] = "Train hard, little poro, and one day you will be strong like... baby!"
end

local PORO_SNACK = 2052
local nextRefresh = 0
local movementEnabled = true
local chatSent = false
local mySpawn = GetSpawnPos()
local Poro = nil

function OnLoad()
    PrincePoro = scriptConfig("PrincePoro "..poroVersion, "PrincePoro")
    PrincePoro:addParam("autoSay", "Inform your team when you fed a Poro", SCRIPT_PARAM_ONOFF, true)
    PrincePoro:addParam("autoRun", "Automatic run like no tomorrow", SCRIPT_PARAM_ONOFF, true)
    PrincePoro:addParam("writeAcquired", "Automatic run like no tomorrow", SCRIPT_PARAM_ONOFF, true)
    PrincePoro:addParam("end", "Seriously, you wanted more options?", SCRIPT_PARAM_INFO, "") -- srsly? SRSLY?! eh? EHHH?!
end

function OnTick()
    if GetInventorySlotItem(PORO_SNACK) and GetDistance(myHero, mySpawn) > 1000 then
        -- If we are here, we check for a valid Poro on the map.
        -- If at least one Poro is found, we have to run LIKE NO TOMORROW to the nearest one
        
        -- step 1: Get the nearest fucking poro
        if PrincePoro.autoRun then
            if not Poro then
                Poro = getNearestPoro()
            elseif nextRefresh < GetTickCount() then
            -- step 2 (optional): Fucking move to the selected poro position, then...
                movementEnabled = true
                myHero:MoveTo(Poro.x, Poro.z)
                movementEnabled = false
                nextRefresh = GetTickCount() + 500
            end
        elseif not Poro then
            Poro = getNearestPoro()
        end
        
        -- step 3: Use Poro Snack to feed that little bastard
        if Poro and GetInventorySlotItem(PORO_SNACK) and GetDistance(myHero, Poro) < 50 then
            if CastItem(PORO_SNACK) == true then
                movementEnabled = true
            
                -- ....aaaand say something!
                if PrincePoro.autoSay and not chatSent then -- bug of CastItem, it goes "true" for 5-10 cycles instead of only one and causes chat spam
                    SendChat(messages[math.random(#messages)])
                    chatSent = true
                end
            end
        end
    end
end

-- Other shit this script needs to run
function OnDraw()
    if PrincePoro.writeAcquired and Poro and GetInventorySlotItem(PORO_SNACK) then
        DrawTextA(">> NEW PORO TARGET ACQUIRED <<", 60, WINDOW_W/2, WINDOW_H/7, ARGB(255,255,0,0),"center")
    end
end

function getNearestPoro()
    local dist = 0
    local maxdist = 500000
    local myPoro
    local poros = minionManager(MINION_ALL, maxdist, myHero, MINION_SORT_MAXHEALTH_DEC)
    
    for i, poro in ipairs(poros.objects) do
        if poro.name == "Poo" then
            dist = GetDistance(myHero, poro)
            if dist < maxdist then
                maxdist = dist
                myPoro = poro
            end
        end
    end
    
    return myPoro
end

function OnSendPacket(p)
    if VIP_USER then
		local packet = Packet(p)
        if packet:get('name') == 'S_MOVE' and packet:get('sourceNetworkId') == myHero.networkID then
            if movementEnabled == false then
                packet:block()
            end
        end
    end
end