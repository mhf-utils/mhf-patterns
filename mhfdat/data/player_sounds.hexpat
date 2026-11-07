#pragma once

/**
	Player motion sounds (header 0x61C): 0x27 + 0x12 banks (0x27 is the value
	of header slot 0xA64), picked by motion id / 1000: 0 the common bank (row
	0), 1 the bank of the weapon class (row class + 1), 2 row 15 in the maze
	tower, row 17 when word [0x1E7FFF3C] +0x14 is 0x1D1, else row 0
	(FUN_1091EB50 turns rows past 0x11 into 0). A bank lists motions sorted by
	id (binary search); a motion lists its cues. A cue fires at its frame when
	its condition holds (1 to 4 test the weapon or the hunter state), then
	draws one of up to 4 ids by weight (choices[0].id when the weights add up
	to 0) and runs its action with it (0xFFFF = nothing): 0 and 2
	se_req_3D, 1 the same with id x 2 + a random 0 / 1, 3 and 4 a
	voice with its face motion (requestSoundEffectPlayer), 5 armor sound, 6 and 7 other
	effects.
*/

#include <std/core.pat>
#include <mhfdat/utils/index.pat>
#include <misc/MonsterIDs.hexpat>

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
	Sound distance (headers 0x548, 0x540, 0x544): se_req_3D (and
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
    u32 soundIdOffset [[comment("added to the requested sound id; also read by fixed rows: [0] FUN_112D08A0 / FUN_112D0A20 / FUN_112D2890 / FUN_11376E90, [1] em_atk15_thunder, [9] em106_set_bind, [15] FUN_112BEF20, any row FUN_114DCED0 / em132_frame_helper_b / em139_effect_move / em140_effect_proj_snd")]];
    u16 curve2 [[comment("row of soundCurves2 when < numSoundCurves2 (unsigned compare), 0xFFFF = none")]];
    padding[2];
};

struct SoundVolumeCurve {
    s8 levels[17] [[comment("level by distance step (0 = fullDistance, 16 = maxDistance)")]];
};

struct SoundCurve2 {
    s32 values[17] [[comment("lerped by distance like the level; se_req_3D passes it to apply_sound_shake_effect as sound parameter +0x20 (flag 0x80)")]];
};

SoundType soundTypes[112] @ header.ptrs.soundTypes [[name("Sound Types")]];
SoundVolumeCurve soundVolumeCurves[139] @ header.ptrs.soundVolumeCurves [[name("Sound Volume Curves")]];
SoundCurve2 soundCurves2[importantNums.numSoundCurves2] @ header.ptrs.soundCurves2 [[name("Sound Curves 2")]];

/**
	Weapon sound banks (header 0x724): the sound bank of each weapon model,
	loaded as sound/o_we%04d.snd (Get_weapon_sndidx, FUN_10B482C0;
	mhfgao pWeaponSoundIds is the Partnyaa copy). 0xFFFF: the default bank of
	the weapon class (DLL table 0x11A422A8). Read only for equipment types 6
	(melee) and 7 (ranged). player_motion_weapon_sound_cases tests banks
	0x1114, 0x112D, 0x11A2, 0x11A5, 0x11EE, 0x11F1 and 0x1278 against motion
	ids for extra sounds.
	The count is important numbers + 0x28E (7001 on the 3 files, then 2
	padding bytes).
*/

u16 weaponModelSoundIds[importantNums.numWeaponModelSoundIds] @ header.ptrs.weaponModelSoundIds [[name("Weapon Model Sound Ids")]];

// Player monster motion banks (header 0xA60, header 0xA64 rows, then one zero
// row the code never reads): when a monster puts the hunter in one of its own
// motions (player_monster_motion_start, player_monster_motion_start_both_layers
// store the monster id, EnemyWork +3, in SkillWork +0x3DC; every ordinary motion
// start clears it), the hunter's motion sounds (0x61C) and motion events (0x618)
// come only from bank 0x12 + row, the first row listing that monster
// (player_motion_sound_bank_by_monster, player_motion_event_bank_by_monster;
// bank 0x12 when none does). This is the only way to reach banks 0x12-0x38.
fn playerMotionMonster(u16 n) {
    if (n == 0)
        return "-";
    MonsterID m = u8(n);
    return std::format("{} {}", n, fmtMonsterID(m));
};

using PlayerMotionMonster = u16 [[format("playerMotionMonster")]];

struct PlayerMonsterMotionBank {
    PlayerMotionMonster monsters[4] [[comment("Monster ids (EnemyWork +3) using this bank, 0 = none")]];
};

PlayerMonsterMotionBank playerMonsterMotionBanks[header.ptrs.playerSoundBankCount] @ header.ptrs.playerMonsterMotionBanks [[name("Player Monster Motion Banks")]];

// Voice face motions (header 0x97C male, 0x980 female; PlayerWork +0x11 picks
// the table). When the hunter plays a sound (player_sound_play_with_face_motion),
// player_voice_face_motion_find looks for a row with the hunter's voice
// (+0xB7B), then one with voice 0, and the sound id; a non-zero faceMotion is
// played on face channel 1 for duration ticks, blended in over blendFrames + 1
// steps. Nothing is queued when the PL_FACIAL option is on.
struct VoiceFaceMotion {
    u16 voice [[comment("PlayerWork +0xB7B voice to match, 0 = any voice")]];
    u16 soundId;
    u16 faceMotion [[comment("Added to the channel 1 base motion (0xD48 male / 0x1130 female); 0 = no change")]];
    u8 duration;
    u8 blendFrames [[comment("0 = instant")]];
};

VoiceFaceMotion voiceFaceMotionsMale[importantNums.numVoiceFaceMotionsMale] @ header.ptrs.voiceFaceMotionsMale [[name("Voice Face Motions (Male)")]];
VoiceFaceMotion voiceFaceMotionsFemale[importantNums.numVoiceFaceMotionsFemale] @ header.ptrs.voiceFaceMotionsFemale [[name("Voice Face Motions (Female)")]];
