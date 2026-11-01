#pragma once

#include <mhfinf/utils/index.pat>

struct IdList {
    u16 id[while(rd16($) != 0)];
    u16 end;
};

struct IdListPtr {
    if (rd32($) == 0)
        u32 none;
    else
        IdList *list : u32;
};

struct IdLists<auto N> {
    IdListPtr e[N];
};

IdLists<listCount(0)> pCounterQuestLists @ header.ptrs.pCounterQuestLists;
IdLists<listCount(1)> pTutorialQuestLists @ header.ptrs.pTutorialQuestLists;
IdLists<listCount(2)> pQuestOrderLists @ header.ptrs.pQuestOrderLists;
IdLists<listCount(3)> pHr1QuestLists @ header.ptrs.pHr1QuestLists;
IdLists<listCount(4)> pHr31QuestLists @ header.ptrs.pHr31QuestLists;
IdLists<listCount(5)> pHr31QuestListsB @ header.ptrs.pHr31QuestListsB;
IdLists<listCount(6)> pHr100QuestLists @ header.ptrs.pHr100QuestLists;
IdLists<listCount(7)> pPremiumQuestLists @ header.ptrs.pPremiumQuestLists;
IdLists<listCount(8)> pBenefitQuestLists @ header.ptrs.pBenefitQuestLists;
IdLists<listCount(9)> pHrRankingRewardLists @ header.ptrs.pHrRankingRewardLists;
IdLists<listCount(10)> pHuntingTechniqueQuestLists @ header.ptrs.pHuntingTechniqueQuestLists;
IdLists<listCount(11)> pSpecialHuntQuestLists @ header.ptrs.pSpecialHuntQuestLists;
IdLists<listCount(12)> pCategoryQuestLists @ header.ptrs.pCategoryQuestLists;
IdLists<listCount(13)> pLocaleA0QuestLists @ header.ptrs.pLocaleA0QuestLists;
IdLists<listCount(14)> pLocaleA1QuestLists @ header.ptrs.pLocaleA1QuestLists;
IdLists<listCount(15)> pLocaleA2QuestLists @ header.ptrs.pLocaleA2QuestLists;
IdLists<listCount(16)> pWeaponSoulQuestLists @ header.ptrs.pWeaponSoulQuestLists;
IdLists<listCount(17)> pHuntingRoadQuestLists @ header.ptrs.pHuntingRoadQuestLists;
IdLists<listCount(18)> pSuperiorQuestLists @ header.ptrs.pSuperiorQuestLists;
IdLists<listCount(19)> pRewardTabQuestLists @ header.ptrs.pRewardTabQuestLists;
IdLists<listCount(20)> pGRewardTabQuestLists @ header.ptrs.pGRewardTabQuestLists;
IdLists<listCount(21)> pFestaRewardQuestLists @ header.ptrs.pFestaRewardQuestLists;
IdLists<listCount(22)> pFestaHrQuestLists @ header.ptrs.pFestaHrQuestLists;
IdLists<listCount(23)> pBlockedQuestLists @ header.ptrs.pBlockedQuestLists;
IdLists<listCount(24)> pExoticQuestLists @ header.ptrs.pExoticQuestLists;
IdLists<listCount(25)> pDailyQuestLists @ header.ptrs.pDailyQuestLists;
IdLists<listCount(26)> pNewWeaponQuestList @ header.ptrs.pNewWeaponQuestList;
IdLists<listCount(27)> pGearAcquisitionQuestLists @ header.ptrs.pGearAcquisitionQuestLists;
