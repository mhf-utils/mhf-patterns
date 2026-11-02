#pragma once

/**
	Tables per weapon class or ammo type: weapon parameters, bullet sets, horn
	melodies, and two tables whose length is unknown.
	Layouts and names from ezemania2/mhf-file-editor. Checked on the ZZ JP and
	EN files: the 14 parameter rows and the 44 bullet sets end at zero padding,
	the 71 melodies too (important numbers + 0x258); the class multiplier is
	the weapon's bloat x 100 (480 for the Great Sword's 4.8).
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
