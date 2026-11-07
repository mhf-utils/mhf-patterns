#pragma once

#include <misc/s32p.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Public Bar recruit choices (mhfpac pPublicBarTexts: "Recruit Members",
// "HR Reqs:", "Target：", "Message："; rank_list_draw_premium_room_detail prints
// each label then the chosen row). HR Reqs are looked up by id (+0xE); when the
// id is not found the readers return the row after the counted ones (the default
// row). Targets have unlock requirements; the player's HR is save +0x1FCD6
// (XOR-encoded).
// =======================

enum PublicBarRankKind : s8 {
    Hr = 0,
    SrHighest = 1, // sr_get_highest_rank
    GRank = 2 // get_g_class_rank
};

struct PublicBarHrReq {
    s32p shortText;
    s32p longText;
    PublicBarRankKind rankKind;
    u8 unk09;
    u16 minRank;
    u16 unk0C;
    u16 id;
    u8 listMask [[comment("FUN_1155C8E0 / FUN_1155C980 list the row when (listMask & mask) != 0: mask 1 from FUN_103F9610, FUN_103F9770, FUN_103FC950; mask 2 from FUN_103FA120, rank_list_draw_premium_room_detail")]];
    padding[3];
};

struct PublicBarMessage {
    s32p text;
    u8 textColor [[comment("rank_list_draw_search_criteria_panel: < 0x20 gFlFntSetPalette id, 0x20-0x55 colour table 0x1185DD70; also byte 0 of the room search request (guild_search_pack_request)")]];
    u8 notSelectable [[comment("Non-zero: choosing the row in rank_list_search_criteria_tick does nothing")]];
    u8 phaseMask [[comment("Bit (g_ud_slot_phase_id - 1) must be set to list it")]];
    u8 flags [[comment("Bit 0: listed")]];
};

enum PublicBarTargetRequirement : u8 {
    None = 0,
    MinHr = 1, // HR >= minHr
    MinHr2AndSaveCount = 2, // FUN_10BADFE0(minHrOrMonster) = 0 (the monster's two save counters not both 0) and HR >= minHr2
    EventFlag = 3, // FUN_10BA2DC0(0xC4)
    Mode = 4, // off_10474978 +0xCF79 is 1 or 2
    EventFlag5 = 5, // FUN_10BA2DC0(0x122)
    EventFlagAndSaveCount = 6 // FUN_10BA2DC0(0x122) and FUN_10BADFE0(minHrOrMonster) = 0
};

struct PublicBarTarget {
    s32p text;
    u8 visible;
    PublicBarTargetRequirement requirement;
    u16 minHrOrMonster [[comment("Requirement 1: minimum HR; 2 and 6: monster id passed to FUN_10BADFE0")]];
    u16 minHr2 [[comment("Requirement 2 only")]];
    u8 flags [[comment("Bit 0: enabled")]];
    u8 unk0B;
};

PublicBarHrReq publicBarHrReqs[importantNums.numPublicBarHrReqs + 1] @ header.ptrs.publicBarHrReqs [[name("Public Bar HR Reqs")]];
PublicBarMessage publicBarMessages[importantNums.numPublicBarMessages] @ header.ptrs.publicBarMessages [[name("Public Bar Messages")]];
PublicBarTarget publicBarTargets[importantNums.numPublicBarTargets] @ header.ptrs.publicBarTargets [[name("Public Bar Targets")]];
