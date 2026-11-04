#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Diva Story gifts (header 0x7D0): the liking change of an item given to the
// Diva (divaStory_gift_liking). The item is looked up in the pairs; an item
// not listed takes the delta of the item 0 row. Liking (save +0x21327 +
// 0x1A81) stays in 0-999; the reaction text is 9 (up), 10 (no change), 11
// (down), 12 (999 reached) or 13 (0 reached). Important numbers + 0x2DE count
// u16 values, so the rows are half of it.
// =======================

struct DivaStoryGiftLiking {
    ItemId item [[comment("0: default row")]];
    s16 liking;
};

DivaStoryGiftLiking divaStoryGiftLiking[importantNums.numDivaStoryGiftLikingValues / 2] @ header.ptrs.divaStoryGiftLiking [[name("Diva Story Gift Liking")]];
