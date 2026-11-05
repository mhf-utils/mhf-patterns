#pragma once

#include <std/mem.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Pioneer (開拓) quest settings (docs/reverse/pioneer.md).
// Header 0x2C8: 4 maps x 6 lists of quest rows, [(map - 1) * 6 + list] with the
// map of the Pioneer work +0xAE (the texts list Jungle, Desert, Snowy Mountain,
// Volcano); the 6 lists are for Pioneer levels 1, 2, 3, 3, 4, 5 (DLL table
// 0x119231C8). The quest settings menu (state 0xB) lists the monsters of the
// rows, 11 a page (pioneer_quest_monsters_page); the quest is one of the row's
// non-zero quest ids at random (pioneer_quest_pick). pioneer_quest_lookup and
// pioneer_quest_monster_find go from a quest back to its row.
// Header 0x2C4: the items the item settings screen (state 0xC) offers, 7 a page,
// only the ones in the pouch, item box or 400-slot store (items 0xA1-0xA9 count
// as one group in the pouch); pioneer_quest_items_page.
// Identical on the EN, JP and rain files.
// =======================

fn pioneerMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

struct PioneerQuestRow {
    u16 monster [[format("pioneerMonster")]];
    u16 unk02;
    u16 quests[6] [[comment("Quest ids; 0 = none")]];
};

struct PioneerQuestList {
    PioneerQuestRow rows[while(std::mem::read_signed($, 2) != -1)];
    s16 end[8];
};

struct PioneerQuestListPtr {
    PioneerQuestList *list : u32;
};

struct PioneerMapQuests {
    PioneerQuestListPtr levels[6] [[comment("Pioneer levels 1, 2, 3, 3, 4, 5")]];
};

struct PioneerQuestItems {
    ItemId items[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

PioneerMapQuests pioneerQuests[4] @ header.ptrs.pioneerQuests [[name("Pioneer Quests")]];
PioneerQuestItems pioneerQuestItems @ header.ptrs.pioneerQuestItems [[name("Pioneer Quest Items")]];

// =======================
// Pioneer public rewards ("Claim Rewards", pioneer_public_rewards_claim): the
// Pioneer work counts in ctx 0x1FF0A the minutes of successful quests played
// while the map is published. A claim seeds the random from a save byte (ctx
// 0x22C2A), then makes one roll per 60 minutes and resets the counter (none:
// text 78 "No public rewards"). A roll gives one item of a tier of header
// 0x2EC (pioneer_public_reward_tier_get, pioneer_public_reward_roll) and then
// one item of header 0x2F0 (pioneer_quest_bonus_reward_roll). The items go into
// the reward list (GameWork +0x3C); with the course right 0x119DE00C they are
// also listed for the result screen.
// Header 0x2EC: 10 tiers picked by the levels of the 20 base slots (ctx
// 0x1FEC8, bases with a type): sum x 100 / 60 (48 on map 3), tier 0 below 20,
// then one tier per 10 up to tier 9 at 100. A tier has 4 groups; a group counts
// when the player qualifies, and one item is drawn by weight among the items
// of all the groups that count.
// Header 0x2F0: one row per Pioneer quest (the 183 quests of header 0x2C8);
// the row of the published quest (ctx 0x1FF02) gives its item when rand % 100
// <= chance.
// =======================

struct PioneerRewardGroup {
    ItemId items[3];
    u16 weights[3];
};

struct PioneerPublicRewardTier {
    PioneerRewardGroup anyRank;
    PioneerRewardGroup hr31 [[comment("HR 31 or more")]];
    PioneerRewardGroup hr100 [[comment("HR 100 or more")]];
    PioneerRewardGroup gRank [[comment("G rank (get_g_class_rank not 0)")]];
};

struct PioneerQuestBonusReward {
    ItemId item;
    u16 quest;
    u16 chance [[comment("rand % 100 <= chance")]];
};

PioneerPublicRewardTier pioneerPublicRewardTiers[10] @ header.ptrs.pioneerPublicRewardTiers [[name("Pioneer Public Reward Tiers"), comment("Base levels: below 20 %, 20-29 % ... 90-99 %, 100 %")]];
PioneerQuestBonusReward pioneerQuestBonusRewards[importantNums.numPioneerQuestBonusRewards] @ header.ptrs.pioneerQuestBonusRewards [[name("Pioneer Quest Bonus Rewards")]];

// =======================
// Pioneer base build costs ("Establish Base", header 0x2E4): 4 pointers, one per
// map (menu work +0xAE minus 1; texts 41-44 Jungle, Desert, Snowy Mountain,
// Volcano), each to 5 rows, one per base type 1-5 (pPioneerTexts[type + 0x2C]:
// texts 45-49 Gather, Mining, Insect, Relics, Defense). A row holds 3 costs,
// indexed by the current level of the selected slot (0 when the slot holds
// another type; level 3 is refused). pioneer_base_select_update (menu state 3)
// copies the cost into the work; the confirmation (state 0x19 of
// pioneer_menu_update, drawn by pioneer_draw_base_build_confirm) checks the items
// held in the pouch, item box and 400-slot store (text 73) and the CP (text 74),
// removes them (item_remove_pouch_then_boxes, cp_points_add) and starts the
// build (pioneer_set_build_progress, text 75). With the course right 0x119DE00C
// (pioneer_has_half_cost_course) the item counts and the CP are halved. Each
// map list is padded with 14 zero bytes. Identical on the EN, JP and rain files.
// =======================

struct PioneerBaseCostItem {
    ItemId item;
    u16 count;
};

struct PioneerBaseLevelCost {
    PioneerBaseCostItem items[3];
    u16 cp;
};

struct PioneerBaseTypeCost {
    PioneerBaseLevelCost levels[3] [[comment("Current level 0, 1, 2")]];
};

struct PioneerMapBaseCosts {
    PioneerBaseTypeCost types[5] [[comment("Gather, Mining, Insect, Relics, Defense")]];
};

struct PioneerMapBaseCostsPtr {
    PioneerMapBaseCosts *costs : u32;
};

PioneerMapBaseCostsPtr pioneerBaseCosts[4] @ header.ptrs.pioneerBaseCosts [[name("Pioneer Base Costs"), comment("Jungle, Desert, Snowy Mountain, Volcano")]];
