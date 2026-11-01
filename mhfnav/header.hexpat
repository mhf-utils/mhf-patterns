#pragma once

#include <misc/types.pat>

const u32 HEADER_SIZE = 0x80;

struct mhfnav_header {
    ptr pTabs[14]               [[name("Navi Tabs Pointers")]];
    ptr pNaviConfig             [[name("Navi Config Pointer")]];
    u32 naviConfigCount         [[name("Number of Navi Config rows")]];
    ptr pDisplayOrder[14]       [[name("Display Order Pointers")]];
    ptr pGroupSlotMap           [[name("Group Slot Map Pointer")]];
    u8 groupSlotCount           [[name("Number of Group Slots")]];
    padding[3];
};

mhfnav_header header @ 0x00 [[name("mhfnav Header")]];
