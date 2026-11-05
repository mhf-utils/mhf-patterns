#pragma once

#include <mhfdat/data/equipment_counts.hexpat>

#include <std/mem.pat>
#include <mhfdat/header.hexpat>
#include <misc/MonsterIDs.hexpat>

struct QuestItem {
	u16 questId;
	u16 questNumber;
	u8  keyQuest;
	u8  urgentQuest;
	u16 unknown;
};

/**
	A quest list has no count: it ends at its first empty entry or invalid
	quest id (the same counts as the ranges measured by hand on the JP build).
	@param addr The list's address
	@return How many quests it has
*/
fn questCount(u32 addr) {
	u32 count = 0;
	while (true) {
		u32 at = addr + count * 8;
		u16 id = std::mem::read_unsigned(at, 2);
		if ((id == 0 && std::mem::read_unsigned(at + 2, 2) == 0) || id > 0x8000) break;
		count += 1;
	}
	return count;
};

struct QuestList {
	QuestItem quests[questCount($)] [[inline]];
};

// HR 1* to 6*: header 0xA98 points to their 6 list pointers
struct HRQuests {
	QuestList *oneStar    : ptr [[name("HR1")]];
	QuestList *twoStars   : ptr [[name("HR2")]];
	QuestList *threeStars : ptr [[name("HR3")]];
	QuestList *fourStars  : ptr [[name("HR4")]];
	QuestList *fiveStars  : ptr [[name("HR5")]];
	QuestList *sixStars   : ptr [[name("HR6")]];
};

HRQuests normalQuests @ header.ptrs.questList [[name("HR")]];

// G1 to G10: each header pointer (0x6C8 to 0x6E0, then 0x740 to 0x748) points
// to a u32 holding the list's address; G8 to G10 are empty on ZZ. Don't chain the lists: they follow each other on the JP
// build only (the EN one relocated them).
struct GRQuestList {
	QuestList *list : ptr [[inline]];
};

struct GRQuests {
	GRQuestList g1 @ header.ptrs.GRankQuestG1 [[name("G1")]];
	GRQuestList g2 @ header.ptrs.GRankQuestG2 [[name("G2")]];
	GRQuestList g3 @ header.ptrs.GRankQuestG3 [[name("G3")]];
	GRQuestList g4 @ header.ptrs.GRankQuestG4 [[name("G4")]];
	GRQuestList g5 @ header.ptrs.GRankQuestG5 [[name("G5")]];
	GRQuestList g6 @ header.ptrs.GRankQuestG6 [[name("G6")]];
	GRQuestList g7 @ header.ptrs.GRankQuestG7 [[name("G7")]];
	GRQuestList g8 @ header.ptrs.GRankQuestG8 [[name("G8")]];
	GRQuestList g9 @ header.ptrs.GRankQuestG9 [[name("G9")]];
	GRQuestList g10 @ header.ptrs.GRankQuestG10 [[name("G10")]];
};

GRQuests gRankQuests @ header.ptrs.GRankQuestG1 [[name("GR")]];

// Conquest quests (header 0xB30): important numbers + 0x400 quest ids (16 on
// ZZ). A quest's index here gives its conquest level, [1, 200, 1000,
// 9999][index & 3]; a quest not in the list is level 1. The Fatalis AI reads
// it (level > 999 unlocks its third phase).
fn conquestLevel(u32 index) {
	match (index & 3) {
		(0): return 1;
		(1): return 200;
		(2): return 1000;
		(3): return 9999;
	}
};

struct ConquestQuest {
	u16 level = conquestLevel(($ - header.ptrs.conquestQuests) / 2) [[export]];
	u16 quest;
};

ConquestQuest conquestQuests[importantNums.numConquestQuests] @ header.ptrs.conquestQuests [[name("Conquest Quests")]];

// Guild Priority Requests: the monsters each tier asks for, by server day
// (day = (server time + 75600) / 86400, so it turns at 12:00 JST). A
// rotation (header 0x588, important numbers + 0x1F4 rows) cycles over
// periodDays from startDay; its entries (header 0x584, important numbers +
// 0x1F2 rows) give the monster of each day index and tier: 1-4 the Souls
// tiers (HR1-2, HR3-4, HR5, Gou), 5-7 the Ribbons tiers (G1-2, G3-4, G5-7).
struct PriorityRequestRotation {
	s32 rotation;
	s32 startDay;
	s32 periodDays;
};

