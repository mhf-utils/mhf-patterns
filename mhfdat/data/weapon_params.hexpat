#pragma once

/**
	Tables per weapon class or ammo type: weapon parameters, bullet sets, horn
	melodies, Light Bowgun rapid fire, and two tables whose length is unknown.
	Layouts and names from ezemania2/mhf-file-editor. Checked on the ZZ JP and
	EN files: the 14 parameter rows and the 44 bullet sets end at zero padding,
	the 71 melodies too (important numbers + 0x258); the class multiplier is
	the weapon's bloat x 100 (480 for the Great Sword's 4.8).
	The rapid fire tables come from the mhfo-hd.dll code that reads them.
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Weapon parameters (header 0x65C): one row of 0xE4 bytes per weapon class,
// in class order (className)
// =======================

struct Pose {
    float position[3];
    float rotation[3];
};

struct DrawMotion {
    u16 motion;
    s8  duration;
    s8  tick;
};

struct WeaponParams {
    u8    unk00;
    u8    classFlags;
    u8    chargeHudSeed;
    u8    adaptationGaugeSeed;
    u8    unk04[4];
    float onHitMultiplier;
    u32   classMultiplier       [[comment("Bloat x 100")]];
    Pose  poses[4]              [[comment("3 variants, then sheathing and drawing")]];
    float hudViewDefaultZ;
    float hudViewPosition[3];
    float hudViewPositionAdd[3];
    float hudViewRotation[3];
    float hudViewRotationAdd[3];
    u8    meleeHoldInputGate;
    u8    unkA5;
    s16   recoveryMotionAction;
    u8    unkA8[4];
    DrawMotion draw;
    DrawMotion drawAlt;
    DrawMotion sheathe;
    DrawMotion sheatheAlt;
    u8    hitstopFrames;
    u8    hitstopReduction;
    u8    unkBE;
    u8    fencingHitSound;
    u16   redSoulGaugeThreshold;
    u16   redSoulTierBonus;
    u32   turnRateStates;
    s16   categorySwitchPenalty;
    s16   thunderCladGaugeDecay;
    u32   rushOnHitGaugeMultiplier;
    u8    rushGaugeIncrement;
    padding[1];
    u16   rushTier0;
    s16   rushTier1Bonus;
    s16   rushTier2Bonus;
    u8    rushTier3OrSlayer[2]  [[comment("Rush tier 3 (s16) or Consumption Slayer (2 u8)")]];
    u16   ceaselessTimer;
    u16   ceaselessThresholds[3];
    u8    unkE2[2];
};

WeaponParams weaponParams[14] @ header.ptrs.weaponParams [[name("Weapon Parameters")]];

// =======================
// Bullet sets (header 0xA4): 44 sets of 100 bytes, the magazine size of each
// ammo type, then 68 bytes of 0/1 (1 almost everywhere, use unknown)
// =======================

struct BulletSet {
    u8 normal[3];
    u8 pierce[3];
    u8 pellet[3];
    u8 crag[3];
    u8 cluster[3];
    u8 fire;
    u8 water;
    u8 thunder;
    u8 ice;
    u8 dragon;
    u8 recovery[2];
    u8 poison[2];
    u8 paralysis[2];
    u8 sleep[2];
    u8 tranquilizer;
    u8 paint;
    u8 demon;
    u8 armor;
    u8 unk20[68];
};

BulletSet bulletSets[44] @ header.ptrs.BulletSets [[name("Bullet Sets")]];

// =======================
// Hunting horn melodies (header 0x670): important numbers + 0x258 of them
// =======================

struct HornMelody {
    u8 song;
    u8 notes[4];
};

HornMelody hornMelodies[importantNums.numHornMelodies] @ header.ptrs.hornMelodies [[name("Horn Melodies")]];

// =======================
// Length unknown. ezemania2's editor reads 11 bonus slot rows and 23 coating
// rows; on ZZ the space up to the next table holds 65 rows of the same shape
// (values 0 to 15, then zeros) and 28 (an s16 and 5 floats each). Only the
// rows that editor reads are shown.
// =======================

struct BonusSlotRow {
    s16 slots[4];
};

BonusSlotRow weaponBonusSlots[11] @ header.ptrs.weaponBonusSlots [[name("Weapon Upgrade Bonus Slots (length unchecked)")]];

struct CoatingModifier {
    s16   delta;
    padding[2];
    float values[5];
};

CoatingModifier coatingModifiers[23] @ header.ptrs.coatingModifiers [[name("Coating Modifiers (length unchecked)")]];

// =======================
// Weapon reach bodies (header 0xD8; Wii U getWeaponReachBodyPtr): rows of 8
// lists, one per weapon reach (melee weapon length, changed by the reach
// sigil, getPlateSkillWeaponReachPlate; ranged weapons use Medium), until a
// row whose first list is null (42 rows on ZZ, picked by the caller). A list
// holds the weapon's hit capsules until a kind of -1: a radius around the
// segment from start to end, in the weapon's space.
// =======================

struct HitCapsule {
    s16   kind;
    s16   unk02;
    u16   index;
    u8    unk06[6];
    float radius;
    float start[3];
    float end[3];
};

struct HitCapsuleList {
    HitCapsule capsules[while(std::mem::read_signed($, 2) != -1)];
    s16 end;
};

struct ReachBodyRow {
    ptVar<HitCapsuleList> byReach[8];
};

ReachBodyRow weaponReachBodies[while(std::mem::read_unsigned($, 4) != 0)] @ header.ptrs.weaponReachBodies [[name("Weapon Reach Bodies")]];

// =======================
// Motion values (header 0x63C, and 0x74C for the alternate bank): one row per
// action id below 0x35, empty when valid is 0. A hit's key - 1 (0 to 11)
// picks the column: the raw motion value goes to the hit, the element one
// too, the status power when it is not 0.
// =======================

struct MotionValueRow {
    u8    valid;
    padding[3];
    u16   raw[12];
    u8    element[12];
    u8    unk28[12];
    u8    statusPower[12];
    float scale[12];
    u16   rawSecondary[12];
};

MotionValueRow motionValues[0x35] @ header.ptrs.motionValues [[name("Motion Values")]];
MotionValueRow motionValuesAlt[0x35] @ header.ptrs.motionValuesAlt [[name("Motion Values (alternate bank)")]];

// =======================
// Random (ex G) melee weapons: the sharpness a rolled value gives, per weapon
// class (header 0x370 Sword and Shield, 0x374 Dual Blades, 0x378 Great Sword
// and Long Sword, 0x37C Lance, 0x380 Hammer and Hunting Horn, 0x4F8
// Gunlance), until a sharpness id of 0xFF. The id picks the color table; the
// max sharpness is (step + 3) x 50, as a weapon's own sharpnessMax.
// =======================

struct RandomSharpness {
    u8 sharpnessId;
    u8 maxStep;
};

struct RandomSharpnessList {
    RandomSharpness rows[while(std::mem::read_unsigned($, 1) != 0xFF)];
    RandomSharpness end;
};

RandomSharpnessList randomSharpnessSwordAndShield @ header.ptrs.randomSharpnessSwordAndShield [[name("Random Sharpness: Sword and Shield")]];
RandomSharpnessList randomSharpnessDualBlades @ header.ptrs.randomSharpnessDualBlades [[name("Random Sharpness: Dual Blades")]];
RandomSharpnessList randomSharpnessGreatSwordLongSword @ header.ptrs.randomSharpnessGreatSwordLongSword [[name("Random Sharpness: Great Sword, Long Sword")]];
RandomSharpnessList randomSharpnessLance @ header.ptrs.randomSharpnessLance [[name("Random Sharpness: Lance")]];
RandomSharpnessList randomSharpnessHammerHorn @ header.ptrs.randomSharpnessHammerHorn [[name("Random Sharpness: Hammer, Hunting Horn")]];
RandomSharpnessList randomSharpnessGunlance @ header.ptrs.randomSharpnessGunlance [[name("Random Sharpness: Gunlance")]];

// Random gunlances roll their shell type in header 0x4F0 (normal, long,
// spread). Header 0x4F4: the draw speed the handling skill (or a G finesse
// weapon) sets when it is faster than the weapon's own.
u8 randomShellTypes[3] @ header.ptrs.randomShellTypes [[name("Random Gunlance Shell Types")]];
float handlingDrawSpeed @ header.ptrs.handlingDrawSpeed [[name("Handling Draw Speed")]];

// Gunner shot power (header 0x1C8): one pointer per ammo type (44, the hit's
// ammo +0x1A) to a u16 list indexed by the hit's byte +0x0B; the value is
// the shot's power (hit +0x6C). The list lengths are not proven, so only the
// pointers are shown. HC Kai armor (armor flag 0x100; Wii U
// PlGetHCkaiCriDmgValue / PlGetHCkaiDefValue), in HC quests or G-rank fields,
// by the number of worn HC Kai pieces (0-5): header 0x5B0 adds a multiplier
// to critical hits (all 0 on ZZ), header 0x5B4 adds defense.
u32 gunnerShotPowerLists[44] @ header.ptrs.gunnerShotPower [[name("Gunner Shot Power Lists")]];
float hcKaiCritDamage[6] @ header.ptrs.hcKaiCritDamage [[name("HC Kai Critical Damage Bonus")]];
s16 hcKaiDefense[6] @ header.ptrs.hcKaiDefense [[name("HC Kai Defense Bonus")]];

// =======================
// Bowgun just reload and just shot (header 0x668 / 0x66C; the Wii U client
// keeps them in code: GetJustReloadActionData, We01_GetJustShotInputData).
// 0x668: one list per reload speed tier (important numbers + 0x252 lists of
// + 0x250 rows); 0x66C: the just shot list, the second one with sigil 0x47
// (+ 0x254 rows each). A row has the shape of a weapon action cancel
// (weapon_actions.hexpat), read by FUN_10A68690 the way
// weapon_action_cancel_check reads a cancel, but its conditions test the
// player's motion id instead of the action step: input inputId pressed
// inside window A, then nextActType starts inside window B.
// =======================

struct JustActionCondition {
    u16 motion;
    u8  mode;
    s8  blend;
    u16 frame;
    u16 count;
};

struct JustActionRow {
    u16 minStep;
    u16 inputId;
    u16 groupBit;
    JustActionCondition windowAOpen;
    JustActionCondition windowAClose;
    u16 nextActType;
    JustActionCondition windowBOpen;
    JustActionCondition windowBClose;
};

struct JustReloadList {
    JustActionRow rows[importantNums.numJustReloadRows];
};

struct JustShotList {
    JustActionRow rows[importantNums.numJustShotRows];
};

ptVar<JustReloadList> justReloadLists[importantNums.numJustReloadLists] @ header.ptrs.justReloadLists [[name("Just Reload Lists")]];
ptVar<JustShotList> justShotLists[2] @ header.ptrs.justShotLists [[name("Just Shot Lists")]];

// =======================
// Gunlance shells (header 0x678; Wii U getBaseDamage, setWeaponAttributeData,
// shell38_i): one row per gunlance attribute (hit +0xC74, important numbers
// + 0x25C rows: 9 shell levels x 3 shell types, row = (level - 1) x 3 + type).
// we09_bomb spawns the shell through shell_k38_call_shell(type, level, action,
// kind), and the hit's action (+0x42) and kind (+0x43) pick the values:
// - actions 0-3, kind 0 or 1 (we09_bomb mode 0 / 1, one hit): shell*;
// - mode 2 (attributeBomb, action 1, and wideAttributeBomb, action 3)
//   spawns two hits: kind 2 takes attributeBomb*, kind 3 carries the
//   weapon's element (its value x attributeHitElementPercent / 100); a weapon
//   with no element makes kind 3 a hit of effect 0x1C (hit +0x84) worth
//   attributeHitNoElementValue (hit +0x89) with attributeHitNoElementRaw as
//   raw. A sword crystal of type 1 or 0xB (setKensibinAttributeData) makes
//   the hit effect 0x23 worth attributeBomb* x 2 instead.
// - action 4 (dragon cannon) and 5 (HD Extreme shot): dragonCannon*.
// The fire values are the hits' fire element (heat blade triples it).
// =======================

struct GunlanceShellRow {
    u8  shellRaw;
    u8  shellFire;
    u8  attributeBombRaw;
    u8  attributeBombFire;
    u8  attributeHitNoElementRaw;
    u8  attributeHitNoElementValue;
    u8  unk06[2];
    s32 attributeHitElementPercent;
    u8  dragonCannonRaw;
    u8  dragonCannonFire;
    u8  unk0E[2];
};

GunlanceShellRow gunlanceShells[importantNums.numGunlanceShells] @ header.ptrs.gunlanceShells [[name("Gunlance Shells")]];

// =======================
// Gunlance shelling (header 0x688-0x6A0; Wii U we09_bomb, getShell38DamegeRate,
// we09_atk_sp_dragon_cannon). Rows are the gunlance's shell type (its
// attribute % 3). we09_bomb(action, mode) takes the sharpness cost of the
// action from 0x688 (the Wii U row has 6 actions, HD inserted exShot
// as action 5 and moved the step bomb to 6). Action 4 at charge level 0 is the
// dragon cannon (shell 4); at charge level 1-8 it is the sp dragon cannon
// (shell 5), which adds the level's 0x694 sharpness and takes its damage
// rate from 0x68C and its timer (player +0xB24) rate from 0x690. The charge
// level (player +0xB28; Wii U +0xAD0) starts at 1 and gains 1 per charge
// input, each one feeding a loaded shell, up to 8. Action 5 (shell 7, HD
// only, event 0x13 of gl_ex_event_handler, the Extreme style script) reads
// 0x698 / 0x69C / 0x6A0 the same way.
// =======================

struct GunlanceShellCostRow {
    s16 bomb                 [[comment("action 0, Wii U we09_attack_bomb")]];
    s16 attributeBomb        [[comment("action 1, Wii U we09_attack_attribute_bomb (mode 2: shell hit kinds 2 and 3)")]];
    s16 wideBomb             [[comment("action 2, Wii U we09_atk_wide_bomb (one cost per shell it fires)")]];
    s16 wideAttributeBomb    [[comment("action 3, Wii U we09_atk_wide_bomb in mode 2; HD gl_rapid_fire_action_update")]];
    s16 dragonCannon         [[comment("action 4, plain and sp dragon cannon")]];
    s16 exShot               [[comment("action 5, HD only: event 0x13 of gl_ex_event_handler")]];
    s16 moveStepBomb         [[comment("action 6 (Wii U 5, we09_attack_move_step_bomb); HD gl_evade_step_action_update")]];
};

struct GunlanceChargeLevelRow<T> {
    T byChargeLevel[8]       [[comment("charge level 1-8 at index 0-7")]];
};

GunlanceShellCostRow gunlanceShellSharpnessCost[3] @ header.ptrs.gunlanceShellSharpnessCost [[name("Gunlance Shell Sharpness Cost")]];
GunlanceChargeLevelRow<float> gunlanceSpDragonCannonDamageRate[3] @ header.ptrs.gunlanceSpDragonCannonDamageRate [[name("Gunlance Sp Dragon Cannon Damage Rate")]];
GunlanceChargeLevelRow<float> gunlanceSpDragonCannonTimerRate[3] @ header.ptrs.gunlanceSpDragonCannonTimerRate [[name("Gunlance Sp Dragon Cannon Timer Rate")]];
GunlanceChargeLevelRow<s16> gunlanceSpDragonCannonSharpnessCost[3] @ header.ptrs.gunlanceSpDragonCannonSharpnessCost [[name("Gunlance Sp Dragon Cannon Sharpness Cost")]];
GunlanceChargeLevelRow<float> gunlanceExShotDamageRate[3] @ header.ptrs.gunlanceExShotDamageRate [[name("Gunlance Extreme Shot Damage Rate")]];
GunlanceChargeLevelRow<float> gunlanceExShotTimerRate[3] @ header.ptrs.gunlanceExShotTimerRate [[name("Gunlance Extreme Shot Timer Rate")]];
GunlanceChargeLevelRow<s16> gunlanceExShotSharpnessCost[3] @ header.ptrs.gunlanceExShotSharpnessCost [[name("Gunlance Extreme Shot Sharpness Cost")]];

// =======================
// Light Bowgun rapid fire. Per ammo type (header 0xA0, up to the next
// table): the shots of a burst and the speed level (an index in the client's
// {1.0, 1.5, 1.6}). Per ranged weapon (header 0xC0, important numbers + 0x1A
// rows, sorted by weapon id): the ammo types it rapid fires; sigils add or
// remove some. Super rapid fire (header 0x794, important numbers + 0x2C4
// rows): the power of each ammo type is 0.5 x its multiplier at the chain
// level (0-15).
// =======================

fn ammoName(u32 i) {
    match (i) {
        (0): return "Normal S Lv1";
        (1): return "Normal S Lv2";
        (2): return "Normal S Lv3";
        (3): return "Pierce S Lv1";
        (4): return "Pierce S Lv2";
        (5): return "Pierce S Lv3";
        (6): return "Pellet S Lv1";
        (7): return "Pellet S Lv2";
        (8): return "Pellet S Lv3";
        (9): return "Crag S Lv1";
        (10): return "Crag S Lv2";
        (11): return "Crag S Lv3";
        (12): return "Clust S Lv1";
        (13): return "Clust S Lv2";
        (14): return "Clust S Lv3";
        (15): return "Flaming S";
        (16): return "Water S";
        (17): return "Thunder S";
        (18): return "Freeze S";
        (_): return std::format("Ammo {}", i);
    }
};

struct RapidFireAmmo {
    u8 unk00;
    u8 unk01;
    u8 burstShots;
    u8 speedLevel;
} [[name(ammoName((addressof(this) - header.ptrs.rapidFireAmmo) / 4))]];

RapidFireAmmo rapidFireAmmo[(nextTable(header.ptrs.rapidFireAmmo) - header.ptrs.rapidFireAmmo) / 4]
    @ header.ptrs.rapidFireAmmo
    [[name("Rapid Fire Ammo")]];

bitfield RapidFireAmmoMask {
    normalLv1  : 1;
    normalLv2  : 1;
    normalLv3  : 1;
    pierceLv1  : 1;
    pierceLv2  : 1;
    pierceLv3  : 1;
    pelletLv1  : 1;
    pelletLv2  : 1;
    pelletLv3  : 1;
    cragLv1    : 1;
    cragLv2    : 1;
    cragLv3    : 1;
    clustLv1   : 1;
    clustLv2   : 1;
    clustLv3   : 1;
    flaming    : 1;
    water      : 1;
    thunder    : 1;
    freeze     : 1;
    unk        : 13;
};

struct RapidFireWeapon {
    u16 rangedWeapon;
    padding[2];
    RapidFireAmmoMask ammo;
};

RapidFireWeapon rapidFireWeapons[importantNums.numRapidFireWeapons] @ header.ptrs.rapidFireWeapons [[name("Rapid Fire Weapons")]];

struct SuperRapidFirePower {
    u32   ammo                  [[format("ammoName")]];
    float multByChainLevel[16];
};

SuperRapidFirePower superRapidFirePower[importantNums.numSuperRapidFirePowers] @ header.ptrs.superRapidFirePower [[name("Super Rapid Fire Power")]];
