#pragma once

/**
	Caravan: voyage routes and the levels that list them, ranking routes,
	gem skills (hunter pearls) and their tiers.
	Layouts from ezemania2/mhf-file-editor; counts and ends checked on the ZZ JP
	and EN files: 111 voyage routes (their texts are inline Shift-JIS, still
	Japanese in the EN file; the bytes after them belong to the tables header
	0x16C and 0x1D4-0x228 point to, some with a non-zero byte where a title
	would be: an empty title alone would read 115), 15 levels, 11 ranking
	groups of up to 12 routes,
	108 gem skills, 9 tiers. The levels and tiers end at zero padding.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <misc/s32p.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Voyage routes (header 0x22C): 0xA1C bytes each, until an empty title or the
// next table
// =======================

struct VoyageLeg {
    s32  quest;
    char map[64];
    char time[64];
    char target[64];
};

struct VoyageRoute {
    u32   fee;
    u32   rewardMoney;
    u32   rewardPoints          [[comment("Caravan points")]];
    u16   rewardItem            [[format("getItemName")]];
    u16   rewardQuantity;
    u16   reputation;
    u16   unk12;
    u16   hrToPost;
    u16   hrToJoin;
    float pointBonus;
    float monsterHp;
    float monsterAttack;
    float monsterDefense;
    u16   finalTrial;
    u16   unk2A;
    char  title[64];
    char  success[64];
    char  failure[64];
    VoyageLeg legs[12];
};

VoyageRoute caravanVoyageRoutes[while(std::mem::read_unsigned($ + 0x2C, 1) != 0 && $ + 0xA1C <= nextTable(header.ptrs.caravanVoyageRoutes))]
    @ header.ptrs.caravanVoyageRoutes
    [[name("Caravan Voyage Routes")]];

// Caravan levels (header 0x230): 15 levels of 12 voyage route indexes, -1 for none
struct CaravanLevel {
    s32 routes[12];
};

CaravanLevel caravanLevels[15] @ header.ptrs.caravanLevels [[name("Caravan Levels")]];

// =======================
// Ranking routes (header 0x91C): 16 group pointers (important numbers + 0x370
// of them used), each to up to 12 routes of 0x10C bytes ending at a null title
// =======================

struct RankingLeg {
    s32  quest;
    s32p map;
    s32p time;
    s32p target;
};

struct RankingRoute {
    s32p  title;
    s32p  success;
    s32p  failure;
    u16   route;
    u16   group;
    s32   fee;
    s32   rewardMoney;
    s32   rewardPoints;
    u16   rewardItem            [[format("getItemName")]];
    u16   unk1E;
    u16   unk20;
    u16   rewardQuantity;
    u32   unk24;
    u16   rankType;
    u16   hrToPost;
    u16   hrToJoin;
    u16   unk2E;
    float carveBonus;
    float gatherBonus;
    s32   hunterTitle;
    s32   extraMission;
    float monsterHp;
    float monsterAttack;
    float monsterDefense;
    RankingLeg legs[12];
};

fn rankingRouteCount(u32 at) {
    u32 n = 0;
    while (n < 12 && std::mem::read_unsigned(at + n * 0x10C, 4) != 0) n += 1;
    return n;
};

struct RankingGroup {
    RankingRoute routes[rankingRouteCount($)];
};

ptVar<RankingGroup> caravanRankingGroups[16]
    @ header.ptrs.caravanRankingRoutes
    [[name("Caravan Ranking Routes")]];

// =======================
// Gem skills (header 0xF0): 0x30 bytes each until a skill id of -1; one list
// of skill ids per tier (header 0xF4, important numbers + 0x5E lists, each
// ending at -1); the tiers (header 0x234), one row more than the lists: the
// unlock requirement of tier t is the last byte of row t + 1.
// =======================

struct GemSkill {
    s16 skill;
    s16 level                   [[comment("Only the low byte is read")]];
    u8  unk04[4];
    u16 points[8]               [[comment("Caravan points needed on each of the 8 counters")]];
    u8  unk18[24];
};

GemSkill gemSkills[while(std::mem::read_signed($, 2) != -1)]
    @ header.ptrs.hunterPearlSkills
    [[name("Gem Skills")]];

struct GemSkillList {
    s16 skills[while(std::mem::read_signed($, 2) != -1)];
};

ptVar<GemSkillList> gemSkillLists[importantNums.numHunterPearlSkillLists]
    @ header.ptrs.hunterPearlSkillLists
    [[name("Gem Skill Lists")]];

struct CaravanTier {
    u8  unk00[4];
    u16 pointCap;
    u8  percent;
    u8  previousTierUnlock      [[comment("The unlock requirement of the tier before this row's")]];
};

CaravanTier caravanTiers[importantNums.numHunterPearlSkillLists + 1]
    @ header.ptrs.caravanTiers
    [[name("Caravan Tiers")]];