PriorityRequestRotation priorityRequestRotations[importantNums.numPriorityRequestRotations] @ header.ptrs.priorityRequestRotations [[name("Guild Priority Request Rotations")]];

fn priorityRequestMonster(s32 n) {
	MonsterID m = u8(n);
	return fmtMonsterID(m);
};

struct PriorityRequestEntry {
	s32 rotation;
	s32 dayIndex;
	s32 tier;
	s32 monster [[format("priorityRequestMonster")]];
	s32 unk10;
};

PriorityRequestEntry priorityRequestEntries[importantNums.numPriorityRequestEntries] @ header.ptrs.priorityRequestEntries [[name("Guild Priority Request Monsters")]];

// Beginner quests (header 0x1B8): important numbers + 0x3C quest ids (2 on ZZ)
u16 beginnerQuests[importantNums.numBeginnerQuests] @ header.ptrs.beginnerQuests [[name("Beginner Quests")]];

// Continuous interception quests (quest variant3 bit 0x20, mhf-client
// 連続迎撃): header 0xB18 points to the row count, header 0xB1C to one row
// per monster. In a G-rank field, the row of the current target (quest work
// +0x9C, entity +0x03) replaces the quest's G star for the priority request
// tier (priorityRequest_quest_tier: 3-4 -> 6, 5-7 -> 7) and for the defense
// recalculation (player_recalc_defense_value_basic / _full; variant3 bit 0x10
// forces 8).
struct InterceptionMonsterStar {
	u8 monster [[format("priorityRequestMonster")]];
	u8 gStar;
};

u16 interceptionMonsterCount @ header.ptrs.interceptionMonsterCount [[name("Interception Monster Count")]];
InterceptionMonsterStar interceptionMonsterStars[interceptionMonsterCount] @ header.ptrs.interceptionMonsterStars [[name("Interception Monster G Stars")]];

// Great Slaying (大討伐, Raviente) quest ids (header 0x4E8), read by 29
// functions (hit_detected, the reward generator, the balloon idle timer, the
// Hunter Navi checkers, quest hall join checks...). Each field is one quest
// id; "support first" starts a run of 5 support (【支援】) quests. The code
// also treats some fields as range starts: firstQuest .. lastQuest - 1
// (berserk, hit_detected) or firstQuest .. firstQuest + 5 except + 4
// (berserkExtreme, captureBreakRewardsZenith choice). Titles from the quest
// files.
struct GreatSlayingQuests {
    u16 ravienteFirstQuest [[comment("震撼！絶島主 (HagiLv 0)")]];
    u16 ravienteLastQuest [[comment("no balloon idle timer; Hunter Navi task 09_07")]];
    u16 violentFirstQuest [[comment("白き絶島主 (HagiLv 1)")]];
    u16 violentLastQuest [[comment("no balloon idle timer; Hunter Navi tasks 09_07 / 09_11 (hunterNavi_ck_09_11_violent_raviente)")]];
    u16 berserkFirstQuest [[comment("猛震！黒き絶島主 (G)")]];
    u16 berserkLastQuest [[comment("no balloon idle timer; Hunter Navi 09_07 / 09_12 (great_slaying_is_berserk_last_quest)")]];
    u16 berserkSupportFirstQuest [[comment("【支援】, 5 quests")]];
    u16 berserkExtremeFirstQuest [[comment("極震！黒き絶島主 (G)")]];
    u16 berserkExtremeLastQuest [[comment("as berserkLastQuest")]];
    u16 berserkExtremeSupportFirstQuest [[comment("【支援】, 5 quests")]];
    u16 berserkSmallPartyFirstQuest [[comment("猛震！黒き絶島主(少人数) (G)")]];
    u16 berserkSmallPartyLastQuest [[comment("as berserkLastQuest")]];
    u16 berserkSmallPartySupportFirstQuest [[comment("【支援】, 5 quests")]];
};

GreatSlayingQuests greatSlayingQuests @ header.ptrs.greatSlayingQuests [[name("Great Slaying Quests")]];

// Zenith quest counter monsters (header 0xAB4): the 0-terminated monster id
// list of category 0xD8; quest_counter_build_zenith_monster_rows adds a 0xD9
// row named pMonsterNames[id] for each monster that has Zenith quests (event
// type 43 or the mhfinf special hunt list 12).
fn zenithQuestMonster(auto e) {
	MonsterID m = u8(e.id);
	return fmtMonsterID(m);
};

