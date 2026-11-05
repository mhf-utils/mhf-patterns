#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Lost item rewards (header 0x214): the reward for bringing a found lost item
// (mhfpac pFarmTaskTexts [5] "Found ~C02%s~C00", [0x10] "Give ~C02 %s ~C00",
// [10..15] Secret Metal Box ... Secret Cloth) to its owner (NPC dialogue case
// 0xA3, menu mode 0x73). lost_item_reward_roll takes the first row whose rank
// is at least minRank. Its drops get up to 6 weighted picks, each made with the
// DLL chances 0x11923DD8 (100, 70, 30, 5, 5, 1 %; the first failure stops), a
// pick queuing count x 1 of the item; each bonus gives 1 item at chance %.
// Item ids are stored inverted (~id). The random starts from the save s8 at
// ctx 0x22C2A. Identical on the EN, JP and rain files.
// =======================

fn lostItemRewardItem(u16 v) {
    return getItemName(u16(~v));
};

enum LostItemRankKind : u8 {
    Always = 0,
    HrTier = 1, // hr_rank_threshold_table band + 1 (1 at HR1 ... 7 at HR999)
    Skipped = 2, // the row is never taken (also above 4)
    GRank = 3, // get_g_class_rank
    HighestGsr = 4 // FUN_10B395D0 (the highest GSR of the secret books)
};

struct LostItemDrop {
    u16 item [[format("lostItemRewardItem"), comment("Stored as ~item id")]];
    u8 count;
    u8 weight;
};

struct LostItemDropList {
    LostItemDrop drops[while(std::mem::read_unsigned($ + 2, 1) != 0)];
    LostItemDrop end;
};

struct LostItemBonus {
    u16 item [[format("lostItemRewardItem"), comment("Stored as ~item id")]];
    u8 valid [[comment("Only tested for 0 (end)")]];
    u8 chance [[comment("Percent")]];
};

struct LostItemBonusList {
    LostItemBonus bonuses[while(std::mem::read_unsigned($ + 2, 1) != 0)];
    LostItemBonus end;
};

struct LostItemRewardTier {
    LostItemRankKind rankKind;
    padding[1];
    u16 minRank;
    LostItemDropList *drops : u32;
    u32 unk08 [[comment("The drop entry count with the end entry; no reader")]];
    if (std::mem::read_unsigned($, 4) != 0)
        LostItemBonusList *bonuses : u32;
    else
        u32 none;
    u32 unk10 [[comment("The bonus entry count with the end entry; no reader")]];
};

LostItemRewardTier lostItemRewardTiers[importantNums.numLostItemRewardTiers] @ header.ptrs.lostItemRewardTiers [[name("Lost Item Reward Tiers")]];
