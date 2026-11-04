#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Armor model id limits (header 0x0E4): one row per gender (player +0x11: 0
// male, 1 female; rows 2 and 3 are 0). The slots follow the equipment counts
// order. When the model id resolved for a slot (modelIdMale / modelIdFemale of
// the worn piece) is >= the limit, the model shown is 0 (armor_model_ids_resolve);
// a preset with -1 for a slot takes random % limit + 1 (player_preset_model_roll).
// Armor colors (header 0x140): 0xAARRGGBB, index = player +0xCA2 (0xFF: none,
// 0xB: FUN_10B86850 instead), turned into RGB floats by
// armor_unk0A_bit0_set_rgb_from_color_table.
// =======================

struct ArmorModelIdLimits {
    u16 leg;
    u16 unk02 [[comment("Slot 1: not checked against the model id")]];
    u16 head;
    u16 body;
    u16 arm;
    u16 waist;
    u16 unk0C [[comment("Slot 6: limit of a byte value in FUN_105E05E0 / FUN_11521B60")]];
};

ArmorModelIdLimits armorModelIdLimits[4] @ header.ptrs.armorModelIdLimits [[name("Armor Model Id Limits")]];

struct ArmorColor {
    u8 b;
    u8 g;
    u8 r;
    u8 a;
};

ArmorColor armorColors[112] @ header.ptrs.armorColors [[name("Armor Colors")]];