struct ZenithQuestMonster {
    u16 id;
} [[format("zenithQuestMonster")]];

struct ZenithQuestMonsters {
    ZenithQuestMonster monsters[while(std::mem::read_unsigned($, 2) != 0)];
    u16 end;
};

ZenithQuestMonsters zenithQuestMonsters @ header.ptrs.zenithQuestMonsters [[name("Zenith Quest Monsters")]];

// Large Monster quest tabs (header 0x864): one quest counter tab 0x7E
// ("Large Monsters", pQuestCounterTextGroups) per row, under Hunter Quests
// (0x7B) or Low Rank / High Rank / High Skill (0xA5-0xA7).
// mhfinf_populate_quest_category_menu adds the tab when the hunter rank
// (gGetHunterRankUd) is at least minHr (with locale on, only when its quest
// list is not empty), labelled pMonsterNames[monsters[0]]; quest_menu_dispatcher
// (case 0x41) finds the row by monsters[0] (row 0 when none) and passes
// monsters to build_quest_list_with_monster_filter, which keeps the HR1 / HR31 /
// HR100 mhfinf quests whose target is one of them. At most 3 ids are used.
fn largeMonsterQuestTabMonster(auto e) {
    MonsterID m = u8(e.id);
    return fmtMonsterID(m);
};

struct LargeMonsterQuestTabMonster {
    u16 id;
} [[format("largeMonsterQuestTabMonster")]];

struct LargeMonsterQuestTab {
    u16 minHr;
    LargeMonsterQuestTabMonster monsters[5] [[comment("0-terminated; [0] is the tab's monster")]];
};

LargeMonsterQuestTab largeMonsterQuestTabs[importantNums.numLargeMonsterQuestTabs] @ header.ptrs.largeMonsterQuestTabs [[name("Large Monster Quest Tabs")]];

// Quest search target monsters (header 0x288): the "Monster" condition of the
// quest counter search. quest_search_monster_list_build copies the ids that
// pass, in file order, into quest counter work +0x4A7C; selection 0 is "Not
// Specified" (pQuestCounterTextGroups[1][0xA6]), the others print
// pMonsterNames[id] (FUN_1038C660). With a monster type selected (work +0x4A54;
// 10 means type 0) only monsters whose mhfemd pSpecies speciesClass is that type
// are kept (Gore Magala 0xA2 counts as type 0). Work +0x7A9F is the G rank
// counter flag (counter mode 0xE, NPC 0xF3, or a G My Mission).
// Rows = important numbers + 0x76 / 2 (that u16 counts u16 values).
fn questSearchMonster(u16 n) {
    MonsterID m = u8(n);
    return fmtMonsterID(m);
};

bitfield QuestSearchMonsterFlags {
    gRankOnly : 1 [[comment("Listed only at the G rank counter")]];
    needsHuntRecord : 1 [[comment("Listed only when the monster's save counters 2 + 3 are not both 0 (Bogabadorumu also adds Musou Bogabadorumu 0xAC); tested when the 3rd argument is set")]];
    notInGRank : 1 [[comment("Not listed at the G rank counter")]];
    padding : 13;
};

struct QuestSearchMonster {
    u16 monster [[format("questSearchMonster")]];
    QuestSearchMonsterFlags flags;
};

QuestSearchMonster questSearchMonsters[importantNums.numQuestSearchMonsterValues / 2] @ header.ptrs.questSearchMonsters [[name("Quest Search Monsters")]];

// Quest search fields (header 0x28C normal counter, 0x290 quest counter mode 0xE,
// work +0x1C == 0xE): the choices of the quest search "Field" condition. Each value
// is a pStageShortNames index (search_menu_disp); choice n (1-based, 0 = "All")
// keeps the quests whose map (mhfinf quest +0x24) maps to that value in the client
// stage table 0x119234D0 (search_list / search_listAll, then search_field).
// Counts: important numbers +0x78 / +0x7A (quest_counter_menu_init uses count + 1).
u16 questSearchFields[importantNums.numQuestSearchFields] @ header.ptrs.questSearchFields [[name("Quest Search Fields")]];
u16 questSearchFieldsG[importantNums.numQuestSearchFieldsG] @ header.ptrs.questSearchFieldsG [[name("Quest Search Fields (G Rank Counter)")]];

