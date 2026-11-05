#pragma once
#include <misc/s32p.pat>
#include <mhfdat/data/equipment_counts.hexpat>

bitfield equipableBy {
  isMaleEquip:   1;
  isFemaleEquip: 1;
  isBladeEquip:  1;
  isGunnerEquip: 1;
  unkBit4:       1 [[comment("FUN_104fe940 (forge lists; weapon counterpart equipType 0x20); never set")]];
  isSPEquip:     1 [[comment("hunterNavi_ck_01_09_sp_armor_worn")]];
  isGouEquip:    1 [[comment("hunterNavi_ck_01_12_gou_equipment, count_armor_equipable_gou")]];
  unkBit7:       1 [[comment("partner_category_stat_get: category value +0x04")]];
};

bitfield armorTypes {
    gArmorF : 1;
    hidenGroup1 : 1 [[comment("armor_get_armor_type_group_1based -> 1")]];
    hidenGroup2 : 1 [[comment("-> 2")]];
    hidenBit3 : 1 [[comment("read only as mask 0x18 (armor_check_weap_hiden_type_group_match)")]];
    hidenBit4 : 1;
    hidenWildcard : 1 [[comment("with bits 3-4 clear and level > 5: matches the requested hiden group")]];
    Grank : 1;
    supremacy : 1;
    hcKai : 1;
    gClassS : 1;
    hidenGroup3 : 1;
    hidenGroup4 : 1;
    hidenGroup5 : 1;
    hidenGroup6 : 1;
    gHasyu : 1;
    retsusyu : 1;
    gx_supremacy : 1;
    towerStoneCapable : 1 [[comment("is_tower_armor_stone_capable; slot count at +0x39")]];
    exotic : 1;
    zenith : 1;
    padding : 12;
};

bitfield appFlags {
    appSelectable : 1 [[comment("FUN_1052cef0 (Lb_equip_app_shop_move): clear = cannot be picked as an appearance")]];
    appPriceInGz : 1 [[comment("Check_equip_app_buy / FUN_10535600: pay appPrice in GZ instead of zenny")]];
    padding : 6;
};

struct EquipmentItem {
  s16 modelIdMale;
  s16 modelIdFemale;
  equipableBy bitfld;
  u8 rarity [[comment("Get_equip_rare: & 0xF")]];
  u8 maxLevel;
  u8 slotUpgradeRow [[comment("Row of the armor slot upgrades (header 0xBC), max 15")]];
  u8 armorSoundMale [[comment("sound = 2 x value + random 0/1; 0 = none")]];
  u8 armorSoundFemale;
  u8 colorFlagsMale [[comment("bit 0: dyeable (header 0x140); bits 1-2: render part 1 alpha off")]];
  u8 colorFlagsFemale;
  u32 zennyCost;
  u16 sortOrder [[comment("equip_sort_value: box sort key << 20")]];
  u16 baseDefense;

  s8 fireRes;
  s8 waterRes;
  s8 thunderRes;
  s8 dragonRes;
  s8 iceRes;

  u8 coefUpgrade [[comment("Row of the armor defense coefficients (header 0xB4)")]];
  u8 upgradeCostRow [[comment("Row of the armor upgrade cost percents (header 0xB8)")]];

  u8 baseSlots;
  u8 maxSlots;

  u8 PostFesti;
  u8 ShowNextLevel [[comment("Upgrade targets shown when ShowNextLevel <= level + 1")]];
  u8 unk1F [[comment("no reader")]];
  u16 EquipID [[
    name("Upgrade to Equipment ID 1")
  ]];
  u16 EquipID2 [[
    name("Upgrade to Equipment ID 2")
  ]];
  u16 EquipID3 [[
    name("Upgrade to Equipment ID 3")
  ]];
  u16 Effect_ID [[comment("Row of the weapon effect sets (header 0x280)")]];
  u16 UpgradeID [[comment("Row of the armor upgrade materials")]];

  u8 skillId1; s8 skillPts1;
  u8 skillId2; s8 skillPts2;
  u8 skillId3; s8 skillPts3;
  u8 skillId4; s8 skillPts4;
  u8 skillId5; s8 skillPts5;

  armorTypes armorType;

  u8 weapHiden [[comment("Hiden weapon type + 1, 0 = none")]];
  u8 towerStoneSlots [[comment("get_tower_armor_stone_slot_count (armorType bit 17)")]];
  u16 decoItemID [[comment("get_armor_deco_no: decoration from armor conversion")]];
  u16 gRarity [[comment("get_equip_g_rarity: G rarity of G-class pieces, shown in place of rarity; each piece below the GR tier adds 20 defense per tier")]];
  u8 unk3E [[comment("no reader")]];
  u8 modelGroup [[comment("Get_equip_model_grp (was ZeroF): 9 adds -so to the parts file")]];
  u32 appPrice;
  appFlags appFlags;
  u8 unk45 [[comment("no reader")]];
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
