#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Hunting Info page (mhfpac pQuestCategoryNames[0x52] "Hunting Info"), "Item
// Info：" part (header 0x194, read by hunting_info_page_draw). One pointer per
// area (DLL list 0x119233F8: Jungle, Desert, Swamp, Snowy Mountains, Volcano,
// Forest & Hills), a second set of 6 in the DundormaGrandPriest stage, then 4
// null pointers. A table has one row per season (pSeasonNames: Warm, Cold,
// Breeding) with the 3 items shown by day, then the 3 shown by night.
// =======================

struct HuntingInfoSeasonItems {
    ItemId day[3];
    ItemId night[3];
};

struct HuntingInfoAreaItems {
    HuntingInfoSeasonItems bySeason[3];
};

struct HuntingInfoArea {
    HuntingInfoAreaItems *items : u32;
};

struct HuntingInfoItems {
    HuntingInfoArea byArea[6];
    HuntingInfoArea byAreaGrandPriest[6] [[comment("When the current stage is DundormaGrandPriest")]];
    padding[16];
};

HuntingInfoItems huntingInfoItems @ header.ptrs.huntingInfoItems [[name("Hunting Info Items")]];
