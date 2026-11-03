#pragma once

/**
	Legend Rastas: their loadouts (header 0x35C, 0x70 bytes each, up to the
	group table: 176 on ZZ) and their groups (header 0x360, important numbers
	+ 0xF6 of them, 20 on ZZ): an NPC id and the loadout rows its "Change
	Weapon" list offers. Also the item sets the Partner and the player's own
	Rasta can buy (header 0x29C, 6 rows: unusable, powder, hunting horn,
	throwing knife, trap, urgent slaying).
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

enum LegendRastaGender : u8 {
    Male   = 0,
    Female = 1
};

struct LegendRastaHairColor {
    u8 blue;
    u8 green;
    u8 red;
    u8 alpha;
};

struct LegendRastaLoadout {
    u8  name                    [[comment("Index in mhfpac's Legend Rasta names")]];
    LegendRastaGender gender;
    u8  faceOneBased            [[comment("Partner face row + 1")]];
    u8  hairstyle;
    u8  voice;
    u8  inner;
    u8  unk06;
    u8  weaponType              [[format("getEquipType")]];
    u16 weapon;
    u16 head;
    u16 chest;
    u16 arms;
    u16 waist;
    u16 legs;
    u16 weaponLevel;
    u16 headLevel;
    u16 chestLevel;
    u16 armsLevel;
    u16 waistLevel;
    u16 legsLevel;
    u16 weaponDecorations[3];
    u16 headDecorations[3];
    u16 chestDecorations[3];
    u16 armsDecorations[3];
    u16 waistDecorations[3];
    u16 legsDecorations[3];
    LegendRastaHairColor hairColor;
    u16 unk48[3]                [[comment("Copied to the NPC's player work")]];
    u8  actions[0x22]           [[comment("NPC action ids, copied to a per-NPC table")]];
};

LegendRastaLoadout legendRastaLoadouts[(header.ptrs.legendRastaGroups - header.ptrs.legendRastaLoadouts) / 0x70]
    @ header.ptrs.legendRastaLoadouts
    [[name("Legend Rasta Loadouts")]];

struct LegendRastaGroup {
    u16 npc;
    u16 loadouts[16]            [[comment("Loadout rows")]];
};

LegendRastaGroup legendRastaGroups[importantNums.numLegendRastaGroups] @ header.ptrs.legendRastaGroups [[name("Legend Rasta Groups")]];

struct RastaItemSet {
    u16 gcpPricePerTab[4];
    ItemId items[8];
};

RastaItemSet rastaItemSets[6] @ header.ptrs.rastaItemSets [[name("Rasta Item Sets")]];