// Daily rotation quests (header 0xB50 / 0xB54 / 0xB58): the quest lists of quest
// counter tab 0xEB (quest_menu_dispatcher case 0x73, the tab's only source), one
// per JST day % 3 (time_now_days_jst = (server time + 9 h) / 86400: 0 -> 0xB50,
// 1 -> 0xB54, 2 -> 0xB58), list [0] only; nothing when server tune 0x2EA is set.
// Rows go through build_quest_list_gr_filtered (questNumber 0 becomes 1 on G
// quests, then the salon type filter). quest_is_daily_rotation_quest also keeps
// these quests out of the G rank HC / UL toggle id range (23000-23999).
struct DailyRotationQuestRow {
    u16 questId [[comment("0 ends the list")]];
    s16 questNumber;
    u8 unk04 [[comment("no reader")]];
    u8 unk05 [[comment("no reader")]];
    u16 unk06 [[comment("no reader")]];
};

struct DailyRotationQuestList {
    DailyRotationQuestRow rows[while(std::mem::read_unsigned($, 2) != 0)];
    DailyRotationQuestRow end;
};

struct DailyRotationQuestListPtr {
    DailyRotationQuestList *list : u32;
};

DailyRotationQuestListPtr dailyRotationQuests0[importantNums.numDailyRotationQuestLists0] @ header.ptrs.dailyRotationQuests0 [[name("Daily Rotation Quests (day % 3 = 0)")]];
DailyRotationQuestListPtr dailyRotationQuests1[importantNums.numDailyRotationQuestLists1] @ header.ptrs.dailyRotationQuests1 [[name("Daily Rotation Quests (day % 3 = 1)")]];
DailyRotationQuestListPtr dailyRotationQuests2[importantNums.numDailyRotationQuestLists2] @ header.ptrs.dailyRotationQuests2 [[name("Daily Rotation Quests (day % 3 = 2)")]];

// G quest party size rates (header 0x39C, rank_points.md): the reward rate in
// percent of a G quest (quest variant1 bit 8) by the number of counted
// players, 1 to important numbers + 0x112 (quest_g_party_size_rate_get; 100
// when the quest is not a G quest).
u16 gQuestPartySizeRates[importantNums.numGQuestPartySizeRates] @ header.ptrs.gQuestPartySizeRates [[name("G Quest Party Size Rates")]];

// G quest difficulty (header 0x798 and 0x79C; Wii U
// get_g_quest_difficulty_str_sub): the aptitude word of the quest counter
// detail panel (mhfpac pAptitudeTexts). For a G-rank target quest seen in
// town, the player's defense (PlayerWork +0x7A8, rebuilt for the selected
// equipment) minus baseDefenses[G star] (blademaster or gunner column by the
// weapon class flags bit 1) gives a margin; the first threshold the margin
// reaches (thresholds go down) is the text index, none gives index 5. Index
// 18 and above (star 9) clamps to the last s32.
struct GQuestDifficultyDefense {
    s32 blademaster;
    s32 gunner;
};

s32 gQuestDifficultyThresholds[importantNums.numGQuestDifficultyThresholds] @ header.ptrs.gQuestDifficultyThresholds [[name("G Quest Difficulty Thresholds")]];
GQuestDifficultyDefense gQuestDifficultyDefenses[importantNums.numGQuestDifficultyDefenses / 2] @ header.ptrs.gQuestDifficultyDefenses [[name("G Quest Difficulty Base Defenses"), comment("Row = G star; row 0 unused")]];

// Experience quests (header 0xA9C; important numbers + 0x3E2): the G Rank and
// Extreme style experience quests, looked up by the current quest id. A non-zero
// legendRastaLoadout makes legend_rasta_hunter_card_build use that row of the
// Legend Rasta loadouts (header 0x35C) instead of the contracted one, and the
// party count drops by 1; a non-zero weaponStyleOneBased makes player_slots_init
// set every hunter's weapon style to it - 1. quest_is_experience_quest turns off
// a few features (ud_prayer_phase_orb_eligible and others) on these quests.
struct ExperienceQuest {
    u16 questId;
    u8 legendRastaLoadout [[comment("Legend Rasta loadout row (header 0x35C), 0 = none")]];
    u8 weaponStyleOneBased [[comment("Weapon style + 1 (1 Earth, 2 Heaven, 3 Storm, 4 Extreme), 0 = keep")]];
};

ExperienceQuest experienceQuests[importantNums.numExperienceQuests] @ header.ptrs.experienceQuests [[name("Experience Quests")]];
