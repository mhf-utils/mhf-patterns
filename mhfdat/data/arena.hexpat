#pragma once
#include <mhfdat/utils/index.pat>

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
    [[group("Arena"), name("Ammo"), comment("Possibly ammo or extra items for ranged weapons")]];


// =======================
// Stage IDs
// =======================

u16 ArenaStageIDsChunk0[28]
    @ header.ptrs.arenaStageIDC0
    [[group("Arena"), name("Stage IDs (Chunk 0)")]];

u16 ArenaStageIDsChunk1[34]
    @ header.ptrs.arenaStageIDC1
    [[group("Arena"), name("Stage IDs (Chunk 1)")]];


// =======================
// Mystery
// =======================

struct unkChunk {
    u16 unkVals[10];
} [[inline]];

ptVar<unkChunk> ArenaMystery[23]
    @ header.ptrs.hd_dll_af5261
    [[group("Arena"), name("Mystery Data")]];
