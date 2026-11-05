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

// Weapon Use Ban free actions (header 0x664): for the ryoudan\rquest.bin
// mission conditions 0x20 "[Personal] Weapon Use Ban" and 0x21 "[Party] Weapon
// Use Ban" (pQuestDetailTexts[type + 0x76]). rquest_weapon_use_ban_check runs on
// every player action in areas 0xCA-0xCC / 0xCE / 0x1BD;
// rquest_weapon_use_ban_is_violation returns 1 (the mission fails) when the
// player's actCategory is 1 and its actType is not in the class's list. One row
// per weapon class (14, fixed); the lists follow in reverse class order.
struct WeaponUseBanFreeActions {
    u8 count;
    padding[3];
    u8 *actTypes[count] : u32;
} [[format("weaponUseBanFreeActionsName")]];

fn weaponUseBanFreeActionsName(ref auto r) {
    return std::format("{} | {} actions", className(std::core::array_index()), r.count);
};

WeaponUseBanFreeActions weaponUseBanFreeActions[14] @ header.ptrs.weaponUseBanFreeActions [[name("Weapon Use Ban Free Actions")]];

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
// Evolution gun extra ammo (header 0x520, gun_extra_ammo_allowed): for a
// light or heavy bowgun, an item listed on the row of the equipped gun can be
// loaded whatever the gun's ammo table says (gunner_find_next_usable_ammo_or_coating_index,
// bowgun_ammo_item_is_usable, FUN_106FD260). The check runs only when
// get_equiptype_or_ammo_type(1) is set: the gun has equip type bit 4 or
// weapon type bit 0x400, and byte +5 of the equipment entry is 1-100.
// Rows are found by a binary search on gun; the rows are not sorted, so on
// the 3 files only 15 of the 76 rows can be found.
// =======================

fn evolutionGunName(u16 id) {
    return getEquipKindName(7, id);
};

struct EvolutionGunAmmo {
    u16 gun [[format("evolutionGunName"), comment("Ranged weapon id, the binary search key")]];
    ItemId items[7] [[comment("0: none")]];
};

EvolutionGunAmmo evolutionGunAmmo[importantNums.numEvolutionGunAmmo] @ header.ptrs.evolutionGunAmmo [[name("Evolution Gun Extra Ammo")]];

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
// Dual Blades blade effects (Wii U Calc_wsword_eft_id, eft03_ofs_calc,
// eft03_mat_calc, eft05_mat_calc). Header 0xE0: ranges of weapon model ids
// (player +0x38C, class 6 only) until -1; the effect index is the model's
// position across the ranges, and picks a row of header 0xD0 (468 rows on
// ZZ, the sum of the ranges). A row has one side per blade joint (0x0E, 0x12):
// effect 03 offsets (x, z) and the two scales of the joint matrix, then
// effect 05 offset and scale, the scale times header 0xD4 at the weapon's
// reach (getPlateSkillWeaponReachPlate). Header 0xDC (Wii U
// shell64_get_weapon_pos, eft13_pos_set, eft41_i): a position (s16 x, y, z)
// on the weapon by reach.
// =======================

struct WswordEftModelRange {
    s16 firstModel;
    s16 lastModel;
};

struct WswordEftModelRanges {
    WswordEftModelRange ranges[while(std::mem::read_signed($, 2) != -1)];
    WswordEftModelRange end;
};

struct WswordEft03Side {
    float offsetX;
    float offsetZ;
    float scaleRow0;
    float scaleRow1;
};

struct WswordEft05Side {
    float offset[3];
    float scale;
};

struct WswordEftRow {
    WswordEft03Side eft03Joint0E;
    WswordEft03Side eft03Joint12;
    WswordEft05Side eft05Joint0E;
    WswordEft05Side eft05Joint12;
};

fn wswordEftCount() {
    u32 p = header.ptrs.wswordEftModelRanges;
    u32 n = 0;
    while (std::mem::read_signed(p, 2) != -1) {
        n += std::mem::read_signed(p + 2, 2) - std::mem::read_signed(p, 2) + 1;
        p += 4;
    }
    return n;
};

struct WeaponPos {
    s16 x;
    s16 y;
    s16 z;
};

WswordEftModelRanges wswordEftModelRanges @ header.ptrs.wswordEftModelRanges [[name("Dual Blades Effect Model Ranges")]];
WswordEftRow wswordEfts[wswordEftCount()] @ header.ptrs.wswordEfts [[name("Dual Blades Blade Effects")]];
float wswordEftReachScale[8] @ header.ptrs.wswordEftReachScale [[name("Dual Blades Effect 05 Scale By Reach")]];
WeaponPos weaponPosByReach[8] @ header.ptrs.weaponPosByReach [[name("Weapon Position By Reach")]];

// =======================
// Bow model materials. Header 0x580 (important numbers + 0x1F0 rows, sorted
// by model; FUN_11266E20 binary searches it with the player's weapon model
// id): the row of header 0x57C for that bow model (Link, Plunderer, Prima
// Shooter, Suzaku Fire Bow, Starry Sky Bow... on ZZ); a model not listed uses
// row 0. A 0x57C column is an index in the material table (0x8C bytes each)
// of the common render resource (DAT_1ED7D6A0 + 0x30), picked by the reader:
// column 0 by the arrow shell (kind 24) draw FUN_11266EE0, columns 1 and 2 by
// the two FUN_10B7FA70 draws (FUN_10B7F510), column 3 by
// shell_atk_tbl_1162AFA8_i_b (shell work + 0x2C4). Column 4 has no reader.
// Rows 0 to 9: 9 is the largest row of 0x580.
// =======================

struct BowModelMaterialRow {
    u16 model;
    u16 row;
};

struct BowModelMaterials {
    u16 arrowShellMaterial;
    u16 fxMaterial1;
    u16 fxMaterial2;
    u16 atkTbl1162AFA8Material;
    u16 unk08;
};

BowModelMaterialRow bowModelMaterialRows[importantNums.numBowModelMaterialRows] @ header.ptrs.bowModelMaterialRows [[name("Bow Model Material Rows")]];
BowModelMaterials bowModelMaterials[10] @ header.ptrs.bowModelMaterials [[name("Bow Model Materials")]];

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

// Random (ex G) weapons (header 0x36C, important numbers + 0xFA rows): a weapon
// is random when chk_ex_g_weapon passes (type 6 / 7, weapon equipType & 0x10).
// Crafting rolls an ex G rank into equipment entry +4 & 0x3FF (header 0x3A0,
// get_ex_g_next_rank): rank 1-16 is the top tier, 17-32 the mid tier, 33-1023
// the base tier; the crafted id becomes the tier's weapon id (+2 mid, +4 top).
// get_exgw_dat finds the row by weapon id and equip type; get_ex_g_num rolls a
// stat in [min, max] of the tier (row + 8 + tier x 0x14), by kind 0-8; for base
// ranks 33-232 attack and sharpness sometimes use the mid ranges. An unrolled
// weapon (rank 0) shows ranges from base min to top max; the top id gets a ★.
struct ExGWeaponTier {
    u16 attackMin [[comment("Kind 0")]];
    u16 attackMax;
    u8 sharpnessOrBowChargeRowMin [[comment("Kind 1: randomSharpness row (melee) or header 0x3A4 row (bow)")]];
    u8 sharpnessOrBowChargeRowMax;
    s8 affinityMin [[comment("Kind 2")]];
    s8 affinityMax;
    u8 elementMin [[comment("Kind 3")]];
    u8 elementMax;
    u8 ailmentMin [[comment("Kind 4")]];
    u8 ailmentMax;
    u8 slotsMin [[comment("Kind 5")]];
    u8 slotsMax;
    u8 hornNotesRowMin [[comment("Kind 6: header 0x4EC row")]];
    u8 hornNotesRowMax;
    u8 shellTypeRowMin [[comment("Kind 7: randomShellTypes row")]];
    u8 shellTypeRowMax;
    u8 shellLevelMin [[comment("Kind 8")]];
    u8 shellLevelMax;
};

struct ExGWeapon {
    u16 baseWeaponId;
    u16 midWeaponId;
    u16 topWeaponId;
    u8 equipType [[comment("6 melee, 7 ranged")]];
    u8 unk07 [[comment("no reader")]];
    ExGWeaponTier baseTier [[comment("Rank 33-1023")]];
    ExGWeaponTier midTier [[comment("Rank 17-32")]];
    ExGWeaponTier topTier [[comment("Rank 1-16")]];
};

ExGWeapon exGWeapons[importantNums.numExGWeapons] @ header.ptrs.exGWeaponData [[name("Random (ex G) Weapons")]];

// Ex G rank chances (header 0x3A0, get_ex_g_next_rank and the inline copies in
// forge_weapon_craft_to_box): r = save ctx 0x1FF40 + weapon class x 16, x = save
// ctx 0x1FF4C; r % topTierPeriod < topTierChance gives rank (x & 15) + 1, else
// (r - topTierChance) % midTierPeriod < midTierChance gives (x & 15) + 0x11,
// else x % 991 + 0x21.
struct ExGRankChances {
    u32 topTierChance;
    u32 topTierPeriod;
    u32 midTierChance;
    u32 midTierPeriod;
    u32 unk10 [[comment("no reader")]];
    u32 unk14 [[comment("no reader")]];
};

ExGRankChances exGRankChances @ header.ptrs.exGRankChances [[name("Ex G Weapon Rank Chances")]];

// Random (ex G) weapon roll percents (get_ex_g_param0_per / param1_per /
// param2_per, called by get_ex_g_num). set_ex_g_srand turns the stored rank
// (equipment entry +4 & 0x3FF) into the roll rank: s = stored rank + weapon
// class + seed + base weapon id; stored rank < 0x11 gives (s & 15) + 1 (top
// tier), < 0x21 gives (s & 15) + 0x11 (mid tier), else s % 991 + 0x21. Each
// byte is a percent p of the tier's [min, max] range of that kind (column =
// get_ex_g_num kind, the ExGWeaponTier columns): value = min + (max - min + 1)
// x p / 100 (+ seed % 5 for kinds 0, 2, 3, 4), clamped to max. Gunlances
// (class 9) use the second table of each pair.
struct ExGRollPercents {
    u8 attack [[comment("Kind 0")]];
    u8 sharpnessOrBowChargeRow [[comment("Kind 1")]];
    u8 affinity [[comment("Kind 2")]];
    u8 element [[comment("Kind 3")]];
    u8 ailment [[comment("Kind 4")]];
    u8 slots [[comment("Kind 5")]];
    u8 hornNotesRow [[comment("Kind 6")]];
    u8 shellTypeRow [[comment("Kind 7")]];
    u8 shellLevel [[comment("Kind 8")]];
};

// Top tier (header 0x384, Gunlance 0x500): row = roll rank 1-16, row 0 is
// never read
ExGRollPercents exGTopTierRollPercents[17] @ header.ptrs.exGTopTierRollPercents [[name("Ex G Top Tier Roll Percents")]];
ExGRollPercents exGTopTierRollPercentsGunlance[17] @ header.ptrs.exGTopTierRollPercentsGunlance [[name("Ex G Top Tier Roll Percents: Gunlance")]];

// Mid tier (header 0x388, Gunlance 0x504): row = roll rank - 0x11 (0-15)
ExGRollPercents exGMidTierRollPercents[16] @ header.ptrs.exGMidTierRollPercents [[name("Ex G Mid Tier Roll Percents")]];
ExGRollPercents exGMidTierRollPercentsGunlance[16] @ header.ptrs.exGMidTierRollPercentsGunlance [[name("Ex G Mid Tier Roll Percents: Gunlance")]];

// Base tier overrides (header 0x38C, Gunlance 0x508): a row whose stored rank
// equals the weapon's replaces the default percent (stored rank + kind + seed)
// % 100; the 0xFFFF row ends the list but is counted
struct ExGBaseTierOverride {
    u16 storedRank;
    ExGRollPercents percents;
    u8 unk0B [[comment("no reader")]];
};

ExGBaseTierOverride exGBaseTierRollOverrides[importantNums.numExGBaseTierRollOverrides] @ header.ptrs.exGBaseTierRollOverrides [[name("Ex G Base Tier Roll Overrides")]];
ExGBaseTierOverride exGBaseTierRollOverridesGunlance[importantNums.numExGBaseTierRollOverridesGunlance] @ header.ptrs.exGBaseTierRollOverridesGunlance [[name("Ex G Base Tier Roll Overrides: Gunlance")]];
float handlingDrawSpeed @ header.ptrs.handlingDrawSpeed [[name("Handling Draw Speed")]];

