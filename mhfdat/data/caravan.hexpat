#pragma once

/**
	Caravan: voyage routes and the levels that list them, ranking routes,
	gem skills (hunter pearls, the Hunter Jewel) and their tiers.
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
#include <misc/MonsterIDs.hexpat>
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
    u8  cost                    [[comment("Up to 10 for all the equipped skills; cost 0 skills are always on in town")]];
    u8  group                   [[comment("One equipped skill per group, 0 for none")]];
    s16 supersededBy            [[comment("Hidden once this skill is offered and unlocked")]];
    u8  unk06[2];
    u16 points[8]               [[comment("Points needed per color: pink, brown, yellow, green, white, purple, cyan; the 8th is 0")]];
    u8  effectValues[24]        [[comment("Read by the skill's own code")]];
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
    u32 cpCost                  [[comment("To upgrade from this tier; halved with course 3 or 7")]];
    u16 pointCap                [[comment("Per color")]];
    u8  percent                 [[comment("Of the cap every color needs to upgrade")]];
    u8  previousTierUnlock      [[comment("The fame points the tier before this row's needs to upgrade")]];
};

CaravanTier caravanTiers[importantNums.numHunterPearlSkillLists + 1]
    @ header.ptrs.caravanTiers
    [[name("Caravan Tiers")]];

// =======================
// Caravan CP. 0x88C: percents read by caravan_cp_rate_get (index <= 9); index 6
// is the finess ext weapon CP percent (caravan_grant_item_cp and the other CP
// grants), indexes 5, 7, 8 scale CP in the lobby caravan menus and quest results.
// 0x8F8 / 0x8F0: CP for each new part break of a monster in a G caravan quest
// (caravan_part_break_cp_grant): caravanPartBreakCp[monster id] row [ranking
// group] [part], x caravanPartBreakCountRates[parts broken so far] / 100.
// 0x8F4: in a ranking quest the base 500 CP is x percent / 100, percent picked
// by weight (caravan_ranking_cp_roll).
// =======================

struct CaravanCpRates {
    u16 unk00[5];
    u16 unk0A [[comment("Index 5")]];
    u16 finessExtCpRate [[comment("Index 6, percent")]];
    u16 unk0E [[comment("Index 7")]];
    u16 unk10 [[comment("Index 8")]];
    u16 unk12;
};

CaravanCpRates caravanCpRates @ header.ptrs.caravanCpRates [[name("Caravan CP Rates")]];

u16 caravanPartBreakCountRates[importantNums.numCaravanPartBreakCountRates] @ header.ptrs.caravanPartBreakCountRates [[name("Caravan Part Break Count Rates")]];

struct CaravanRankingCpRoll {
    u16 percent;
    u16 weight;
};

CaravanRankingCpRoll caravanRankingCpRolls[importantNums.numCaravanRankingCpRolls] @ header.ptrs.caravanRankingCpRolls [[name("Caravan Ranking CP Rolls")]];

struct CaravanPartBreakCpGroup {
    u16 byPart[12];
};

struct CaravanPartBreakCpTable {
    CaravanPartBreakCpGroup byRankingGroup[11];
};

struct CaravanPartBreakCpMonster {
    CaravanPartBreakCpTable *table : u32;
};

CaravanPartBreakCpMonster caravanPartBreakCp[importantNums.numCaravanPartBreakCpMonsters] @ header.ptrs.caravanPartBreakCp [[name("Caravan Part Break CP")]];

// Caravan monster prices (header 0xB70, importantNums.numCaravanMonsterPrices
// rows): the CP a hunted monster gives (mhfpac pQuestResultTexts[122]
// ≪現在のモンスター取引価格≫, [123] ×%2d：%dCP). caravan_monster_prices_load
// (after a server reply) copies them into the 128-row price list (0x1E63952C;
// kind 1, or 3 when rate > 100) and into the price by monster (0x1ED6BCA4,
// caravan_monster_price_get), which quest_complete_build_monster_hunt_count_rewards
// uses on a quest with variant1 bit 8 (else the table at 0x1ED6B8A0). The quest
// result shows hunts x price x caravan_cp_rate_get / 100. Identical on the EN,
// JP and rain files.
fn caravanMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

struct CaravanMonsterPrice {
    u16 monster [[format("caravanMonster")]];
    u16 unk02;
    u32 price [[comment("CP per hunt (slain or captured)")]];
    u16 rate [[comment("100 on ZZ; > 100 makes the list row kind 3")]];
    u16 unk0A;
};

CaravanMonsterPrice caravanMonsterPrices[importantNums.numCaravanMonsterPrices] @ header.ptrs.caravanMonsterPrices [[name("Caravan Monster Prices")]];

// Monster price board (header 0x6C0): the monsters of the G rank monster
// pricing board (mhfpac pBountyListTexts[10] / [16] / [19]).
// monster_price_board_build (after the server reply that runs
// caravan_monster_prices_load; from quest_counter_menu_tick and
// monster_price_board_menu_tick) keeps, in file order, each row whose
// requiredLevel is at most the quest-list tune value 1030 (default 10) and
// whose monster is in the caravan price list, and pages them 10 a page;
// monster_price_board_page_draw prints the monster name and its price.
// Fatalis, Crimson Fatalis, Disufiroa and Shantien are priced but not listed.
struct MonsterPriceBoardRow {
    u32 requiredLevel [[comment("Listed when <= quest-list tune value 1030 (default 10); 1-8, ascending")]];
    u16 monster [[format("caravanMonster"), comment("Looked up in the caravan price list")]];
    u16 unk06 [[comment("0; no reader")]];
};

MonsterPriceBoardRow monsterPriceBoard[importantNums.numMonsterPriceBoardRows] @ header.ptrs.monsterPriceBoard [[name("Monster Price Board")]];
