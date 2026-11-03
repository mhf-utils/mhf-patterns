#pragma once
#include <misc/s32p.pat>
#include <mhfdat/data/equipment_counts.hexpat>

bitfield equipableBy {
  isMaleEquip:   1; 
  isFemaleEquip: 1;
  isBladeEquip:  1; 
  isGunnerEquip: 1;
  bool1:         1; 
  isSPEquip:     1;
  bool3:         1; 
  bool4:         1;
};

bitfield armorTypes {
    gArmorF : 1;       // bit 0, Wii U Pl_G_Armor_f_num (was gou)
    padding : 5;
    Grank : 1;         // bit 6 (the byte at 0x3F is not the G rank)
    supremacy : 1;     // bit 7; Wii U Pl_G_Armor_fx_num counts bits 7, 14 and 15 together
    hcKai : 1;         // bit 8, Wii U Pl_HC_Armor_kai_num (was premium_HR); HC Kai bonuses, header 0x5B0 / 0x5B4
    gClassS : 1;       // bit 9, Wii U Pl_G_Class_S_Armor_num (was premium_GR)
    padding : 4;
    gHasyu : 1;        // bit 14, Wii U Pl_G_Armor_hasyu_num (was g_supremacy)
    retsusyu : 1;      // bit 15, Wii U Pl_Retsusyu_Armor_num (was gf_supremacy)
    gx_supremacy : 1;  // bit 16 (GX_SUPREMACY); HD only, header 0x968-0x970 by piece count
    padding : 1;
    exotic : 1;        // bit 18
    zenith : 1;        // bit 19
    padding : 12;
};

struct EquipmentItem {
  s16 modelIdMale; 
  s16 modelIdFemale;
  equipableBy bitfld;
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

  u8 coefUpgrade; 
  u8 upgradeCostRow [[comment("Row of the armor upgrade cost percents (header 0xB8)")]];

  u8 baseSlots; 
  u8 maxSlots;

  u8 PostFesti;
  u16 ShowNextLevel;
  u16 EquipID [[
    name("Upgrade to Equipment ID 1")
  ]];
  u16 EquipID2 [[
    name("Upgrade to Equipment ID 2")
  ]];
  u16 EquipID3 [[
    name("Upgrade to Equipment ID 3")
  ]];
  u16 Effect_ID; 
  u16 UpgradeID;

  u8 skillId1; s8 skillPts1;
  u8 skillId2; s8 skillPts2;
  u8 skillId3; s8 skillPts3;
  u8 skillId4; s8 skillPts4;
  u8 skillId5; s8 skillPts5;

  armorTypes armorType;

  u32 weapHiden; 
  u8 towerslots;
  u16 decoItemID;
  u8 unk3F [[comment("Not the G rank (armorType bit 6 is): 0x0F on almost every armor")]];
  u8 ZeroF; 
  u32 appPrice; 
  u8 unk44; 
  u16 zenithSkill;
};

struct EquipmentName {
  s32p name;
};

struct EquipmentDescription {
  s32p description_1;
  s32p description_2;
  s32p description_3;
  s32p mhfy;
};

// The counts come from the equipment counts (header 0x0E8): the legs don't end
// at a -1 (ZZ EN: 13514 legs, a scan to -1 finds 13528). The descriptions are
// one table, head first and leg last, each part where the previous one ends.
u32 __descHeads  = header.ptrs.equipDesc;
u32 __descBodies = __descHeads  + 0x10 * equipmentCounts.numHeadA;
u32 __descArms   = __descBodies + 0x10 * equipmentCounts.numBodyA;
u32 __descWaists = __descArms   + 0x10 * equipmentCounts.numArmA;
u32 __descLegs   = __descWaists + 0x10 * equipmentCounts.numWaistA;

struct EquipmentHeads {
  EquipmentItem        data         [equipmentCounts.numHeadA]  @ header.ptrs.headArmor      [[name("Data")]];
  EquipmentName        names        [equipmentCounts.numHeadA]  @ header.ptrs.headArmorNames [[name("Names")]];
  EquipmentDescription descriptions [equipmentCounts.numHeadA]  @ __descHeads                [[name("Descriptions")]];
};

struct EquipmentBodies {
  EquipmentItem        data         [equipmentCounts.numBodyA]  @ header.ptrs.bodyArmor      [[name("Data")]];
  EquipmentName        names        [equipmentCounts.numBodyA]  @ header.ptrs.bodyArmorNames [[name("Names")]];
  EquipmentDescription descriptions [equipmentCounts.numBodyA]  @ __descBodies               [[name("Descriptions")]];
};

struct EquipmentArms {
  EquipmentItem        data         [equipmentCounts.numArmA]   @ header.ptrs.armArmor       [[name("Data")]];
  EquipmentName        names        [equipmentCounts.numArmA]   @ header.ptrs.armArmorNames  [[name("Names")]];
  EquipmentDescription descriptions [equipmentCounts.numArmA]   @ __descArms                 [[name("Descriptions")]];
};

struct EquipmentWaists {
  EquipmentItem        data         [equipmentCounts.numWaistA] @ header.ptrs.waistArmor      [[name("Data")]];
  EquipmentName        names        [equipmentCounts.numWaistA] @ header.ptrs.waistArmorNames [[name("Names")]];
  EquipmentDescription descriptions [equipmentCounts.numWaistA] @ __descWaists                [[name("Descriptions")]];
};

struct EquipmentLeg {
  EquipmentItem        data         [equipmentCounts.numLegA]   @ header.ptrs.legArmor        [[name("Data")]];
  EquipmentName        names        [equipmentCounts.numLegA]   @ header.ptrs.legArmorNames   [[name("Names")]];
  EquipmentDescription descriptions [equipmentCounts.numLegA]   @ __descLegs                  [[name("Descriptions")]];
};

struct Equipments {
  EquipmentHeads  head  @ header.ptrs.headArmor  [[name("Heads")]];
  EquipmentBodies body  @ header.ptrs.bodyArmor  [[name("Chests")]];
  EquipmentArms   arm   @ header.ptrs.armArmor   [[name("Arms")]];
  EquipmentWaists waist @ header.ptrs.waistArmor [[name("Waists")]];
  EquipmentLeg    leg   @ header.ptrs.legArmor   [[name("Legs")]];
};

Equipments equipments @ header.ptrs.headArmor [[name("Equipments")]];

// Pointers to the tables above, as the code indexes them: armor data by equip
// type (header 0x94: legs, head, head again, chest, arms, waist), names by
// equip type (header 0x98: legs, none, head, chest, arms, waist, melee,
// ranged), armor names from head to legs (header 0x9C)
u32 armorTablesByEquipType[6] @ header.ptrs.armorStatArray [[name("Armor Tables by Equip Type")]];
u32 nameTablesByEquipType[8] @ header.ptrs.armorWeaponStatArray [[name("Name Tables by Equip Type")]];
u32 armorNameTablesHeadToLegs[5] @ header.ptrs.armorNameArray [[name("Armor Name Tables, Head to Legs")]];
