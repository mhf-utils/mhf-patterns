#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Evolution weapons. A weapon's evolution series comes from header 0x2CC
// (melee, important numbers + 0xB4) / 0x2D0 (ranged, + 0xB6) {weapon row,
// series} (get_evo_weapon_lvuptype, Wii U get_evo_weapon_lvuptype); its level is
// byte +4 of the equipment slot (+5 for bowguns, Get_Evo_level_eq). Series
// 0-11 use 100-level tables of 0x7C bytes (get_evo_weapon_tbl, Wii U
// get_evo_weapon_tbl: headers 0x2D4-0x2E0, 0x3A8-0x3B4, 0x9FC-0xA08), series
// 12-15 tables of 0xB0 bytes (evo_g_series_table_get: 0xA0C-0xA18). Row =
// level - 1 (level 0 reads level 1). Series 8-11 are the G rank Flash / Shine /
// Glory / Clear weapons and 12-15 the Zenith ones: the title unlock rows of
// header 0xA6C give series 8-15 titles 295-298 / 409-412 (pTitleTexts[id * 2]
// Supreme / Eternal Lustre "Flash" ... "Clear", same order). Series 0-7 weapons
// level up with g, series 8-15 weapons with Gg (evo_level_up_can_afford:
// get_equiptype_or_ammo_type(1) kind 1 / kind 2-3). The per-class entries follow the class order SnS, DS, GS, LS,
// Hammer, HH, Lance, GL, Tonfa, SAF, MS (code table 0x1188DD9C). Proofs:
// tools/mhfdat_re/data/evo_notes.md.
// =======================

struct EvoWeaponSeries {
    u16 weapon [[comment("melee / ranged weapon row")]];
    s16 series [[comment("signed: cwde in get_evo_weapon_tbl, movsx in get_evo_slash_power, jg against 12")]];
};

EvoWeaponSeries evoMeleeWeaponSeries[importantNums.numEvoMeleeWeapons] @ header.ptrs.evoMeleeWeaponSeries [[name("Evolution Melee Weapon Series")]];
EvoWeaponSeries evoRangedWeaponSeries[importantNums.numEvoRangedWeapons] @ header.ptrs.evoRangedWeaponSeries [[name("Evolution Ranged Weapon Series")]];

struct EvoClassStats {
    u16 attack [[comment("get_evo_atk")]];
    u8 element [[comment("get_evo_attrvalue(class, 0)")]];
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

// gunner_load_bowgun_level_modifier_row puts these 5 floats where a
// non-evolution bowgun gets bowgunLevelModifiers row +4 ... +0x14 (gunner work
// +0x24 ... +0x34) and zeroes the attackBonus slot (+0x20)
struct EvoShotModifiers {
    float shotSpeedMult;
    float shotSpeedRandomMult;
    float shotHit60RandomMult;
    float flight1CMult;
    float critDistanceScale;
};

struct EvoBowgunStats {
    EvoShotModifiers shot;
    u16 lbgAttack [[comment("get_evo_atk, class 5; + bowgunLevelModifiers row 20 attackBonus when equipment +4 bit 0x20")]];
    u16 hbgAttack [[comment("class 1; + row 21 attackBonus with the same bit")]];
};

struct EvoLevel {
    s32 cost [[comment("g for series 0-7, Gg for 8-11; signed compares in evo_level_up_can_afford")]];
    u16 requiredHR [[comment("get_evo_lvup_hr (\"HR Not Sufficient\")")]];
    u16 level [[comment("no reader; row + 1 in every table")]];
    EvoClassStats classes[11];
    EvoBowStats bow;
    EvoBowgunStats bowgun;
};

struct EvoGClassStats {
    u16 attack;
    u16 maxSharpness [[comment("get_evo_slash_power (weapon_max_sharpness_value_compute); series 0 and 4: 150 + min(2 x (level - 1), 200), other series 0-11: 350")]];
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
    EvoShotModifiers shot;
    u16 lbgAttack;
    u16 hbgAttack;
    u8 lbgAffinity;
    u8 hbgAffinity;
    u16 gap1A;
};

struct EvoGLevel {
    s32 cost [[comment("Gg")]];
    u16 requiredHR;
    u16 level [[comment("no reader")]];
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
// series 8-11 (G rank) and 12-15 (Zenith): Flash, Shine, Glory, Clear (title
// unlock rows of header 0xA6C + pTitleTexts); mhfpac: Flash favors attack, Shine
// element, Glory sharpness length; Clear has no element
EvoLevel evoSeries8[100] @ header.ptrs.evoSeries8 [[name("Evolution Series 8 (G Flash)")]];
EvoLevel evoSeries9[100] @ header.ptrs.evoSeries9 [[name("Evolution Series 9 (G Shine)")]];
EvoLevel evoSeries10[100] @ header.ptrs.evoSeries10 [[name("Evolution Series 10 (G Glory)")]];
EvoLevel evoSeries11[100] @ header.ptrs.evoSeries11 [[name("Evolution Series 11 (G Clear)")]];

EvoGLevel evoUpgradesFlash[100] @ header.ptrs.evoUpgradesFlash [[name("Evolution Series 12 (Zenith Flash)")]];
EvoGLevel evoUpgradesShine[100] @ header.ptrs.evoUpgradesShine [[name("Evolution Series 13 (Zenith Shine)")]];
EvoGLevel evoUpgradesGlory[100] @ header.ptrs.evoUpgradesGlory [[name("Evolution Series 14 (Zenith Glory)")]];
EvoGLevel evoUpgradesClear[100] @ header.ptrs.evoUpgrades [[name("Evolution Series 15 (Zenith Clear)")]];

// Evolution gunlance shelling levels (header 0x3B8): one u8 per series
// (get_evo_weapon_lvuptype, 0-15) and level (Get_Evo_level_eq, 1-100; level 0
// reads level 1). get_evo_gunlance_type (Wii U get_evo_gunlance_lv, slot 0x3E0):
// shell row = min(max(value - 1, 0), gunlance shell rows / 3 - 1) x 3 + the melee
// weapon row's weaponAttribute % 3, at most the last gunlance shell row
// (important numbers + 0x25C).
struct EvoGunlanceShellLevels {
    u8 shellLevelByEvoLevel[100];
};

EvoGunlanceShellLevels evoGunlanceShellLevels[16] @ header.ptrs.evoGunlanceShellLevels [[name("Evolution Gunlance Shell Levels")]];

// Evolution bowgun bomb rates (header 0x554, important numbers + 0x1DC rows).
// get_evo_bowgun_bomb_rate (Wii U name) scans every row and returns the rate of
// the last row whose weapon is the attacker's ranged weapon row (pw+0x402, only
// when pw+0x401 == 7), 1.0 when none matches. The rate multiplies (value +
// evolution level x 0.5, 1 or 0.2, by caller) of element and bomb shell hits.
struct EvoBowgunBombRate {
    u16 weapon [[comment("Ranged weapon row (pw+0x402); every row is in evoRangedWeaponSeries")]];
    u16 unk02 [[comment("no reader, always 0")]];
    float rate;
};

EvoBowgunBombRate evoBowgunBombRates[importantNums.numEvoBowgunBombRates] @ header.ptrs.evoBowgunBombRates [[name("Evolution Bowgun Bomb Rates")]];
