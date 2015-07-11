local old_vote = 0
local new = {}
    new['surr_start_end_header'] = 0x00CC --
    new['surr_vote_header'] = 0x001F --
    new['surr_vote_netid_pos'] = 19 --
    new['surr_vote_val_pos'] = 10 --
local decoded_table_4_new = { -- working for patch 5.13
    [0xDE] = 0x53,[0x06] = 0x49,[0x0A] = 0x2A,[0xE0] = 0xDF,[0xA1] = 0x38,[0x51] = 0x83,[0xA2] = 0x94,
    [0xE3] = 0x77,[0x21] = 0x0C,[0xE4] = 0x25,[0xA5] = 0x62,[0x53] = 0x40,[0xE6] = 0xD9,[0x87] = 0x46,
    [0x1D] = 0x64,[0x32] = 0x60,[0xA8] = 0x96,[0xE9] = 0xFB,[0x55] = 0x59,[0x8A] = 0x52,[0x8B] = 0x84,
    [0x2B] = 0x4B,[0x56] = 0x76,[0xAC] = 0x37,[0x77] = 0xD3,[0x0D] = 0x35,[0x12] = 0x4E,[0x58] = 0x82,
    [0xF0] = 0x5B,[0xF1] = 0xFA,[0x49] = 0xB4,[0xD2] = 0x3E,[0xF3] = 0xB0,[0x25] = 0x4C,[0x6A] = 0x3C,
    [0xF4] = 0x91,[0x31] = 0x43,[0xF7] = 0x10,[0x13] = 0x2B,[0xEC] = 0x6B,[0x5C] = 0x00,[0x22] = 0x26,
    [0xD1] = 0x0E,[0x46] = 0x3B,[0x47] = 0xD2,[0x92] = 0x5A,[0x94] = 0x78,[0x90] = 0x24,[0x5D] = 0x1E,
    [0xFA] = 0x44,[0x4D] = 0x3D,[0xC7] = 0x18,[0xEB] = 0x21,[0x9B] = 0xD6,[0x17] = 0x63,[0x3F] = 0x33,
    [0xBA] = 0x32,[0x5F] = 0x75,[0xBE] = 0xD1,[0xC0] = 0x27,[0x63] = 0xA9,[0x69] = 0xA5,[0x07] = 0xEA,
    [0x37] = 0x5C,[0x6F] = 0xC7,[0x76] = 0x15,
}

function OnRecvPacket(p)
    if p.header == new['surr_start_end_header'] then
        old_vote = 0
    elseif p.header == new['surr_vote_header'] then
        p.pos = new['surr_vote_netid_pos']
        local networkID = PacketDecryptF(p:DecodeF(), decoded_table_4_new)
        local who = objManager:GetObjectByNetworkId(networkID)
        
        p.pos = new['surr_vote_val_pos']
        local new_vote = p:Decode1()
        
        if old_vote == 0 then
            voteTxt = "<font color=\"#00FF00\">YES</font>"
        elseif new_vote ~= old_vote then
            voteTxt = "<font color=\"#FF0000\">NO</font>"
        else 
            voteTxt = "<font color=\"#00FF00\">YES</font>"
        end
        
        old_vote = new_vote
        
        if who then
            PrintChat("<font color=\"#00FF00\">[Surrender]</font><font color=\"#FFCC00\"> "..who.name.." ("..who.charName..")</font><font color=\"#00FF00\"> voted </font>"..voteTxt)
        end
    end
end

function PacketDecryptF(float, mapTable)
    local dummy = CLoLPacket(0)
    dummy:EncodeF(float)
    dummy.pos = dummy.pos - 4
    local F = { dummy:Decode1(), dummy:Decode1(), dummy:Decode1(), dummy:Decode1() }
    if mapTable[F[1]] and mapTable[F[2]] and mapTable[F[3]] and mapTable[F[4]] then
        dummy:Encode1(mapTable[F[1]])
        dummy:Encode1(mapTable[F[2]])
        dummy:Encode1(mapTable[F[3]])
        dummy:Encode1(mapTable[F[4]])
        dummy.pos = dummy.pos - 4
        return dummy:DecodeF()
    end
    return 0
end

-- scriptstatus
assert(load(Base64Decode("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"), nil, "bt", _ENV))() ScriptStatus("QDGCLIKIGJK") 
--