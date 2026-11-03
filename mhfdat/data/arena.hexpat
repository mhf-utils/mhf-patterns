#pragma once
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Equipment
// =======================

struct DefBlock {
    u16 weaponClass;
    u16 weaponId;
    u16 unk;
    u16 head;
    u16 chest;
    u16 arms;
    u16 waist;
    u16 legs;
    u16 setIdx;
    u16 multi;
};

struct ArenaEquips {
    DefBlock def[4];
} [[inline]];

ptVar<ArenaEquips> ArenaEquipment[17]
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
    u16 quantity;
    u16 id;
} [[sealed, format("itemBlockFmt")]];

struct ItemTable {
    ItemBlock items[while(std::mem::read_signed($, 2) != -1)];
} [[inline]];

ptVar<ItemTable> ArenaItems[68]
    @ header.ptrs.arenaItems
    [[group("Arena"), name("Items")]];

ptVar<ItemTable> ArenaAmmo[23]
    @ header.ptrs.arenaAmmo
    [[group("Arena"), name("Ammo"), comment("Possibly ammo or extra items for ranged weapons; every list is empty on ZZ")]];


// =======================
// Stage IDs
// =======================

u16 ArenaStageIDsChunk0[28]
    @ header.ptrs.arenaStageIDC0
    [[group("Arena"), name("Stage IDs (Chunk 0)")]];

u16 ArenaStageIDsChunk1[34]
    @ header.ptrs.arenaStageIDC1
    [[group("Arena"), name("Stage IDs (Chunk 1)")]];

// The training text of each stage (header 0x150): row i is the quest at index
// i of Chunk 0; each row lists its lines, ending at a null pointer
struct ArenaStageInfo {
    s32p lines[while(std::mem::read_unsigned($, 4) != 0)];
    u32  end;
};

ptVar<ArenaStageInfo> ArenaStageInfoTexts[while(std::mem::read_unsigned($, 4) != 0)]
    @ header.ptrs.arenaStageInfoText
    [[group("Arena"), name("Stage Info Texts")]];


// =======================
// Tutorial equipment sets (header 0x15C): important numbers + 0x48 pointers,
// null for none, to 20-byte sets (23 pointers, 21 sets on ZZ). Layout from
// ezemania2/mhf-file-editor, checked on ZZ (the sets give a Rookie Knife and
// starter armor).
// =======================

struct TutorialSet {
    u8  weaponType          [[format("getEquipType")]];
    u8  unk01;
    u16 weapon;
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
