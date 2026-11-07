#pragma once

/**
	Transcend (the Rites): one row per effect and depth (header 0x990,
	important numbers + 0x3A8 of them, 109 on ZZ) and the EXP a quest clear
	gives (header 0x994, rows up to the depth table, 25 on ZZ; no end marker:
	transcend_find_quest_gain_row scans at most 0x1D5 rows and falls back to
	row 0).
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

enum TranscendStat : u8 {
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
    TranscendStat stat         [[comment("Read as a byte (movzx)")]];
    padding[3];
    s32 value                  [[comment("Read signed (cvtsi2ss)")]];
};

struct TranscendDepth {
    TranscendEffect effect;
    u8  depth;
    TranscendGroup group        [[comment("Random quest upgrades pick inside a group")]];
    TranscendEffect effectAgain;
    TranscendValue values[4];
    s32 expToReach              [[comment("Signed compare (transcend_set_exp JL)")]];
    u16 minTowerRank;
    u8  riteName                [[comment("1 Attack Rite, 2 Defense Rite")]];
    u8  minItemCount            [[comment("Of the next depth row (transcend_next_min_item_count): an upgrade item is offered / used only when the player owns at least this many (pouch + box + storage); 0xFF at max depth")]];
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
    u8  attackChance            [[comment("Percent: rand % 100 below it gives the Attack EXP (byte compare, transcend_quest_clear_upgrade)")]];
    padding[1];
    u16 attackExp;
    u8  defenseChance           [[comment("Percent, same roll for the Defense EXP (byte compare)")]];
    padding[1];
    u16 defenseExp;
};

TranscendQuestGain transcendQuestGains[(header.ptrs.transcendDepths - header.ptrs.transcendQuestGains) / 0x14]
    @ header.ptrs.transcendQuestGains
    [[name("Transcend Quest Gains")]];
