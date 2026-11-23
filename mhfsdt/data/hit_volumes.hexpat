#pragma once

#include <mhfsdt/utils/index.pat>

// =======================
// Hit volumes (Ghidra HitzoneInfo, same 0x28 layout as the monster hurtbox
// tables, walked by the same code). A list ends at transform_idx 0xFFFF.
// Attack lists: groups[A.group_index].slot0 becomes hit +0xA0 at shell init
// (hitbox_process_collision_shapes); hurtbox lists: process_hitbox_collision.
//
// Space (transform_hitbox): bone rows are local to the bone matrix (rotated,
// then + bone translation), radius x entity scaleX (monster size). Shell rows
// (0x77-0x7F) scale offsets and radius by slot +0xEC (Table B scale_pct x 0.01).
//
// Slots: every path reads slot0, except kind 100 (Tonfa, FUN_11204580:
// slot[(s8)PlayerWork +0xB28 % 3]) and kind 502 (shell_k502_shell_init:
// groups[1 + owner +0xDA8].slot[owner +0xDB0]); slots 3-7 are always copies.
//
// Each group shows "kind K group G | rows R... | users of the first row": the Table A rows
// whose group_index is G, so the attack / move the volumes belong to.
// =======================

enum HitShape : u16 {
    Sphere  = 0, // pos1 + radius
    Capsule = 1  // pos1 -> pos2 + radius; any other value is skipped
};

bitfield HitVolumeFlags {
    padding : 2;
    no_hurtbox : 1 [[comment("Excluded from every hurtbox scan (hitzone %, tonfa gauge, camera / body push, random bone pick)")]];
    weapon_matrix : 1 [[comment("Bone index is a weapon-model part (Tonfa / Switch Axe F / Magnet Spike), not a body bone")]];
    padding : 5;
    hurtbox_skip_low : 1 [[comment("0x200: excluded from hurtbox scans; always tested together with hurtbox_skip_high (mask 0x1200)")]];
    no_gauge_no_bone_pick : 1 [[comment("0x400: excluded, with 0x1200 (mask 0x1600), from the tonfa gauge and the random bone pick")]];
    padding : 1;
    hurtbox_skip_high : 1 [[comment("0x1000: excluded from hurtbox scans; always tested together with hurtbox_skip_low (mask 0x1200)")]];
    padding : 3;
    hane_deflect : 1 [[comment("em_hane_ck: weapon deflect (result 1) while EnemyWork.em_haneTimer > 0 (mask 0x30000); on Giaorugu also part flag 0x20000")]];
    hane_deflect_no_push : 1 [[comment("Same deflect as hane_deflect (mask 0x30000); also excluded from camera / body push and the random bone pick")]];
    guard_hane_deflect : 1 [[comment("em_hane_ck: weapon deflect (result 2) while EnemyWork.em_guardHaneTimer > 0 (mask 0xC0000)")]];
    guard_hane_deflect_no_push : 1 [[comment("Same deflect as guard_hane_deflect (mask 0xC0000); also excluded from camera / body push")]];
    hane_deflect_result_8 : 1 [[comment("em_hane_ck: result bit 8 (tested apart from 1 / 2 by the hit code) while EnemyWork.em_haneTimer > 0; excluded from camera / body push")]];
    padding : 3;
    no_body_push_no_bone_pick : 1 [[comment("Excluded from body push / proximity and the random bone pick")]];
    no_camera_push : 1 [[comment("Excluded from camera push")]];
    no_body_push : 1 [[comment("Excluded from body push / proximity")]];
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
        (0x7D): return "group gate: skip the next volumes when EnemyWork.em_partBits & gate_mask";
        (0x7E): return "shell anchor: capsule shell +0x38 -> +0x44";
        (0x7F): return "shell anchor: static at shell +0x38, no rotation";
        (_): return "ignored (transform_hitbox returns -1)";
    }
};

struct HitVolume {
    s16 transform_idx [[color("42A5F5"), format("transform_fmt"), comment("< 0x76 bone (baseModel +0x24 + idx x 0x1C0); 0x77-0x7F shell anchors (hurtbox lists: entity xyz + pos1, unrotated, unscaled); 0x7D group gate; -1 end")]];
    if (transform_idx == 0x7D) {
        u16 gate_mask [[comment("Skip when EnemyWork.em_partBits & gate_mask")]];
        u16 gate_count [[comment("Volumes skipped after this header")]];
    } else {
        HitShape shape;
        u16 hzv_index [[comment("Hurtbox: hitzone value row (get_hzvs); attack: sharp_col_b column 3 when == 1")]];
    }
    u16 part_index [[comment("Hurtbox: monster body part (EnemyWork.em_partGauge via mhfemd pTonfaGaugeGroup, & 7 for breakthrough / part break bonus)")]];
    HitVolumeFlags flags;
    float radius [[comment("x entity scaleX (bones) or slot +0xEC (shell anchors)")]];
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

/// Table A rows of the descriptor at o whose group_index is g, as "rows a, b, c | users of a"
fn group_rows(u32 o, u32 g) {
    u32 a = rd32(o + 0x08);
    u32 n = rd16(o + 0x04);
    str rows = "";
    u32 first = 0xFFFFFFFF;
    u32 shown = 0;
    if (a == 0)
        return "no Table A";
    for (u32 i = 0, i < n, i = i + 1) {
        if (rd16(a + i * ROW_A_SIZE + 0x10) == g) {
            if (first == 0xFFFFFFFF)
                first = i;
            if (shown < 8)
                rows = rows + (shown == 0 ? "" : ", ") + std::format("{}", i);
            shown = shown + 1;
        }
    }
    if (shown == 0)
        return "no Table A row uses it";
    if (shown > 8)
        rows = rows + std::format(" +{}", shown - 8);
    return std::format("rows {} | {}", rows, row_owner(kind_at(o), first));
};

fn group_fmt(ref auto g) {
    return std::format("kind {} group {} | {}", g.kind, g.group, group_rows(g.owner, g.group));
};

struct GroupSlots {
    u32 owner = owner_descriptor($, 0x10, 0x06, 2, GROUP_SLOTS_SIZE);
    s16 kind = kind_at(owner);
    u32 group = (owner == 0xFFFFFFFF) ? 0 : ($ - rd32(owner + 0x10)) / GROUP_SLOTS_SIZE;
    SlotRef<0> slot0 [[comment("Read by every shell init")]];
    SlotRef<1> slot1 [[comment("Kind 100: Tonfa style % 3 == 1; kind 502: owner +0xDB0 == 1")]];
    SlotRef<2> slot2 [[comment("Kind 100: Tonfa style % 3 == 2; kind 502: owner +0xDB0 == 2")]];
    SlotRef<3> slot3 [[comment("Unread (copy of slot0)")]];
    SlotRef<4> slot4 [[comment("Unread")]];
    SlotRef<5> slot5 [[comment("Unread")]];
    SlotRef<6> slot6 [[comment("Unread")]];
    SlotRef<7> slot7 [[comment("Unread (empty list in kind 442 group 17)")]];
} [[format("group_fmt")]];
