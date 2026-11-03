#pragma once

#include <mhfdat/data/equipment_counts.hexpat>

#include <std/mem.pat>
#include <mhfdat/header.hexpat>

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

// Beginner quests (header 0x1B8): important numbers + 0x3C quest ids (2 on ZZ)
u16 beginnerQuests[importantNums.numBeginnerQuests] @ header.ptrs.beginnerQuests [[name("Beginner Quests")]];