// Gunner shot power (header 0x1C8): pointers picked by the hit's ammo +0x1A,
// each to a u16 list indexed by the hit's byte +0x0B; the value is the
// shot's power (hit +0x6C). The lists follow the pointers in the same block
// (several pointers share one), each ending at 0xFFFF and padded to 4 bytes,
// so the pointers stop where the first list starts: 20 pointers to 14 lists
// on the ZZ EN file, and the block ends at the next header table.
struct ShotPowerList {
    u16 power[while(std::mem::read_unsigned($, 2) != 0xFFFF)];
    u16 end;
};

fn shotPowerPointerCount() {
    u32 p = header.ptrs.gunnerShotPower;
    u32 first = std::mem::read_unsigned(p, 4);
    u32 n = 0;
    while (p + n * 4 < first) {
        if (std::mem::read_unsigned(p + n * 4, 4) < first)
            first = std::mem::read_unsigned(p + n * 4, 4);
        n += 1;
    }
    return n;
};

ptVar<ShotPowerList> gunnerShotPowerLists[shotPowerPointerCount()] @ header.ptrs.gunnerShotPower [[name("Gunner Shot Power Lists")]];

// HC Kai armor (armor flag 0x100; Wii U PlGetHCkaiCriDmgValue /
// PlGetHCkaiDefValue), in HC quests or G-rank fields, by the number of worn
// HC Kai pieces (0-5): header 0x5B0 adds a multiplier to critical hits (all
// 0 on ZZ), header 0x5B4 adds defense.
float hcKaiCritDamage[6] @ header.ptrs.hcKaiCritDamage [[name("HC Kai Critical Damage Bonus")]];
s16 hcKaiDefense[6] @ header.ptrs.hcKaiDefense [[name("HC Kai Defense Bonus")]];

// =======================
// Element and status multipliers by worn armor pieces (0-5), applied to the
// weapon's element (rate 0) or status (rate 1) in qualifying quests.
// G Armor fx pieces (armor flags 0x80, 0x4000, 0x8000; Wii U
// Pl_G_Armor_fx_num, PlGetGousyuFxAttrValue / ...Int): header 0x598 / 0x59C
// (rates) and 0x5A0 (element percent). HD only, pieces with armor flag
// 0x10000: 0x968 / 0x96C (rates) and 0x970 (percent). The count of id 4 in
// the player's 15 skill context slots (+0x50A) adds 0x968 / 0x96C too, and
// 0x974 in the percent version (which the code indexes by the flag 0x10000
// count). Readers: FUN_10A853A0 (rates), FUN_10A854C0 (percents),
// player_status_attack_multiplier.
// =======================

float gArmorFxElementRate[6] @ header.ptrs.gArmorFxElementRate [[name("G Armor Fx Element Rate")]];
float gArmorFxStatusRate[6] @ header.ptrs.gArmorFxStatusRate [[name("G Armor Fx Status Rate")]];
s32 gArmorFxElementPercent[6] @ header.ptrs.gArmorFxElementPercent [[name("G Armor Fx Element Percent")]];
float armorFlag10000ElementRate[6] @ header.ptrs.armorFlag10000ElementRate [[name("Armor Flag 0x10000 Element Rate")]];
float armorFlag10000StatusRate[6] @ header.ptrs.armorFlag10000StatusRate [[name("Armor Flag 0x10000 Status Rate")]];
s32 armorFlag10000ElementPercent[6] @ header.ptrs.armorFlag10000ElementPercent [[name("Armor Flag 0x10000 Element Percent")]];
s32 skillSlotId4ElementPercent[6] @ header.ptrs.skillSlotId4ElementPercent [[name("Skill Slot Id 4 Element Percent")]];

// Attack added by the same armor piece counts (gou_armor_combo_attack_add,
// player_recalc_attack_power_full / calculate_weapon_damage when the Gou combo
// is on): header 0x5A8 by the G Armor fx piece count (armor flags 0x1, 0x80,
// 0x4000, 0x8000) plus header 0x978 by the flag 0x10000 piece count + the
// count of id 3 in the 15 skill context slots. Index 0 = no piece.
u8 gArmorFxAttackAdd[8] @ header.ptrs.gArmorFxAttackAdd [[name("G Armor Fx Attack Add")]];
u8 armorFlag10000AttackAdd[8] @ header.ptrs.armorFlag10000AttackAdd [[name("Armor Flag 0x10000 Attack Add")]];

// G armor skill up (Wii U isGouyuSkillUpEnable / Pl_G_Armor_act_ck, header
// 0x3BC, count important numbers + 0x122): the row whose key matches the worn
// pieces (Gousyu = equipableBy bit 6 + armor flag 0x1; Gousyu Fx = armor flags
// 0x80 + 0x4000) gives the HP percent and the max stamina (PlayerWork +0xB2A)
// the player needs; no matching row = row 0. When it holds, the Wii U
// Pl_Skill_ck raises the active skills with Pl_G_Armor_skill_get.
struct GousyuSkillUpCondition {
    s32 gousyuArmorCount;
    s32 gousyuFxArmorCount;
    s32 minHpPercent;
    s32 minStaminaMax;
};

GousyuSkillUpCondition gousyuSkillUpConditions[importantNums.numGousyuSkillUpConditions] @ header.ptrs.gousyuSkillUpConditions [[name("Gousyu Skill Up Conditions")]];

// G armor skill up skill types (header 0x3C0, Wii U isGousyuSkillUpSkillType):
// the skill tree ids (Skill Tree header 0xEC) whose active skill
// Pl_G_Armor_skill_get raises one level further from zero; ends at 0. Each id
// is compared with the low byte of the tree id. Important numbers + 0x124
// (127: the ids + the terminator) has no reader.
u16 gousyuSkillUpSkillTypes[while(std::mem::read_unsigned($, 2) != 0)] @ header.ptrs.gousyuSkillUpSkillTypes [[name("Gousyu Skill Up Skill Types")]];
u16 gousyuSkillUpSkillTypesEnd @ addressof(gousyuSkillUpSkillTypes) + sizeof(gousyuSkillUpSkillTypes) [[name("Gousyu Skill Up Skill Types End")]];

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

// =======================
// Weapon constants (header 0x660, Otya unk660): one block of constants read
// one by one by the code of each weapon class, split here by weapon: each
// member is placed at its offset in the block. Every field with a reader is
// named from reading it (tools/mhfdat_re/data/660_gen.py); gapXXX bytes have
// no reader found, direct or indexed. Evade triplets go to
// player_evade_extra_distance_scaled_window (Evade Distance Up / Spacing).
// "SkillWork" = gSkillWorks[slot] (get_entity_render_slot). Rates are per
// mille unless noted.
// =======================

u32 weaponConstantsBase = header.ptrs.weaponConstants;

struct BowChargeRow {
    float speedAdd [[comment("forward speed (shot +0x58) = shot table DAT_11695A90 +0x4 + it + ... (shell_k24_i_b, gunner_compute_shot_ballistics_params)")]];
    float speedGainMult [[comment("x shot table +0x8 in the same sum (x2 with shot flag 2)")]];
    float ballisticsParam8Add [[comment("gunner_compute_shot_ballistics_params: param_8 = it + shot table +0xC - ballisticsParam8Mult term")]];
    float ballisticsParam8Mult [[comment("x shot table +0x10 (shell_k24_i_b, gunner_compute_shot_ballistics_params)")]];
    float spreadAdd [[comment("FUN_11264F80: random lateral spread x (it + shot table +0x14)")]];
    float wobbleMult [[comment("FUN_11264F80: random wobble over the first 20 frames, x shot table +0x18 (x2 with flag 2, x a Hunter pearl skill value)")]];
    float rawMult [[comment("gunner_compute_shot_damage_and_status: raw damage x it before the critical hit")]];
    float statusMult [[comment("status buildup (hit +0x80) x it")]];
    float elementMult [[comment("element x it (also status flag 0x1000000)")]];
    float elementMultFlag2 [[comment("element x it when the attack flags have 2")]];
};

struct BowHitParamRow {
    u8 hitValue [[comment("hit value (+0x6C), then x the coating raw multiplier and the critical multipliers")]];
    u8 pad1;
    u16 elementRate [[comment("per mille of the shot's element / status values (hit +0x80, +0x144-+0x154)")]];
    u16 coatingStatusValue [[comment("status coatings (shell +8 = 2 / 3 / 4): status value, x bowStatusCoatingMult")]];
    u8 hit89Value [[comment("copied to hit +0x89")]];
    u8 pad7;
    u16 elementRateFlag1000000 [[comment("replaces elementRate when the hit flags +0x7C have 0x1000000")]];
    u16 padA;
};

struct FloatTriple {
    float values[3];
};

struct BowGuideColorPair {
    u32 colorFrom;
    u32 colorTo;
};

struct BowArcGuideRow {
    u8 dashCount [[comment("bow_arc_guide_draw: the 64 guide points are split in groups of 64 / it")]];
    u8 pad1;
    u16 scrollFrames [[comment("FUN_11461630: the guide pattern scrolls one length in this many frames")]];
    float bandTop [[comment("bow_arc_guide_draw: band height above the arc")]];
    float bandBottom [[comment("same: depth below the arc")]];
};

struct ShotStageRow {
    s16 thresholds[8];
};

struct EvadeDistanceF {
    float extraDistance;
    float startFrame;
    float endFrame;
};

struct BowgunConstants {
    u16 bowgunGaugeMax @ weaponConstantsBase + 0x000 [[comment("+0x0 bowgun gauge (SkillWork +0x1C0; get_entity_render_slot returns gSkillWorks[slot]) max: FUN_1027D6F0 caps it, FUN_10284320 stores it in SkillWork +0x1C2")]];
    u16 bowgunGaugeCost @ weaponConstantsBase + 0x002 [[comment("+0x2 gauge spent per use: bowgun_event_handler event 0x10; FUN_102806F0 / FUN_102850C0 / FUN_10287560 need gauge >= it")]];
    u32 bowgunGaugeHudColor @ weaponConstantsBase + 0x004 [[comment("+0x4 FUN_1095E220 -> FUN_1095E190(0x68, 0x34, it, bowgunGaugeMax): colour of the bowgun gauge HUD (ARGB 0xFF89DFEC)")]];
    u16 bowgunGaugeBurstFrames @ weaponConstantsBase + 0x008 [[comment("+0x8 FUN_10284320 (gauge burst, motion 0x5C6): frames of the action; the shown gauge drains with it")]];
    u16 bowgunGaugeBurstShotInterval @ weaponConstantsBase + 0x00a [[comment("+0xa FUN_10284320: one shot (FUN_1027DBE0) every this many frames of the burst")]];
    u16 bowgunGaugeBurstFxFrames @ weaponConstantsBase + 0x010 [[comment("+0x10 frames over which the burst effect scales in (FUN_10284320, FUN_102841E0, FUN_10284260)")]];
    u8 gap012[2] @ weaponConstantsBase + 0x012 [[comment("+0x12 no direct reader found")]];
    float bowgunHopStartFrame @ weaponConstantsBase + 0x014 [[comment("+0x14 FUN_10282FC0 (bowgun_act_update): the hop moves from this motion frame")]];
    float bowgunHopSpeed @ weaponConstantsBase + 0x018 [[comment("+0x18 same: horizontal speed (+0x468 / +0x470, sign by direction)")]];
    float bowgunHopGravity @ weaponConstantsBase + 0x01c [[comment("+0x1c same: vertical acceleration (+0x460)")]];
    EvadeDistanceF bowgunEvadeDistance[3] @ weaponConstantsBase + 0x020 [[comment("+0x20 FUN_10282FC0 (bowgun_act_update): Evade Distance Up / Spacing, by direction")]];
    float bowgunShotFlag20Mult @ weaponConstantsBase + 0x090 [[comment("+0x90 FUN_1027EA60 (shot from bowgun_event_handler): shot power x it when the event flags have 0x20")]];
    float bowgunShotFlag40Mult @ weaponConstantsBase + 0x094 [[comment("+0x94 same, flag 0x40")]];
    EvadeDistanceF bowgunEvadeDistance2 @ weaponConstantsBase + 0x098 [[comment("+0x98 FUN_10284650 (bowgun), both directions")]];
};

BowgunConstants bowgunConstants @ header.ptrs.weaponConstants [[name("Bowgun Constants")]];

