#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// G-rank gathering item overrides by quest star (headers 0x6E8 / 0x6E4 /
// 0x6EC for the 3rd argument 0 / 1 / 2 of item_gather_reward_grant;
// gather_star_item_override). Row = star - 1, the star from quest_star_level_get
// (the interception G stars of the main monster when quest variant2 bit 0x80
// is set, else the G star or the quest star, 1 at least). Two rolls: entry 0
// or 1 (1 in an area of type 1, g_area_desc_table), then entry 2 or 3; a roll
// below chance (percent) replaces the gathered item. 999 rows (stars 1-999).
// =======================

struct GatherStarItem {
    u16 item [[format("getItemName")]];
    u16 chance;
};

struct GatherStarItems {
    GatherStarItem entries[4];
};

GatherStarItems gatherStarItems0[999] @ header.ptrs.gatherStarItems0 [[name("Gather Star Items 0")]];
GatherStarItems gatherStarItems1[999] @ header.ptrs.gatherStarItems1 [[name("Gather Star Items 1")]];
GatherStarItems gatherStarItems2[999] @ header.ptrs.gatherStarItems2 [[name("Gather Star Items 2")]];
