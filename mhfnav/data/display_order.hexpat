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

u8 displayOrder[14] @ header.pDisplayOrder [[name("Display Order"), comment("Tab indexes in display order")]];
GroupSlotEntry groupSlotMap[header.groupSlotCount] @ header.pGroupSlotMap [[name("Group Slot Map")]];
