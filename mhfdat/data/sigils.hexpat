#pragma once

/**
	Random sigils (G-rank sigil crafting with a budget), from
	var-username/Monster-Hunter-Frontier-Patterns (patterns/mhfdat/sigil.hexpat, LGPL-3.0).
	Checked on the ZZ EN client: 382 recipes (364 normal, 7 premium, 11 zenith),
	the probabilities table is exactly 382 x 64 bytes and the 132 base infos
	end where header 0x630 points. FW5 and S6 have no such tables.
	Not the Tower sigil crafting (header 0x944, crafting.hexpat): fixed recipes.
*/

#include <std/mem.pat>
#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

enum SigilSkill: u16 {
    Empty = 0,
    Attack = 1,
    Element = 2,
    Status = 3,
    Affinity = 4,
    Defense = 5,
    Stun = 6,
    FlyingWyvernSlayer = 7,
    BirdWyvernSlayer = 8,
    CarapaceonSlayer = 9,
    PiscineSlayer = 10,
    FangedBeastSlayer = 11,
    BruteWyvernSlayer = 12,
    LeviathanSlayer = 13,
    ElderDragonSlayer = 14,
    SmallMonsterSlayer = 15,
    ElementalCoatingCrystal = 16,
    HeatWave = 17,
    IntenseCold = 18,
    MorningSlayer = 19,
    NightSlayer = 20,
    BreedingSeasonSlayer = 21,
    WarmSeasonSlayer = 22,
    ColdSeasonSlayer = 23,
    MondaySlayer = 24,
    TuesdaySlayer = 25,
    WednesdaySlayer = 26,
    ThursdaySlayer = 27,
    FridaySlayer = 28,
    SaturdaySlayer = 29,
    SundaySlayer = 30,
    ManagerFriend = 31,
    BalloonFriend = 32,
    Dowsing = 33,
    HunterSoul = 34,
    SoulCollection = 35,
    GoocooFriend = 36,
    HalkFriend = 37,
    MoneyExpert = 38,
    ExperienceExpert = 39,
    Omnivorous = 40,
    CarvingDivision = 41,
    NoddingOff = 42,
    Decoy = 43,
    Tantrum = 44,
    Unity = 45,
    Support = 46,
    RapidFireAdd = 47,
    SuperRapidFireAdd = 48,
    RapidFireDisable = 49,
    HeatCannonAdd = 50,
    BallistaSaver = 51,
    RawBowBoost = 52,
    RawSnsBoost = 53,
    SonicBombRange = 54,
    TechBoostSnS = 55,
    TechBoostDb = 56,
    TechBoostGs = 57,
    TechBoostLs = 58,
    TechBoostLance = 59,
    TechBoostGunlance = 60,
    TechBoostHammer = 61,
    TechBoostHorn = 62,
    TechChangeSnS = 63,
    TechChangeDb = 64,
    TechChangeGs = 65,
    TechChangeLs = 66,
    TechChangeLance = 67,
    TechChangeGunlance = 68,
    TechChangeHammer = 69,
    TechChangeHorn = 70,
    TechChangeLbg = 71,
    TechChangeHbg = 72,
    TechChangeBow = 73,
    LengthUp = 74,
    ShellingChange = 75,
    NoteChange1 = 76,
    NoteChange2 = 77,
    NoteChange3 = 78,
    ArcShotChange = 79,
    RarityChange = 80,
    ShellingLvUp = 81,
    TechBoostBow = 82,
    CatBreeder = 83,
    ShotChange = 84,
    DrawStrengthGs = 85,
    DrawStrengthHammer = 86,
    DrawStrengthLance = 87,
    DrawStrengthSns = 88,
    DrawStrengthDb = 89,
    DrawStrengthLs = 90,
    DrawStrengthHorn = 91,
    DrawStrengthGunlance = 92,
    DrawStrengthTonfa = 93,
    TechBoostTonfa = 94,
    FangedWyvernSlayer = 95,
    UnsheathedMovementSpeed = 96,
    TechBoostSaf = 97,
    TechBoostHbg = 98,
    GsUp = 99,
    HbgUp = 100,
    HammerUp = 101,
    LanceUp = 102,
    SnsUp = 103,
    LbgUp = 104,
    DbUp = 105,
    LsUp = 106,
    HornUp = 107,
    GunlanceUp = 108,
    BowUp = 109,
    TonfaUp = 110,
    SafUp = 111,
    MsUp = 112,
    ZCooldown = 113,
    ZDuration = 114,
    ZFireRes = 115,
    ZWaterRes = 116,
    ZIceRes = 117,
    ZThunderRes = 118,
    ZDragonRes = 119,
    ZHealing = 120,
    ZHeroics = 121,
    ZAttack = 122,
    ZElement = 123,
    ZMovementSpeed = 124,
    RAttack = 125,
    RElement = 126,
    RAffinity = 127,
    RStatus = 128,
    RStun = 129,
    RHealing = 130,
    RAllRes = 131,
};