struct CommonWeaponConstants {
    u32 damageGaugeMax @ weaponConstantsBase + 0x044 [[comment("+0x44 max of the damage-action gauge pw +0xE08 (Otya unk3592): capped in player_entity_tick_hp_regen, refilled by apply_damage; full: player_damage_action_update takes input 0x94, FUN_10A06AF0 returns the guard level")]];
    u8 guardLevelBase @ weaponConstantsBase + 0x048 [[comment("+0x48 skill_guard_level_table_value: guard level with neither Guard+1 nor Guard+2")]];
    u8 guardLevelGuardPlus1 @ weaponConstantsBase + 0x049 [[comment("+0x49 same, Guard+1 (0x28)")]];
    u8 guardLevelGuardPlus2 @ weaponConstantsBase + 0x04a [[comment("+0x4a same, Guard+2 (0x29)")]];
    u8 gap04B[1] @ weaponConstantsBase + 0x04b [[comment("+0x4b no direct reader found")]];
    s16 damageGaugeRegenDistraction @ weaponConstantsBase + 0x04c [[comment("+0x4c player_entity_tick_hp_regen: gauge gain per tick with Distraction (0x130)")]];
    s16 damageGaugeRegenBase @ weaponConstantsBase + 0x04e [[comment("+0x4e same, with no Focus / Distraction")]];
    s16 damageGaugeRegenFocusPlus1 @ weaponConstantsBase + 0x050 [[comment("+0x50 same, Focus+1 (0x12F)")]];
    s16 damageGaugeRegenFocusPlus2 @ weaponConstantsBase + 0x052 [[comment("+0x52 same, Focus+2 (0x12E)")]];
    float nearbyPlayerActionOffset @ weaponConstantsBase + 0x054 [[comment("+0x54 FUN_10914680: point this far ahead of another player in action 0x6B-0x6F (category 2, FUN_10A06C70)")]];
    float nearbyPlayerActionRadius @ weaponConstantsBase + 0x058 [[comment("+0x58 same: that player counts when within this distance")]];
    float techTier4MotionSpeed @ weaponConstantsBase + 0x0a8 [[comment("+0xa8 every weapon (341 readers): motion speed (pw +0xC24) x it when weapon_tech_get_tier(class) == 4")]];
    float statusBit4000HitMult @ weaponConstantsBase + 0x0f4 [[comment("+0xf4 FUN_108C16A0 (on_hit_effects_dispatch): returns it when SkillWork +0x714 bit 0x4000 is set, else 1.0")]];
    float statusAttackUpMult @ weaponConstantsBase + 0x0f8 [[comment("+0xf8 player_status_attack_multiplier: status x it with Status Attack Up (0x47)")]];
    u16 style3HitCounterMax @ weaponConstantsBase + 0x0fe [[comment("+0xfe weapon style 3 (pw +0xD42): SkillWork +0x1C0 gains 1 per hit up to it (FUN_102E0EE0, on_hit_effects_dispatch); FUN_102D7AC0 (Hunting Horn) needs it full; the sharpness HUD tints toward style3HudTint until then (FUN_1095C990)")]];
    u8 style3HudTintR @ weaponConstantsBase + 0x100 [[comment("+0x100 FUN_1095C8C0: tint red")]];
    u8 style3HudTintG @ weaponConstantsBase + 0x101 [[comment("+0x101 tint green")]];
    u8 style3HudTintB @ weaponConstantsBase + 0x102 [[comment("+0x102 tint blue")]];
    u8 gap103[1] @ weaponConstantsBase + 0x103 [[comment("+0x103 no direct reader found")]];
    u16 style3HudPulseFrames @ weaponConstantsBase + 0x104 [[comment("+0x104 FUN_1095C990: once the counter is full the HUD pulses with this period")]];
    u8 gap106[2] @ weaponConstantsBase + 0x106 [[comment("+0x106 no direct reader found")]];
    s16 hitValueAddNoElement @ weaponConstantsBase + 0x124 [[comment("+0x124 weapon_action_update_frame: added to the hit value +0x6C when the hit has no element; see hitValueAddEffect23")]];
    s16 hitValueAddEffect23 @ weaponConstantsBase + 0x126 [[comment("+0x126 same, when hit +0x84 is 0x23")]];
};

CommonWeaponConstants commonWeaponConstants @ header.ptrs.weaponConstants [[name("Common Weapon Constants")]];

struct LanceConstants {
    u8 gap05C[6] @ weaponConstantsBase + 0x05c [[comment("+0x5c no direct reader found")]];
    u16 lanceExHeal @ weaponConstantsBase + 0x062 [[comment("+0x62 lance_ex_event_handler events 2 / 3: HP healed (item_apply_recovery_amount_to_hp)")]];
    u16 lanceExDashJuiceFrames @ weaponConstantsBase + 0x064 [[comment("+0x64 lance_ex_event_handler event 2: the Dash Juice timer is raised to at least this")]];
    s16 lanceExBuffAttack @ weaponConstantsBase + 0x066 [[comment("+0x66 player_recalc_attack_power_full: attack added to a Lance while the event 3 buff (render slot +0x202) lasts")]];
    s16 lanceExBuffFrames @ weaponConstantsBase + 0x068 [[comment("+0x68 lance_ex_event_handler event 3: buff timer (render slot +0x202); player_entity_update_tick plays its effect every 48 frames")]];
    u8 gap06A[2] @ weaponConstantsBase + 0x06a [[comment("+0x6a no direct reader found")]];
    EvadeDistanceF lanceExEvadeDistance @ weaponConstantsBase + 0x06c [[comment("+0x6c FUN_102A3690 (lance_act_dispatch_extreme)")]];
};

LanceConstants lanceConstants @ header.ptrs.weaponConstants [[name("Lance Constants")]];

struct SnsConstants {
    EvadeDistanceF snsExEvadeDistance[2] @ weaponConstantsBase + 0x078 [[comment("+0x78 FUN_102ABD10 (sns_act_dispatch_extreme), two moves")]];
};

SnsConstants snsConstants @ header.ptrs.weaponConstants [[name("Sword and Shield Constants")]];

struct DualBladesConstants {
    u16 dsMotionSharpnessGain0 @ weaponConstantsBase + 0x0a4 [[comment("+0xa4 ds_indexed_motion_act (param 0): sharpness_consumtion_handler(+it, 1), then the level +0xB28 rises (max 4)")]];
    u16 dsMotionSharpnessGain1 @ weaponConstantsBase + 0x0a6 [[comment("+0xa6 same, param != 0")]];
    u32 dsSpecialColor @ weaponConstantsBase + 0x0ac [[comment("+0xac FUN_1140DB90: colour (ARGB 0x64FFB430) used while ds_special_bit21_active (Dual Blades, pw +0xC4C > 1, SkillWork +0x714 bit 21); otherwise 0x33FF6414 / 0x33FF3333")]];
    u8 dsSpecialColorBytes[4] @ weaponConstantsBase + 0x0b0 [[comment("+0xb0 FUN_11412E60: colour bytes used under the same ds_special_bit21_active condition")]];
    u16 dsGaugeMax @ weaponConstantsBase + 0x0b4 [[comment("+0xb4 Dual Blades gauge SkillWork +0x1C6 max: FUN_102BBB90 (on_hit_effects_dispatch, player_entity_tick_hp_regen) fills it when class 6 and pw +0xC4C > 1; FUN_102BBC20 = full")]];
    u16 dsGaugeRegenPerTick @ weaponConstantsBase + 0x0b6 [[comment("+0xb6 player_entity_tick_hp_regen: Dual Blades gauge (SkillWork +0x1C6) gain per tick (FUN_102BBB90)")]];
    u16 dsGaugeGainPerHit @ weaponConstantsBase + 0x0b8 [[comment("+0xb8 on_hit_effects_dispatch: Dual Blades gauge gain per hit when the monster prmsys unk32 bit 0 is set and hit +0x2 == 0")]];
    u8 dsLifestealCapBase @ weaponConstantsBase + 0x0ba [[comment("+0xba player_lifesteal_on_hit: heal cap = dsLifestealCapPerTier x vampirism tier + it when player_weapon6_special_mode > 1 (0 when the hit flags +0x15C have 0x4000)")]];
    u8 dsLifestealCapPerTier @ weaponConstantsBase + 0x0bb [[comment("+0xbb same")]];
    s8 dsTech4HitStamina @ weaponConstantsBase + 0x0bc [[comment("+0xbc FUN_111D6840 (melee hit shell, state 3): with weapon_tech_get_tier(6) == 4 and player_weapon6_special_mode != 0, a monster hit gives stamina +it (player_apply_stamina_delta_with_skills)")]];
    s8 dsStaminaTickNum @ weaponConstantsBase + 0x0bd [[comment("+0xbd FUN_109BEE50 (from FUN_109BEEF0, FUN_10332250): per-frame stamina change for Dual Blades = it / dsStaminaTickDiv (other weapons -1)")]];
    s8 dsStaminaTickDiv @ weaponConstantsBase + 0x0be [[comment("+0xbe same")]];
    u8 gap0BF[1] @ weaponConstantsBase + 0x0bf [[comment("+0xbf no direct reader found")]];
    u16 dsExCounterStart @ weaponConstantsBase + 0x0c0 [[comment("+0xc0 FUN_102B4E90 (dualblades_act_dispatch_extreme): value written to SkillWork +0x1C4")]];
    u8 gap0C2[2] @ weaponConstantsBase + 0x0c2 [[comment("+0xc2 no direct reader found")]];
    float dsExHopSpeed @ weaponConstantsBase + 0x0c4 [[comment("+0xc4 same action: horizontal speed (+0x470)")]];
    float dsExHopGravity @ weaponConstantsBase + 0x0c8 [[comment("+0xc8 same action: vertical acceleration (+0x460)")]];
    float dsExHop2SpeedX @ weaponConstantsBase + 0x0cc [[comment("+0xcc FUN_102B5DF0 (dualblades_act_dispatch_extreme): speed +0x470")]];
    float dsExHop2SpeedZ @ weaponConstantsBase + 0x0d0 [[comment("+0xd0 same: speed +0x46C")]];
    float dsExHop2Gravity @ weaponConstantsBase + 0x0d4 [[comment("+0xd4 same: vertical acceleration (+0x460)")]];
    EvadeDistanceF dsExEvadeDistance[2] @ weaponConstantsBase + 0x0d8 [[comment("+0xd8 FUN_102B65E0 (dualblades_act_dispatch_extreme), two moves")]];
};

DualBladesConstants dualBladesConstants @ header.ptrs.weaponConstants [[name("Dual Blades Constants")]];

struct LongSwordConstants {
    u16 lsSpiritFullBuffFrames @ weaponConstantsBase + 0x0f0 [[comment("+0xf0 FUN_10A9D6A0 (ls_act_dispatch_style012): when the gauge pw +0xA12 reaches 100, an attack buff (+10, +40 with the Long Sword Active Feature, effect 2) lasts this many frames (pw +0x720)")]];
    u8 gap0F2[2] @ weaponConstantsBase + 0x0f2 [[comment("+0xf2 no direct reader found")]];
};

LongSwordConstants longSwordConstants @ header.ptrs.weaponConstants [[name("Long Sword Constants")]];

struct HuntingHornConstants {
    s16 hhExSharpnessChange @ weaponConstantsBase + 0x0fc [[comment("+0xfc Hunting Horn: sharpness_consumtion_handler(it) in hh_ex_event_handler and FUN_102CF0B0 (-10 = 10 sharpness spent)")]];
};

HuntingHornConstants huntingHornConstants @ header.ptrs.weaponConstants [[name("Hunting Horn Constants")]];

struct GunlanceConstants {
    float glEvadeStepSpeed @ weaponConstantsBase + 0x108 [[comment("+0x108 Player_Dodge_EvadeStep_Update: Gunlance (class 9) step speed, negated (backward)")]];
    u16 glQuickReloadTimerFrames @ weaponConstantsBase + 0x10c [[comment("+0x10c FUN_102E44B0 (= Wii U we09_atk_quick_reload): after the quick reload motion pw +0xDFE is set to it; gl_ex_event_handler event 0xE sets pl_skillTimer12E to it")]];
    s16 glShellDamageRateOther @ weaponConstantsBase + 0x10e [[comment("+0x10e getShell38DamegeRate: damage rate x 0.001 for the shell actions other than 4 / 5 / 6 (Wii U +0x6)")]];
    s16 glComboStepInputFrames @ weaponConstantsBase + 0x110 [[comment("+0x110 gl_combo_step_act / FUN_102E2F80: the step ends (action flag 0x8000 cleared) after this many frames")]];
    s16 glDragonCannonCooldown @ weaponConstantsBase + 0x112 [[comment("+0x112 dragon cannon cooldown (pw +0xB24, scaled by FUN_102E23A0 with the shelling timer rates): gl_charged_shot_release_update, gl_ex_event_handler, apply_damage, player_entity_tick_hp_regen (Wii U +0xA, pl +0xACC)")]];
    s16 glSpDragonCannonFirstChargeFrames @ weaponConstantsBase + 0x114 [[comment("+0x114 gl_motion_next_act: frames of the first sp dragon cannon charge (Wii U +0xC)")]];
    s16 glSpDragonCannonChargeFrames @ weaponConstantsBase + 0x116 [[comment("+0x116 gl_motion_next_act: frames per further charge, level +0xB28 up to 8 (Wii U +0xE)")]];
    u16 glHeatBladeFrames @ weaponConstantsBase + 0x118 [[comment("+0x118 gl_ex_event_handler event 0xF: heat blade timer (pl_frenzyTimer) and sharpness refilled (Wii U getHeatBladeTime +0x10); FUN_102E3B40, HUD")]];
    s16 glHeatBladeEndSharpnessCost @ weaponConstantsBase + 0x11a [[comment("+0x11a when the heat blade timer (pl_frenzyTimer) ends (player_entity_tick_hp_regen, apply_damage): sharpness is restored from pw +0xE00, then sharpness_consumtion_handler(-it)")]];
    float glExShotTimerTech4Mult @ weaponConstantsBase + 0x11c [[comment("+0x11c FUN_102E2310 (Extreme shot timer): x it with weapon_tech_get_tier(9) == 4")]];
    float glExShotTimerZenithMult @ weaponConstantsBase + 0x120 [[comment("+0x120 same: x it when skill_is_granted_by_equipped_gear")]];
    EvadeDistanceF glExEvadeDistance[3] @ weaponConstantsBase + 0x128 [[comment("+0x128 FUN_102E94B0 (gl_act_dispatch_extreme) and gl_evade_step_action_update")]];
};

