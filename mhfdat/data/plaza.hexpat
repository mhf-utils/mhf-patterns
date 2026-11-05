#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Plaza (world) HR ranges (header 0x1C4). snj_mhf_plaza_hr_check (Wii U name)
// takes the world type byte of a world entry (+0x1A, 1-6) and allows the move
// when the player's HR lies in [minHr, maxHr] or in [minHr2, maxHr2] of row
// type - 1; otherwise lb_check_world_condition shows mhfpac dialog 0xF
// "Insufficient Hunter Rank.". gCanEnterReturnWorld (world type 5, the return
// area) also refuses a player without G rank whose HR is below row 4 minHr
// (dialog 0x1DA). Rows 6 and 7 (16 bytes) are zero and never read.
// =======================
struct PlazaHrRange {
    s16 minHr;
    s16 maxHr;
    s16 minHr2;
    s16 maxHr2;
};

PlazaHrRange plazaHrRanges[6] @ header.ptrs.plazaHrRanges [[name("Plaza HR Ranges")]];