enum SigilType: u8 {
    Normal = 0,
    Premium = 1,
    Zenith = 2,
};

struct SigilMaterial {
    u16 item [[format("getItemName"), color("8888FF")]];
    u8 percentage_filled;
    u8 unk [[comment("0x80: active, 0x00: inactive")]];
};

// recipes end at a u32 0
struct SigilRecipe {
    SigilType sigil_type;
    u8 budget_low;
    u8 budget_high;
    u8 unk;
    u16 cost;
    padding[0x2];
    SigilMaterial key_materials[0x5];
    padding[0xC];
};

// the skills a recipe never rolls, until -1
struct SkillsBlacklist {
    SigilSkill skills[while(std::mem::read_signed($, 2) != -1)];
};

struct BlacklistPtr {
    SkillsBlacklist* ptr : u32;
};

struct SigilSkillProbability {
    SigilSkill skill;
    u8 percentage_chance;
	u8 always_rolled;
    s16 low_points;
    s16 high_points;
};

// a recipe's 8 skill rolls, in the order of the recipes
struct SigilSkillProbabilities {
    SigilSkillProbability probabilities[0x8];
};

struct SigilSkillPointsBudget {
	s16 points_low;
	s16 points_high;
	u16 budget;
	padding[2];
};

// per skill (SigilSkill order): the points it rolls for each budget
struct SigilSkillBaseInfo {
	SigilSkillPointsBudget rolls_entries[8];
	s16 max_roll;
	padding[2];
	u8 can_red_roll;
	padding[1];
	s16 red_roll_threshold;
	s16 specific_red_roll_points[8];
};

SigilRecipe recipes[while(std::mem::read_unsigned($, 4) != 0)] @ header.ptrs.sigilCraftingRecipes
    [[name("Sigil Crafting Recipes")]];
u16 recipes_len = std::core::member_count(recipes);
SigilSkillProbabilities probabilities[recipes_len] @ header.ptrs.sigilSkillProbabilities
    [[name("Sigil Skill Probabilities")]];
BlacklistPtr blacklist_ptrs[recipes_len] @ header.ptrs.sigilSkillBlacklists
    [[name("Sigil Random Skill Blacklists")]];
SigilSkillBaseInfo random_points_rolls[132] @ header.ptrs.sigilSkillBaseInfo [[name("Sigil Skill Base Info")]];

// =======================
// Zenith and Ranged sigils (header 0xBA8): the three weapon sigils (pw +0x920
// types, +0x926 values) all Zenith (0x71-0x7C, with ZCooldown and ZDuration)
// or all Ranged (0x7D-0x83). A sigil action (sigil_activate_action_update) applies them:
// Zenith sigils go to SkillWork +0x92C (timers) and +0x964 / +0x994 (12
// effect slots: sigil, level); Ranged sigils spawn the dome shell
// (shell_k400_call_shell). Effect = base + perLevel * (level - 1), level
// capped at maxLevel (sigil_effect_row_get). Proofs:
// tools/mhfdat_re/data/ba8_notes.md.
// =======================