GunlanceConstants gunlanceConstants @ header.ptrs.weaponConstants [[name("Gunlance Constants")]];

struct GunnerConstants {
    float gunnerShot34HitboxEC @ weaponConstantsBase + 0x00c [[comment("+0xc gunner_shot_hitbox_init: written to the shot hitbox +0xEC for shot row 0x34 (shot row 0x20 uses pw +0xD0C instead)")]];
    ShotStageRow gunnerShotStages[6] @ weaponConstantsBase + 0x14c [[comment("+0x14c gunner_advance_shot_distance_stage: per shot type (shell table DAT_11695A90 row +0), thresholds of the shot counter +0x94 that move it to the next stage; -1 ends; Spacing (0x20B) changes the step")]];
    ShotStageRow gunnerShotStagesCharge3[6] @ weaponConstantsBase + 0x1ac [[comment("+0x1ac same table when the charge level +0xB28 is 3")]];
    ShotStageRow gunnerShotStagesSpecial @ weaponConstantsBase + 0x20c [[comment("+0x20c same, shot type 3 with hit +0xC == 5")]];
};

GunnerConstants gunnerConstants @ header.ptrs.weaponConstants [[name("Gunner Shot Constants")]];

struct BowConstants {
    BowChargeRow bowChargeLevels[6] @ weaponConstantsBase + 0x21c [[comment("+0x21c by charge level (pw +0xB28, or the shot +0xD; level 4 counts as 5 when FUN_11263B00): gunner_compute_shot_ballistics_params, shell_k24_i_b (arrow), FUN_11264F80, gunner_compute_shot_damage_and_status")]];
    u8 gap30C[80] @ weaponConstantsBase + 0x30c [[comment("+0x30c no direct reader found")]];
    float bowStatusCoatingMult[4] @ weaponConstantsBase + 0x35c [[comment("+0x35c status of a poison / paralysis / sleep coating hit x it, index = the bow's coating level for that status (bow_coating_level_get: equip +0x28 bits, 3 when +6 bit 2): gunner_compute_shot_damage_and_status, FUN_11267B40, weapon_init_hitbox_damage_from_params")]];
    float bowShotType1ChargeMult[4] @ weaponConstantsBase + 0x36c [[comment("+0x36c gunner_compute_shot_damage_and_status: damage, element and status x it, index = the shot charge level (+0xD), when the shot type (+0x1C) is 1 and pw +0xB28 < 4")]];
    float bowShotType1Level4Mult @ weaponConstantsBase + 0x37c [[comment("+0x37c same at pw +0xB28 == 4 when the shot flags (+0x18) have 0x100")]];
    float gunnerCoatingKind1RawMult[3] @ weaponConstantsBase + 0x380 [[comment("+0x380 gunner_select_ammo_stat_table (shot coating kind +0xC == 1, without Consumption Slayer 0x1F9; with it the mhfdat 0xA8C +0xC table): raw x it; [0] base, [1] / [2] by the weapon class checks (G / Gou / Tower / exotic / Zenith, player_equip_has_gou_sharpness_bonus) in gunner_compute_shot_damage_and_status")]];
    float gunnerCoatingRawMult[3] @ weaponConstantsBase + 0x38c [[comment("+0x38c same for the other coating kinds (with Consumption Slayer: mhfdat 0xA8C +0x10)")]];
    s16 bowArcLaunchSpeedY @ weaponConstantsBase + 0x398 [[comment("+0x398 shell_atk_tbl_1162AFA8_i_b: arc shell upward speed (+0x54); bow_arc_guide_landing_point (guide) apex = (it / bowArcGravity / 2) x it")]];
    s16 bowArcGravity @ weaponConstantsBase + 0x39a [[comment("+0x39a arc shell (i_b) and sub-shots (i_c): vertical acceleration -it (+0x60)")]];
    s16 bowArcFlightFrames @ weaponConstantsBase + 0x39c [[comment("+0x39c i_b: flight frames of the arc shell (work +0x28 / +0x2A); FUN_112E6940 spawns the sub-shots once it has run out")]];
    s16 bowArcHeightOffset @ weaponConstantsBase + 0x39e [[comment("+0x39e i_b: work +0x30, added to the height over the flight (FUN_112E6940)")]];
    s16 bowArcSubShotLifeFrames @ weaponConstantsBase + 0x3a0 [[comment("+0x3a0 bow_arc_subshot_falloff_update / FUN_112E7B00: a sub-shot ends (+0x6A = 0, state 2) after this many frames (+0x94)")]];
    s16 bowArcSubShotFalloffStart @ weaponConstantsBase + 0x3a2 [[comment("+0x3a2 bow_arc_subshot_falloff_update: past this age (work +0x18) the sub-shot hit value, damage and hit +0x89 shrink linearly")]];
    s16 bowArcSubShotFalloffEnd @ weaponConstantsBase + 0x3a4 [[comment("+0x3a4 same: they reach 1 at this age")]];
    BowHitParamRow bowArcSubShotHitRows[4] @ weaponConstantsBase + 0x3a6 [[comment("+0x3a6 shell_atk_tbl_1162AFA8_i_c -> weapon_init_hitbox_damage_from_params, coating kind (+8) other than 5 / 7: by sub-shot row 2 / 3 / 4 / 6")]];
    BowHitParamRow bowArcSubShotHitRowsKind5[4] @ weaponConstantsBase + 0x3d6 [[comment("+0x3d6 same, coating kind 5")]];
    BowHitParamRow bowArcSubShotHitRowsKind7[4] @ weaponConstantsBase + 0x406 [[comment("+0x406 same, coating kind 7")]];
    BowHitParamRow bowArcShotHitRow @ weaponConstantsBase + 0x436 [[comment("+0x436 shell_atk_tbl_1162AFA8_i_b (the arc shell), coating kind other than 5 / 7")]];
    BowHitParamRow bowArcShotHitRowKind5 @ weaponConstantsBase + 0x442 [[comment("+0x442 same, coating kind 5")]];
    BowHitParamRow bowArcShotHitRowKind7 @ weaponConstantsBase + 0x44e [[comment("+0x44e same, coating kind 7")]];
    u8 gap45A[38] @ weaponConstantsBase + 0x45a [[comment("+0x45a no direct reader found")]];
    FloatTriple hitboxCoatingKind1RawMult @ weaponConstantsBase + 0x480 [[comment("+0x480 weapon_init_hitbox_damage_from_params (shell +8 == 1, without Consumption Slayer; with it mhfdat 0xA8C +0x14): hit value x it; [0] base, [1] / [2] by the weapon class checks")]];
    FloatTriple hitboxCoatingRawMult @ weaponConstantsBase + 0x48c [[comment("+0x48c same for the other coating kinds (with Consumption Slayer: 0xA8C +0x18)")]];
    u16 bowArcType0ShotCount @ weaponConstantsBase + 0x498 [[comment("+0x498 i_b arc type 0: number of sub-shots (max 8)")]];
    s16 bowArcType0Radius[4] @ weaponConstantsBase + 0x49a [[comment("+0x49a arc type 0 (sub-shot row 2), by deviation level: bow_arc_guide_init (guide radius), FUN_112E6940 (spread = it - bowArcType0InnerRadius)")]];
    s16 bowArcType0InnerRadius[4] @ weaponConstantsBase + 0x4a2 [[comment("+0x4a2 same: i_c sub-shot +0x280, FUN_112E6940")]];
    s16 bowArcType0ShotInterval @ weaponConstantsBase + 0x4aa [[comment("+0x4aa i_b: sub-shot i waits i x it frames + random % bowArcType0ShotJitter")]];
    s16 bowArcType0ShotJitter @ weaponConstantsBase + 0x4ac [[comment("+0x4ac same: random part")]];
    s16 bowArcType0DistanceMin @ weaponConstantsBase + 0x4ae [[comment("+0x4ae i_b / bow_arc_guide_landing_point: landing distance, lerped to bowArcType0DistanceMax by pw +0xB71 + 100")]];
    s16 bowArcType0DistanceMax @ weaponConstantsBase + 0x4b0 [[comment("+0x4b0 same")]];
    u8 gap4B2[4] @ weaponConstantsBase + 0x4b2 [[comment("+0x4b2 no direct reader found")]];
    u16 bowArcType1ShotCount @ weaponConstantsBase + 0x4b6 [[comment("+0x4b6 i_b arc type 1: number of sub-shots (max 8)")]];
    s16 bowArcType1Radius[4] @ weaponConstantsBase + 0x4b8 [[comment("+0x4b8 arc type 1 (sub-shot row 3), by deviation level: bow_arc_guide_init, FUN_112E6940")]];
    s16 bowArcType1InnerRadius[4] @ weaponConstantsBase + 0x4c0 [[comment("+0x4c0 same: i_c +0x280, FUN_112E6940")]];
    s16 bowArcType1ShotInterval @ weaponConstantsBase + 0x4c8 [[comment("+0x4c8 i_b: frames between sub-shots")]];
    s16 bowArcType1ShotJitter @ weaponConstantsBase + 0x4ca [[comment("+0x4ca same: random part")]];
    s16 bowArcType1DistanceMin @ weaponConstantsBase + 0x4cc [[comment("+0x4cc landing distance min (lerp by pw +0xB71)")]];
    s16 bowArcType1DistanceMax @ weaponConstantsBase + 0x4ce [[comment("+0x4ce landing distance max")]];
    u8 gap4D0[4] @ weaponConstantsBase + 0x4d0 [[comment("+0x4d0 no direct reader found")]];
    s16 bowArcType2Radius @ weaponConstantsBase + 0x4d4 [[comment("+0x4d4 arc type 2 (one sub-shot, row 4): bow_arc_guide_init guide radius")]];
    s16 bowArcType2DistanceMin @ weaponConstantsBase + 0x4d6 [[comment("+0x4d6 landing distance min (lerp by pw +0xB71)")]];
    s16 bowArcType2DistanceMax @ weaponConstantsBase + 0x4d8 [[comment("+0x4d8 landing distance max")]];
    u16 bowArcType3ShotCount @ weaponConstantsBase + 0x4da [[comment("+0x4da i_b arc type 3: number of sub-shots (max 8); bow_arc_guide_init width = spacing x (it - 1) / 2")]];
    s16 bowArcType3InnerRadius[4] @ weaponConstantsBase + 0x4dc [[comment("+0x4dc arc type 3 (sub-shot row 6), by deviation level: i_c +0x280, FUN_112E6940")]];
    s16 bowArcType3Spacing[4] @ weaponConstantsBase + 0x4e4 [[comment("+0x4e4 same: distance between sub-shots (FUN_112E6940, bow_arc_guide_init)")]];
    s16 bowArcType3Radius[4] @ weaponConstantsBase + 0x4ec [[comment("+0x4ec same: bow_arc_guide_init guide radius, FUN_112E6940")]];
    s16 bowArcType3ShotInterval @ weaponConstantsBase + 0x4f4 [[comment("+0x4f4 i_b: frames between sub-shots")]];
    s16 bowArcType3ShotJitter @ weaponConstantsBase + 0x4f6 [[comment("+0x4f6 same: random part")]];
    s16 bowArcType3DistanceMin @ weaponConstantsBase + 0x4f8 [[comment("+0x4f8 landing distance min (lerp by pw +0xB71)")]];
    s16 bowArcType3DistanceMax @ weaponConstantsBase + 0x4fa [[comment("+0x4fa landing distance max")]];
    u8 gap4FC[4] @ weaponConstantsBase + 0x4fc [[comment("+0x4fc no direct reader found")]];
    BowGuideColorPair bowGuideColors[8] @ weaponConstantsBase + 0x500 [[comment("+0x500 {from, to} colours lerped by FUN_10930C40: row 0 in FUN_114643E0, row 0 or EBX in FUN_11461C20, row 3 from in FUN_11463C90")]];
    u8 bowArcGuideBandAlpha[4] @ weaponConstantsBase + 0x540 [[comment("+0x540 bow_arc_guide_draw (arc guide draw): alpha of the 3 bands, band i from [i] to [i + 1]")]];
    u32 bowArcGuidePulseColorB @ weaponConstantsBase + 0x544 [[comment("+0x544 bow_arc_guide_draw: guide colour, lerped (FUN_10930C40) from bowArcGuidePulseColorA by a sine of work +0x10")]];
    u32 bowArcGuidePulseColorA @ weaponConstantsBase + 0x548 [[comment("+0x548 same")]];
    BowArcGuideRow bowArcGuideRows[4] @ weaponConstantsBase + 0x54c [[comment("+0x54c bow_arc_guide_draw / FUN_11461630 (arc guide), by arc type (work +0x1C)")]];
};

