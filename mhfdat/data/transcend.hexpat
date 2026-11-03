#pragma once

/**
	Transcend (the Rites): one row per effect and depth (header 0x990,
	important numbers + 0x3A8 of them, 109 on ZZ) and the EXP a quest clear
	gives (header 0x994, rows up to the depth table, 25 on ZZ).
	A depth row's stats index the label / format pairs of mhfpac's Transcend
	effect texts.
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

enum TranscendEffect : u8 {
    FireVein    = 0,
    WaterVein   = 1,
    IceVein     = 2,
    ThunderVein = 3,
    DragonVein  = 4,
    RawVein     = 5,
    Cloak       = 6,
    Focus       = 7,
    Mind        = 8,
    Wall        = 9,
    Speed       = 10,
    Recovery    = 11
};

enum TranscendGroup : u8 {
    Attack  = 0,
    Defense = 1
};

enum TranscendStat : u32 {
    None                      = 0,
    ElementBlademasterPercent = 1,
    ElementGunnerPercent      = 2,
    ElementResistance         = 3,
    Defense                   = 4,
    InitialStatePercent       = 5,
    DurationSeconds           = 6,
    Recovery                  = 7,
    Courage                   = 8,
    SpeedUp                   = 9
};

struct TranscendValue {
    TranscendStat stat;
    u32 value;
};

struct TranscendDepth {
    TranscendEffect effect;
    u8  depth;
    TranscendGroup group        [[comment("Random quest upgrades pick inside a group")]];
    TranscendEffect effectAgain;
    TranscendValue values[4];
    u32 expToReach;
    u16 minTowerRank;
    u8  riteName                [[comment("1 Attack Rite, 2 Defense Rite")]];
    u8  unk2B;
    ItemId upgradeItems[4];
};

TranscendDepth transcendDepths[importantNums.numTranscendDepths]
    @ header.ptrs.transcendDepths
    [[name("Transcend Depths")]];

enum TranscendRankKind : u8 {
    HunterRank = 0,
    GRank      = 1
};

enum TranscendQuestKind : u8 {
    Normal    = 0,
    Hardcore  = 1,
    GRankQuest = 2
};

struct TranscendQuestGain {
    TranscendRankKind rankKind;
    padding[1];
    u16 rankMin;
    u16 rankMax;
    TranscendQuestKind questKind;
    padding[1];
    u16 questLevelMin;
    u16 questLevelMax;
    u16 attackChance            [[comment("Percent")]];
    u16 attackExp;
    u16 defenseChance           [[comment("Percent")]];
    u16 defenseExp;
};

TranscendQuestGain transcendQuestGains[(header.ptrs.transcendDepths - header.ptrs.transcendQuestGains) / 0x14]
    @ header.ptrs.transcendQuestGains
    [[name("Transcend Quest Gains")]];