struct SigilEffectRow {
    s32 base;
    s16 perLevel;
    s16 maxLevel [[comment("0 = no cap on the level")]];
};

struct SigilEffectCaps {
    u16 rangedAttack [[comment("RAttack sum (sigil_ranged_attack_add, player_recalc_attack_power_full); ZAttack is added on top")]];
    u16 rangedElement [[comment("RElement (weapon_element_attack_value_with_skills)")]];
    u16 rangedAffinity [[comment("RAffinity (weapon_total_affinity_percent)")]];
    u16 rangedStatus [[comment("RStatus (weapon_init_hitbox_damage_from_params)")]];
    u16 rangedStun [[comment("RStun (on_hit_effects_dispatch)")]];
    u16 rangedHealing [[comment("RHealing (player_entity_tick_hp_regen); ZHealing is added on top")]];
    u16 rangedAllRes [[comment("RAllRes (player_update_elemental_resistances)")]];
};

struct ZenithRangedSigils {
    u32 zenithRowsPtr [[comment("points to zenithRows below (block +0x1C)")]];
    u32 rangedParamsPtr [[comment("points to rangedCooldown (block +0x08)")]];
    float rangedCooldown [[comment("sigil_ranged_dome_apply: SkillWork +0x92C / +0x930 for a Ranged set (a Zenith set takes ZCooldown)")]];
    float rangedDuration [[comment("SkillWork +0x934 / +0x938 for a Ranged set (Zenith: ZDuration); x 2 x k_fall_threshold_y = dome shell reaction param (HitEvent_BarrelBombAOE_Init)")]];
    float rangedDomeScale [[comment("x 1500 = dome shell size (HitEvent_BarrelBombAOE_Init)")]];
    SigilEffectRow *rangedRows[7] : u32 [[comment("sigils 0x7D-0x83: RAttack, RElement, RAffinity, RStatus, RStun, RHealing, RAllRes")]];
    SigilEffectCaps *caps : u32 [[comment("caps of the summed Ranged effects")]];
    SigilEffectRow *zenithRows[12] : u32 [[comment("sigils 0x71-0x7C: ZCooldown, ZDuration, ZFireRes, ZWaterRes, ZIceRes, ZThunderRes, ZDragonRes, ZHealing, ZHeroics, ZAttack, ZElement, ZMovementSpeed")]];
};

ZenithRangedSigils zenithRangedSigils @ header.ptrs.zenithRangedSigils [[name("Zenith and Ranged Sigils")]];

// =======================
// Sigil crafting skill lists, both read while showing a recipe's skill chances
// (sigil_craft_draw_skill_chances). Header 0x894 (count important numbers
// +0x338): skills listed once in the recipe's possible skills
// (sigil_craft_build_skill_preview, sigil_craft_skill_is_unique). Header
// 0x898 (count +0x33A): skills named after their value when a chance row
// has low == high (sigil_get_name, sigil_craft_skill_is_value_named).
// =======================

SigilSkill sigilCraftUniqueSkills[importantNums.numSigilCraftUniqueSkills] @ header.ptrs.sigilCraftUniqueSkills [[name("Sigil Craft Unique Skills")]];
SigilSkill sigilCraftValueNamedSkills[importantNums.numSigilCraftValueNamedSkills] @ header.ptrs.sigilCraftValueNamedSkills [[name("Sigil Craft Value-Named Skills")]];

