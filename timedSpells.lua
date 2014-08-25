local TIMERTYPE_ENDPOS = 1
local TIMERTYPE_STARTPOS = 2
local TIMERTYPE_CASTER = 3
local timedDrawings = {}

function OnDraw()
    for i, tDraw in pairs(timedDrawings) do
        if tDraw.endTime > os.clock() and tDraw.startTime < os.clock() then
            if tDraw.stickTo then
                DrawText3D(tostring(round(tDraw.endTime - os.clock(),1)), tDraw.stickTo.pos.x, tDraw.stickTo.pos.y, tDraw.stickTo.pos.z, 30, ARGB(255,255,255,255), true)
            else
                DrawText3D(tostring(round(tDraw.endTime - os.clock(),1)), tDraw.pos.x, tDraw.pos.y, tDraw.pos.z, 30, ARGB(255,255,255,255), true)
            end
        end
    end
end

function OnProcessSpell(caster,spell)
    if caster ~= nil and caster.valid and caster.type == "AIHeroClient" then
        if spell and spell.name and timerType(spell.name) then
            local tType, duration, delay = timerType(spell.name)
            
            if tType == TIMERTYPE_ENDPOS then
                addTimedDrawPos(spell.endPos.x, spell.endPos.y, spell.endPos.z, duration, delay)
            elseif tType == TIMERTYPE_STARTPOS then
                addTimedDrawPos(spell.startPos.x, spell.startPos.y, spell.startPos.z, duration, delay)
            elseif tType == TIMERTYPE_CASTER then
                addTimedDrawStick(caster, duration, delay)
            end
        end
    end
end

-- add a new timer in the timed drawings table (with position)
function addTimedDrawPos(posX, posY, posZ, duration, delay)
    local tmpID = math.random(1,10000)
    table.insert(timedDrawings, {id = tmpID, startTime = os.clock() + (delay or 0), endTime = os.clock() + (delay or 0) + duration, pos = Vector(posX, posY, posZ)})
    DelayAction(function() removeTimedDraw(tmpID) end, duration)
end

-- add a new timer in the timed drawings table (with target)
function addTimedDrawStick(target, duration, delay)
    local tmpID = math.random(1,10000)
    table.insert(timedDrawings, {id = tmpID, startTime = os.clock() + (delay or 0), endTime = os.clock() + (delay or 0) + duration, stickTo = target})
    DelayAction(function() removeTimedDraw(tmpID) end, duration)
end

-- remove a timer from the timed drawings table
function removeTimedDraw(timerID)
    for i, timedDr in pairs(timedDrawings) do
        if timedDr.id == timerID then
            table.remove(timedDrawings, i)
            break
        end
    end
end

-- check if a spell timer is supported, returning target type, duration and delay
function timerType(spellName)
    if spellName == "AkaliSmokeBomb" then -- akali bubble
        return TIMERTYPE_ENDPOS, 8
    elseif spellName == "UndyingRage" then -- trynda ult
        return TIMERTYPE_CASTER, 5, 0.5
    elseif spellName == "JudicatorIntervention" then -- kayle ult
        return TIMERTYPE_CASTER, 3
    elseif spellName == "ThreshW" then -- thresh lantern
        return TIMERTYPE_ENDPOS, 6
    end
end

-- rounds a number
function round(num, dec)
    return string.format("%." .. (dec or 0) .. "f", num)
end
