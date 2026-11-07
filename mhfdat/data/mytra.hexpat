#pragma once

/**
	Mytra (the player's facility with shops run by Felynes). mhfgao has the
	Partnyaa copies of these tables (mhfgao 0x154-0x174); each getter takes
	the mhfdat one unless a Partnyaa party member has its own.
	Each cat shop has its own 2-bit level, Lb_mytra_GetCatShopLevel(shop)
	(bits 0x2B / 0x2D / 0x2F / 0x31 / 0x33 of mytra +0xBA for shops 0-4):
	shop 0 picks the shop stock, 1 the cat mix rows, 2 gates the cat
	equipment, 4 the Adventure Dispatch rows.
	Adventure Dispatch (header 0x1D4): 56 destinations; a row is available
	when its cost is paid (zenny for rows below 0x2D, Gzenny after) and the
	assigned Felyne's (intelligence + willpower) / 5 reaches requiredLevel.
	lb_mytra_npc_cat_shop_create_quest_list lists the rows whose
	requiredStage is below shop 4's level (rows 0x13-0x25 and 0x29-0x2B
	below HR 100, 0x00-0x12 and 0x26-0x28 from HR 100, 0x2C with
	sb_get1_chk, 0x2D-0x31 from GR 100, 0x32-0x37 from GR 600); -1 rows of
	the first range only on a day where (Lb_mytra_GetQuestRand() + row) % 8
	is 0 (also rows 0x2C, 0x31, 0x36, 0x37).
	lb_mytra_npc_cat_shop_quest_result_init rolls the rewards list, after
	the bonusRewards list when its bonus roll succeeds (60 / 30 / 10 / 5 %
	by the dispatch result 0-3, 40 / 15 / 6 / 1 % after Mytra event 0x67).
	Shop stock (header 0x1DC-0x1E8): item lists ending at 0, by shop 0's
	level (below 2, 2, 3, 3 at GR 600 and above). Cat mix rows (header
	0x1EC-0x1F8): same choice by shop 1's level and GR, ending at a
	resultItem of 0.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <misc/MonsterIDs.hexpat>

fn mytraAdventureItem(u16 v) { return getItemName(u16(~v)); };

struct MytraAdventureReward {
    u16 item [[format("mytraAdventureItem"), comment("Stored as ~item id")]];
    s8 minCount;
    s8 maxCount;
    u8 chance [[comment("Percent")]];
    u8 skillKind [[comment("Cat equipment skills (pManagerNames[0x38E + id]) that change the count: 0 bugs 8-11, 1 plants 0-3, 2 mining 4-7, 3 fishing 12-15, 4 carving 16-19, 5 none")]];
};

struct MytraAdventureRewards {
    MytraAdventureReward rewards[while(std::mem::read_unsigned($, 2) != 0xFFFF)];
    MytraAdventureReward end [[comment("item 0xFFFF ends the list; its other bytes are not read")]];
};

struct MytraAdventure {
    u16 requiredLevel;
    s16 requiredStage [[comment("Listed when below cat shop 4's level; -1: rotation day only")]];
    u16 cost;
    padding[2];
    MytraAdventureRewards *rewards : u32;
    MytraAdventureRewards *bonusRewards : u32 [[comment("Rolled first when the bonus roll succeeds")]];
};

MytraAdventure mytraAdventures[56] @ header.ptrs.mytraAdventures [[name("Mytra Adventure Dispatch")]];

struct MytraShopStock {
    ItemId items[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

MytraShopStock mytraShopStage0 @ header.ptrs.mytraShopStage0 [[name("Mytra Shop Stock (stage below 2)")]];
MytraShopStock mytraShopStage2 @ header.ptrs.mytraShopStage2 [[name("Mytra Shop Stock (stage 2)")]];
MytraShopStock mytraShopStage3 @ header.ptrs.mytraShopStage3 [[name("Mytra Shop Stock (stage 3)")]];
MytraShopStock mytraShopStage3G @ header.ptrs.mytraShopStage3G [[name("Mytra Shop Stock (stage 3, GR 600+)")]];

struct MytraCatMixRecipe {
    u16 itemCount [[comment("2 or 3")]];
    u8 unk02;
    padding[1];
    u8 unk04;
    padding[1];
    ItemId items[3] [[comment("items[2] is read only when itemCount is 3")]];
};

struct MytraCatMixRecipePtr {
    MytraCatMixRecipe *recipe : u32;
};

struct MytraCatMixRow {
    ItemId resultItem;
    s16 recipeCount;
    MytraCatMixRecipePtr recipes[recipeCount];
    if (recipeCount < 3) padding[(3 - recipeCount) * 4];
};

struct MytraCatMixRows {
    MytraCatMixRow rows[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

MytraCatMixRows mytraCatMixStage0 @ header.ptrs.mytraCatMixStage0 [[name("Mytra Cat Mix (stage below 2)")]];
MytraCatMixRows mytraCatMixStage2 @ header.ptrs.mytraCatMixStage2 [[name("Mytra Cat Mix (stage 2)")]];
MytraCatMixRows mytraCatMixStage3 @ header.ptrs.mytraCatMixStage3 [[name("Mytra Cat Mix (stage 3)")]];
MytraCatMixRows mytraCatMixStage3G @ header.ptrs.mytraCatMixStage3G [[name("Mytra Cat Mix (stage 3, GR 600+)")]];

// =======================
// Cat equipment shop (header 0x1D8, menu title mhfpac pManagerNames[0x284]
// "Buy Cat Equipment"). Row n is named pManagerNames[0x346 + n] (row 0
// "Nothing"); the shop lists rows 1-70 (fixed bound of the reader). A row is
// listed when it is not the Felyne's current piece, cat shop 2's level
// (Lb_mytra_GetCatShopLevel(2)) is above requiredStage, and, for
// needsSaveFlag = -1, sb_get1_chk (one of the save bytes +0x23B58 +
// 0xA4..0xB1 has bit 0x80). Skill names are
// pManagerNames[0x38E + skill] ("装備スキル一覧").
// =======================

struct MytraCatEquipment {
    u16 price [[comment("Zenny; x DAT_117C9EC0 when DAT_1EE2768C is on")]];
    u8 requiredStage;
    s8 needsSaveFlag;
    s16 skills[4] [[comment("-1: none")]];
};

MytraCatEquipment mytraCatEquipment[71] @ header.ptrs.mytraCatEquipment [[name("Mytra Cat Equipment")]];

// Mytra Poogie level thresholds (header 0x228). The Poogie level printed on its
// status page (pManagerNames[0x46E] "LV : %d") is the number of thresholds below
// intelligence + agility + willpower (Lb_mytra_GetPigLv); the quest Poogie
// level (mytra_GetQuestPigLv) also counts a threshold equal to the sum. Ends at
// 0: 100 thresholds, then zero padding.
struct MytraPoogieLevelThresholds {
    u16 thresholds[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

MytraPoogieLevelThresholds mytraPoogieLevelThresholds @ header.ptrs.mytraPoogieLevelThresholds [[name("Mytra Poogie Level Thresholds")]];

// Mytra guild quests (header 0x1FC, Wii U slot 0x21C): 10 one-monster hunt
// requests (fixed bound). lb_mytra_npc_girl_update_guild_quest_list lists the
// rows whose requiredEvent is 0 or set in the Mytra event bits (MytraData
// +0x04); lb_mytraQuest_Trans prints pManagerNames[0x19D + row] with the item
// and monster names; Lb_mytra_SendMessage_DieEnemy flags the kill of the
// target; Lb_mytra_Quest_SetPresent adds the reward. Item, count and monster
// are stored inverted.
fn mytraGuildQuestItem(u16 v) { return getItemName(u16(~v)); };
fn mytraGuildQuestCount(u16 v) { return u16(~v); };
fn mytraGuildQuestMonster(u16 v) { MonsterID m = u8(~v); return fmtMonsterID(m); };

struct MytraGuildQuest {
    u16 rewardItem [[format("mytraGuildQuestItem"), comment("Stored as ~item id")]];
    u16 rewardCount [[format("mytraGuildQuestCount"), comment("Stored as ~count")]];
    u16 targetMonster [[format("mytraGuildQuestMonster"), comment("Stored as ~monster id")]];
    u16 requiredEvent [[comment("Mytra event bit; 0: always listed")]];
};

MytraGuildQuest mytraGuildQuests[10] @ header.ptrs.mytraGuildQuests [[name("Mytra Guild Quests")]];
