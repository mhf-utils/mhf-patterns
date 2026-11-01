#pragma once

#include <misc/types.pat>

const u32 HEADER_SIZE = 0x3C;

struct ptr_table {
    ptr pSubHeader          [[name("Entry Counts Pointer")]];
    ptr pParamBlock         [[name("Param Block Pointer")]];
    ptr pRewardRates        [[name("UD Reward Rates Pointer")]];
    ptr pBoostItems         [[name("UD Boost Items Pointer")]];
    ptr pSlotLevels         [[name("Slot Levels Pointer")]];
    ptr pCategoryStrings    [[name("Prayer Strings Pointer")]];
    ptr pEventEntries       [[name("Skill Shop Pointer")]];
    ptr pActiveMonsters     [[name("Active Monsters Pointer")]];
    ptr pFollowerWeapons    [[name("Follower Weapons Pointer")]];
    ptr pFollowerRanks      [[name("Follower Ranks Pointer")]];
    ptr pFollowerNames      [[name("Follower Names Pointer")]];
    ptr pFollowerLoadouts   [[name("Follower Loadouts Pointer")]];
    ptr pFollowerSkills     [[name("Follower Skills Pointer")]];
    ptr pSection13          [[name("Section 13 Pointer")]];
    ptr pSection14          [[name("Section 14 Pointer")]];
    padding[4];
};

struct SqdCounts {
    u16 paramBlock;
    u16 rewardRates;
    u16 boostItems;
    u16 slotLevels;
    u16 categoryStrings;
    u16 eventEntries;
    u16 activeMonsters;
    u16 followerWeapons;
    u16 followerRanks;
    u16 followerNames;
    u16 followerLoadouts;
    u16 followerSkills;
    u16 section13;
    u16 section14;
    padding[4];
};

ptr_table header @ 0x00 [[name("Top level pointer table")]];
SqdCounts counts @ header.pSubHeader [[name("Entry Counts")]];
