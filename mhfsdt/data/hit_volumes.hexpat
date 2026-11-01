#pragma once

#include <mhfsdt/utils/index.pat>

struct HitVolume {
    s16 transform_idx [[color("42A5F5")]];
    u16 shape;
    u16 hzv_index;
    u16 part_index;
    u32 flags;
    float radius;
    float pos1_x;
    float pos1_y;
    float pos1_z;
    float pos2_x;
    float pos2_y;
    float pos2_z;
};

struct NodeList {
    HitVolume volumes[while(rd16($) != 0xFFFF)];
    u16 terminator [[color("E53935")]];
};

/// Whether the slot at p (index i in its group) should be followed.
/// Unless LINK_ALL_SLOTS is set, slots duplicating an earlier one are left as raw offsets.
fn slotLinked(u32 p, u32 i) {
    if (rd32(p) == 0)
        return false;
    if (LINK_ALL_SLOTS)
        return true;
    for (u32 j = 1, j <= i, j = j + 1)
        if (rd32(p) == rd32(p - 4 * j))
            return false;
    return true;
};

struct SlotRef<auto I> {
    if (slotLinked($, I))
        NodeList *list : FileOffset;
    else
        FileOffset none;
};

struct GroupSlots {
    SlotRef<0> slot0;
    SlotRef<1> slot1;
    SlotRef<2> slot2;
    SlotRef<3> slot3;
    SlotRef<4> slot4;
    SlotRef<5> slot5;
    SlotRef<6> slot6;
    SlotRef<7> slot7;
};
