function OnRecvPacket(p)
    if p.header == 201 then
        p.pos = 6
        local networkID = p:DecodeF()
        p.pos = 11
        local vote = p:Decode1()
        
        if vote > 0 then 
            vote = "<font color=\"#FF0000\">NO</font>"
        else 
            vote = "<font color=\"#00FF00\">YES</font>"
        end
        
        local who = objManager:GetObjectByNetworkId(networkID)
        if who then
            PrintChat("<font color=\"#00FF00\">[Surrender]</font><font color=\"#FFCC00\"> "..who.name.." ("..who.charName..")</font><font color=\"#00FF00\"> voted </font>"..vote)
        end
    end
end

--[[
Packet 201: summoner voted to surrend

game 1   2   2   2   3   3   3   3   3
pos yes yes no  yes yes yes no  no  no
01  00  00  00  00  00  00  00  00  00
02  00  00  00  00  00  00  00  00  00
03  00  00  00  00  00  00  00  00  00
04  00  00  00  01  00  00  00  00  00
05  03  03  19  1A  03  01  00  00  00 -- ???
06  19  1B  00  00  1D  1B  1A  1C  19 -- network id
07  00  00  00  01  00  00  00  00  00 -- network id
08  00  00  00  01  00  00  00  00  00 -- network id
09  40  40  40  40  40  40  40  40  40 -- network id
10  01  01  01  02  01  02  02  02  02 -- ???
11  00  00  01  01  00  00  01  02  03 -- VOTE: yes if 0, else no
12  01  05  05  05  05  05  05  05  05 -- total numbers of vote (first game was a custom alone)
13  C8  64  64  64  64  64  64  64  64 -- team (c8 = 200, 64 = 100)
14  00  00  00  00  00  00  00  00  00
15  00  00  00  00  00  00  00  00  00
16  00  00  00  00  00  00  00  00  00
17  00  00  00  01  00  00  00  00  00
18  03  03  19  1A  03  01  00  00  00 -- ???
19  70  70  70  70  70  70  70  70  70 -- constants
20  42  42  42  42  42  42  42  42  42 -- constants

--]]
