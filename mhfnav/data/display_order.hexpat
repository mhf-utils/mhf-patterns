#pragma once

#include <mhfnav/utils/index.pat>
#include <mhfnav/header.hexpat>

enum NaviGroup : u8 {
    HR = 0,
    GR = 1,
    Other = 2
};

struct GroupSlotEntry {
    NaviGroup group;
    u8 tabId;
};

struct DisplayOrderRef {
    u8 *value : u32;
};

DisplayOrderRef displayOrder[14] @ addressof(header.pDisplayOrder) [[name("Display Order")]];
GroupSlotEntry groupSlotMap[header.groupSlotCount] @ header.pGroupSlotMap [[name("Group Slot Map")]];
