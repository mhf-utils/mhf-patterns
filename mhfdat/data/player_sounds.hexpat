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

/**
	Sound distance (headers 0x548, 0x540, 0x544): apply_sound_and_shake (and
	apply_sound_shake_effect) takes a sound type row from 0x548 (0x53 for one
	raid side, remapped by 0x119DEFD8 in the maze tower), hears the sound up to
	maxDistance, at full level within fullDistance, and between them reads the
	level from a 17-step curve of 0x540 (s8, 127 = full), lerped by distance.
	The sound id is the requested id + soundIdOffset. Proofs:
	tools/mhfdat_re/data/548_notes.md.
*/

#include <mhfdat/data/equipment_counts.hexpat>

struct SoundType {
    float fullDistance [[comment("closer than it: curve step 0 and no pan")]];
    float maxDistance [[comment("not played past it")]];
    u16 curve [[comment("row of soundVolumeCurves (check_player_movement_mode != 1)")]];
    u16 curveAlt [[comment("row used when check_player_movement_mode == 1 (in a raid zone: when FUN_108D03F0 is 0)")]];
    u32 soundIdOffset [[comment("added to the requested sound id; also read by fixed rows: [0] FUN_112D08A0 / FUN_11376E90, [1] em_atk15_thunder, [9] em106_set_bind, [15] FUN_112BEF20, any row FUN_114DCED0")]];
    s16 curve2 [[comment("row of soundCurves2 when < numSoundCurves2, -1 = none")]];
    padding[2];
};

struct SoundVolumeCurve {
    s8 levels[17] [[comment("level by distance step (0 = fullDistance, 16 = maxDistance)")]];
};

struct SoundCurve2 {
    s32 values[17] [[comment("lerped by distance like the level; no use of the result found in apply_sound_and_shake")]];
};

SoundType soundTypes[112] @ header.ptrs.soundTypes [[name("Sound Types")]];
SoundVolumeCurve soundVolumeCurves[139] @ header.ptrs.soundVolumeCurves [[name("Sound Volume Curves")]];
SoundCurve2 soundCurves2[importantNums.numSoundCurves2] @ header.ptrs.soundCurves2 [[name("Sound Curves 2")]];
