#pragma once

/**
	Partner: creation (starter weapons, header 0x6B0, important numbers +
	0x264 of them; two starter armor sets of 5 pieces, 0x6B4 and 0x6B8, one
	picked at random; the 3 tables also give a new hunter its first equipment;
	the look per gender and personality, 0x800), faces (0x320, important
	numbers + 0xDC, also the hunters' own faces), the weapon teaching fee by number of
	classes already unlocked (0x84C), the skill point cap and skill slot count
	by Partner level (0x85C, 0x860), the skill shop (0x838, important numbers
	+ 0x30C) and the extra skill shop (0x9D8, its count is the u32 in header
	slot 0x9D4).
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

struct PartnerEquip {
    u8  type                    [[format("getEquipType")]];
    u8  unk01;
    u16 id;
};

PartnerEquip partnerStarterWeapons[importantNums.numPartnerStarterWeapons] @ header.ptrs.partnerStarterWeapons [[name("Partner Starter Weapons"), comment("Partner creation keeps those of the Rasta's class; a new hunter gets all of them in the box and equips the one picked in character creation")]];
PartnerEquip partnerArmorSetA[5] @ header.ptrs.partnerArmorSetA [[name("Partner Armor Set A"), comment("Partner: 50 / 50 with set B; new hunter: inner (save +0x200B4) bit 0 clear")]];
PartnerEquip partnerArmorSetB[5] @ header.ptrs.partnerArmorSetB [[name("Partner Armor Set B"), comment("Partner: 50 / 50 with set A; new hunter: inner (save +0x200B4) bit 0 set")]];

struct PartnerHairColor {
    u8 blue;
    u8 green;
    u8 red;
    u8 alpha;
};

struct PartnerLook {
    u8 inner;
    u8 face;
    u8 voice;
    u8 hairstyle;
    PartnerHairColor hairColor;
};

struct PartnerLooks {
    PartnerLook male[7]         [[comment("By personality")]];
    PartnerLook female[7];
};

PartnerLooks partnerLooks @ header.ptrs.partnerLooks [[name("Partner Looks")]];

struct PartnerFace {
    u16 faceModel;
    u8  skinToneMale            [[comment("0-3, read as a byte at +2 + gender x 2")]];
    padding[1];
    u8  skinToneFemale;
    padding[1];
};

PartnerFace partnerFaces[importantNums.numPartnerFaces] @ header.ptrs.partnerFaces [[name("Partner Faces")]];

struct PartnerTeachFees {
    u16 gcp[13]                 [[comment("By number of classes already unlocked - 1")]];
    u16 end;
};

PartnerTeachFees partnerTeachFees @ header.ptrs.partnerTeachFees [[name("Partner Weapon Teaching Fees")]];

// A value applies from its Partner level up to the next step's
struct PartnerLevelStep {
    s16 fromPartnerLevel;
    padding[2];
    s32 value;
};

struct PartnerLevelSteps {
    PartnerLevelStep steps[while(std::mem::read_signed($, 2) != -1)];
    PartnerLevelStep end;
};

PartnerLevelSteps partnerSkillPointCaps @ header.ptrs.partnerSkillPointCaps [[name("Partner Skill Point Caps")]];
PartnerLevelSteps partnerSkillSlotCounts @ header.ptrs.partnerSkillSlotCounts [[name("Partner Skill Slot Counts")]];

struct PartnerSkill {
    u16 skill;
    u16 gcpPrice;
    u16 pointCost;
    u16 minPartnerLevel;
    u16 minGRank;
    u16 unk0A;
    u16 requiredSkills[6];
};

PartnerSkill partnerSkills[importantNums.numPartnerSkills] @ header.ptrs.partnerSkills [[name("Partner Skills")]];

struct PartnerExtraSkill {
    u16 extraSkill;
    u16 gcpPrice;
    u16 pointCost               [[comment("Shop draws '-' in this column, the value is never shown")]];
    u16 minMasteredClassLevel;
    u16 minGRank;
    u16 unk0A;
    u16 requiredExtraSkills[6];
};

PartnerExtraSkill partnerExtraSkills[header.ptrs.partnerExtraSkillCount] @ header.ptrs.partnerExtraSkills [[name("Partner Extra Skills")]];

// Partner attack by the equipped weapon's category (header 0x854, every weapon
// class but Tonfa; 0x92C, Tonfa: Get_weapon_job2 == 11), from
// partner_category_stat_get (first match in this
// order: finess ext, Gou GR2, Gou GR3, exotique, Gou GR1, G-K, Gou HR2,
// HcGousyu, G, exG, hc, evolution kind 1, G evolution kinds 2 / 3, zenith,
// hcGousyu equip type, SP, else none). Added to the Partner level and class
// mastery values (partner_attack_total).
struct PartnerCategoryValues {
    u16 none;
    u16 sp;
    u16 hcGousyuEquipType;
    u16 evolution;
    u16 hc;
    u16 exG;
    u16 gClass;
    u16 hcGousyu;
    u16 gouHR2;
    u16 gClassK;
    u16 gouGR1;
    u16 gouGR2;
    u16 finessExt;
    u16 gouGR3;
    u16 exotique;
    u16 exotiqueRanked [[comment("get_ex_g_weapon_rank() != 0")]];
    u16 gEvolution;
    u16 zenith;
};

PartnerCategoryValues partnerWeaponCategoryAttack @ header.ptrs.partnerWeaponCategoryAttack [[name("Partner Weapon Category Attack")]];
PartnerCategoryValues partnerTonfaCategoryAttack @ header.ptrs.partnerTonfaCategoryAttack [[name("Partner Tonfa Category Attack")]];

// Partner armor defense by the piece's category (header 0x858).
// partner_category_stat_get returns the first match in this order:
// retsusyu, gx_supremacy, exotic (ranked when the piece's gRarity != 0),
// zenith, gHasyu, hiden groups 6 / 5 / 4 / 3 (each by hidenWildcard, then
// hidenBit4, then hidenBit3), gClassS, hcKai, supremacy, Grank, hiden groups
// 1-2 (same three bits), gArmorF, equipableBy bit 7, Gou, SP, else none.
// partner_defense_total adds the five pieces to the Partner level defense;
// Get_Armor_adj_eq returns it as the piece's defense in the Partner box.
struct PartnerArmorCategoryValues {
    u16 none;
    u16 gou [[comment("equipableBy bit 6")]];
    u16 equipableBit7 [[comment("equipableBy bit 7")]];
    u16 gArmorF;
    u16 hidenGroup12Bit3 [[comment("armorType bit 1 or 2, with bit 3")]];
    u16 hidenGroup12Bit4;
    u16 hidenGroup12Wildcard;
    u16 gRank;
    u16 supremacy;
    u16 hcKai;
    u16 gClassS;
    u16 hidenGroup3Bit3;
    u16 hidenGroup3Bit4;
    u16 hidenGroup3Wildcard;
    u16 hidenGroup4Bit3;
    u16 hidenGroup4Bit4;
    u16 hidenGroup4Wildcard;
    u16 hidenGroup5Bit3;
    u16 hidenGroup5Bit4;
    u16 hidenGroup5Wildcard;
    u16 hidenGroup6Bit3;
    u16 hidenGroup6Bit4;
    u16 hidenGroup6Wildcard;
    u16 gHasyu;
    u16 retsusyu;
    u16 sp [[comment("equipableBy bit 5")]];
    u16 gxSupremacy;
    u16 exotic;
    u16 exoticRanked [[comment("get_ex_g_armor_rank() != 0")]];
    u16 zenith;
    u16 unk3C [[comment("no reader")]];
    u16 unk3E [[comment("no reader")]];
};

PartnerArmorCategoryValues partnerArmorCategoryDefense @ header.ptrs.partnerArmorCategoryDefense [[name("Partner Armor Category Defense")]];

// Partner attack, defense and element by level (header 0x83C, 0x840, 0x844,
// 0x848). partner_level_rate_sum sums (toLevel - previous toLevel) x perLevel
// over the rows below the level, plus (level - previous toLevel) x perLevel for
// the row that holds it, then divides by 10000; past the last row the value no
// longer grows. partner_attack_total adds 0x83C at the Partner level and 0x840
// at the level of the equipped weapon's class (999 when mastered), plus 5 per
// mastered class and the weapon category value; partner_defense_total adds
// 0x844 at the Partner level to the armor category values. 0x848, at the class
// level, is the weapon element value weapon_element_status_affinity_value uses
// with Partner equipment.
struct PartnerLevelRate {
    s16 toLevel;
    padding[2];
    s32 perLevel [[comment("1/10000 per level")]];
};

struct PartnerLevelRates {
    PartnerLevelRate rates[while(std::mem::read_signed($, 2) != -1)];
    PartnerLevelRate end;
};

PartnerLevelRates partnerLevelAttack @ header.ptrs.partnerLevelAttack [[name("Partner Level Attack")]];
PartnerLevelRates partnerClassLevelAttack @ header.ptrs.partnerClassLevelAttack [[name("Partner Class Level Attack")]];
PartnerLevelRates partnerLevelDefense @ header.ptrs.partnerLevelDefense [[name("Partner Level Defense")]];
PartnerLevelRates partnerClassLevelElement @ header.ptrs.partnerClassLevelElement [[name("Partner Class Level Element")]];

// Partner point rates (header 0x850): percent rates that turn a quest's HRP
// total (quest result +0xFF0) and GRP total (+0x1098) into Partner Rank Points
// (partner_rank_points_gain_calc), Partner weapon proficiency
// (partner_weapon_rank_points_gain_calc, no Premium part) and Partnyaa rank
// points (partnyaa_rank_points_gain_calc); the Premium parts need the Premium
// course (result +0x1B48 bit 0, "Premium Bonus!"). Each sum then goes through
// quest_result_bonus_rate_apply and the 99999999 cap. tonfaStatusPercent: with
// Partner equipment and a Tonfa, the weapon status value is scaled by it
// (partner_tonfa_status_scale).
struct PartnerPointRates {
    u16 partnerRankHrpPercent [[comment("PRP = HRP total x this / 100")]];
    u16 weaponRankHrpPercent [[comment("Weapon proficiency = HRP total x this / 100")]];
    u16 partnerRankGrpPercent [[comment("PRP += GRP total x this / 100")]];
    u16 weaponRankGrpPercent [[comment("Weapon proficiency += GRP total x this / 100")]];
    u16 partnerRankPremiumHrpPercent [[comment("Premium: extra PRP = HRP total x this / 100")]];
    u16 partnerRankPremiumGrpPercent [[comment("Premium: extra PRP += GRP total x this / 100")]];
    u16 partnyaaRankHrpPercent [[comment("Partnyaa points = HRP total x this / 100")]];
    u16 partnyaaRankGrpPercent [[comment("Partnyaa points += GRP total x this / 100")]];
    u16 partnyaaRankPremiumHrpPercent [[comment("Premium: extra Partnyaa points = HRP total x this / 100")]];
    u16 partnyaaRankPremiumGrpPercent [[comment("Premium: extra Partnyaa points += GRP total x this / 100")]];
    u16 tonfaStatusPercent [[comment("Partner equipment, Tonfa: status value x this / 100")]];
    u16 unk16 [[comment("no reader")]];
};

PartnerPointRates partnerPointRates @ header.ptrs.partnerPointRates [[name("Partner Point Rates")]];
