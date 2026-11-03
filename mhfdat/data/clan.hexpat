#pragma once

/**
	Clan missions: the part a mission asks to break or cut (header 0xA28,
	important numbers + 0x3D0 of them) and, per Caravan ranking group (11),
	the weights the client rolls a mission with: the slay chance (0xA2C), the
	time limit (0xA30), the reward (0xA34) and its multiplier (0xA38).
	Read by the clan mission roll of mhfo-hd.dll.
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

enum ClanTargetAction : u8 {
    Break = 0,
    Cut   = 1
};

struct ClanMissionTarget {
    u8 monster;
    u8 partCode;
    u8 partNameIndex;
    ClanTargetAction action;
};

struct ClanMissionTimeWeights {
    u8 min5;
    u8 min10;
    u8 min15;
    u8 min20;
};

struct ClanMissionRewardWeights {
    u8 hunterGem;
    u8 zenny;
    u8 cp;
    u8 greatLuck;
    u8 superLuck;
};

struct ClanMissionMultiplierWeights {
    u8 x2;
    u8 x3;
    u8 x4;
    u8 x5;
};

ClanMissionTarget clanMissionTargets[importantNums.numClanMissionTargets]
    @ header.ptrs.clanMissionTargets
    [[name("Clan Mission Targets")]];

u8 clanMissionSlayChances[11] @ header.ptrs.clanMissionSlayChances [[name("Clan Mission Slay Chances"), comment("Percent, per ranking group")]];

ClanMissionTimeWeights clanMissionTimeWeights[11] @ header.ptrs.clanMissionTimeWeights [[name("Clan Mission Time Weights")]];

ClanMissionRewardWeights clanMissionRewardWeights[11] @ header.ptrs.clanMissionRewardWeights [[name("Clan Mission Reward Weights")]];

ClanMissionMultiplierWeights clanMissionMultiplierWeights[11] @ header.ptrs.clanMissionMultiplierWeights [[name("Clan Mission Multiplier Weights")]];
