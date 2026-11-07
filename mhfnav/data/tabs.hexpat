#pragma once

#include <mhfnav/utils/index.pat>
#include <mhfnav/header.hexpat>

enum RewardType : u16 {
    End = 0,
    Item = 1,
    Zenny = 2,
    GZenny = 3
};

enum ProgressType : u16 {
    None = 0,
    Quest = 1
};

bitfield TabFlags {
    disabled : 1;
    retired : 1;
    unk : 30;
};

bitfield TaskFlags {
    unk0 : 1;
    unk1 : 1;
    rowFrameByIndex : 1;
    rowFrame5 : 1;
    rowFrame4 : 1;
    rowState80 : 1;
    retired : 1;
    unk7 : 1;
};

struct NaviCharEntry {
    s8 taskIndex;
    u8 sefIndexOfs;
};

struct ProgressListEntry {
    u16 taskIndex;
    ProgressType type;
    u16 questId;
    u16 pad06;
};

struct RewardItem {
    u16 pad00;
    RewardType rewardType;
    if (rewardType == RewardType::Item) {
        u16 itemId;
        u16 quantity;
    } else if (rewardType == RewardType::End) {
        u16 unk04;
        u16 unk06;
    } else {
        u16 unused04;
        u16 amount;
    }
};

struct RewardList {
    RewardItem items[while(rd16($ + 2) != 0)];
    RewardItem end;
};

struct RewardRef {
    if (rd32($) != 0)
        RewardList *list : u32;
    else
        u32 none;
};

struct NaviCharList {
    NaviCharEntry entries[while(std::mem::read_signed($, 1) != -1)];
    NaviCharEntry end;
};

struct ArmorParams {
    float headId;
    float bodyId;
    float armId;
    float waistId;
    u32 legId;
    u32 familyStep;
    u32 unused20;
    u32 unk24;
};

struct ArmorDecoParams {
    float headId;
    float bodyId;
    float armId;
    float waistId;
    u32 legId;
    u32 familyStep;
    u32 decoItemId;
    u32 unk24;
};

struct DecoCountParams {
    float decoItemId;
    float unused0C[3];
    u32 unused18;
    u32 unused1C;
    u32 unused20;
    u32 unk24;
};

struct HrParams {
    float unused08[4];
    u32 hrMin;
    u32 unused1C;
    u32 unused20;
    u32 unk24;
};

struct SrParams {
    float unused08[4];
    u32 srMin;
    u32 unused1C;
    u32 unused20;
    u32 unk24;
};

struct GrParams {
    float unused08[4];
    u32 grMin;
    u32 unused1C;
    u32 unused20;
    u32 unk24;
};

struct MonsterParams {
    float unused08[4];
    u32 monsterId;
    u32 unused1C;
    u32 unused20;
    u32 unk24;
};

struct DivaChapterParams {
    float unused08[4];
    u32 storyBit;
    u32 unused1C;
    u32 unused20;
    u32 unk24;
};

struct SrHrParams {
    float unused08[4];
    u32 srMin;
    u32 hrMin;
    u32 unused20;
    u32 unk24;
};

struct RawParams {
    float fparams[4];
    u32 iparam;
    u32 iparam2;
    u32 itemOrDeco;
    u32 unk24;
};

/// Task row; the layout of params depends on the tab and the task index in the pool
struct TaskEntry<auto Tab, auto Pool> {
    u32 task = (addressof(this) - Pool) / 0x28;
    TaskFlags flags;
    u8 pad01;
    u16 pad02;
    u16 unk04;
    u16 rewardIndex;
    match (Tab, task) {
        (3, 1 | 2 | 5 | 6): ArmorParams params;
        (11, 3 | 4 | 5 | 6 | 12): ArmorParams params;
        (12, 3 | 6 | 10): ArmorParams params;
        (3, 7 | 8): ArmorDecoParams params;
        (11, 2): DecoCountParams params;
        (1, 6 | 8 | 13 | 14 | 15): HrParams params;
        (2, 7 | 9 | 12 | 14): SrParams params;
        (2, 15): SrHrParams params;
        (12, 8 | 12 | 13): GrParams params;
        (3, 4): MonsterParams params;
        (8, 2 | 3 | 5 | 6 | 8 | 9 | 10 | 12 | 14): MonsterParams params;
        (11, 7 | 8 | 9 | 10 | 11): MonsterParams params;
        (12, 2 | 5 | 9): MonsterParams params;
        (6, 1 | 2 | 5 | 6): DivaChapterParams params;
        (_, _): RawParams params;
    }
};

struct NaviTab {
    u32 tab = (addressof(this) - header.pTabs) / 0x24;
    TabFlags flags;
    u32 unk04;
    u32 nTaskPool = rd32($ + 4);
    u32 pool = rd32($);
    TaskEntry<tab, pool> *pTaskPool[nTaskPool] : u32;
    u32 taskPoolCount;
    u32 nTaskReward = rd32($ + 4);
    RewardRef *pTaskRewardPtrs[nTaskReward] : u32;
    u32 taskRewardCount;
    NaviCharList *pAvailableChars : u32;
    u32 nProgress = rd32($ + 4);
    if (nProgress != 0 && rd32($) != 0)
        ProgressListEntry *pProgressList[nProgress] : u32;
    else
        u32 pProgressListNone;
    u32 progressListCount;
};

/// The 14 tabs are stored contiguously at header.pTabs
NaviTab tabs[14] @ header.pTabs [[name("Navi Tabs")]];
