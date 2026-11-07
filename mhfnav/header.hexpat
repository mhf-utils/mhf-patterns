#pragma once

#include <misc/types.pat>

const u32 HEADER_SIZE = 0x80;

struct mhfnav_header {
    ptr pTabs                   [[name("Navi Tabs Pointer"), comment("One pointer to the 14 tabs (rd_mhfnav relocates +0x00 once and walks 14 tabs of 0x24)")]];
    ptr pNaviConfig             [[name("Navi Config Pointer")]];
    u32 naviConfigCount         [[name("Number of Navi Config rows")]];
    ptr pDisplayOrder           [[name("Display Order Pointer"), comment("One pointer to 14 tab indexes (a permutation of 0-13)")]];
    ptr pGroupSlotMap           [[name("Group Slot Map Pointer")]];
    u8 groupSlotCount           [[name("Number of Group Slots")]];
    padding[3];
};

mhfnav_header header @ 0x00 [[name("mhfnav Header")]];
