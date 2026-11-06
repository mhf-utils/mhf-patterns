#pragma once

/**
	Hunting Road: the points each monster gives (header 0xB20) and the Road
	skills (header 0x930). Their counts are u16s in counter blocks: +8 of the
	block header 0xB04 points to (data_counters.hexpat) for the monsters, +8 of
	the one header 0x910 points to (extra_counters.hexpat) for the skills.
	Both tables end at zero padding on ZZ (88 monsters, 66 skills).
	Road skill names are in mhfpac.bin, behind its header slot 0xD58, indexed by
	the skill id (0 is "None").
	Skill fields from ezemania2/mhf-file-editor; the monster point layout comes
	from BlazeMH/Blaze-Hunting-Road-Editor (GPL-3.0), as that editor credits.
	The Road cat shop (header 0xB10) is in shop_road_cat.hexpat.
	Floor milestones (header 0x64C, important numbers + 0x24A rows): when a
	Road run settles (road_settle_floor_score), every row whose threshold
	lies between the old and the new value adds `add` to a save counter
	(UserSaveData +146976), capped by header 0x648 +0x14.
*/

#include <std/core.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// Monster: id, flag, then its base points and those of Road levels 1 to 5
Monster roadMonsterPoints[std::mem::read_unsigned(header.ptrs.dataCounters + 8, 2)]
    @ header.ptrs.Road_Monster_Point_Value_Pointer
    [[name("Road Monster Points")]];

struct RoadSkillPrerequisite {
    u16 skill;
    u16 level;
};

struct RoadSkill {
    u16 skill;
    u16 level;
    u16 category;
    u16 description;
    u16 sortKey;
    u16 unk0A;
    u32 cost;
    u16 roadRank            [[comment("Road rank needed")]];
    u16 roadPoints;
    u16 icon;
    RoadSkillPrerequisite prerequisites[4];
    u16 unk26;
} [[name(std::format("{} Lv{}", skill, level))]];

RoadSkill roadSkills[std::mem::read_unsigned(header.ptrs.extraCounters + 8, 2)]
    @ header.ptrs.roadSkills
    [[name("Road Skills")]];

// Second Road skill table (header 0x934, count header 0x910 block +0x0A): read
// only by road_skills_result_cost_sum, which the Road result
// (road_result_update) uses: the cost of every level learned in the run (game
// work +0x3354, 64 skills) is added to game work +0x3350 into the result, then
// the levels are cleared. Same row layout as roadSkills; 77 rows on ZZ (66 in
// 0x930), the same cost for the skill levels both tables hold.
RoadSkill roadSkillsResultCosts[std::mem::read_unsigned(header.ptrs.extraCounters + 0x0A, 2)]
    @ header.ptrs.roadSkillsResultCosts
    [[name("Road Skills (Result Costs)")]];

struct RoadMilestone {
    u16 threshold;
    u16 add;
};

RoadMilestone roadMilestones[importantNums.numRoadMilestones]
    @ header.ptrs.roadMilestones
    [[name("Road Floor Milestones")]];

// =======================
// Monster scaling by Road floor (header 0xB0C: multiplayer Road, 0xB7C: the
// solo Road quest 0x5C4C), read by em_calc_attack_mult (through
// road_monster_scale_get), em_calc_defense_mult, em_calc_flinch_value,
// em_hp_vital_set, em_torabasami_dmg_timer_set and em_ana_loop_timer_set in a
// Road quest (variant2 & 0x80). The first row with maxFloor >= the current
// floor (0x1E87FAF0) applies, else the last row. Row counts: dataCounters
// +0x02 and +0x0E. Proofs: tools/mhfdat_re/data/b0c_b4c_954_notes.md.
// =======================

struct RoadMonsterScale {
    u8 maxFloor;
    u8 gap01[3];
    float attack [[comment("em_calc_attack_mult")]];
    float defense [[comment("em_calc_defense_mult")]];
    float flinch [[comment("em_calc_flinch_value")]];
    float trapTime [[comment("em_torabasami_dmg_timer_set")]];
    float pitfallTime [[comment("em_ana_loop_timer_set")]];
};

