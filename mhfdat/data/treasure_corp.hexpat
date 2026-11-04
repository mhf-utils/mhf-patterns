#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Treasure Corp (Partnyaa dispatch, mhfgao.md). Header 0x8D0 has one row per
// area (the 8 dispatch areas). At load time rd_mhfdat writes into each row the
// pointers to that area's entries of 0x8D4-0x8EC (in the file they are 0); an
// entry belongs to the row whose area matches its first byte, and lists of
// 0x8D8-0x8EC are indexed by the tier byte (get_hunter_rank_tier, 0-5).
// Counts: important numbers +0x350 to +0x35E.
// =======================

struct TreasureCorpArea {
    u8 area;
    padding[3];
    u32 resultChances [[comment("Runtime pointer to this area's 0x8D4 entries")]];
    u32 drawRulesKind2[6] [[comment("Runtime pointers to 0x8D8 lists, by tier")]];
    u32 drawRulesKind01[6] [[comment("Runtime pointers to 0x8DC lists, by tier")]];
    u32 listsA[6] [[comment("Runtime pointers to 0x8E0 lists, by tier")]];
    u32 listsB[6] [[comment("Runtime pointers to 0x8E4 lists, by tier")]];
    u32 listsC[6] [[comment("Runtime pointers to 0x8E8 lists, by tier")]];
    u32 listsD[6] [[comment("Runtime pointers to 0x8EC lists, by tier")]];
};

// FUN_106d69f0(area, n, m): roll % 100 < chance2 (+ the m-th chance2Add, + a
// header 0x904 bonus) gives result 2, < chance2 + chance1 (+ adds) result 1, else 0.
// Groups of 5 per area (n, m = 1-5).
struct TreasureCorpResultChance {
    u8 area;
    u8 index;
    u8 chance1;
    u8 chance2;
    s8 chance1Add;
    s8 chance2Add;
};

// treasure_corp_draw_rewards: the number of item draws is the number of rules
// that pass in the (area, tier) list. A list ends with a kind 0 entry.
enum TreasureCorpDrawRuleKind : u8 {
    End = 0,
    Always = 1,
    Chance = 2,
    MinHr = 4
};

struct TreasureCorpDrawRule {
    u8 area;
    u8 tier;
    TreasureCorpDrawRuleKind kind;
    u8 chance [[comment("Chance: percent, scaled by get_tune_rate")]];
    u8 param [[comment("Chance: index (< 5) of the caller's 5 values, (value + 19) / 20 is added; MinHr: g_player_hr_cache >= param")]];
    u8 unk05;
};

// No HD reader: only rd_mhfdat links them. The u16 at +2 continues a list
// while it is not 0 (its values look like item ids: Honey, Herb...).
struct TreasureCorpListEntry {
    u8 area;
    u8 tier;
    u16 unk02;
    u16 unk04;
    u16 unk06;
};

TreasureCorpArea treasureCorpAreas[importantNums.numTreasureCorpAreas] @ header.ptrs.treasureCorpAreas [[name("Treasure Corp Areas")]];
TreasureCorpResultChance treasureCorpResultChances[importantNums.numTreasureCorpResultChances] @ header.ptrs.treasureCorpResultChances [[name("Treasure Corp Result Chances")]];
TreasureCorpDrawRule treasureCorpDrawRulesKind2[importantNums.numTreasureCorpDrawRulesKind2] @ header.ptrs.treasureCorpDrawRulesKind2 [[name("Treasure Corp Draw Rules Kind 2")]];
TreasureCorpDrawRule treasureCorpDrawRulesKind01[importantNums.numTreasureCorpDrawRulesKind01] @ header.ptrs.treasureCorpDrawRulesKind01 [[name("Treasure Corp Draw Rules Kind 0 and 1")]];
TreasureCorpListEntry treasureCorpListsA[importantNums.numTreasureCorpListsA] @ header.ptrs.treasureCorpListsA [[name("Treasure Corp Lists A")]];
TreasureCorpListEntry treasureCorpListsB[importantNums.numTreasureCorpListsB] @ header.ptrs.treasureCorpListsB [[name("Treasure Corp Lists B")]];
TreasureCorpListEntry treasureCorpListsC[importantNums.numTreasureCorpListsC] @ header.ptrs.treasureCorpListsC [[name("Treasure Corp Lists C")]];
TreasureCorpListEntry treasureCorpListsD[importantNums.numTreasureCorpListsD] @ header.ptrs.treasureCorpListsD [[name("Treasure Corp Lists D")]];
