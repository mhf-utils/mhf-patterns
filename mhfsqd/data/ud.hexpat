#pragma once

#include <mhfsqd/utils/index.pat>

struct UdRewardRateRow {
    float rate[5];
};

struct UdBoostItem {
    s16 itemId;
    u16 points;
    u16 contribMask;
};

struct SlotLevelEntry {
    s16 id;
    s16 level;
    Str pRes;
    u16 max_uses;
    u16 unk0A;
};

UdRewardRateRow rewardRates[counts.rewardRates] @ header.pRewardRates [[name("UD Reward Rates")]];
UdBoostItem boostItems[counts.boostItems] @ header.pBoostItems [[name("UD Boost Items")]];
SlotLevelEntry slotLevels[counts.slotLevels] @ header.pSlotLevels [[name("Slot Levels")]];
