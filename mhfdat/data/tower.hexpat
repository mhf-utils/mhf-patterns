#pragma once

/**
	Tower weapons: the jewel recipes (header 0x938) and the upgrade cost tables
	(header 0x93C). Layouts from ezemania2/mhf-file-editor, checked against the
	code. ZZ JP, EN and rain: 1,371 recipes (important numbers + 0x38A), the
	table ends where the next one starts; 65 cost tables (extra counters +0xC)
	of 200 steps, each ended by a step whose first byte is 0xFF (the loader
	walks to it); the steps past the last level used are all zero.
	The Tower sigil forging (header 0x944) is in crafting.hexpat.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

struct TowerJewelMaterial {
    u16 item                    [[format("getItemName")]];
    u16 quantity;
    u32 unk04;
};

struct TowerJewelRecipe {
    u16 weapon                  [[comment("Melee (equipType 6) or ranged (7) weapon id, a Tower weapon on every ZZ row (63 distinct); tower_jewel_lookup_recipe matches it with the box entry's weapon")]];
    u16 levelMin                [[comment("tower_jewel_lookup_recipe: the weapon's level of this stat (get_tower_stat_level) is in levelMin..levelMax")]];
    u16 levelMax;
    u8  stat                    [[comment("Tower stat kind (get_tower_stat_level, the 0x93C step kinds)")]];
    u8  equipType               [[format("getEquipType")]];
    TowerJewelMaterial materials[3];
};

TowerJewelRecipe towerJewelRecipes[importantNums.numTowerJewelRecipes]
    @ header.ptrs.towerJewelRecipes
    [[name("Tower Jewel Recipes")]];

// One upgrade step; the row is the stat's current level and the table is
// the weapon's Tower/G50 Param ID. Ten (ok, cost) byte pairs, the ok byte
// read by tower_upgrade_get_step_flag, the cost by tower_upgrade_sum_step_cost,
// by stat kind: kind 0, kind 2, kind 1, kind 3, kind 4 with a seal of deco
// type 7, 5, 6 (the last one owned wins), kinds 5 and 6, kind 0xC, kind 0xB;
// then one byte each for the bow kinds 0xE / 0x12, 0xF / 0x13, 0x10 / 0x14,
// 0x11 / 0x15 (cost; ok = byte != 0 for 0xE-0x11, always 1 for 0x12-0x15).
struct TowerUpgradeCost {
    u8 okCost[20];
    u8 bow[4];
};

struct TowerUpgradeCostTable {
    TowerUpgradeCost steps[while(std::mem::read_unsigned($, 1) != 0xFF)];
};

struct ptTowerUpgradeCostTable {
    TowerUpgradeCostTable *table : u32 [[inline]];
};

ptTowerUpgradeCostTable towerUpgradeCosts[std::mem::read_unsigned(header.ptrs.extraCounters + 0xC, 2)]
    @ header.ptrs.towerUpgradeCosts
    [[name("Tower Weapon Upgrade Costs")]];

// Tower skills (header 0x928): one row per tower skill id (names: mhfpac
// pTowerSkillNames, 0xD58). tower_skill_level(id) reads the player's
// level of that skill (20 (id, level) pairs: per player in quests, save
// +0x23A3C in town; only in the quests quest_tower_skills_apply accepts) and caps it
// at maxLevel; the skill's code reads the rate (floats) or the value (s32) at
// that level. Read so far: 1 Attack value (CalculatePlayerBonuses), 2 Defense
// value (FUN_10A858A0), 6 Flame Protection rate (FUN_111BCAB0), 10 技巧術
// level (tower_gimmick_try_use), 19 Guardian Offense value.
fn towerSkillName(u32 i) {
    match (i) {
        (0): return "None";
        (1): return "Attack";
        (2): return "Defense";
        (3): return "希望への活力";
        (4): return "Stamina";
        (5): return "Recovery";
        (6): return "Flame Protection";
        (7): return "Shock Protection";
        (8): return "打撃保護";
        (9): return "斬撃保護";
        (10): return "技巧術";
        (11): return "Negotiation";
        (12): return "砲撃手";
        (13): return "破壊王";
        (14): return "Care";
        (15): return "Pharmacist";
        (16): return "Treasure";
        (17): return "激遭";
        (18): return "Virus Res.";
        (19): return "Guardian Offense";
        (20): return "Guardian Defense";
        (21): return "罠回避";
        (22): return "Frost Res.";
        (23): return "Fire Res";
        (24): return "Water Res";
        (25): return "Ice Res";
        (26): return "Thunder Res";
        (27): return "Dragon Res";
        (28): return "Starting Gm Up";
        (29): return "Rd P Up";
        (30): return "Revival Sage";
        (31): return "Advancement Guru";
        (32): return "Last Stand";
        (33): return "Bonus Encounter";
        (34): return "All Res";
        (35): return "Rewards Up";
    }
    return "?";
};

struct TowerSkill {
    u8  maxLevel                [[comment("Read as a byte (tower_skill_level, GetPlayerRankLevel); the player's level is capped at it")]];
    padding[3];
    float rateByLevel[8]        [[comment("[level - 1]")]];
    s32 valueByLevel[8]         [[comment("[level - 1]")]];
} [[name(towerSkillName(std::core::array_index()))]];

TowerSkill towerSkills[36] @ header.ptrs.towerSkills [[name("Tower Skills")]];

// Tower support bonuses (header 0xA48; header 0xA4C holds the row count, not a
// pointer): the "効果ＵＰ" support effects of pTowerSupportTexts. A row is
// for one tower skill id (kind) and adds to its tower skill value (header
// 0x928) at the support level (1-5) held in a SkillWork byte: kind 1 Attack
// (+0x708, CalculatePlayerBonuses), 2 Defense (+0x709, FUN_10A858A0), 12
// 砲撃手 (+0x70A, FUN_111C5370, FUN_111C6390), 13 破壊王 (+0x70C,
// FUN_111BCDC0), 6 Flame Protection (+0x70D, rate, FUN_111BCAB0,
// FUN_111BC4F0), 7, 8 and 9 (the other protections, +0x70D, FUN_111BC4F0), 14
// Care (+0x70B, copied by FUN_10A4C5F0 to the word read by FUN_109F5680):
// value x 0.01 or rate. The support levels come from header 0xA50 (below).
struct TowerSupportBonus {
    s32 kind                    [[format("towerSkillName")]];
    s32 valueByLevel[5];
    float rateByLevel[5];
};

TowerSupportBonus towerSupportBonuses[header.ptrs.towerSupportBonusCount] @ header.ptrs.towerSupportBonuses [[name("Tower Support Bonuses")]];

// Tower support level thresholds (header 0xA50): 6 pointers, one per support
// category in the order of pTowerSupportTexts [5..10] (Attack, Defense, 砲撃手,
// 気つけ術, 破壊王, 保護系), each to 5 s32 point thresholds.
// tower_request_support_points_sum adds the six u8 support points (bytes 6-11)
// of the Tower request rows already cleared; tower_support_level_calc counts
// the thresholds at or below a category's sum (level 0-5). At quest start the
// 6 levels go in the player data packet (+0x1C5) and SetMiniDataToPl copies
// them to SkillWork +0x708 to +0x70D, the levels towerSupportBonuses uses.
fn towerSupportCategoryName(u32 i) {
    match (i) {
        (0): return "Attack";
        (1): return "Defense";
        (2): return "砲撃手";
        (3): return "気つけ術";
        (4): return "破壊王";
        (5): return "保護系";
    }
    return "?";
};

struct TowerSupportLevelThresholds {
    s32 pointsForLevel[5];
};

struct ptTowerSupportLevelThresholds {
    TowerSupportLevelThresholds *thresholds : u32 [[inline]];
} [[name(towerSupportCategoryName(std::core::array_index()))]];

ptTowerSupportLevelThresholds towerSupportLevelThresholds[6] @ header.ptrs.towerSupportLevelThresholds [[name("Tower Support Level Thresholds")]];
