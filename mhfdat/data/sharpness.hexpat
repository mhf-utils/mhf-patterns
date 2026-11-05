#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Sharpness tables (header 0x0AC). One pointer per weapon class (player +0x03,
// class order of className), several classes share a table. A melee weapon's
// sharpnessId (weapon row +0x08) is its row in its class table; ex G weapons
// and G50 / Tower weapons pick another row of the same table
// (get_ex_g_weapon_sla_type, get_tower_g50_sharpness_id). Each value is where
// a color ends: weapon_melee_sharpness_color_tier returns the first color whose
// value is >= the current sharpness (signed compares). 128 rows per table: the
// 8 distinct tables fill the block exactly on the EN, JP and rain files.
// =======================

struct SharpnessRow {
  s16 Red     [[color("FF0000")]];
  s16 Orange  [[color("FFA500")]];
  s16 Yellow  [[color("FFFF00")]];
  s16 Green   [[color("00FF00")]];
  s16 Blue    [[color("0000FF")]];
  s16 White   [[color("FFFFFF")]];
  s16 Purple  [[color("800080")]];
  s16 SkyBlue [[color("87CEEB")]];
};

struct SharpnessTables {
  SharpnessRow *greatSword[128]     : u32 [[name("Great Sword")]];
  SharpnessRow *heavyBowgun[128]    : u32 [[name("Heavy Bowgun")]];
  SharpnessRow *hammer[128]         : u32 [[name("Hammer")]];
  SharpnessRow *lance[128]          : u32 [[name("Lance")]];
  SharpnessRow *swordAndShield[128] : u32 [[name("Sword And Shield")]];
  SharpnessRow *lightBowgun[128]    : u32 [[name("Light Bowgun")]];
  SharpnessRow *dualBlades[128]     : u32 [[name("Dual Blades")]];
  SharpnessRow *longSword[128]      : u32 [[name("Long Sword")]];
  SharpnessRow *huntingHorn[128]    : u32 [[name("Hunting Horn")]];
  SharpnessRow *gunlance[128]       : u32 [[name("Gunlance")]];
  SharpnessRow *bow[128]            : u32 [[name("Bow")]];
  SharpnessRow *tonfa[128]          : u32 [[name("Tonfa")]];
  SharpnessRow *switchAxe[128]      : u32 [[name("Switch Axe")]];
  SharpnessRow *magnetSpike[128]    : u32 [[name("Magnet Spike")]];
};

SharpnessTables sharpnessTables @ header.ptrs.SharpnessIds [[name("Sharpness Tables")]];

// Sharpness multipliers (header 0x658; Wii U hit_hit_sub_em, slot 0x670): one
// row per sharpness colour tier of the attacker (PlayerWork +0xB2F; +1 for the
// Gunlance under status flag 0x10000000, capped at 7; forced to white when
// Shell00_shield_attack_check returns 2), read by on_hit_effects_dispatch. Bow
// skips the table; a Partnyaa uses only bounce.
struct SharpnessMultiplierRow {
    float raw [[comment("x the hit column factor and the hitzone, scales the hit's raw value")]];
    float element [[comment("scales the sum of the five element damages and the sigil 0x34 extra damage")]];
    float bounce [[comment("x the column factor and the hitzone, compared with 0.23 / 0.45 / 1.0 for the bounce state and hitstop")]];
};

struct SharpnessMultipliers {
    SharpnessMultiplierRow red;
    SharpnessMultiplierRow orange;
    SharpnessMultiplierRow yellow;
    SharpnessMultiplierRow green;
    SharpnessMultiplierRow blue;
    SharpnessMultiplierRow white;
    SharpnessMultiplierRow purple;
    SharpnessMultiplierRow skyBlue;
};

SharpnessMultipliers sharpnessMultipliers @ header.ptrs.sharpnessMultipliers [[name("Sharpness Multipliers")]];