BowConstants bowConstants @ header.ptrs.weaponConstants [[name("Bow Constants")]];

struct TonfaConstants {
    s16 tonfaStyle0GaugeFrames @ weaponConstantsBase + 0x57c [[comment("+0x57c FUN_11325F30 (style 0 gauge gain): the gauge lasts this many frames at level 0 (SkillWork +0x1F0 / +0x1F4, <<12; FUN_113266D0 counts it down and empties the gauge +0x1F8 at 0), lerped to tonfaStyle0GaugeFramesMaxLevel")]];
    s16 tonfaStyle0GaugeFramesMaxLevel @ weaponConstantsBase + 0x57e [[comment("+0x57e same, at the max level")]];
    s16 tonfaStyle0GaugeFirstLevel @ weaponConstantsBase + 0x580 [[comment("+0x580 style 0 gauge (SkillWork +0x1F8) level = (gauge - it) / tonfaStyle0GaugeLevelSize + 1 (FUN_11325F30, FUN_11325710, FUN_113266D0, HUD FUN_11343320); max = (max level - 1) x size + it (FUN_113347D0)")]];
    s16 tonfaStyle0GaugeLevelSize @ weaponConstantsBase + 0x582 [[comment("+0x582 same: gauge per level; tonfa_gauge_has_levels / tonfa_gauge_spend_levels (level checks / costs) use it for style 0")]];
    s16 tonfaStyle0GaugeMaxLevel @ weaponConstantsBase + 0x584 [[comment("+0x584 tonfa_gauge_max_level: style 0 max level")]];
    s16 tonfaStyle0GaugeMaxLevelTech4 @ weaponConstantsBase + 0x586 [[comment("+0x586 same with weapon_tech_get_tier(0xB) >= 4")]];
    s16 tonfaStyle1HitValueRate @ weaponConstantsBase + 0x588 [[comment("+0x588 tonfa_style_hit_value_scale (kind 100 shell init FUN_11204580, shell_k101_i_b): style 1 hit value (+0x6C) x it")]];
    s16 tonfaEvent11LevelCost @ weaponConstantsBase + 0x58a [[comment("+0x58a tonfa_event_handler event 0x11: gauge levels spent (tonfa_gauge_spend_levels); FUN_11335390 (styles 1 / 3) checks the gauge holds them")]];
    s16 tonfaGaugeLevelSize @ weaponConstantsBase + 0x58c [[comment("+0x58c styles 1 / 3: gauge per level (tonfa_gauge_has_levels, tonfa_gauge_spend_levels, FUN_11335100, FUN_113347D0, HUD FUN_11343970 / FUN_11344B50)")]];
    s16 tonfaGaugeMaxLevel @ weaponConstantsBase + 0x58e [[comment("+0x58e styles 1 / 3: max level (tonfa_gauge_max_level, FUN_11335310, FUN_11326930)")]];
    s16 tonfaGaugeMaxLevelTech4 @ weaponConstantsBase + 0x590 [[comment("+0x590 same with weapon_tech_get_tier(0xB) >= 4 (FUN_11335290)")]];
    s16 tonfaStyle1Tech4GainRate @ weaponConstantsBase + 0x592 [[comment("+0x592 FUN_11325A10: style 1 main gauge gain x it with weapon_tech_get_tier(0xB) >= 4")]];
    s16 tonfaStyle1GainRate @ weaponConstantsBase + 0x594 [[comment("+0x594 FUN_11325A10 (from tonfa_gauge_gain_dispatch, param_2 = 0: on_hit_effects_dispatch hits): style 1 gauge gain = it x the hit gain")]];
    s16 tonfaStyle1GainRateParam2 @ weaponConstantsBase + 0x596 [[comment("+0x596 same when param_2 != 0")]];
    s16 tonfaStyle1SubGaugeLevelSize @ weaponConstantsBase + 0x598 [[comment("+0x598 style 1 sub-gauge per level (FUN_11335100, FUN_11335250, FUN_11326930, FUN_11326DF0, HUD FUN_11343970 / FUN_11344B50)")]];
    s16 tonfaStyle1SubGaugeMaxLevel @ weaponConstantsBase + 0x59a [[comment("+0x59a FUN_11335310: style 1 sub-gauge max level")]];
    s16 tonfaStyle1SubGaugeMaxLevelTech4 @ weaponConstantsBase + 0x59c [[comment("+0x59c FUN_11335290: same with weapon_tech_get_tier(0xB) >= 4")]];
    u8 gap59E[2] @ weaponConstantsBase + 0x59e [[comment("+0x59e no direct reader found")]];
    s16 tonfaStyle1SubGaugeFrames @ weaponConstantsBase + 0x5a0 [[comment("+0x5a0 FUN_11325A10: the sub-gauge lasts this many frames at level 0 (SkillWork +0x1FC / +0x200, <<12; FUN_11326930 counts it down and empties it at 0), lerped to tonfaStyle1SubGaugeFramesMaxLevel")]];
    s16 tonfaStyle1SubGaugeFramesMaxLevel @ weaponConstantsBase + 0x5a2 [[comment("+0x5a2 same, at the max level")]];
    s16 tonfaStyle1BoostHitValueAdd @ weaponConstantsBase + 0x5a4 [[comment("+0x5a4 tonfa_style_hit_value_scale: added to tonfaStyle1HitValueRate while the style state timer +0x14 (tonfaBoostFrames) runs")]];
    s16 tonfaBoostFrames @ weaponConstantsBase + 0x5a6 [[comment("+0x5a6 tonfa_boost_set (from FUN_11336E00, FUN_1137F2E0): style 1 / 3 state +0x14 timer; tonfa_boost_is_active = timer > 0")]];
    u8 gap5A8[4] @ weaponConstantsBase + 0x5a8 [[comment("+0x5a8 no direct reader found")]];
    u32 tonfaStyle1HudColor @ weaponConstantsBase + 0x5ac [[comment("+0x5ac FUN_11343970 (style 1 gauge HUD): colour of one quad (ARGB 0xFF89DFEC)")]];
    s16 tonfaStyle2HitValueRate @ weaponConstantsBase + 0x5b0 [[comment("+0x5b0 tonfa_style_hit_value_scale: style 2 hit value (+0x6C) x it")]];
    s16 tonfaStyle2GainRate @ weaponConstantsBase + 0x5b2 [[comment("+0x5b2 FUN_11325C00: style 2 gauge gain = it x the hit gain (param_2 = 0)")]];
    s16 tonfaStyle2GainRateParam2 @ weaponConstantsBase + 0x5b4 [[comment("+0x5b4 same when param_2 != 0")]];
    u8 gap5B6[2] @ weaponConstantsBase + 0x5b6 [[comment("+0x5b6 no direct reader found")]];
    s16 tonfaStyle23LevelCheck @ weaponConstantsBase + 0x5b8 [[comment("+0x5b8 FUN_11335BF0: styles 2 / 3 need this many gauge levels (tonfa_gauge_has_levels)")]];
    s16 tonfaTargetHitTier1 @ weaponConstantsBase + 0x5ba [[comment("+0x5ba styles 2 / 3 per-target hit count (style state +0x8 / +0x1A, tonfa_target_hit_count_add adds 1 per shell hit): FUN_11336540 needs >= it; HUD FUN_11344B50 tier 1")]];
    s16 tonfaActionGaugeCost @ weaponConstantsBase + 0x5bc [[comment("+0x5bc gauge spent (tonfa_gauge_spend) at the start of actions 0x39 / 0x89 / 0x8A (FUN_11340DB0) and 0x7B-0x7E (FUN_113414F0)")]];
    s16 tonfaActionLevelCost @ weaponConstantsBase + 0x5be [[comment("+0x5be gauge levels spent (tonfa_gauge_spend_levels) by actions 0x5B-0x5D / 0x8C (FUN_11341D90) and FUN_11337CD0")]];
    s16 tonfaTargetHitTier2 @ weaponConstantsBase + 0x5c0 [[comment("+0x5c0 per-target hit count tier: FUN_112068D0 picks effect 9 below it, 7 from it; HUD FUN_11344B50")]];
    s16 tonfaTargetHitTier3 @ weaponConstantsBase + 0x5c2 [[comment("+0x5c2 FUN_112068D0: from it, effect 2 and FUN_11206630; FUN_11326C20 / FUN_11326DF0 animate the HUD (FUN_113366E0 >= it); FUN_11344210 / FUN_11344B50")]];
    s16 tonfaTargetHitFxTier1 @ weaponConstantsBase + 0x5c4 [[comment("+0x5c4 tonfa_target_hit_fx_tier (from FUN_11336A10, FUN_11204380): count > it = tier 1")]];
    s16 tonfaTargetHitFxTier2 @ weaponConstantsBase + 0x5c6 [[comment("+0x5c6 same, tier 2")]];
    s16 tonfaTargetHitFxTier3 @ weaponConstantsBase + 0x5c8 [[comment("+0x5c8 same, tier 3")]];
    s16 tonfaStyle2GaugeLevelSize @ weaponConstantsBase + 0x5ca [[comment("+0x5ca style 2 gauge per level (FUN_11325C00, tonfa_gauge_has_levels, tonfa_gauge_spend_levels, FUN_113347D0, FUN_11326C20, HUD FUN_11344210)")]];
    s16 tonfaStyle2GaugeMaxLevel @ weaponConstantsBase + 0x5cc [[comment("+0x5cc tonfa_gauge_max_level: style 2 max level")]];
    s16 tonfaStyle2GaugeMaxLevelTech4 @ weaponConstantsBase + 0x5ce [[comment("+0x5ce same with weapon_tech_get_tier(0xB) >= 4")]];
    s16 tonfaStyle2Tech4GainRate @ weaponConstantsBase + 0x5d0 [[comment("+0x5d0 FUN_11325C00: style 2 gauge gain x it with weapon_tech_get_tier(0xB) >= 4")]];
    u8 gap5D2[2] @ weaponConstantsBase + 0x5d2 [[comment("+0x5d2 no direct reader found")]];
    float tonfaHomingForwardStep @ weaponConstantsBase + 0x5d4 [[comment("+0x5d4 FUN_113414F0 (actions 0x7B-0x7E) -> player_turn_and_step_toward_target: forward move per frame while it turns toward the target")]];
    s16 tonfaHomingYawStep @ weaponConstantsBase + 0x5d8 [[comment("+0x5d8 same: max yaw step per frame (65536 = 360 degrees; 384 = 2.1 degrees)")]];
    u8 gap5DA[2] @ weaponConstantsBase + 0x5da [[comment("+0x5da no direct reader found")]];
    u32 tonfaStyle2HudColor @ weaponConstantsBase + 0x5dc [[comment("+0x5dc FUN_11344210 (style 2 gauge HUD): colour of one quad (ARGB 0xFF89DFEC)")]];
    s16 tonfaStyle3GainRate @ weaponConstantsBase + 0x5e0 [[comment("+0x5e0 FUN_11325D70: style 3 sub-gauge gain = it x the hit gain (param_2 = 0)")]];
    s16 tonfaStyle3GainRateParam2 @ weaponConstantsBase + 0x5e2 [[comment("+0x5e2 same when param_2 != 0")]];
    u8 gap5E4[4] @ weaponConstantsBase + 0x5e4 [[comment("+0x5e4 no direct reader found")]];
    s16 tonfaStyle3SubGaugeFrames @ weaponConstantsBase + 0x5e8 [[comment("+0x5e8 FUN_11325D70: sub-gauge duration at level 0 (style 3 state +0xC / +0x10, <<12), lerped to tonfaStyle3SubGaugeFramesMaxLevel")]];
    s16 tonfaStyle3SubGaugeFramesMaxLevel @ weaponConstantsBase + 0x5ea [[comment("+0x5ea same, at the max level")]];
    s16 tonfaStyle3BoostHitValueAdd @ weaponConstantsBase + 0x5ec [[comment("+0x5ec tonfa_style_hit_value_scale: style 3 hit value x (1000 + it) while tonfaBoostFrames runs")]];
    u8 tonfaAirStallCount @ weaponConstantsBase + 0x5ee [[comment("+0x5ee copied to SkillWork +0x1DC by the jumps (FUN_1133BDC0, FUN_1133C730, player_update_ground_jump_motion) and player_position_sink_anchor_init; player_update_extra_jump_motion (actions 0x34-0x36) stops the fall while it is > 0 and spends one")]];
    u8 tonfaAirStall2Count @ weaponConstantsBase + 0x5ef [[comment("+0x5ef same for SkillWork +0x1DD, spent by FUN_113420E0 (actions 0x8F / 0x90)")]];
    s16 tonfaAirCeilingHeight @ weaponConstantsBase + 0x5f0 [[comment("+0x5f0 player_position_sink_anchor_init: ceiling (SkillWork +0x1D0) = take-off Y + it; tonfa_air_ceiling_update keeps the airborne player under it")]];
    s16 tonfaAirCeilingDropDistance @ weaponConstantsBase + 0x5f2 [[comment("+0x5f2 tonfa_air_ceiling_update: the ceiling starts to fall once the player is farther than it from the take-off point (and higher than tonfaAirCeilingDropHeight)")]];
    s16 tonfaAirCeilingDropHeight @ weaponConstantsBase + 0x5f4 [[comment("+0x5f4 same: height above the ground (refPosY)")]];
    u16 tonfaExtraJumpLiftFrames @ weaponConstantsBase + 0x5f6 [[comment("+0x5f6 player_update_extra_jump_motion: when the entity at pw +0x848 has mhfemd prmsys unk32 bit 1 (player_jump_target_prmsys_bit1), upward speed = it x gravity")]];
    u16 tonfaRunningJumpLiftFrames @ weaponConstantsBase + 0x5f8 [[comment("+0x5f8 same, player_update_running_jump_motion (action 0x22)")]];
    u16 tonfaGroundJumpLiftFrames @ weaponConstantsBase + 0x5fa [[comment("+0x5fa same, player_update_ground_jump_motion (actions 0x95-0x98)")]];
    s16 tonfaExtraJumpLiftKickboxingKing @ weaponConstantsBase + 0x5fc [[comment("+0x5fc added to tonfaExtraJumpLiftFrames with Kickboxing King (0x167)")]];
    s16 tonfaRunningJumpLiftKickboxingKing @ weaponConstantsBase + 0x5fe [[comment("+0x5fe added to tonfaRunningJumpLiftFrames with Kickboxing King")]];
    s16 tonfaGroundJumpLiftKickboxingKing @ weaponConstantsBase + 0x600 [[comment("+0x600 added to tonfaGroundJumpLiftFrames with Kickboxing King")]];
    s16 tonfaShellPartDamageRate @ weaponConstantsBase + 0x602 [[comment("+0x602 on_hit_effects_dispatch: part damage x it when the hit is a kind 100 shell (FUN_112054D0)")]];
    s16 tonfaMode0GaugeGainRate @ weaponConstantsBase + 0x604 [[comment("+0x604 on_hit_effects_dispatch: Tonfa hit gauge gain x it when pw +0xB28 % 3 == 0 (the mode set by tonfa_event_handler event 0x12)")]];
    u8 tonfaMode2HitElementAdd @ weaponConstantsBase + 0x606 [[comment("+0x606 FUN_11204580 (kind 100 shell init): hit +0x89 += it when pw +0xB28 % 3 == 2")]];
    u8 tonfaCameraShakeAlt @ weaponConstantsBase + 0x607 [[comment("+0x607 camera_shake_request kind: tonfa_event_handler event 0x15 with param bit 0, FUN_113379D0")]];
    u8 tonfaCameraShake @ weaponConstantsBase + 0x608 [[comment("+0x608 camera_shake_request kind: event 0x15 otherwise, FUN_1133A4F0, FUN_1133A540, FUN_112068D0")]];
    u8 gap609[1] @ weaponConstantsBase + 0x609 [[comment("+0x609 no direct reader found")]];
    s16 tonfaNoGaugeCostFrames[3] @ weaponConstantsBase + 0x60a [[comment("+0x60a tonfa_status_hit_no_cost_frames_add (Monster_Status_ApplyHitEffect, by level up to 2): added to SkillWork +0x1E2 of every Tonfa player in the stage; while it is not 0, tonfa_gauge_spend spends no gauge")]];
    EvadeDistanceF tonfaEvadeDistance[3] @ weaponConstantsBase + 0x610 [[comment("+0x610 FUN_1133C730 (tonfa actions 0x91-0x94): [0] action 0x91, [1] 0x94, [2] 0x92 / 0x93")]];
    EvadeDistanceF tonfaJumpEvadeDistance[3] @ weaponConstantsBase + 0x634 [[comment("+0x634 player_update_ground_jump_motion (tonfa actions 0x95-0x98): [0] action 0x95, [1] 0x98, [2] 0x96 / 0x97")]];
    u8 gap658[8] @ weaponConstantsBase + 0x658 [[comment("+0x658 no direct reader found")]];
};

