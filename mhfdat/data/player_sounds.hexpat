#pragma once

/**
	Player motion sounds (header 0x61C): 0x27 + 0x12 banks (0x27 is the value
	of header slot 0xA64), picked by motion id / 1000: 0 the common bank (row
	0), 1 the bank of the weapon class (row class + 1), 2 a row from 15 on. A
	bank lists motions sorted by id (binary search); a motion lists its cues.
	A cue fires at its frame when its condition holds (1 to 4 test the weapon
	or the hunter state), then draws one of up to 4 ids by weight and runs
	its action (0-2 sound and shake, 5 armor sound, 6 and 7 other effects).
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>

struct PlayerSoundChoice {
    u16 id;
    u16 weight;
};

struct PlayerSoundCue {
    u16 frame;
    u16 action;
    u8  condition;
    u8  unk05;
    PlayerSoundChoice choices[4];
};

struct PlayerSoundMotion {
    u16 motion;
    u16 cueCount;
    PlayerSoundCue *cues[cueCount] : u32;
};

struct PlayerSoundBank {
    u16 motionCount;
    padding[2];
    PlayerSoundMotion *motions[motionCount] : u32;
};

PlayerSoundBank playerSoundBanks[header.ptrs.playerSoundBankCount + 0x12]
    @ header.ptrs.playerSoundBanks
    [[name("Player Sound Banks")]];
