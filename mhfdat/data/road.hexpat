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

struct RoadMilestone {
    u16 threshold;
    u16 add;
};

RoadMilestone roadMilestones[importantNums.numRoadMilestones]
    @ header.ptrs.roadMilestones
    [[name("Road Floor Milestones")]];
