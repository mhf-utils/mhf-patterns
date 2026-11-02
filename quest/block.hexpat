#pragma once

#include <misc/types.pat>
#include <misc/s32p.pat>
#include <misc/MapIDs.hexpat>
#include <misc/MonsterIDs.hexpat>
#include <misc/ItemIDs.hexpat>
#include <quest/objective.hexpat>

/**
	A quest's main block: the 0x140 bytes a quest file's header (0x00) points
	to, which mhfinf copies byte for byte for every quest of the counters.
	Offsets in the comments are relative to the block.
*/

struct QuestText {
    s32p title;
    s32p textMain;
    s32p textSubA;
    s32p testSubB;
    s32p successCond;
    s32p failCond;
    s32p contractor;
    s32p description;
};

// A piece the quest forces, then its 3 decorations: 0x8000 means no
// decoration on a forced piece, 0 a free slot
struct ForcedEquipment {
    u16 piece;
    u16 decos[3];
} [[static]];

struct QuestBlock {
    u8 unk00 [[hidden]];
    u8 MusicModeFlag;
    u8 QuestLocaleFlags;
    u8 TimeFlags [[comment("Spring, warm, cold, day, night, -, required objective")]];
    u8 RankingID [[comment("The quest's stars")]];
    u8 unk05 [[hidden]];
    u16 unk06 [[hidden]];
    u16 RankBand0;
    u16 unk0A [[hidden]]; //QuestTypeID untatID
    u32 QuestFee;
    u32 RewardMain;
    u32 CartsOrRewardReduction [[comment("Faints before the quest fails")]];
    u16 RewardA;
    padding[2];
    u16 rewardB;

    u16 HardHunterRankReq;
    u32 QuestTime [[comment("Frames, 30 per second")]];
    qMapID QuestMap;
    ptr QuestStringsPtr;
    u16 unk2C [[hidden]];
    u16 QuestID;
    QuestObj QuestObjectives[3];
    u8 unk48 [[hidden]];
    u8 unk49 [[hidden]];

    // + 0x4A: the lower rank range always comes first, so to join, then to
    // post (checked on the quest dump)
    u16 JoinRankMin;
    u16 JoinRankMax;
    u16 PostRankMin;
    u16 PostRankMax;

    padding[0xA];

    // + 0x5C: forced equipment
    ForcedEquipment legs;
    ForcedEquipment weapon;
    ForcedEquipment head;
    ForcedEquipment chest;
    ForcedEquipment arms;
    ForcedEquipment waist;

    u32 unk8C [[hidden]];

    // + 0x90: quest and monster variations
    u8 rewardMode [[comment("0-4 (Pax's quest editor labels them)")]];
    u8 monsterVariants[2];
    u8 mapVariant;
    ItemID requiredItemType;
    u8 requiredItemCount;
    u8 questVariant1;
    u8 questVariant2;
    u8 questVariant3;
    u8 questVariant4;

    padding[5];

    u32 allowedEquipBitmask;

    // + 0xA4: rewards focus (a quest file repeats them at 0x4C, 0x54 and 0x58)
    u32 mainPoints;
    u32 subAPoints;
    u32 subBPoints;

    // + 0xB0: what the counter shows, whatever the objective
    ItemID items[3];
    u8 monsterVariants2[3];
    MonsterID monsters[5];

    padding[0xA];

    u32 questClearsAllowed;

    padding[0x74];

    QuestText questText @ QuestStringsPtr;
};
