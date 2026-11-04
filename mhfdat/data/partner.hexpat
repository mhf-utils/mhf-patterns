#pragma once

/**
	Partner: creation (starter weapons, header 0x6B0, important numbers +
	0x264 of them; two starter armor sets of 5 pieces, 0x6B4 and 0x6B8, one
	picked at random; the look per gender and personality, 0x800), faces
	(0x320, important numbers + 0xDC), the weapon teaching fee by number of
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

PartnerEquip partnerStarterWeapons[importantNums.numPartnerStarterWeapons] @ header.ptrs.partnerStarterWeapons [[name("Partner Starter Weapons"), comment("Creation keeps those of the Rasta's class")]];
PartnerEquip partnerArmorSetA[5] @ header.ptrs.partnerArmorSetA [[name("Partner Armor Set A")]];
PartnerEquip partnerArmorSetB[5] @ header.ptrs.partnerArmorSetB [[name("Partner Armor Set B")]];

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
    u16 skinToneMale            [[comment("0-3")]];
    u16 skinToneFemale;
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
    u16 unk04;
    u16 minMasteredClassLevel;
    u16 minGRank;
    u16 unk0A;
    u16 requiredExtraSkills[6];
};

PartnerExtraSkill partnerExtraSkills[header.ptrs.partnerExtraSkillCount] @ header.ptrs.partnerExtraSkills [[name("Partner Extra Skills")]];

// Partner attack (header 0x854, weapons) and defense (0x92C, armor) by the
// equipped piece's category (partner_category_stat_get, first match in this
// order: finess ext, Gou GR2, Gou GR3, exotique, Gou GR1, G-K, Gou HR2,
// HcGousyu, G, exG, hc, evolution kind 1, G evolution kinds 2 / 3, zenith,
// hcGousyu equip type, SP, else none). Added to the Partner level and class
// mastery values (partner_attack_total / partner_defense_total).
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
PartnerCategoryValues partnerArmorCategoryDefense @ header.ptrs.partnerArmorCategoryDefense [[name("Partner Armor Category Defense")]];
