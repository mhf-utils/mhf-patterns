#pragma once

#include <mhfgao/utils/index.pat>

struct TreasureCorpArea {
    u16 unk00;
    u16 areaId;
    u16 durationSeconds;
    u16 unk06;
    u8 unk08[10];
};

struct TreasureCorpGroup {
    u32 flags;
    u32 n = rd32($ + 4);
    Rows<TreasureCorpArea, n> *areas : u32;
    u32 areaCount;
};

struct WeightedItem {
    u16 itemId;
    u16 count;
    u32 weight;
};

struct WeightedItemList {
    u16 count;
    padding[2];
    Rows<WeightedItem, count> *items : u32;
};

struct WeightedItemListPair {
    u16 countA;
    padding[2];
    Rows<WeightedItem, countA> *itemsA : u32;
    u16 countB;
    padding[2];
    Rows<WeightedItem, countB> *itemsB : u32;
};

struct ThresholdItem {
    u32 threshold;
    u16 itemId;
    u16 count;
};

struct ThresholdItemList {
    u16 count;
    padding[2];
    Rows<ThresholdItem, count> *items : u32;
};

struct TreasureCorpRewardsByTier {
    u16 tierCount;
    padding[2];
    Rows<WeightedItemList, tierCount> *tiers : u32;
};

struct TreasureCorpRewardPairsByTier {
    u16 tierCount;
    padding[2];
    Rows<WeightedItemListPair, tierCount> *tiers : u32;
};

struct TreasureCorpBonusByTier {
    u16 tierCount;
    padding[2];
    Rows<ThresholdItemList, tierCount> *tiers : u32;
};

struct TreasureSpot {
    u8 unk00[4];
    Str name;
    float position[3];
    u8 unk14[40];
};

struct TreasureSpotList {
    u32 n = rd32($ + 4);
    Rows<TreasureSpot, n> *spots : u32;
    u32 count;
};

Rows<TreasureCorpGroup,header.treasureCorpGroupCount> pTreasureCorpGroups @ header.pTreasureCorpGroups;
Rows<TreasureSpotList,header.treasureSpotListCount> pTreasureSpotLists @ header.pTreasureSpotLists;
Rows<TreasureCorpRewardsByTier,header.treasureCorpRewardAreaCount> pTreasureCorpRewards @ header.pTreasureCorpRewards;
Rows<TreasureCorpRewardPairsByTier,header.treasureCorpRewardPairAreaCount> pTreasureCorpRewardPairs @ header.pTreasureCorpRewardPairs;
Rows<TreasureCorpBonusByTier,header.treasureCorpBonusAreaCount> pTreasureCorpBonusRewards @ header.pTreasureCorpBonusRewards;
