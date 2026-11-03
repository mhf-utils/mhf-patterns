#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Evolution weapons. A weapon's evolution series comes from header 0x2CC
// (melee, important numbers + 0xB4) / 0x2D0 (ranged, + 0xB6) {weapon row,
// series} (evo_weapon_series_get); its level is byte +4 of the equipment slot
// (+5 for bowguns, evo_weapon_level_get). Series 0-11 use 100-level tables of
// 0x7C bytes (evo_series_table_get: headers 0x2D4-0x2E0, 0x3A8-0x3B4,
// 0x9FC-0xA08), series 12-15 the G tables of 0xB0 bytes (evo_g_series_table_get:
// 0xA0C Flash, 0xA10 Shine, 0xA14 Glory, 0xA18 Clear). Row = level - 1 (level 0
// reads level 1). The per-class entries follow the class order SnS, DS, GS, LS,
// Hammer, HH, Lance, GL, Tonfa, SAF, MS (code table 0x1188DD9C). Proofs:
// tools/mhfdat_re/data/evo_notes.md.
// =======================

struct EvoWeaponSeries {
    u16 weapon [[comment("melee / ranged weapon row")]];
    u16 series;
};

EvoWeaponSeries evoMeleeWeaponSeries[importantNums.numEvoMeleeWeapons] @ header.ptrs.evoMeleeWeaponSeries [[name("Evolution Melee Weapon Series")]];
EvoWeaponSeries evoRangedWeaponSeries[importantNums.numEvoRangedWeapons] @ header.ptrs.evoRangedWeaponSeries [[name("Evolution Ranged Weapon Series")]];

struct EvoClassStats {
    u16 attack [[comment("evo_weapon_attack_get")]];
    u8 element [[comment("evo_weapon_element_status_get(class, 0)")]];
    u8 poison [[comment("(class, 1)")]];
    u8 paralysis [[comment("(class, 2)")]];
    u8 sleep [[comment("(class, 3)")]];
    u16 gap06;
};

struct EvoBowStats {
    u16 attack;
    u8 element;
    u8 gap03;
};

struct EvoBowgunStats {
    float shotModifiers[5] [[comment("gunner_load_coating_modifier_row copies these 0x18 bytes to the gunner work where a coatingModifiers row goes")]];
    u16 lbgAttack [[comment("evo_weapon_attack_get, class 5")]];
    u16 hbgAttack [[comment("class 1")]];
};

struct EvoLevel {
    u32 cost [[comment("g (\"Not enough g\")")]];
    u16 requiredHR [[comment("evo_level_required_hr_get (\"HR Not Sufficient\")")]];
    u16 level;
    EvoClassStats classes[11];
    EvoBowStats bow;
    EvoBowgunStats bowgun;
};

struct EvoGClassStats {
    u16 attack;
    u16 maxSharpness [[comment("evo_weapon_max_sharpness_get (weapon_max_sharpness_value_compute); series 0-11 use 350")]];
    u16 element;
    u8 poison;
    u8 paralysis;
    u8 sleep;
    u8 affinity [[comment("evo_weapon_affinity_get (weapon_base_affinity_value); series 12-15 only")]];
    u16 gap0A;
};

struct EvoGBowStats {
    u16 attack;
    u16 element;
    u8 affinity;
    u8 gap05;
    u16 gap06;
};

struct EvoGBowgunStats {
    float shotModifiers[5];
    u16 lbgAttack;
    u16 hbgAttack;
    u8 lbgAffinity;
    u8 hbgAffinity;
    u16 gap1A;
};

struct EvoGLevel {
    u32 cost [[comment("Gg")]];
    u16 requiredHR;
    u16 level;
    EvoGClassStats classes[11];
    EvoGBowStats bow;
    EvoGBowgunStats bowgun;
};

EvoLevel evoSeries0[100] @ header.ptrs.evoSeries0 [[name("Evolution Series 0")]];
EvoLevel evoSeries1[100] @ header.ptrs.evoSeries1 [[name("Evolution Series 1")]];
EvoLevel evoSeries2[100] @ header.ptrs.evoSeries2 [[name("Evolution Series 2")]];
EvoLevel evoSeries3[100] @ header.ptrs.evoSeries3 [[name("Evolution Series 3")]];
EvoLevel evoSeries4[100] @ header.ptrs.evoSeries4 [[name("Evolution Series 4")]];
EvoLevel evoSeries5[100] @ header.ptrs.evoSeries5 [[name("Evolution Series 5")]];
EvoLevel evoSeries6[100] @ header.ptrs.evoSeries6 [[name("Evolution Series 6")]];
EvoLevel evoSeries7[100] @ header.ptrs.evoSeries7 [[name("Evolution Series 7")]];
EvoLevel evoSeries8[100] @ header.ptrs.evoSeries8 [[name("Evolution Series 8")]];
EvoLevel evoSeries9[100] @ header.ptrs.evoSeries9 [[name("Evolution Series 9")]];
EvoLevel evoSeries10[100] @ header.ptrs.evoSeries10 [[name("Evolution Series 10")]];
EvoLevel evoSeries11[100] @ header.ptrs.evoSeries11 [[name("Evolution Series 11")]];

// series 12-15; mhfpac: Flash favors attack, Shine element, Glory sharpness length.
// 0xA0C has the highest attack and 0xA10 the highest element; the Glory / Clear
// labels of 0xA14 / 0xA18 are kept from the old pattern (all four have the same
// maxSharpness; 0xA18 has no element and the highest affinity)
EvoGLevel evoUpgradesFlash[100] @ header.ptrs.evoUpgradesFlash [[name("Evolution Series 12 (Flash)")]];
EvoGLevel evoUpgradesShine[100] @ header.ptrs.evoUpgradesShine [[name("Evolution Series 13 (Shine)")]];
EvoGLevel evoUpgradesGlory[100] @ header.ptrs.evoUpgradesGlory [[name("Evolution Series 14 (Glory)")]];
EvoGLevel evoUpgradesClear[100] @ header.ptrs.evoUpgrades [[name("Evolution Series 15 (Clear)")]];
