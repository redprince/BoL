local fileName = nil

function OnLoad()
    if not DirectoryExist(SCRIPT_PATH.."\\Chats") then
        CreateDirectory(SCRIPT_PATH.."\\Chats")
    end
    
    if GetInGameTimer() < 5 then -- new game detected, change filename
        print("[ChatSaver] Chat log enabled for this match")

        local tmpfileName = os.date("%y-%m-%d %H-%M-%S")
        fileName = tmpfileName..".txt"
        
        local lastDateFile = io.open(LIB_PATH .. "chatDumper.txt", "w")
        lastDateFile:write(fileName)
        lastDateFile:close()
        
        local chatFile = io.open(SCRIPT_PATH .. "\\Chats\\"..fileName, "a")
        chatFile:write("Map: "..GetGame().map.name.."\n")
        chatFile:write("\n-------- My Team -------- \n")
        chatFile:write(myHero.name.." ("..myHero.charName..") - ME\n")
        for i, ally in ipairs(GetAllyHeroes()) do
            chatFile:write(ally.name.." ("..ally.charName..")\n")
        end
        chatFile:write("\n-------- Enemy Team --------\n")
        for i, enemy in ipairs(GetEnemyHeroes()) do
            chatFile:write(enemy.name.." ("..enemy.charName..")\n")
        end
        chatFile:write("\n-------- CHAT --------\n\n\n")
        chatFile:close()
    else -- load filename of this match
        local lastDateFile = io.open(LIB_PATH .. "chatDumper.txt", "r")
        fileName = lastDateFile:read("*l")
        lastDateFile:close()
    end
end

function OnRecvChat(fromWho, text)
    if fileName then
        local t = GetInGameTimer()
        local m = math.floor(t/60)
        local s = math.ceil(t%60)
        local timestamp = os.date("%H:%M:%S.txt")
        local chatFile = io.open(SCRIPT_PATH .. "\\Chats\\"..fileName, "a")
        chatFile:write("["..m..":"..s.."] "..fromWho.name.." ("..fromWho.charName.."): "..text.."\n")
        chatFile:close()
    end
end
