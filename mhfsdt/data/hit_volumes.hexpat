#pragma once

#include <mhfsdt/utils/index.pat>

// =======================
// Hit volumes (Ghidra HitzoneInfo, same 0x28 layout as the monster hurtbox
// tables, walked by the same code). A list ends at transform_idx 0xFFFF.
// Attack lists: groups[A.group_index].slot0 becomes hit +0xA0 at shell init
// (hitbox_process_collision_shapes); hurtbox lists: process_hitbox_collision.
//
// Space (transform_hitbox): bone rows are local to the bone matrix (rotated,
// then + bone translation), radius x entity +0xB8 (monster size). Shell rows
// (0x77-0x7F) scale offsets and radius by slot +0xEC (Table B scale_pct x 0.01).
//
// Slots: every path reads slot0, except kind 100 (Tonfa, FUN_11204580:
// slot[(s8)PlayerWork +0xB28 % 3]) and kind 502 (shell_k502_shell_init:
// groups[1 + owner +0xDA8].slot[owner +0xDB0]); slots 3-7 are always copies.
// =======================

enum HitShape : u16 {
    Sphere  = 0, // pos1 + radius
    Capsule = 1  // pos1 -> pos2 + radius; any other value is skipped
};

bitfield HitVolumeFlags {
    padding : 2;
    not_hurtbox_04 : 1 [[comment("Excluded from every hurtbox scan (hitzone %, tonfa gauge, camera / body push, random bone pick)")]];
    weapon_matrix : 1 [[comment("Bone index is a weapon-model part (Tonfa / Switch Axe F / Magnet Spike), not a body bone")]];
    padding : 5;
    not_hurtbox_200 : 1 [[comment("Excluded from hurtbox scans (mask 0x1200)")]];
    excl_400 : 1 [[comment("Excluded with 0x1200 (mask 0x1600): tonfa gauge, random bone pick")]];
    padding : 1;
    not_hurtbox_1000 : 1 [[comment("Excluded from hurtbox scans (mask 0x1200)")]];
    padding : 3;
    hane_10000 : 1 [[comment("em_hane_ck bounce: with 0x20000 and em +0xCB1 > 0 returns 1; on em 0x70 also part flag 0x20000")]];
    hane_20000 : 1 [[comment("em_hane_ck (0x30000); excluded from camera / body push and the random bone pick")]];
    hane_40000 : 1 [[comment("em_hane_ck: with 0x80000 and em +0xCB0 > 0 returns 2")]];
    hane_80000 : 1 [[comment("em_hane_ck (0xC0000); excluded from camera / body push")]];
    hane_100000 : 1 [[comment("em_hane_ck: em +0xCB1 > 0 returns 8; excluded from camera / body push")]];
    padding : 3;
    excl_1000000 : 1 [[comment("Excluded from body push / proximity and the random bone pick")]];
    excl_2000000 : 1 [[comment("Excluded from camera push")]];
    excl_4000000 : 1 [[comment("Excluded from body push / proximity")]];
    padding : 5;
};

fn transform_fmt(s16 t) {
    if (t == -1) return "end";
    if (t < 0x76) return std::format("bone {}", t);
    match (t) {
        (0x77): return "shell anchor: capsule shell +0x38 -> +0x44, + pos1 x scale";
        (0x78): return "shell anchor: weapon bone + Y-rotated, pre-scaled pos";
        (0x79): return "shell anchor: weapon bone + Y-rotated pos";
        (0x7A): return "shell anchor: capsule shell +0x44 -> +0x50, + pos1";
        (0x7B): return "shell anchor: from shell +0x38";
        (0x7C): return "shell anchor: static at shell +0x44";
        (0x7D): return "group gate: skip the next hzv_index volumes when owner +0xB5C & shape";
        (0x7E): return "shell anchor: capsule shell +0x38 -> +0x44";
        (0x7F): return "shell anchor: static at shell +0x38, no rotation";
        (_): return "ignored (transform_hitbox returns -1)";
    }
};

struct HitVolume {
    s16 transform_idx [[color("42A5F5"), format("transform_fmt"), comment("< 0x76 bone (baseModel +0x24 + idx x 0x1C0); 0x77-0x7F shell anchors (hurtbox lists: entity xyz + pos1, unrotated, unscaled); 0x7D group gate; -1 end")]];
    if (transform_idx == 0x7D) {
        u16 gate_mask [[comment("Skip when owner / entity +0xB5C & gate_mask")]];
        u16 gate_count [[comment("Volumes skipped after this header")]];
    } else {
        HitShape shape;
        u16 hzv_index [[comment("Hurtbox: hitzone value row (get_hzvs); attack: sharp_col_b column 3 when == 1")]];
    }
    u16 part_index [[comment("Hurtbox: monster body part (part gauge +0xCF2 via mhfemd pTonfaGaugeGroup, & 7 for breakthrough / part break bonus)")]];
    HitVolumeFlags flags;
    float radius [[comment("x entity +0xB8 (bones) or slot +0xEC (shell anchors)")]];
    float pos1_x;
    float pos1_y;
    float pos1_z;
    float pos2_x [[comment("Capsule end")]];
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
    SlotRef<0> slot0 [[comment("Read by every shell init")]];
    SlotRef<1> slot1 [[comment("Kind 100: Tonfa style % 3 == 1; kind 502: owner +0xDB0 == 1")]];
    SlotRef<2> slot2 [[comment("Kind 100: Tonfa style % 3 == 2; kind 502: owner +0xDB0 == 2")]];
    SlotRef<3> slot3 [[comment("Unread (copy of slot0)")]];
    SlotRef<4> slot4 [[comment("Unread")]];
    SlotRef<5> slot5 [[comment("Unread")]];
    SlotRef<6> slot6 [[comment("Unread")]];
    SlotRef<7> slot7 [[comment("Unread (empty list in kind 442 group 17)")]];
};
