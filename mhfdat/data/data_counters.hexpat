#pragma once

struct Counters {
  u16 unk00 [[comment("82 on the 3 files = the u8 count of header 0xB08's list; no reader")]];
  u16 numRoadMonsterScales [[comment("header 0xB0C (em_hp_vital_set, em_calc_defense_mult, em_calc_flinch_value ...)")]];
  u16 numRoadCatShopItems [[comment("header 0xB10 (road_gm_shop_count_items / road_gm_shop_get_item, action 0xF9)")]];
  u16 roadRankCurveDwords [[comment("header 0xB14, a count of u32 (rows x 2)")]];
  u16 numRoadMonsterPoints [[comment("header 0xB20 (gGetRdp)")]];
  u16 unk0A [[comment("no reader")]];
  u16 unk0C [[comment("no reader")]];
  u16 numSoloRoadMonsterScales [[comment("header 0xB7C")]];
  u16 unk10 [[comment("no reader")]];
  u16 end [[comment("0: rd_mhfdat walks the u16 list up to it")]];
};

Counters counters @ header.ptrs.dataCounters [[name("Data")]];