TonfaConstants tonfaConstants @ header.ptrs.weaponConstants [[name("Tonfa Constants")]];

// =======================
// Switch Axe F tunables (header 0xA88, Otya unkA88): twelve u16 counts, then
// fourteen pointers, read by Switch Axe F (weapon class 0xC) code. "Gauge" =
// SkillWork +0x1C0 (SAF work, gSkillWorks + 0x1C0); style = pw +0xD42; style
// 3 has a second gauge at its style state +0xC (FUN_10316DA0). SAF events =
// handler table 0x11926D84 (event n = entry n). Gains go through
// skill_focus_charge_rate (Focus / Distraction) unless noted. Proofs and
// readers: tools/mhfdat_re/data/a88_notes.md.
// =======================

struct SafStyleGauge {
    s16 gaugeMax [[comment("saf_style_gauge_max: gauge cap (saf_gauge_add)")]];
    s16 gaugeThreshold [[comment("saf_style_gauge_threshold: saf_gauge_above_threshold = gauge > it")]];
    s16 passiveGain [[comment("saf_style_passive_gain: gain every passiveGainFrames (saf_passive_gain_tick from player_entity_tick_hp_regen)")]];
    s16 reloadGain [[comment("saf_style_reload_gain: event 15 argument 0 gain (the gauge max instead with the Switch Axe F Active Feature, GetDailyFeatureTable)")]];
    s16 startGauge [[comment("saf_style_start_gauge: gauge at weapon init (saf_weapon_init)")]];
};

struct SafEvadeDistance {
    s16 extraDistance;
    s16 startFrame;
    s16 endFrame;
};

struct SafValues {
    SafStyleGauge styleGauge[3] [[comment("[0]-[14] by weapon style 0 / 1 / 2")]];
    s16 style3GaugeMax [[comment("[15] style 3 gauge cap (saf_style_gauge_max)")]];
    s16 style3PassiveGain [[comment("[16] style 3 passive gain (saf_style_passive_gain)")]];
    s16 style3StartGauge [[comment("[17] style 3 gauge at weapon init (saf_style_start_gauge); style 3 has no threshold or reload gain (0)")]];
    s16 style3Gauge2Max [[comment("[18] style 3 second gauge cap (saf_gauge2_max, saf_gauge2_add, FUN_10315770, saf_weapon_init)")]];
    s16 style3Gauge2PassiveGain [[comment("[19] saf_gauge2_passive_gain: style 3 second gauge passive gain")]];
    s16 style3Gauge2Start [[comment("[20] saf_weapon_init: style 3 second gauge at weapon init for the local player (others start at style3Gauge2Max / 2)")]];
    s16 passiveGainFrames [[comment("[21] saf_passive_gain_tick: frames between two passive gains (timers SAF work +0x1C / +0x1E)")]];
    s16 passiveGainFirstFrames [[comment("[22] saf_weapon_init: both passive gain timers at weapon init")]];
    s16 event14GaugeCost[4] [[comment("[23]-[26] SAF event 14 (saf_ev14_gauge_cost) by argument 0-3 (others: [0]): gauge spent (saf_gauge_spend; style 3 second gauge FUN_10316E10)")]];
    s16 gap36 [[comment("[27] no reader found")]];
    s16 binHitGain [[comment("[28] saf_bin_hit_gauge_gain (switchaxe_bin_projectile_update, phial shot hit on a monster): gauge gain, styles 0-2")]];
    s16 binHitGainStyle3 [[comment("[29] same, style 3")]];
    s16 binHitGauge2GainStyle3 [[comment("[30] same, style 3 second gauge")]];
    s16 event12StaminaCost [[comment("[31] SAF event 12 (saf_ev12_stamina_cost): stamina spent (FUN_10A996A0), halved at weapon_tech_get_tier(0xC) >= 4")]];
    s16 event12BuffTimerDrain [[comment("[32] same event: frames removed from the Dash Juice timer (+0xB74) and SkillWork +0x2B6")]];
    s16 mode2NoBounceSharpnessTier [[comment("[33] saf_hit_landed_update (hit landed, weapon sub-class 1): in switch axe mode 2 the motion is cut (hitstop cleared, action reset) when the sharpness colour tier is below it")]];
    s16 actionCondWork19Limit [[comment("[34] saf_cond_work19_below_limit (SAF weapon action condition): returns 2 while SAF work +0x19 (saf_work19_get) is below it")]];
    s16 guardSharpnessCost [[comment("[35] player_update_weapon_stamina_and_sharpness: sharpness spent by a Switch Axe F guard")]];
    s16 chargeLevel3Frames [[comment("[36] saf_charge_update (actions 0x70 / 0x71): the charge counter pw +0xB24 reaches level 3 at it (Focus applies, weapon_charge_time_apply_focus_multiplier)")]];
    s16 chargeLevel2Frames [[comment("[37] same, level 2 (level 1 from a fraction of it)")]];
    s16 aimYawStep [[comment("[38] saf_aim_toward_target (actions 0x67 / 0x94): max yaw step per frame toward the target (player_turn_and_step_toward_target)")]];
    s16 styles13ElementStatusRate [[comment("[39] saf_styles13_element_status_scale: styles 1 / 3, actions 0x74 / 0x75 / 0x7A / 0x9B-0x9D (FUN_103168C0): the hit status (+0x80) and element (+0x8C) values x it per mille")]];
    s16 counterTier3 [[comment("[40] saf_counter_tier: styles 2 / 3 counter (SAF work +0x38 / +0x3A, saf_counter_ptr) >= it = tier 3 (switchaxe_bin_spawn_fx, FUN_1031FB80)")]];
    s16 counterTier2 [[comment("[41] same, tier 2")]];
    s16 counterTier1 [[comment("[42] same, tier 1")]];
    s16 event15Gain1 [[comment("[43] SAF event 15 (saf_ev15_gauge_gain) argument 1, style 2: gauge gain (saf_gauge_add_by_style)")]];
    s16 event15Gain2 [[comment("[44] same, argument 2, style 2")]];
    s16 event15Gain4 [[comment("[45] same, argument 4, style 3 (second gauge)")]];
    s16 focusPlus2Rate [[comment("[46] skill_focus_charge_rate: gains x it per mille with Focus+2 (0x12E)")]];
    s16 focusPlus1Rate [[comment("[47] same, Focus+1 (0x12F)")]];
    s16 distractionRate [[comment("[48] same, Distraction (0x130)")]];
    SafEvadeDistance evadeDistance[3] [[comment("[49]-[57] saf_evade_extra_distance -> player_evade_extra_distance_in_window: [0] actions 0x24 / 0x25 / 0x77 / 0x78, [1] 0x6B / 0x6C / 0x99 / 0x9A, [2] 0x6A / 0x98")]];
    s16 evasionPlus1Frames [[comment("[58] player_evade_invuln_frames_from_evasion_skill: Evasion+1 (0xB1) or Starving Wolf (0xFB): invulnerability frames added")]];
    s16 evasionPlus2Frames [[comment("[59] same, Evasion+2 (0xB2) or Starving Wolf (0xFC)")]];
    s16 tech4BuffAttackRateStyle0 [[comment("[60] saf_tech4_buff_attack_rate (player_recalc_attack_power_full): attack x it per mille while the tech buff (SAF work +0x20) runs; style 0 and style 3")]];
    s16 tech4BuffFramesStyle0 [[comment("[61] saf_tech4_buff_frames -> saf_tech4_buff_start: buff frames set on a monster hit at weapon_tech_get_tier(0xC) == 4 (FUN_101E6620, FUN_10319D20); style 0 and style 3")]];
    s16 tech4BuffAttackRateStyle1 [[comment("[62] same, style 1")]];
    s16 tech4BuffFramesStyle1 [[comment("[63] same, style 1")]];
    s16 tech4BuffAttackRateStyle2 [[comment("[64] same, style 2")]];
    s16 tech4BuffFramesStyle2 [[comment("[65] same, style 2")]];
    s16 gap84[2] [[comment("[66]-[67] no reader found (style 3 reads [60] / [61])")]];
    s16 tech4BinHitGain [[comment("[68] saf_bin_hit_gauge_gain_tech4: extra gauge per phial shot hit at weapon_tech_get_tier(0xC) == 4, styles 0-2")]];
    s16 tech4BinHitGainStyle3 [[comment("[69] same, style 3")]];
    s16 tech4BinHitGauge2GainStyle3 [[comment("[70] same, style 3 second gauge")]];
    s16 tech4CostRate [[comment("[71] saf_gauge_spend / FUN_10316E10: gauge costs x it per mille at weapon_tech_get_tier >= 4")]];
    s16 cameraShake0 [[comment("[72] camera_shake_request kind: SAF event 17 (saf_ev17_camera_shake) other arguments, saf_hit_landed_update hits of weapon sub-class 0 / 1")]];
    s16 cameraShake1 [[comment("[73] event 17 argument 1, hits of sub-class 2 / 3")]];
    s16 cameraShake2 [[comment("[74] event 17 argument 2")]];
};

