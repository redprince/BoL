local voteVar = 0
local new = {}
    new['surr_start_end_header'] = 0x00E8 --
    new['surr_vote_header'] = 0x00B8 --
    new['surr_vote_netid_pos'] = 13 --
    new['surr_vote_val_pos'] = 22 --

local decoded_table_4_new = { -- 5.18 surrender netids
    [0x01] = 0x00,[0x02] = 0x60,[0x03] = 0xA0,[0x04] = 0xE0,[0x05] = 0x10,[0x06] = 0x74,[0x07] = 0xB4,[0x08] = 0xF4,
    [0x09] = 0x24,[0x0A] = 0x40,[0x0B] = 0x80,[0x0C] = 0xC0,[0x0D] = 0x34,[0x0E] = 0x5F,[0x0F] = 0x9F,[0x10] = 0xDF,
    [0x11] = 0x0F,[0x12] = 0x6F,[0x13] = 0xAF,[0x14] = 0xEF,[0x15] = 0x1F,[0x16] = 0x73,[0x17] = 0xB3,[0x18] = 0xF1,
    [0x19] = 0x21,[0x1A] = 0x4F,[0x1B] = 0x8F,[0x1C] = 0xCF,[0x1D] = 0x33,[0x1E] = 0x5B,[0x1F] = 0x9B,[0x20] = 0xDB,
    [0x21] = 0x0B,[0x22] = 0x6B,[0x23] = 0xAB,[0x24] = 0xEB,[0x25] = 0x1B,[0x26] = 0x7F,[0x27] = 0xBF,[0x28] = 0xFF,
    [0x29] = 0x2F,[0x2A] = 0x4B,[0x2B] = 0x8B,[0x2C] = 0xCB,[0x2D] = 0x3F,[0x2E] = 0x55,[0x2F] = 0x95,[0x30] = 0xD5,
    [0x31] = 0x05,[0x32] = 0x65,[0x33] = 0xA5,[0x34] = 0xE5,[0x35] = 0x15,[0x36] = 0x78,[0x37] = 0xB8,[0x38] = 0xF8,
    [0x39] = 0x28,[0x3A] = 0x45,[0x3B] = 0x85,[0x3C] = 0xC5,[0x3D] = 0x38,[0x3E] = 0x51,[0x3F] = 0x91,[0x40] = 0xD1,
    [0x41] = 0x01,[0x42] = 0x61,[0x43] = 0xA1,[0x44] = 0xE1,[0x45] = 0x11,[0x46] = 0x75,[0x47] = 0xB5,[0x48] = 0xF5,
    [0x49] = 0x25,[0x4A] = 0x41,[0x4B] = 0x81,[0x4C] = 0xC1,[0x4D] = 0x35,[0x4E] = 0x5C,[0x4F] = 0x9C,[0x50] = 0xDC,
    [0x51] = 0x0C,[0x52] = 0x6C,[0x53] = 0xAC,[0x54] = 0xEC,[0x55] = 0x1C,[0x56] = 0x70,[0x57] = 0xB0,[0x58] = 0xF2,
    [0x59] = 0x22,[0x5A] = 0x4C,[0x5B] = 0x8C,[0x5C] = 0xCC,[0x5D] = 0x30,[0x5E] = 0x58,[0x5F] = 0x98,[0x60] = 0xD8,
    [0x61] = 0x08,[0x62] = 0x68,[0x63] = 0xA8,[0x64] = 0xE8,[0x65] = 0x18,[0x66] = 0x7C,[0x67] = 0xBC,[0x68] = 0xFC,
    [0x69] = 0x2C,[0x6A] = 0x48,[0x6B] = 0x88,[0x6C] = 0xC8,[0x6D] = 0x3C,[0x6E] = 0x56,[0x6F] = 0x96,[0x70] = 0xD6,
    [0x71] = 0x06,[0x72] = 0x66,[0x73] = 0xA6,[0x74] = 0xE6,[0x75] = 0x16,[0x76] = 0x79,[0x77] = 0xB9,[0x78] = 0xF9,
    [0x79] = 0x29,[0x7A] = 0x46,[0x7B] = 0x86,[0x7C] = 0xC6,[0x7D] = 0x39,[0x7E] = 0x52,[0x7F] = 0x92,[0x80] = 0xD2,
    [0x81] = 0x02,[0x82] = 0x62,[0x83] = 0xA2,[0x84] = 0xE2,[0x85] = 0x12,[0x86] = 0x76,[0x87] = 0xB6,[0x88] = 0xF6,
    [0x89] = 0x26,[0x8A] = 0x42,[0x8B] = 0x82,[0x8C] = 0xC2,[0x8D] = 0x36,[0x8E] = 0x5D,[0x8F] = 0x9D,[0x90] = 0xDD,
    [0x91] = 0x0D,[0x92] = 0x6D,[0x93] = 0xAD,[0x94] = 0xED,[0x96] = 0x71,[0x97] = 0xB1,[0x98] = 0xF3,[0x99] = 0x23,
    [0x9A] = 0x4D,[0x9B] = 0x8D,[0x9C] = 0xCD,[0x9D] = 0x31,[0x9E] = 0x59,[0x9F] = 0x99,[0xA0] = 0xD9,[0xA1] = 0x09,
    [0xA2] = 0x69,[0xA3] = 0xA9,[0xA4] = 0xE9,[0xA5] = 0x19,[0xA6] = 0x7D,[0xA7] = 0xBD,[0xA8] = 0xFD,[0xA9] = 0x2D,
    [0xAA] = 0x49,[0xAB] = 0x89,[0xAC] = 0xC9,[0xAD] = 0x3D,[0xAE] = 0x57,[0xAF] = 0x97,[0xB0] = 0xD7,[0xB1] = 0x07,
    [0xB2] = 0x67,[0xB3] = 0xA7,[0xB4] = 0xE7,[0xB5] = 0x17,[0xB6] = 0x7A,[0xB7] = 0xBA,[0xB8] = 0xFA,[0xB9] = 0x2A,
    [0xBA] = 0x47,[0xBB] = 0x87,[0xBC] = 0xC7,[0xBD] = 0x3A,[0xBE] = 0x53,[0xBF] = 0x93,[0xC0] = 0xD3,[0xC1] = 0x03,
    [0xC2] = 0x63,[0xC3] = 0xA3,[0xC4] = 0xE3,[0xC5] = 0x13,[0xC6] = 0x77,[0xC7] = 0xB7,[0xC8] = 0xF7,[0xC9] = 0x27,
    [0xCA] = 0x43,[0xCB] = 0x83,[0xCC] = 0xC3,[0xCD] = 0x37,[0xCE] = 0x5E,[0xCF] = 0x9E,[0xD0] = 0xDE,[0xD1] = 0x0E,
    [0xD2] = 0x6E,[0xD3] = 0xAE,[0xD4] = 0xEE,[0xD5] = 0x1E,[0xD6] = 0x72,[0xD7] = 0xB2,[0xD8] = 0xF0,[0xD9] = 0x20,
    [0xDA] = 0x4E,[0xDB] = 0x8E,[0xDC] = 0xCE,[0xDD] = 0x32,[0xDE] = 0x5A,[0xDF] = 0x9A,[0xE0] = 0xDA,[0xE1] = 0x0A,
    [0xE2] = 0x6A,[0xE3] = 0xAA,[0xE4] = 0xEA,[0xE5] = 0x1A,[0xE6] = 0x7E,[0xE7] = 0xBE,[0xE8] = 0xFE,[0xE9] = 0x2E,
    [0xEA] = 0x4A,[0xEB] = 0x8A,[0xEC] = 0xCA,[0xED] = 0x3E,[0xEE] = 0x54,[0xEF] = 0x94,[0xF0] = 0xD4,[0xF1] = 0x04,
    [0xF2] = 0x64,[0xF3] = 0xA4,[0xF4] = 0xE4,[0xF5] = 0x14,[0xF6] = 0x7B,[0xF7] = 0xBB,[0xF8] = 0xFB,[0xF9] = 0x2B,
    [0xFA] = 0x44,[0xFB] = 0x84,[0xFC] = 0xC4,[0xFD] = 0x3B,[0xFE] = 0x50,[0xFF] = 0x90,[0x00] = 0xD0,
}

function OnRecvPacket(p)
    if p.header == new['surr_start_end_header'] then
        voteVar = 0
    elseif p.header == new['surr_vote_header'] then
        p.pos = new['surr_vote_netid_pos']
        local networkID = PacketDecryptF(p:DecodeF(), decoded_table_4_new)
        local who = objManager:GetObjectByNetworkId(networkID)
        
        p.pos = new['surr_vote_val_pos']
        local vote = p:Decode1()
        
        if voteVar == 0 then
            voteVar = vote
        end
        
        if vote == voteVar then
            voteTxt = "<font color=\"#00FF00\">YES</font>"
        else 
            voteTxt = "<font color=\"#FF0000\">NO</font>"
        end
        
        if who then
            PrintChat("<font color=\"#00FF00\">[Surrender]</font><font color=\"#FFCC00\"> "..who.charName.."</font><font color=\"#00FF00\"> voted </font>"..voteTxt)
        else
            print("Error on detecting who votes, detected vote is: "..voteTxt)
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
