local no_count = 0

Callback.Bind('Load', function()
    Callback.Bind('RecvPacket', OnRecvPacket)
    print("Loaded Surrender Votes - v 1.0.0")
end)

function OnRecvPacket(p)
    if p.header == 165 then
        no_count = 0
    elseif p.header == 201 then
        p.pos = 6
        local netID = p:Decode4()
        p.pos = 11
        local vote = p:Decode1()
        
        if vote == (no_count + 1) then
            vote = "<font color=\"#FF0000\">NO</font>"
            no_count = no_count + 1
        else 
            vote = "<font color=\"#00FF00\">YES</font>"
        end
        
        local who = Game.ObjectByNetworkId(netID)
        if who then
            Game.Chat.Print("<font color=\"#00FF00\">[Surrender]</font><font color=\"#FFCC00\"> "..who.name.." ("..who.charName..")</font><font color=\"#00FF00\"> voted </font>"..vote)
        end
    end
end
