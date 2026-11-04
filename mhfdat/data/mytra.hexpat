#pragma once

/**
	Mytra (the player's facility with shops run by Felynes). mhfgao has the
	Partnyaa copies of these tables (mhfgao 0x154-0x174); each getter takes
	the mhfdat one unless a Partnyaa party member has its own.
	Adventure Dispatch (header 0x1D4): 56 destinations; a row is available
	when its cost is paid (zenny for rows below 0x2D, Gzenny after) and the
	assigned Felyne's (intelligence + willpower) / 5 reaches requiredLevel.
	Each row also points to two blocks whose format is not proven.
	Shop stock (header 0x1DC-0x1E8): item lists ending at 0, by Mytra stage
	(below 2, 2, 3, 3 at GR 600 and above). Cat mix rows (header 0x1EC-0x1F8):
	same stage choice, ending at a key of 0.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

struct MytraAdventure {
    u16 requiredLevel;
    u16 unk02;
    u16 cost;
    padding[2];
    u32 block1;
    u32 block2;
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

struct MytraCatMixRow {
    u16 key;
    u16 count;
    u32 entries[3];
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
// listed when it is not the Felyne's current piece, the Mytra stage
// (mytra +0xBA) is above requiredStage, and, for needsSaveFlag = -1, one of
// the save bytes +0x23B58 + 0xA4..0xB1 has bit 0x80. Skill names are
// pManagerNames[0x38E + skill] ("装備スキル一覧").
// =======================

struct MytraCatEquipment {
    u16 price [[comment("Zenny; x DAT_117C9EC0 when DAT_1EE2768C is on")]];
    u8 requiredStage;
    s8 needsSaveFlag;
    s16 skills[4] [[comment("-1: none")]];
};

MytraCatEquipment mytraCatEquipment[71] @ header.ptrs.mytraCatEquipment [[name("Mytra Cat Equipment")]];
