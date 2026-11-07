#pragma once

struct ExtraCounters {
  u16 numFelyneGmShopItems [[comment("header 0x90C (road_gm_shop_count_items / road_gm_shop_get_item)")]];
  u16 unk02 [[comment("16 = the stock weights at header 0x920, but em134_init loops a constant 0x10; no reader")]];
  u16 numBlueNpcGmShopItems [[comment("header 0x924")]];
  u16 unk06 [[comment("36 = the towerSkills rows (header 0x928, indexed by skill id); no reader")]];
  u16 numRoadSkills [[comment("header 0x930 (road_skill_lookup_def, road_skill_get_max_level)")]];
  u16 numRoadSkillsResultCosts [[comment("header 0x934")]];
  u16 numTowerUpgradeCostTables [[comment("header 0x93C (rd_mhfdat)")]];
  u16 numTowerMedalShopItems [[comment("header 0x948 (tower_medal_shop_find_entry, FUN_103841E0, FUN_10384CB0)")]];
  u16 unk10 [[comment("no reader")]];
  u16 unk12 [[comment("no reader")]];
  u16 end [[comment("0: rd_mhfdat walks the u16 list up to it")]];
};

ExtraCounters extraCounters @ header.ptrs.extraCounters [[name("Extra Counters")]];
