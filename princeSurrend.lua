local old_vote = 0
local new = {}
    new['surr_start_end_header'] = 0x00CC --
    new['surr_vote_header'] = 0x001F --
    new['surr_vote_netid_pos'] = 19 --
    new['surr_vote_val_pos'] = 10 --
local decoded_table_4_new = { -- working for patch 5.13
    [0x01] = 0x1B,[0x03] = 0x51,[0x04] = 0x74,[0x06] = 0x49,[0x07] = 0xEA,[0x08] = 0x79,[0x09] = 0xD0,
    [0x0A] = 0x2A,[0x0B] = 0x08,[0x0C] = 0xE9,[0x0D] = 0x35,[0x0E] = 0x85,[0x0F] = 0xD5,[0x10] = 0xBC,
    [0x11] = 0xBD,[0x12] = 0x4E,[0x13] = 0x2B,[0x14] = 0x95,[0x15] = 0x9B,[0x16] = 0x9C,[0x17] = 0x63,
    [0x18] = 0xB2,[0x19] = 0xBF,[0x1A] = 0xDB,[0x1B] = 0xC0,[0x1C] = 0xE5,[0x1D] = 0x64,[0x1E] = 0x9E,
    [0x1F] = 0x4D,[0x20] = 0x93,[0x21] = 0x0C,[0x22] = 0x26,[0x23] = 0x57,[0x24] = 0x07,[0x25] = 0x4C,
    [0x26] = 0xF6,[0x27] = 0xA3,[0x28] = 0xDC,[0x29] = 0xA0,[0x2A] = 0x2E,[0x2B] = 0x4B,[0x2C] = 0xB7,
    [0x2D] = 0x9A,[0x2E] = 0x50,[0x31] = 0x43,[0x32] = 0x60,[0x33] = 0x19,[0x34] = 0x42,[0x35] = 0x1C,
    [0x36] = 0x0A,[0x37] = 0x5C,[0x38] = 0xD8,[0x3A] = 0xAA,[0x3C] = 0xA4,[0x3D] = 0x48,[0x3E] = 0xEC,
    [0x3F] = 0x33,[0x41] = 0x68,[0x42] = 0x0D,[0x43] = 0x5D,[0x44] = 0x05,[0x45] = 0x17,[0x46] = 0x3B,
    [0x47] = 0xD2,[0x48] = 0x3A,[0x49] = 0xB4,[0x4A] = 0xFD,[0x4B] = 0xF2,[0x4C] = 0x92,[0x4D] = 0x3D,
    [0x4E] = 0x29,[0x4F] = 0x80,[0x50] = 0xE3,[0x51] = 0x83,[0x52] = 0x1D,[0x53] = 0x40,[0x54] = 0x09,
    [0x55] = 0x59,[0x56] = 0x76,[0x57] = 0xD4,[0x58] = 0x82,[0x5A] = 0x55,[0x5B] = 0x99,[0x5C] = 0x00,
    [0x5D] = 0x1E,[0x5E] = 0x71,[0x5F] = 0x75,[0x60] = 0xBA,[0x61] = 0xC2,[0x62] = 0x8C,[0x63] = 0xA9,
    [0x64] = 0xF7,[0x65] = 0xF9,[0x66] = 0x56,[0x67] = 0xE7,[0x6A] = 0x3C,[0x6B] = 0xC5,[0x6C] = 0xC1,
    [0x6D] = 0xB5,[0x6E] = 0xCE,[0x6F] = 0xC7,[0x70] = 0xED,[0x71] = 0x41,[0x72] = 0x58,[0x73] = 0x8D,
    [0x74] = 0xFC,[0x75] = 0x04,[0x76] = 0x15,[0x77] = 0xD3,[0x7A] = 0x23,[0x7B] = 0x69,[0x7D] = 0xF8,
    [0x7E] = 0xC6,[0x7F] = 0xAD,[0x80] = 0x02,[0x81] = 0x47,[0x82] = 0x8B,[0x83] = 0x34,[0x84] = 0xEE,
    [0x85] = 0x87,[0x86] = 0x98,[0x87] = 0x46,[0x88] = 0xEB,[0x89] = 0x20,[0x8A] = 0x52,[0x8B] = 0x84,
    [0x8C] = 0x54,[0x8D] = 0x6C,[0x8E] = 0x13,[0x8F] = 0x30,[0x90] = 0x24,[0x91] = 0x8A,[0x92] = 0x5A,
    [0x93] = 0xF0,[0x94] = 0x78,[0x95] = 0xE6,[0x96] = 0x3F,[0x97] = 0xFE,[0x99] = 0x6F,[0x9A] = 0x2C,
    [0x9B] = 0xD6,[0x9C] = 0xE8,[0x9D] = 0xB9,[0x9F] = 0x9D,[0xA0] = 0x36,[0xA1] = 0x38,[0xA2] = 0x94,
    [0xA3] = 0xDD,[0xA5] = 0x62,[0xA8] = 0x96,[0xA9] = 0xB8,[0xAB] = 0xAB,[0xAC] = 0x37,[0xAD] = 0xA2,
    [0xAE] = 0x45,[0xAF] = 0x6E,[0xB0] = 0x61,[0xB1] = 0xC9,[0xB2] = 0x8E,[0xB3] = 0xC8,[0xB4] = 0xEF,
    [0xB5] = 0xFF,[0xB6] = 0x01,[0xB7] = 0x28,[0xB8] = 0x2F,[0xB9] = 0x8F,[0xBA] = 0x32,[0xBD] = 0xBB,
    [0xBE] = 0xD1,[0xBF] = 0xBE,[0xC0] = 0x27,[0xC2] = 0x0F,[0xC3] = 0x86,[0xC4] = 0x7F,[0xC5] = 0x90,
    [0xC6] = 0x4F,[0xC7] = 0x18,[0xC8] = 0xCA,[0xC9] = 0x73,[0xCA] = 0x65,[0xCC] = 0xC3,[0xCE] = 0x2D,
    [0xCF] = 0xCC,[0xD1] = 0x9F,[0xD2] = 0x3E,[0xD3] = 0xAF,[0xD4] = 0xC4,[0xD5] = 0x7A,[0xD6] = 0x6A,
    [0xD7] = 0x7E,[0xD8] = 0x31,[0xD9] = 0xA6,[0xDA] = 0x70,[0xDB] = 0xA8,[0xDC] = 0xF3,[0xDD] = 0x03,
    [0xDE] = 0x53,[0xE0] = 0xDF,[0xE1] = 0x06,[0xE2] = 0x5E,[0xE3] = 0x77,[0xE4] = 0x25,[0xE5] = 0xDA,
    [0xE9] = 0xFB,[0xEA] = 0x4A,[0xEB] = 0x21,[0xEC] = 0x6B,[0xED] = 0x88,[0xEE] = 0xB6,[0xEF] = 0xB1,
    [0xF0] = 0x5B,[0xF1] = 0xFA,[0xF2] = 0x66,[0xF3] = 0xB0,[0xF4] = 0x91,[0xF5] = 0xE4,[0xF6] = 0x22,
    [0xF7] = 0x10,[0xF9] = 0x6D,[0xFA] = 0x44,[0xFB] = 0x39,[0xFC] = 0x0B,[0xFD] = 0xF1,[0xFE] = 0x81,
    [0xFF] = 0x67,[0x00] = 0xB3,
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