struct SoloRoadMonsterScale {
    u8 maxFloor;
    u8 gap01[3];
    float hp [[comment("em_hp_vital_set")]];
    float attack [[comment("em_calc_attack_mult")]];
    float defense [[comment("em_calc_defense_mult")]];
    float flinch [[comment("em_calc_flinch_value")]];
    float trapTime [[comment("em_torabasami_dmg_timer_set")]];
    float pitfallTime [[comment("em_ana_loop_timer_set")]];
};

RoadMonsterScale roadMonsterScales[std::mem::read_unsigned(header.ptrs.dataCounters + 0x02, 2)] @ header.ptrs.roadMonsterScales [[name("Road Monster Scales"), comment("no HP field: em_hp_vital_set scales HP only in the solo Road quest 0x5C4C (0xB7C); its 0xB0C fallback is unreachable")]];
SoloRoadMonsterScale soloRoadMonsterScales[std::mem::read_unsigned(header.ptrs.dataCounters + 0x0E, 2)] @ header.ptrs.soloRoadMonsterScales [[name("Solo Road Monster Scales")]];

// Zenith monster scale on Road (header 0xB80: the solo Road quest 0x5C4C;
// header 0xB24: any other Road quest), returned by
// road_zenith_monster_scale_get. The six readers apply it after the floor scale
// (0xB0C / 0xB7C) when the quest is a Road quest (variant2 & 0x80, not Musou
// Dure, not 0x54E3 / 0x54F2-0x54F8) and em_variation_check(monster, 0x10) is 1.
struct RoadZenithMonsterScale {
    float hp [[comment("em_hp_vital_set")]];
    float attack [[comment("em_calc_attack_mult")]];
    float defense [[comment("em_calc_defense_mult")]];
    float flinch [[comment("em_calc_flinch_value")]];
    float trapTime [[comment("em_torabasami_dmg_timer_set")]];
    float pitfallTime [[comment("em_ana_loop_timer_set")]];
};

RoadZenithMonsterScale soloRoadZenithMonsterScale @ header.ptrs.soloRoadZenithMonsterScale [[name("Solo Road Zenith Monster Scale")]];
RoadZenithMonsterScale roadZenithMonsterScale @ header.ptrs.roadZenithMonsterScale [[name("Road Zenith Monster Scale")]];

// Road rank curve (header 0xB14): turns the saved Road Rank Points (ctx [1] +
// 0xAE, "Rd RP") into the Road Rank 1-999 ("RdP"). road_rank_points_needed(N)
// sums pointsPerRank over the rank steps 1..N-1, moving to the next row when
// the step reaches untilRank (last row kept); road_rank_from_points gives 1 for
// 0 points and caps at 999. The row count is dataCounters + 6 / 2 (that u16
// counts u32: every reader shifts it right by 1). Used by the Road Basic Info
// page, road_skill_can_unlock (skill +0x10) and the end-of-run rank-up.
struct RoadRankStep {
    s32 untilRank;
    s32 pointsPerRank;
};

RoadRankStep roadRankCurve[std::mem::read_unsigned(header.ptrs.dataCounters + 6, 2) / 2] @ header.ptrs.roadRankCurve [[name("Road Rank Curve")]];

// Road suspended cameras (header 0xB28): the fixed camera of the local player
// once road_points_suspended_ck is non zero on a variant2 & 0x80 quest (a
// player ran out of revives: player_no_more_revives_enter sets 0x1E87FBEC to 1,
// FUN_10A6B9C0 to 2, then player_structs_array_tick forces faint category 3
// action 0xE). road_suspended_camera_apply, called each frame by category 3
// actions 0xE and 0xF, copies the row into active_camera_pos_* /
// active_camera_target_* and sets camera_control_flags bit 0x20. The row index
// (0x1E87FBF4) is written by road_quest_area_update: 0 when the player's stage
// area equals the quest's returnBC_ID (GameWork +0x38), 1 otherwise.
struct RoadSuspendedCamera {
    float position[3];
    float target[3];
};

struct RoadSuspendedCameras {
    RoadSuspendedCamera returnStage [[comment("Player stage area == quest returnBC_ID")]];
    RoadSuspendedCamera otherStage [[comment("Any other stage area")]];
};

RoadSuspendedCameras roadSuspendedCameras @ header.ptrs.roadSuspendedCameras [[name("Road Suspended Cameras")]];
