#pragma once

#include <mhfinf/utils/index.pat>

struct ForceEquipment {
    u16 itemId;
    u16 option1;
    u16 option2;
    u16 option3;
};

struct QuestObjective {
    u32 objectiveType;
    u16 targetId;
    u16 quantity;
};

struct QuestText {
    Str questName;
    Str mainObjective;
    Str subQuestA;
    Str subQuestB;
    Str successCondition;
    Str failureCondition;
    Str client;
    Str description;
};

struct QuestInfo {
    u32 questFlags;
    u8 star;
    u8 listGroup;
    u16 requiredCourse;
    u16 rankBand;
    u8 hagiLv;
    u8 unk0B;
    u32 questFee;
    u32 rewardMain;
    u32 faintTimes;
    u32 rewardA;
    u32 rewardB;
    u32 questTime [[comment("Timing in frames (30Hz)")]];
    u32 questMap;
    u32 questDescStringEachPointersPtr;
    u16 questRestriction;
    u16 questId;
    QuestObjective objective1;
    QuestObjective objective2;
    QuestObjective objective3;
    u8 questObjectiveSystem;
    u8 unk49;
    u16 joinRankMin;
    u16 joinRankMax;
    u16 postRankMin;
    u16 postRankMax;
    u8 pad52[2];
    QuestObjective objective4;
    ForceEquipment forceEquipments[6];
    u32 unk140;
    u8 rewardVariant;
    u8 monsterVariant1;
    u8 monsterVariant2;
    u8 mapVariant;
    u16 requiredItem;
    u8 requiredItemCount;
    u8 variant1;
    u8 variant2;
    u8 variant3;
    u8 variant4;
    u8 unk9B;
    u32 bannedWeapons;
    u16 disableInNewbie;
    u8 unkA2;
    u8 unkA3;
    u32 mainHrpGrp;
    u32 subAHrpGrp;
    u32 subBHrpGrp;
    u16 item1;
    u16 item2;
    u16 item3;
    u8 interceptionVariants[3];
    u8 monsters[5];
    u16 unk190;
    u32 forceEquipFlags;
    u32 remainingAttempts;
    u16 forceMonsterIcon;
    u8 forceIconOverlay;
    u8 padCB[117];
    QuestText textInline;
};

struct QuestPtr {
    if (rd32($) == 0)
        u32 none;
    else
        QuestInfo *quest : u32;
};

struct QuestPtrs<auto N> {
    QuestPtr e[N];
};

struct QuestSection {
    u16 idRangeEnd;
    u16 entryCount;
    QuestPtrs<entryCount> *entries : u32;
};

struct QuestSections<auto N> {
    QuestSection s[N];
};

QuestSections<sectionCount()> questSections @ header.ptrs.pQuestSections;
