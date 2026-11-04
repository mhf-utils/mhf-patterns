#pragma once

#include <misc/s32p.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Party recruit filters: the rank condition, goal and quest type choices of a
// room / party search. Rank conditions are looked up by id (+0xE); when the id is
// not found the readers return the row after the counted ones (the default row).
// The player's HR is save +0x1FCD6 (XOR-encoded).
// =======================

enum RecruitRankKind : u8 {
    Hr = 0,
    SrHighest = 1, // sr_get_highest_rank
    GRank = 2 // get_g_class_rank
};

struct RecruitRankCondition {
    s32p shortText;
    s32p longText;
    RecruitRankKind rankKind;
    u8 unk09;
    u16 minRank;
    u16 unk0C;
    u16 id;
    u32 unk10;
};

struct RecruitGoal {
    s32p text;
    u16 unk04;
    u8 phaseMask [[comment("Bit (g_ud_slot_phase_id - 1) must be set to list it")]];
    u8 flags [[comment("Bit 0: listed")]];
};

enum RecruitQuestTypeRequirement : u8 {
    None = 0,
    MinHr = 1, // HR >= minHr
    MinHr2AndSaveCount = 2, // FUN_10BADFE0 = 0 (save counters of the id not both 0) and HR >= minHr2
    EventFlag = 3,
    Mode = 4, // off_10474978 +0xCF79 is 1 or 2
    EventFlag5 = 5,
    EventFlagAndSaveCount = 6 // event flag and FUN_10BADFE0 = 0
};

struct RecruitQuestType {
    s32p text;
    u8 visible;
    RecruitQuestTypeRequirement requirement;
    u16 minHr;
    u16 minHr2;
    u8 flags [[comment("Bit 0: enabled")]];
    u8 unk0B;
};

RecruitRankCondition recruitRankConditions[importantNums.numRecruitRankConditions + 1] @ header.ptrs.recruitRankConditions [[name("Recruit Rank Conditions")]];
RecruitGoal recruitGoals[importantNums.numRecruitGoals] @ header.ptrs.recruitGoals [[name("Recruit Goals")]];
RecruitQuestType recruitQuestTypes[importantNums.numRecruitQuestTypes] @ header.ptrs.recruitQuestTypes [[name("Recruit Quest Types")]];