struct SafPhialBeatsRow {
    s16 phials[5] [[comment("saf_phial_compare compare(a, b) for ui_draw_switchaxe_phial: -1 when row b lists a, 1 when row a lists b; -1 ends; all empty on ZZ")]];
};

struct SafHudPartTransform {
    u16 part [[comment("saf_hud_view_part_transforms: model part (< 6)")]];
    padding[2];
    float position[3];
    float rotation[3] [[comment("x 2 pi x a constant (Mat4_ApplyEulerRotationXYZ)")]];
    float scale[3];
};

struct SafHudPartTransformSet {
    u32 count;
    SafHudPartTransform *rows[count] : u32;
};

struct SafMotionRow {
    s16 motionId [[comment("sorted key: the motion that starts (pw +0x32C, saf_motion_start_submode from FUN_10A73030)")]];
    u8 submode [[comment("index into 0x11926D30 for player_weapon_submode_value_set (FUN_1032ACE0); 0 = none")]];
    u8 submodeMode2 [[comment("used instead in switch axe mode 2 (SAF work +0x4, FUN_10314000)")]];
    s16 syncFrameOffset [[comment("added to the motion start frame for the sync message (entity_hit_message_queue_push)")]];
    s16 syncFrameCap [[comment("when > 0: written to SAF work +0x14 and caps that frame")]];
};

struct SafHitstopOverride {
    u8 hitstopFrames [[comment("weapon_melee_hitstop_frames_get: replaces weaponDamageCoefficients +0xBC while saf_hitstop_override_active (SAF in switch axe mode 2, or action 8 / 9)")]];
    u8 hitstopReduction [[comment("weapon_melee_hitstop_reduction_get: replaces +0xBD")]];
    u8 hitstopParamBE [[comment("FUN_108BBFD0 (on_hit_effects_dispatch, after the hitstop reduction): replaces +0xBE")]];
    u8 fencingHitSound [[comment("weapon_fencing_bonus_hit_sound_param_get: replaces +0xBF")]];
};

struct SafAiParams {
    s16 rangeCheckMode [[comment("ai_saf_in_attack_range / ai_saf_pick_action (NPC hunter AI, master AI tick FUN_113B9320): 0 = distance to the anchor (resolve_entity_anchor_position), else FUN_113C4A00")]];
    s16 engageDistanceAlt [[comment("ai_weapon_engage_distance (weapon class 0xC): distance returned when FUN_113BB400")]];
    s16 engageDistance [[comment("same, otherwise outside switch axe mode 2")]];
    s16 engageDistanceMode2 [[comment("same, switch axe mode 2")]];
    s16 mode2ApproachDistance [[comment("FUN_1003E3E0: in mode 2, at or past it the AI sets its move flag (+0x60) and heading")]];
    s16 attackRange [[comment("ai_saf_in_attack_range: no attack when the distance is past it (+ a constant)")]];
    s16 attackHeightMax [[comment("ai_saf_in_attack_range: height difference limit; FUN_1003E880: distance limit of the close-range picks")]];
    u16 turnAngleLimit [[comment("FUN_113C5230 case 0xC: true when the target angle (diva_song_target_relative_angle_delta) is past it (0x38E4 = 80 degrees)")]];
    s16 gaugeHighThreshold [[comment("ai_saf_pick_action: flag gauge > it")]];
    s16 gaugeLowThreshold [[comment("ai_saf_pick_action: flag gauge <= it")]];
    s16 gaugeNeeded[2] [[comment("ai_saf_pick_action, AI flag 4: gauge >= it, [1] in switch axe mode 2")]];
    s16 pickNoTargetChance [[comment("FUN_1003E760 (AI target not the player): AI context +0x0 below it picks 0xB, else 7")]];
    s16 pickCloseDistance [[comment("FUN_1003E7A0: distance below it picks 7 or 3 (by pickCloseHeight)")]];
    s16 pickCloseHeight [[comment("same: AI context +0x8 at or past it picks 7")]];
    s16 pickChance4 [[comment("same: AI context +0x0 below it picks 4")]];
    u16 pickAngle [[comment("same: angle past it and distance past pickAngleDistance pick 3")]];
    s16 pickAngleDistance [[comment("same")]];
    s16 pickCountLimit [[comment("FUN_1003E880 actions 8 / 9: AI context +0x10 at or past it picks 2")]];
    s16 pickFarDistance [[comment("FUN_1003E880 actions 0xF / 0x17 / 0x18 / 0x39: distance at or past it picks 0xC, else 2")]];
    s16 cooldownFrames [[comment("FUN_1003E620: after actions 0x30 / 0x31 / 0x3C / 0x3F the AI timer +0xCA is set to it, then counts down")]];
    s16 gap2A [[comment("no reader found")]];
};

struct SwitchAxeFTunables {
    u16 numValues [[comment("75 = the values (no reader; the code indexes fixed offsets)")]];
    u16 numPhialRates [[comment("5 = the phial rates (no reader)")]];
    u16 numNoTurnActions [[comment("saf_stick_turn_update")]];
    u16 numNoStaminaRegenActions [[comment("saf_stamina_regen_tick")]];
    u16 numNoHitCheckActions [[comment("saf_action_skips_hit_check")]];
    u16 numMotionRows [[comment("saf_motion_start_submode")]];
    u16 numNoSyncMotions [[comment("saf_motion_sync_check")]];
    u16 numHitFxAttackRows [[comment("saf_hit_fx_attack_row_listed")]];
    u16 numHitFxShellRows [[comment("saf_hit_fx_shell_row_listed")]];
    u16 numAiParams [[comment("21 = the AI params before the last (no reader)")]];
    u16 numStyle3ModeKeepActions [[comment("saf_action_keeps_mode_flag")]];
    u16 gap16 [[comment("no reader found")]];
    SafValues *values : u32;
    s16 *phialRates[numPhialRates] : u32 [[comment("switchaxe_hit_dispatch_phial_apply / switchaxe_bin_dispatch_phial_apply: per mille by phial (docs/reverse/switch_axe_phials.md)")]];
    SafPhialBeatsRow *phialBeats[5] : u32 [[comment("by phial")]];
    SafHudPartTransformSet *hudViewTransforms[5] : u32 [[comment("saf_hud_view_part_transforms (hud_weapon_view_transform_update): weapon view part transforms by motion bank (get_melee_weapon_motion_type, typeA-E)")]];
    u16 *hitFxAttackRows[numHitFxAttackRows] : u32 [[comment("switchaxe_attack_tag_phial: a kind 106 attack whose attack row (+6) is listed gets hit effect DAT_119330BC (type 7)")]];
    u16 *hitFxShellRows[numHitFxShellRows] : u32 [[comment("same, by shell row (+6): hit effect DAT_119331FC")]];
    u16 *noTurnActions[numNoTurnActions] : u32 [[comment("saf_stick_turn_update: outside these actions the player turns toward the stick by 0x1000 (0x2000 with FUN_1031AFE0, FUN_1031AF10)")]];
    u16 *noStaminaRegenActions[numNoStaminaRegenActions] : u32 [[comment("saf_stamina_regen_tick (player_entity_tick_hp_regen): stamina recovers outside these actions")]];
    u16 *noHitCheckActions[numNoHitCheckActions] : u32 [[comment("saf_act_update: these actions skip saf_hit_landed_update (bounce / hit shake)")]];
    u16 *style3ModeKeepActions[numStyle3ModeKeepActions] : u32 [[comment("saf_action_keeps_mode_flag: style 3 category 1 actions that set SAF flag 0x800 (FUN_10314C50) and weapon submode 1 when hit (apply_damage); style 1 always does")]];
    SafMotionRow *motionRows[numMotionRows] : u32;
    u16 *noSyncMotions[numNoSyncMotions] : u32 [[comment("saf_motion_sync_check (FUN_10314260): motions (pw +0x32C) not listed send entity_hit_message_queue_push(1)")]];
    SafHitstopOverride *hitstopOverride : u32;
    SafAiParams *aiParams : u32 [[comment("NPC hunter AI with a Switch Axe F")]];
    padding[16];
};

SwitchAxeFTunables switchAxeFTunables @ header.ptrs.switchAxeFTunables [[name("Switch Axe F Tunables")]];

// =======================
// Lance combo rules (header 0x654, Otya unk654): 26 rule lists. While a Lance
// action plays, lance_act_dispatch_style012 takes the list of that action
// (code table 0x11A86B38 by action pw +0x14, category 1) and runs
// lance_combo_rules_update on it; list 25 is used by FUN_10A05100 (Lance
// action from player_damage_action_update). A rule can be picked while its
// select window is open, and its action starts while its start window is
// open. A window opens when the motion (pw motionId) reaches the frame, and
// closes the same way; motion 0 opens at once / never closes. Window bits
// per rule: SkillWork +0x1C / +0x20 (select), +0x24 / +0x28 (start).
// Proofs: tools/mhfdat_re/data/654_notes.md.
// =======================

struct LanceComboRule {
    u16 step [[comment("a rule is a candidate when its step >= the step of the rule already picked (index pw pl_nextComboIdx) + 1, or 0 when none")]];
    u16 styleCondition [[comment("lance_combo_style_condition: 1 = style 0, 2 / 3 = styles 1-3, 4 = styles 0-1, 5 = styles 2-3, other = always")]];
    u16 input [[comment("input id the rule waits for (lance_input_id_get, 0x11 = none); the rules' ids form the mask of inputs read")]];
    padding[2];
    u32 selectOpenMotion;
    float selectOpenFrame;
    u32 selectCloseMotion;
    float selectCloseFrame;
    u16 action [[comment("lance_combo_action_start: below 0x38 = set_entity_action_state(category 1, it); 0x38 and up = special cases")]];
    padding[2];
    u32 startOpenMotion;
    float startOpenFrame;
    u32 startCloseMotion;
    float startCloseFrame;
};

struct LanceComboRuleList {
    u32 count;
    LanceComboRule *rules[count] : u32;
};

struct LanceComboRules {
    u32 numLists [[comment("26 (no reader; the lists are indexed by the code table)")]];
    LanceComboRuleList *lists[numLists] : u32;
    padding[24];
};

LanceComboRules lanceComboRules @ header.ptrs.lanceComboRules [[name("Lance Combo Rules")]];

// =======================
// Weapon skill modifiers (header 0xA8C, Otya unkA8C): values and pointers to
// small tables inside the same block. Most are Consumption Slayer (skill
// 0x1F9) alternatives: with it the code reads these instead of the normal
// values. Proofs: tools/mhfdat_re/data/a8c_notes.md.
// =======================

