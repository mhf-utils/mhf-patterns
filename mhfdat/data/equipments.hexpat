#pragma once
#include <misc/s32p.pat>

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
    gou : 1;           // bit 0
    padding : 5;
    Grank : 1;         // bit 6
    supremacy : 1;     // bit 7
    premium_HR : 1;       // bit 8
    premium_GR : 1;  // bit 9 (utilisé dans GRANK_PREMIUM et ZENITH_PREMIUM)
    padding : 4;
    g_supremacy : 1;   // bit 14 (G_SUPREMACY)
    gf_supremacy : 1;  // bit 15 (GF_SUPREMACY)
    gx_supremacy : 1;  // bit 16 (GX_SUPREMACY)
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
  u8 unk1A;

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
  u8 Grank; 
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

struct TableEquipments {
  EquipmentItem head  [while (std::mem::read_signed($, 2) != -1)]  @ header.ptrs.headArmor  [[name("Heads")]];
  EquipmentItem body  [while (std::mem::read_signed($, 2) != -1)]  @ header.ptrs.bodyArmor  [[name("Chests")]];
  EquipmentItem arm   [while (std::mem::read_signed($, 2) != -1)]  @ header.ptrs.armArmor   [[name("Arms")]];
  EquipmentItem waist [while (std::mem::read_signed($, 2) != -1)]  @ header.ptrs.waistArmor [[name("Waists")]];
  EquipmentItem leg   [while (std::mem::read_signed($, 2) != -1)]  @ header.ptrs.legArmor   [[name("Legs")]];
};

TableEquipments tableEquipments;

u32 EquipmentLength        = sizeof(EquipmentItem);
u32 EquipmentHeadQuantity  = sizeof(tableEquipments.head)  / EquipmentLength;
u32 EquipmentBodyQuantity  = sizeof(tableEquipments.body)  / EquipmentLength;
u32 EquipmentArmQuantity   = sizeof(tableEquipments.arm)   / EquipmentLength;
u32 EquipmentWaistQuantity = sizeof(tableEquipments.waist) / EquipmentLength;
u32 EquipmentLegQuantity   = sizeof(tableEquipments.leg)   / EquipmentLength;
u32 EquipmentQuantity      = EquipmentHeadQuantity + EquipmentBodyQuantity + EquipmentArmQuantity + EquipmentWaistQuantity + EquipmentLegQuantity;

struct EquipmentHeads {
  EquipmentItem        data         [EquipmentHeadQuantity]  @ header.ptrs.headArmor      [[name("Data")]];
  EquipmentName        names        [EquipmentHeadQuantity]  @ header.ptrs.headArmorNames [[name("Names")]];
  EquipmentDescription descriptions [EquipmentHeadQuantity]  @ header.ptrs.equipDesc      [[name("Descriptions")]];
};

struct EquipmentBodies {
  EquipmentItem        data         [EquipmentBodyQuantity]  @ header.ptrs.bodyArmor      [[name("Data")]];
  EquipmentName        names        [EquipmentBodyQuantity]  @ header.ptrs.bodyArmorNames [[name("Names")]];
  EquipmentDescription descriptions [EquipmentBodyQuantity]  @ header.ptrs.equipDesc      [[name("Descriptions")]];
};

struct EquipmentArms {
  EquipmentItem        data         [EquipmentArmQuantity]   @ header.ptrs.armArmor       [[name("Data")]];
  EquipmentName        names        [EquipmentArmQuantity]   @ header.ptrs.armArmorNames  [[name("Names")]];
  EquipmentDescription descriptions [EquipmentArmQuantity]   @ header.ptrs.equipDesc      [[name("Descriptions")]];
};

struct EquipmentWaists {
  EquipmentItem        data         [EquipmentWaistQuantity] @ header.ptrs.waistArmor      [[name("Data")]];
  EquipmentName        names        [EquipmentWaistQuantity] @ header.ptrs.waistArmorNames [[name("Names")]];
  EquipmentDescription descriptions [EquipmentWaistQuantity] @ header.ptrs.equipDesc       [[name("Descriptions")]];
};

struct EquipmentLeg {
  EquipmentItem        data         [EquipmentLegQuantity]   @ header.ptrs.legArmor        [[name("Data")]];
  EquipmentName        names        [EquipmentLegQuantity]   @ header.ptrs.legArmorNames   [[name("Names")]];
  EquipmentDescription descriptions [EquipmentLegQuantity]   @ header.ptrs.equipDesc       [[name("Descriptions")]];
};

struct Equipments {
  EquipmentHeads  head  @ header.ptrs.headArmor  [[name("Heads")]];
  EquipmentBodies body  @ header.ptrs.bodyArmor  [[name("Chests")]];
  EquipmentArms   arm   @ header.ptrs.armArmor   [[name("Arms")]];
  EquipmentWaists waist @ header.ptrs.waistArmor [[name("Waists")]];
  EquipmentLeg    leg   @ header.ptrs.legArmor   [[name("Legs")]];
};

Equipments equipments @ header.ptrs.headArmor [[name("Equipments")]];
