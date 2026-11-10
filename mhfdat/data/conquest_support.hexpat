#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Extreme Conquest (極征) support bonus, Wii U "G Dragon" (header 0x784 /
// 0x788; type names mhfpac 0xC6C). No HD reader (rd_mhfdat relocation
// only); Wii U chkGDragonBonusChg (slots 0x780 / 0x784, counts important
// numbers +0x2B4 / +0x2B6 there, +0x2BC / +0x2BE here) runs once an hour in
// a conquest lobby (IsLobbyGDragon). hour = tm_hour of gmtime(server hour +
// 9 h). For each range row it rolls, for each of the 5 bonus types, a value
// in [min, max] of that hour into slot key x 5 + type; for each map it rolls
// the bonus type with the hour's weights (cumulative, against rand % 100).
// getGDragonBonusType gives the map's type, getGDragonBonusNum(type, u16
// +0x34 of the quest's get_quest_info row) its value (setGDragonQuestBonus,
// shown "%s +%d" by GrankPageView, kept per type by quest_result_gr_init).
// =======================

enum ConquestSupportType : u8 {
    Attack = 0,
    Defense = 1,
    Affinity = 2,
    Reward = 3,
    Points = 4
};

struct ConquestSupportRange {
    s16 min [[comment("Rolled value = rand % (max - min + 1) + min (type 0 read unsigned)")]];
    s16 max [[comment("Included in the roll")]];
};

struct ConquestSupportTypeRanges {
    ConquestSupportRange hours[24] [[comment("By tm_hour of gmtime(server hour + 9 h)")]];
};

struct ConquestSupportRangeRow {
    u16 key [[comment("Value slot key x 5 + type; matched with u16 +0x34 of the quest's get_quest_info row")]];
    u16 unk02 [[comment("No reader (Wii U chkGDragonBonusChg skips it)")]];
    ConquestSupportTypeRanges types[5] [[comment("By ConquestSupportType: attack, defense, affinity, reward, points (mhfpac 0xC6C names)")]];
};

struct ConquestSupportHourWeights {
    u8 typeWeights[5] [[comment("Percent by ConquestSupportType, cumulative against rand % 100 (100 in all on every hour)")]];
    u8 unk05[3] [[comment("No reader")]];
};

struct ConquestSupportWeightRow {
    MapId map [[comment("Get_looks_map_no(map); the first row whose looks map is 0 (map 0) fills all 69 looks maps first")]];
    u16 unk02 [[comment("No reader (Wii U chkGDragonBonusChg skips it)")]];
    ConquestSupportHourWeights hours[24] [[comment("By tm_hour of gmtime(server hour + 9 h)")]];
};

ConquestSupportRangeRow conquestSupportRanges[importantNums.numConquestSupportRangeRows] @ header.ptrs.conquestSupportRanges [[name("Conquest Support Ranges")]];
ConquestSupportWeightRow conquestSupportWeights[importantNums.numConquestSupportWeightRows] @ header.ptrs.conquestSupportWeights [[name("Conquest Support Weights")]];
