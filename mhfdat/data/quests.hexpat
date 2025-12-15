#pragma once

#include <std/mem.pat>

struct QuestItem {
	u16 questId;
	u16 questNumber;
	u8  keyQuest;
	u8  urgentQuest;
	u16 unknown;
};

struct HRQuestPointers {
	u32 oneStar;
	u32 twoStars;
	u32 threeStars;
	u32 fourStars;
	u32 fiveStars;
	u32 sixStars;
};

struct HRQuests {
	HRQuestPointers questPointers @ addressof(this) [[name("HR-Rank pointers")]];
	QuestItem oneStar[get_hr_count(questPointers.oneStar, questPointers.twoStars)]        @ questPointers.oneStar    [[name("HR1")]];
	QuestItem twoStars[get_hr_count(questPointers.twoStars, questPointers.threeStars)]    @ questPointers.twoStars   [[name("HR2")]];
	QuestItem threeStars[get_hr_count(questPointers.threeStars, questPointers.fourStars)] @ questPointers.threeStars [[name("HR3")]];
	QuestItem fourStars[get_hr_count(questPointers.fourStars, questPointers.fiveStars)]   @ questPointers.fourStars  [[name("HR4")]];
	QuestItem fiveStars[get_hr_count(questPointers.fiveStars, questPointers.sixStars)]    @ questPointers.fiveStars  [[name("HR5")]];
	QuestItem sixStars[get_dynamic_count(questPointers.sixStars)]                         @ questPointers.sixStars   [[name("HR6")]];
};

struct GRQuestPointers {
	ptr G7 @ addressof(this) [[name("G7 Pointer")]];
	ptr G6 @ (G7 + get_gr_count(G7) * sizeof(QuestItem) + 8) [[name("G6 Pointer")]];
	ptr G5 @ (G6 + get_gr_count(G6) * sizeof(QuestItem) + 8) [[name("G5 Pointer")]];
	ptr G4 @ (G5 + get_gr_count(G5) * sizeof(QuestItem) + 8) [[name("G4 Pointer")]];
	ptr G3 @ (G4 + get_gr_count(G4) * sizeof(QuestItem) + 8) [[name("G3 Pointer")]];
	ptr G2 @ (G3 + get_gr_count(G3) * sizeof(QuestItem) + 8) [[name("G2 Pointer")]];
	ptr G1 @ (G2 + get_gr_count(G2) * sizeof(QuestItem) + 8) [[name("G1 Pointer")]];
};

struct GRQuests {
	GRQuestPointers ptrs @ addressof(this) [[name("G-Rank pointers")]];
	QuestItem g1[get_gr_count(ptrs.G1)] @ ptrs.G1 [[name("G1")]];
	QuestItem g2[get_gr_count(ptrs.G2)] @ ptrs.G2 [[name("G2")]];
	QuestItem g3[get_gr_count(ptrs.G3)] @ ptrs.G3 [[name("G3")]];
	QuestItem g4[get_gr_count(ptrs.G4)] @ ptrs.G4 [[name("G4")]];
	QuestItem g5[get_gr_count(ptrs.G5)] @ ptrs.G5 [[name("G5")]];
	QuestItem g6[get_gr_count(ptrs.G6)] @ ptrs.G6 [[name("G6")]];
	QuestItem g7[get_gr_count(ptrs.G7)] @ ptrs.G7 [[name("G7")]];
};

fn get_dynamic_count(ptr start_addr) {
	u32 count = 0;
	ptr current_addr = start_addr;
	
	while (count < 300) {
		if (current_addr + sizeof(QuestItem) > std::mem::size()) break;
		
		u16 questId = std::mem::read_unsigned(current_addr, 2);
		u16 questNumber = std::mem::read_unsigned(current_addr + 2, 2);
		u8 keyQuest = std::mem::read_unsigned(current_addr + 4, 1);
		u8 urgentQuest = std::mem::read_unsigned(current_addr + 5, 1);
		
		if (questId == 0x0000 && questNumber == 0x0000) break;
		if (questId > 0x8000) break;
		if (questId == 0xFFFF) break;
		
		count = count + 1;
		current_addr = current_addr + sizeof(QuestItem);
	}
	
	if (count == 0) count = 1;
	
	return count;
};

fn get_hr_count(ptr start_addr, ptr end_addr) {
	if (end_addr <= start_addr) {
		return get_dynamic_count(start_addr);
	}
	
	u32 calculated_count = (end_addr - start_addr) / sizeof(QuestItem);
	
	if (calculated_count > 0 && calculated_count <= 500) {
		return calculated_count;
	}
	
	return get_dynamic_count(start_addr);
};

fn get_gr_count(ptr start_addr) {
	u32 count = 0;
	ptr current = start_addr;

	while (count < 300) {
		if (current + sizeof(QuestItem) > std::mem::size()) break;

		u16 questId     = std::mem::read_unsigned(current, 2);
		u16 questNumber = std::mem::read_unsigned(current + 2, 2);

		if (questId == 0x0000 && questNumber == 0x0000) {
			u32 zeroes = 0;
			u32 i = 0;

			while (i < 8) {
				if (current + i < std::mem::size() && std::mem::read_unsigned(current + i, 1) == 0x00) {
					zeroes = zeroes + 1;
				}
				i = i + 1;
			}

			if (zeroes >= 6) break;
		}

		if (questId == 0xFFFF || questId > 0x8000) break;

		count = count + 1;
		current = current + sizeof(QuestItem);
	}

	if (count == 0) count = 1;
	return count;
};

HRQuests normalQuests @ header.ptrs.questList      [[name("HR")]];
GRQuests gRankQuests  @ header.ptrs.GRankQuestList [[name("GR")]];