// Sigil craft material catalog (header 0x634; header 0xB9C when the craft
// type, work +0x6E24, is 2 / Zenith). The material screen of
// sigil_craft_recipe_select_input lists the materials of a tab (tab 7 shows
// all), counts the owned ones (pouch, box, storage, capped at 999, minus those
// already placed) by category (DLL table 0x1192042C maps it to a display
// group) and takes fillPercent as the share of a material that is not one of
// the recipe's key materials (sigil_craft_material_fill_get).
struct SigilCraftMaterial {
    u16 item [[format("getItemName")]];
    u8 category;
    u8 tab [[comment("1-7")]];
    u8 fillPercent;
    padding[3];
};

SigilCraftMaterial sigilCraftMaterials[importantNums.numSigilCraftMaterials] @ header.ptrs.sigilCraftMaterials [[name("Sigil Craft Materials")]];
SigilCraftMaterial sigilCraftMaterialsZenith[importantNums.numSigilCraftMaterialsZenith] @ header.ptrs.sigilCraftMaterialsZenith [[name("Sigil Craft Materials: Zenith")]];

// Sigil craft recipe material categories (header 0xBA0, important numbers
// +0x41E rows): sigil_craft_recipe_allows_material_category looks up the recipe
// under the cursor; a recipe with no row accepts every material category, else
// only its 3 (0xFF = unused). sigil_craft_material_list_build and the Zenith
// per-category counts skip the other materials.
struct SigilCraftRecipeMaterialCategories {
    u16 recipe [[comment("sigilCraftingRecipes index")]];
    u8 categories[3] [[comment("Category byte (+2) of the 0x634 / 0xB9C materials")]];
    padding[3];
};

SigilCraftRecipeMaterialCategories sigilCraftRecipeMaterialCategories[importantNums.numSigilCraftRecipeMaterialCategories] @ header.ptrs.sigilCraftRecipeMaterialCategories [[name("Sigil Craft Recipe Material Categories")]];

// Sigil class and icon by total budget (headers 0x630 / 0x638): the first
// threshold >= sigil_calc_total_budget gives the class shown as
// pDistortedWeaponTexts[1][index] (Hunter Sigil, Trial Sigil ... Extreme
// Sigil; sigil_class_from_budget) and the icon drawn by the sigil screens.
u8 sigilClassThresholds[importantNums.numSigilClassThresholds] @ header.ptrs.sigilClassThresholds [[name("Sigil Class Thresholds")]];
u8 sigilIconThresholds[importantNums.numSigilIconThresholds] @ header.ptrs.sigilIconThresholds [[name("Sigil Icon Thresholds")]];

