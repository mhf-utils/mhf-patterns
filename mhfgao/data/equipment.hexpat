#pragma once

#include <mhfgao/utils/index.pat>

struct SkillPoint {
    u8 skillId;
    s8 points;
};

struct ArmorData {
    u16 modelIdMale;
    u16 modelIdFemale;
    u8 equipableBy;
    u8 rarity;
    u8 maxLevel;
    u8 unk07;
    u16 unk08;
    u16 unk0A;
    u32 zennyCost;
    u16 unk10;
    u16 baseDefense;
    s8 fireRes;
    s8 waterRes;
    s8 thunderRes;
    s8 dragonRes;
    s8 iceRes;
    u8 upgradeCoef;
    u8 unk1A;
    u8 baseSlots;
    u8 maxSlots;
    u8 postFesti;
    u16 showNextLevel;
    u16 equipId;
    u16 unk22;
    u32 unk24;
    u16 unk28;
    SkillPoint skills[5];
    u32 armorType;
    u16 weaponHiden;
    u16 decoItemId;
    u16 towerSlots;
    u8 gRank;
    u8 unk3F;
    u32 appPrice;
    u16 unk44;
    u16 zenithSkill;
};

struct MeleeWeaponData {
    u16 modelId;
    u8 rarity;
    u8 weaponType;
    u32 zennyCost;
    u8 sharpnessId;
    u8 sharpnessMax;
    u16 rawDamage;
    u16 defense;
    s8 affinity;
    u8 elementId;
    u8 elementDamage;
    u8 ailmentId;
    u8 ailmentDamage;
    u8 slots;
    u8 weaponAttribute;
    u8 unk15;
    u16 upgradePath;
    u16 otherModelId;
    u8 equipType;
    u8 unk1B;
    u32 length;
    u32 weaponCategory;
    u16 visualEffects;
    u16 g50ParamId;
    u8 gRank;
    u8 unk29;
    u8 unk2A;
    u8 unk2B;
    u32 unk2C;
    u16 zenithSkill;
    padding[2];
};

struct ArmorRows {
    ArmorData r[while(rd16($) != 0xFFFF)];
    u16 end;
};

struct WeaponRows {
    MeleeWeaponData r[while(rd16($) != 0xFFFF)];
    u16 end;
};

struct PartnyaaDescription {
    Str lines[4];
};

struct Descriptions {
    PartnyaaDescription r[while(rd32($) != 0)];
    u32 end;
};

U16s<8> pAppearancePartCounts @ header.pAppearancePartCounts;
ArmorRows pHeadRows @ header.pHeadRows;
ArmorRows pBodyRows @ header.pBodyRows;
Strs<rows(header.pHeadRows,0x48)> pHeadNames @ header.pHeadNames;
Strs<rows(header.pBodyRows,0x48)> pBodyNames @ header.pBodyNames;
Descriptions pArmorDescriptions @ header.pArmorDescriptions;
WeaponRows pWeaponRows @ header.pWeaponRows;
Strs<rows(header.pWeaponRows,0x34)> pWeaponNames @ header.pWeaponNames;
Descriptions pWeaponDescriptions @ header.pWeaponDescriptions;
U32s<6> pArmorRowsByEquipType @ header.pArmorRowsByEquipType;
U32s<8> pNamesByEquipType @ header.pNamesByEquipType;
U32s<5> unk038 @ header.unk038;
U32s<header.armorModelCount> pArmorModelPartMasks @ header.pArmorModelPartMasks;
U16s<header.weaponModelCount> pWeaponSoundIds @ header.pWeaponSoundIds;
U8s<header.groundSoundCount> pGroundSoundTypes @ header.pGroundSoundTypes;
