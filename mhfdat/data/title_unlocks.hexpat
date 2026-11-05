#pragma once

#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>

// =======================
// Hunter title unlocks (header 0xA6C): conditions that give a title (称号). A
// title is a bit of the save title bits (ctx +0x21327 + 0x260D); giving one sets
// the bit, sends it to the server (FUN_115113E0 0x7C), adds it to the quest
// result list and shows mhfpac pQuestEventTexts[25] 新しい称号を手に入れました.
// Three lists: monster rows (title_unlock_check_quest_monsters at quest end),
// evolution weapon rows (title_unlock_check_evo_weapons, after an equipment flag
// changes or a forge) and UD contribution rows (title_unlock_check_ud_points).
// Identical on the EN, JP and rain files.
// =======================

fn titleUnlockMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

bitfield TitleUnlockMonsterFlags {
    gRankQuest : 1 [[comment("quest_is_g_rank")]];
    needsFlag1E76BADA : 1 [[comment("DAT_1E76BADA set")]];
    notInSecondBits : 1 [[comment("the monster's bit of quest work +0xF81 must be clear")]];
    variant : 1 [[comment("not in an online room, em_variation_check(monster, 0xF)")]];
    special : 1 [[comment("not in an online room, FUN_10AC33C0")]];
    padding : 11;
};

struct TitleUnlockMonster {
    u16 maxValue [[comment("0, or the quest work +0x6EF0 value (set at quest end from [0x1E8001EC] + 0x914) must be <= this")]];
    TitleUnlockMonsterFlags flags;
    u16 monster [[format("titleUnlockMonster"), comment("Its bit in quest work +0xF6A or +0xF81 must be set")]];
    u16 title;
};

struct TitleUnlockEvoWeapon {
    u16 series [[comment("evo_weapon_series_get")]];
    u16 needed [[comment("Distinct weapons of the series at level >= 100 in the box; 0xFFFF = numEvoMeleeWeapons + numEvoRangedWeapons (important numbers +0xB4 / +0xB6)")]];
    u16 title;
};

struct TitleUnlockUdPoints {
    u16 noExtra [[comment("0: DAT_1E827484 is added to the sum")]];
    padding[2];
    u32 minPoints [[comment("Sum of the UD contribution counters, on a quest with variant bit 0x2000")]];
    u16 title;
    padding[2];
};

struct TitleUnlocks {
    u16 monsterCount;
    u16 evoWeaponCount;
    u16 udPointsCount;
    padding[2];
    TitleUnlockMonster *monsters[monsterCount] : u32;
    TitleUnlockEvoWeapon *evoWeapons[evoWeaponCount] : u32;
    TitleUnlockUdPoints *udPoints[udPointsCount] : u32;
    u32 unk14;
};

TitleUnlocks titleUnlocks @ header.ptrs.titleUnlocks [[name("Title Unlocks")]];

// =======================
// Title categories (header 0x550): the title setting screen of the Hunter Info
// menu (title_select_update, from my_house_menu_update). 8 rows, one per
// category, named by mhfpac pHuntingLogCategoryNames: Hunter Rank, Lifestyle,
// Monster, Equipment, Quest; rows 5-7 are empty. title_list_page_build lists,
// 8 a page, the titles of the category whose bit is set in the menu's title
// bits (work +0xD0); title_list_draw prints mhfpac pTitleTexts[title * 2] (name)
// and [title * 2 + 1] (description), or pHuntingLogCategoryNames[6] for a
// locked title. The chosen title goes to save ctx 0x22FC2, which the room
// packet sends to the other players.
// =======================

struct TitleCategory {
    s16 count;
    padding[2];
    if (count > 0)
        u16 titles[count] @ std::mem::read_unsigned($, 4) [[comment("Title ids (mhfpac pTitleTexts[id * 2])")]];
    u32 titlesPtr [[comment("Pointer to the title ids")]];
};

TitleCategory titleCategories[8] @ header.ptrs.titleCategories [[name("Title Categories"), comment("Hunter Rank, Lifestyle, Monster, Equipment, Quest, then 3 empty rows")]];