// Header 0x890: sigil skills shown by their name alone when their value is
// below 2 (FUN_101BFDD0; the others use pSkillValueFormats[2]); the sigil skill
// merge (sigil_skills_merge) also treats them apart (sigil_skill_is_listed_no_value
// returns 0 for them). 0-terminated.
struct SigilSkillsNoValueAtOne {
    SigilSkill skills[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

SigilSkillsNoValueAtOne sigilSkillsNoValueAtOne @ header.ptrs.sigilSkillsNoValueAtOne [[name("Sigil Skills Without Value At 1")]];

// Header 0xAE8: sigil skills the sigil skill merge (sigil_skills_merge) counts
// instead of adding their values. sigil_counted_skill_bump maps (skill, value)
// to its sigil text index (sigil_text_index_get) and looks it up; when listed,
// the merged row's counter (starts at 1) goes up, capped at maxCount when > 0.
// The sigil screens (FUN_101BFDD0, FUN_109963F0) then print the counter with
// pSkillValueFormats[2] instead of the value when it is 2 or more. 0-terminated.
struct SigilCountedSkill {
    u16 textIndex [[comment("Sigil text index (pac 0xC44)")]];
    s8  maxCount [[comment("Counter cap when > 0")]];
    u8  unk03 [[comment("no reader")]];
};

struct SigilCountedSkills {
    SigilCountedSkill skills[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

SigilCountedSkills sigilCountedSkills @ header.ptrs.sigilCountedSkills [[name("Sigil Counted Skills")]];

// Rarity Change sigil (sigil 80, RarityChange; header 0x8A4 / 0x8A8 / 0x8AC):
// for a G or Gou weapon, an ex G weapon of rank > 0, a weapon of equip type 2
// or 3, or a Zenith weapon (weapon_element_status_affinity_value),
// the sigil's value v (1-12, weapon_slot_get_skill_value_entity(0x50)) scales
// the weapon's element by element[class][v] / 100 (at least 1 when the element
// is not 0), its status by status[class][v] / 100 (same rule) and a positive
// affinity by affinity[class][v] / 100 (rarity_change_*_scale). class =
// Get_weapon_job2 (className order). Column 0 is not used. The affinity table
// is all 0 on the EN, JP and rain files (positive affinity drops to 0), and
// its block is zeros up to the next table.
struct RarityChangeRates {
    u16 greatSword[16];
    u16 heavyBowgun[16];
    u16 hammer[16];
    u16 lance[16];
    u16 swordAndShield[16];
    u16 lightBowgun[16];
    u16 dualBlades[16];
    u16 longSword[16];
    u16 huntingHorn[16];
    u16 gunlance[16];
    u16 bow[16];
    u16 tonfa[16];
    u16 switchAxe[16];
    u16 magnetSpike[16];
};

RarityChangeRates rarityChangeElementRates @ header.ptrs.rarityChangeElementRates [[name("Rarity Change Element Rates")]];
RarityChangeRates rarityChangeStatusRates @ header.ptrs.rarityChangeStatusRates [[name("Rarity Change Status Rates")]];
RarityChangeRates rarityChangeAffinityRates @ header.ptrs.rarityChangeAffinityRates [[name("Rarity Change Affinity Rates")]];

// Rarity Change attack caps (header 0x8A0): same [14 classes][16] shape, but a
// cap, not a percent: the weapon attack becomes min(attack, cap[class][v]) for
// sigil 80 value v (1-12; columns 0 and 13-15 are not read).
// rarity_change_attack_cap (from player_recalc_attack_power_full),
// shooting_rampage_attack_bonus, FUN_10A85580 (from myset_pl_init) and
// calculate_weapon_damage (G / Gou class, ex G rank > 0, equip type 2 / 3 or
// Zenith weapons, the same gate as the rates above) read it.
using RarityChangeAttackCaps = RarityChangeRates;
RarityChangeAttackCaps rarityChangeAttackCaps @ header.ptrs.rarityChangeAttackCaps [[name("Rarity Change Attack Caps")]];

// Sigil recovery items (header 0x728; Wii U plate_item_data_set, Wii U slot
// 0x724): the items offered when a sigil is taken back from a G weapon into the
// Sigil box (pDistortedWeaponTexts[2] [0x2E] "Recovery Sigil"). plate_item_data_set
// copies every row whose G level range holds the weapon's G level
// (get_equip_weapon_class; 0 lists all rows) into the menu (8 slots);
// kako04_plate_get_item_sel_disp shows name and "%3d x" and greys rows the
// player cannot afford. No row and not a Weapon_g_class_k_check weapon:
// pSystemMessageTexts[120] "no recovery recipe". The list ends at item 0.
struct SigilRecoveryItem {
    ItemId item [[comment("0 ends the list")]];
    u16 count [[comment("Shown (%3d x) and compared with the owned count")]];
    u8 minGLevel [[comment("Listed when minGLevel <= weapon G level <= maxGLevel")]];
    u8 maxGLevel;
    u16 unk06 [[comment("no reader")]];
};

struct SigilRecoveryItemList {
    SigilRecoveryItem rows[while(std::mem::read_unsigned($, 2) != 0)];
    SigilRecoveryItem end;
};

SigilRecoveryItemList sigilRecoveryItems @ header.ptrs.sigilRecoveryItems [[name("Sigil Recovery Items")]];
