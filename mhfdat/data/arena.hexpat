#pragma once
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Equipment
// =======================

// Row = the set picked on the selection screen (0-3); copied by ac_player_init /
// Arcade_set_data into the player's equipment slots
struct DefBlock {
    u8  equipType           [[format("getEquipType")]];
    padding[1];
    u16 weaponId;
    u16 weaponLevel;
    u16 head;
    u16 chest;
    u16 arms;
    u16 waist;
    u16 legs;
    u16 itemSetIdx          [[comment("Item list ArenaItems[course * 4 + itemSetIdx]")]];
    u16 pointRate           [[comment("Point multiplier in percent: the course points are multiplied by it / 100")]];
};

struct ArenaEquips {
    DefBlock def[4];
} [[inline]];

// One row per course; the course is the ArenaCourseQuestIds row that holds the quest id
ptVar<ArenaEquips> ArenaEquipment[importantNums.numArenaCourses]
    @ header.ptrs.arenaEquipment
    [[group("Arena"), name("Equipment")]];


// =======================
// Items
// =======================

using ItemBlock;
fn itemBlockFmt(ItemBlock n) {
    return std::format("{:02}x {}", n.quantity, getItemName(n.id));
};

struct ItemBlock {
    s16 quantity;
    u16 id;
} [[sealed, format("itemBlockFmt")]];

struct ItemTable {
    ItemBlock items[while(std::mem::read_signed($, 2) != -1)];
} [[inline]];

// Item lists given (topped up to quantity) at the start: index course * 4 + equipment set
ptVar<ItemTable> ArenaItems[importantNums.numArenaItemSets]
    @ header.ptrs.arenaItems
    [[group("Arena"), name("Items")]];

// Item lists given in tutorial and sleep quests, same index as TutorialEquipSets; null for none
ptVar<ItemTable> TutorialItems[importantNums.numTutorialItemSets]
    @ header.ptrs.arenaAmmo
    [[group("Arena"), name("Tutorial Items")]];

// Item lists of Pl_item_charge (header 0x13C) outside the arena and the tutorial /
// sleep quests: one per weapon class, row = PlayerWork weaponType; the pouch is
// topped up to each quantity while the restock count PlayerWork +0xB67 lasts
ptVar<ItemTable> WeaponClassItems[14]
    @ header.ptrs.weaponClassItemLists
    [[group("Arena"), name("Weapon Class Items")]];


// =======================
// Stage IDs
// =======================

// Quest ids of the help texts (header 0x154), ending at 0
struct ArenaHelpQuestIdList {
    u16 questIds[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

ArenaHelpQuestIdList ArenaHelpQuestIds
    @ header.ptrs.arenaHelpQuestIds
    [[group("Arena"), name("Help Text Quest IDs")]];

// Course of a quest (header 0x14C): the first row holding its quest id, 0 if none
struct ArenaCourseQuests {
    u16 questIds[2];
};

ArenaCourseQuests ArenaCourseQuestIds[importantNums.numArenaCourseQuests]
    @ header.ptrs.arenaCourseQuestIds
    [[group("Arena"), name("Course Quest IDs")]];

// The training text of each quest (header 0x150): row i is the quest at index
// i of ArenaHelpQuestIds; each row lists its lines, ending at a null pointer
struct ArenaStageInfo {
    s32p lines[while(std::mem::read_unsigned($, 4) != 0)];
    u32  end;
};

ptVar<ArenaStageInfo> ArenaStageInfoTexts[while(std::mem::read_unsigned($, 4) != 0)]
    @ header.ptrs.arenaStageInfoText
    [[group("Arena"), name("Stage Info Texts")]];


// =======================
// Tutorial equipment sets (header 0x15C): important numbers + 0x48 pointers,
// null for none, to 20-byte sets (23 pointers, 21 sets on ZZ). Index: the quest
// id of a tutorial quest, or in a sleep quest the cursor table 0x118E7D90 entry
// (6 when out of range); not used for the beginner quests (header 0x1B8).
// =======================

struct TutorialSet {
    u8  weaponType          [[format("getEquipType")]];
    u8  unk01;
    u16 weapon              [[comment("0xFFFF keeps the current weapon (0x2DF7 in a sleep quest)")]];
    u16 weaponLevel;
    u16 head;
    u16 chest;
    u16 arms;
    u16 waist;
    u16 legs;
    u8  unk10[4];
};

ptVar<TutorialSet> TutorialEquipSets[importantNums.numTutorialEquipSets]
    @ header.ptrs.tutorialEquipSets
    [[group("Arena"), name("Tutorial Equipment Sets")]];