struct WeaponSkillModifiers {
    u32 consumptionSlayerMeleeAttack [[comment("player_consumable_attack_bonus_total: attack added with Consumption Slayer (0x1F9) and a melee weapon (pw +0x401 == 6)")]];
    s16 *consumptionSlayerSharpnessCost[14] : u32 [[comment("by weapon class (entity +3): with Consumption Slayer the sharpness change is lowered by it (sharpness_consumtion_handler, weapon_apply_sharpness_loss_and_hit_result; not for gunlance_action_subtype_allowed)")]];
    u16 consumptionSlayerCoatingCost [[comment("bow_consume_loaded_ammo(_if_flagged / _with_save): loaded coatings (pouch pw +0xA18) consumed per shot with Consumption Slayer")]];
    padding[2];
    FloatTriple *consumptionSlayerGunnerKind1RawMult : u32 [[comment("gunner_select_ammo_stat_table with Consumption Slayer, coating kind 1 (instead of weaponConstants +0x380)")]];
    FloatTriple *consumptionSlayerGunnerRawMult : u32 [[comment("same, other coating kinds (instead of +0x38C)")]];
    FloatTriple *consumptionSlayerHitboxKind1RawMult : u32 [[comment("weapon_init_hitbox_damage_from_params with Consumption Slayer, shell +8 == 1 (instead of +0x480)")]];
    FloatTriple *consumptionSlayerHitboxRawMult : u32 [[comment("same, other kinds (instead of +0x48C)")]];
    u32 *safPhialStunAdd[5] : u32 [[comment("saf_phial_stun_sigil_add (switchaxe_bin_dispatch_phial_apply) with sigil TechBoostSaf (0x61) value 1: added to the hit +0x89 (stun), by shell row (+6) - 1; the code allows rows up to skillCounts +0x12 (5)")]];
    float reachBonus [[comment("player_attack_reach_bonus_max: reach bonus candidate when weapon_slot_get_skill_value_entity(0x60)")]];
};

WeaponSkillModifiers weaponSkillModifiers @ header.ptrs.weaponSkillModifiers [[name("Weapon Skill Modifiers")]];

// =======================
// Evade actions (header 0x8C0, Otya unk8C0): per weapon class (entity +3,
// 0-13) a list of {category, action} rows, then a list for every weapon
// ([14], checked after the class list). hit_lookup_motion_iframe_entry
// matches the player's current category (+0x15) and action (+0x14).
// hit_detected uses the match for its evade flags (docs/reverse/
// hit_detected.md: Stylish, Thunder Clad, Stylish Assault, Furious, Tonfa,
// Absolute Evasion). Proofs: tools/mhfdat_re/data/8c0_notes.md.
// =======================

struct EvadeAction {
    u16 category [[comment("player category (+0x15)")]];
    u16 action [[comment("player action (+0x14)")]];
    s16 stylishSharpnessRestore [[comment("weapon_consume_sharpness_on_hit (evade flag 2, Stylish 0x1E0): sharpness_consumtion_handler(+it)")]];
    s16 blastBlightReduce [[comment("evade_reduce_ailment_counters (Player_PendingInput_Check, after an evade): blast blight counter SkillWork +0x6CC -= it (player_blast_blight_reduce)")]];
    s16 sharpnessDrainReduce [[comment("same: sharpness-drain debuff counter SkillWork +0x712 -= it (player_sharpness_drain_reduce)")]];
    s16 fireBlightReduce [[comment("same: fire blight timer SkillWork +0x688 -= it (player_fire_blight_timer_add)")]];
    s16 zenithSpikeMarkReduce [[comment("same: Zenith spike mark timer SkillWork +0x8F0 -= it (player_zenith_spike_mark_reduce)")]];
    u16 flags [[comment("bit 0: Tonfa styles 1 / 3 special evade (hit_special_iframe_motion_ok -> tonfaBoostFrames); bit 1: Switch Axe F hit reaction branch (player_hit_reaction_motion_dispatch); bits 2 / 3: no reader found")]];
};

struct EvadeActionList {
    u32 count;
    EvadeAction *rows[count] : u32;
};

struct EvadeActionLists {
    EvadeActionList byWeaponClass[14] [[comment("[8] (Hunting Horn) is empty, its pointer is not used")]];
    EvadeActionList allWeapons [[comment("checked when the class list has no match; [13] is also read by FUN_103321C0 (Magnet Spike, category 1 only)")]];
    padding[8];
};

EvadeActionLists evadeActions @ header.ptrs.evadeActions [[name("Evade Actions")]];

// =======================
// Bowgun shot tables (header 0xA70, Otya unkA70): fifteen pointers, then the
// counts of some tables. Read by the bowgun shot code (kind 6 shells,
// gunner_shot_hitbox_init, gunner_shot_flight_update shot update, gunner_shot_hit_update / gunner_shot_trail_update
// hits). A shot row is picked by the shell row (+6); a shot's distance stage
// (shot work +1) rises as its age (+0x94) passes the thresholds of its band
// row (gunner_shot_critical_distance_band_update) and picks the damage
// multiplier of the stage tables (gunner_shot_apply_ammo_to_hit). Proofs:
// tools/mhfdat_re/data/a70_notes.md.
// =======================

struct BowgunShotRow {
    u8 pattern [[comment("2: velocity built from the shot's spread bits (+0xDE) (gunner_shot_hitbox_init); 4: multi-hit shot, one more hit every 4 frames from frame 3 while the hit count (+3) <= hitBehaviorValue (gunner_shot_flight_update); em101_counter_dmg_scale tests 4")]];
    u8 trailPart [[comment("effect part (row x 0x8C of _DAT_1ED7D6A0 +0x30) drawn on the shot (gunner_shot_trail_update); 0x62: plus the shot age, random seed, render position copy (gunner_shot_tick); 0xFF: none")]];
    u8 trailColor [[comment("row of trailColors (gunner_shot_trail_update)")]];
    u8 effect412Delay [[comment("row of effect412Delays: after that many frames effect 0x412 spawns at the shot (effect412_spawn_at_shot)")]];
    s16 distanceBand [[comment("row of the distance band lists; -1 = no distance stages")]];
    s16 modelMode [[comment("not 0: the shot gets a render slot (gunner_shot_model_slot_alloc), then FUN_111E75A0 (gunner_shot_flight_update)")]];
    float speed [[comment("forward speed = speed + random x speedRandom, both x the shot's speed factors (gunner_shot_hitbox_init)")]];
    float speedRandom;
    float gravity [[comment("shot +0x60 = -(random x gravityRandom + gravity)")]];
    float gravityRandom;
    float spread [[comment("gunner_shot_flight_update: random lateral spread x it x speed")]];
    float wobble [[comment("gunner_shot_flight_update: random wobble over the first 20 frames, x it (and the coating modifiers)")]];
    s16 moveFrames [[comment("gunner_shot_flight_update: the shot moves while its age is below it")]];
    u8 hitBehavior [[comment("gunner_shot_hit_update (monster hit, jump table 0x111E45C8) / gunner_shot_flight_update (end): 6 = ricochet and 8 = pierce, more hits while the hit count (+0xA) < hitBehaviorValue; 7 = cluster, monster hit spawns cluster row hitBehaviorValue (ground end: row 0); 0xC / 0xD / 0xE spawn cluster row 0 / 1 / 2; 1 / 3-5 / 0xC-0xE stay on the target while age < hitBehaviorValue; 0xA: FUN_11421ED0")]];
    u8 hitBehaviorValue;
};

struct BowgunDistanceBand {
    s16 thresholds[8] [[comment("shot age per stage (x the coating modifiers); -1 ends")]];
};

struct BowgunDistanceBandList {
    BowgunDistanceBand *bands[21] : u32;
};

struct BowgunClusterRow {
    u8 shotRow [[comment("gunner_shot_spawn_cluster: shot row of the fragments")]];
    padding[1];
    s16 count [[comment("number of fragments")]];
};

struct BowgunStageMults {
    float stages[7] [[comment("damage multiplier by distance stage")]];
};

struct BowgunShotTables {
    BowgunShotRow *shotRows[53] : u32 [[comment("by shell row (+6); 53 rows fill the block. Rows 0-19 follow the Ferias shot list (doc-gun.htm): Normal 1-3, Pierce 1-3, Pellet 1-3, Crag 1-3, Clust 1-3, Flame, Water, Thunder, Freeze, Dragon")]];
    u32 *shotHitFlags[53] : u32 [[comment("gunner_shot_hitbox_init: ORed into hit +0x90, by shell row")]];
    BowgunDistanceBandList *distanceBands : u32 [[comment("gunner_shot_distance_band_list_get default (Light Bowgun styles 0 / 3, other classes)")]];
    BowgunDistanceBandList *distanceBandsLbgStyles12 : u32 [[comment("Light Bowgun in styles 1 / 2")]];
    BowgunDistanceBandList *distanceBandsFlag8 : u32 [[comment("shots with flag 8 (shot work +0x3C)")]];
    BowgunDistanceBandList *distanceBandsHbg : u32 [[comment("Heavy Bowgun")]];
    u16 *effect412Delays[3] : u32 [[comment("frames, by shot row +3 (gunner_shot_flight_update)")]];
    BowgunClusterRow *clusterRows[3] : u32 [[comment("by hitBehavior 0xC / 0xD / 0xE (7 uses row 0)")]];
    u32 *trailColors[4] : u32 [[comment("by shot row +2 (gunner_shot_trail_update -> FUN_1000C390)")]];
    BowgunStageMults *stageMult : u32 [[comment("gunner_shot_apply_ammo_to_hit: default (Light Bowgun, other classes)")]];
    BowgunStageMults *stageMultLbgStyles12 : u32 [[comment("Light Bowgun in styles 1 / 2 without the Active Feature")]];
    BowgunStageMults *stageMultFlag8 : u32 [[comment("shots with flag 8 (+0x3C)")]];
    BowgunStageMults *stageMultHbg : u32 [[comment("Heavy Bowgun without the Active Feature")]];
    BowgunStageMults *stageMultLbgActiveFeature : u32 [[comment("Light Bowgun with Active Feature effect 9 (IsMineDailyFeature(9))")]];
    BowgunStageMults *stageMultHbgActiveFeature : u32 [[comment("Heavy Bowgun with Active Feature effect 8 (IsMineDailyFeature(8))")]];
    u16 numDistanceBands [[comment("21 (no reader; matches the band lists)")]];
    u16 numEffect412Delays [[comment("3 (no reader)")]];
    u16 gap40 [[comment("6, no reader found")]];
    u16 numTrailColors [[comment("4 (no reader)")]];
    u16 numDistanceStages [[comment("7 (no reader; matches the stage tables)")]];
    padding[2];
};

BowgunShotTables bowgunShotTables @ header.ptrs.bowgunShotTables [[name("Bowgun Shot Tables")]];

// HBG shot gauge gains (header 0x640): sorted by ammo type, binary search
// (hbg_shot_gauge_gain_row_find) on the loaded ammo (PlayerWork +0x6C6).
// hbg_shot_gauge_gain_apply runs on each bowgun shot of a local Heavy Bowgun
// with PlayerWork +0x8C3 bit 4 (gou special mode / Heat Cannon sigil 0x32) or the
// Extreme style. With bit 4 the shot adds heatGaugeGain (Focus-adjusted) to the
// gauge +0xA12 (cap +0xD0C) and sets +0xD15 to heatDecayDelay, the frames before
// player_entity_tick_hp_regen drains 1 point every 30 frames; in Extreme style
// with a large monster in the stage, bowgunGaugeGain fills SkillWork +0x1C0.
struct HbgShotGaugeGain {
    u16 ammoType [[format("ammoName")]];
    s16 heatGaugeGain;
    u8 heatDecayDelay [[comment("Frames")]];
    u8 unk05 [[comment("no reader")]];
    s16 bowgunGaugeGain;
};

HbgShotGaugeGain hbgShotGaugeGains[importantNums.numHbgShotGaugeGains] @ header.ptrs.hbgShotGaugeGains [[name("HBG Shot Gauge Gains")]];

// Fencing hitstop overrides (header 0x644): fencing_hitstop_frames_get searches
// them linearly for kind 0 (player melee) hits by attack id (hit +6), else the
// class default weaponParams +0xBE (or the Switch Axe F override). From
// on_hit_effects_dispatch, when Fencing+2 applies (melee_attack_bounces_is_active,
// ratio >= 0.23) on a hit with flag +0x15C & 0x4000, the value becomes the
// attacker's hitstop (+0x4E6).
struct FencingHitstopOverride {
    u16 attackId;
    u16 hitstopFrames [[comment("Low byte used")]];
};

FencingHitstopOverride fencingHitstopOverrides[importantNums.numFencingHitstopOverrides] @ header.ptrs.fencingHitstopOverrides [[name("Fencing Hitstop Overrides")]];
