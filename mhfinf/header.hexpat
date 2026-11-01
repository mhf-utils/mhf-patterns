#pragma once

#include <std/sys.pat>
#include <misc/types.pat>

const u32 HEADER_SIZE = 0x88;

struct signature {
    u32 header1 [[comment("Must equal 1A 66 6E 69")]];
    u32 header2 [[comment("Must equal 00 00 00 06")]];
    u32 unk08;
    u32 headerSize [[comment("Must equal 00 00 00 88")]];
};

struct ptr_table {
    // [mhfo-hd.dll + 0xafa411]
    ptr pCounts          [[name("Inf Quantities Pointer")]];
    ptr pQuestSections   [[name("Quest Table Pointer")]];
    ptr pCounterQuestLists;
    ptr pTutorialQuestLists;
    ptr pQuestOrderLists;
    ptr pHr1QuestLists;
    ptr pHr31QuestLists;
    ptr pHr31QuestListsB;
    ptr pHr100QuestLists;
    ptr pPremiumQuestLists;
    ptr pBenefitQuestLists;
    ptr pHrRankingRewardLists;
    ptr pHuntingTechniqueQuestLists;
    ptr pSpecialHuntQuestLists;
    ptr pCategoryQuestLists;
    ptr pLocaleA0QuestLists;
    ptr pLocaleA1QuestLists;
    ptr pLocaleA2QuestLists;
    ptr pWeaponSoulQuestLists;
    ptr pHuntingRoadQuestLists;
    ptr pSuperiorQuestLists;
    ptr pRewardTabQuestLists;
    ptr pGRewardTabQuestLists;
    ptr pFestaRewardQuestLists;
    ptr pFestaHrQuestLists;
    ptr pBlockedQuestLists;
    ptr pExoticQuestLists;
    ptr pDailyQuestLists;
    ptr pNewWeaponQuestList;
    ptr pGearAcquisitionQuestLists;
};

struct MhfInfCounts {
    u16 sectionCount [[name("Number of quest table entries")]];
    u16 listCount[28];
};

struct mhfinf_header {
    signature sig   [[name("File header signature")]];
    ptr_table ptrs  [[name("Top level pointer table")]];
};

mhfinf_header header @ 0x0 [[name("mhfinf Header")]];
MhfInfCounts counts @ header.ptrs.pCounts [[name("Counts")]];

str __header_fail_msg = "File header does not match expected mhfinf header";

std::assert_warn(header.sig.header1 == 0x1A666E69, __header_fail_msg);
std::assert_warn(header.sig.header2 == 0x00000006, __header_fail_msg);
std::assert_warn(header.sig.headerSize == 0x00000088, __header_fail_msg);
