#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Player motion events (header 0x618): same layout and bank choice as the
// player motion sounds (player_sounds.hexpat): header 0xA64 + 0x12 banks,
// picked by motion id / 1000 (0 the common bank, 1 the weapon class bank,
// 2 a row from 15 on); a bank lists its motions sorted by id (binary search,
// player_motion_event_bank_run); a motion lists its events. An event runs
// handler `type` of DLL table 0x11A42488 when the motion frame crosses
// `frame` (player_motion_events_run; player_motion_events_run_type8 runs only
// type 8). The dispatcher passes the entity then +4, +6, +8, +9, +0xA, +0xC,
// +0xE; what they mean depends on the type.
// Effect types build an effect_desc_blob_spawn descriptor: effectId goes to
// descriptor +0x40, effectVariant to +0x44; bone is the entity bone
// (entity_bone_matrix_get: skeleton bones below 0x15, weapon bones above);
// follow picks how the effect follows the entity (effect_follow_mode_set:
// 3 copies the entity yaw, 4 the yaw + 90 degrees, 5 nothing, others their
// own callbacks).
// =======================

enum PlayerMotionEventType : u16 {
    WeaponSfx = 0, // FUN_11413D70(sfxId + 2, sfxKind)
    ObjectSpawn = 1, // FUN_114252B0: object of objectKind, objectParam, value / 100
    EffectAtBone = 2, // effect at the bone position, sampled once
    EffectOnBone = 3, // effect tied to the bone (the bone goes in the descriptor)
    EffectFromBone = 4, // FUN_1099A970(0, ...)
    EffectFromBoneOnGround = 5, // FUN_1099A970(1, ...): put on the ground height
    EffectAtBoneOffset = 6, // type 2 with the x / y / z offset
    EffectOnBoneOffset = 7, // type 3 with the x / y / z offset
    StateSet = 8 // per-player motion state slot (0x1E776E88 + slot * 0x5C + player * 0x118)
};

struct PlayerMotionEvent {
    u16 frame;
    PlayerMotionEventType type;
    match (type) {
        (PlayerMotionEventType::WeaponSfx): {
            u16 sfxKind;
            u16 sfxId [[comment("The game passes sfxId + 2")]];
            u8 unk08;
            u8 unk09;
            s16 unk0A[3];
        }
        (PlayerMotionEventType::ObjectSpawn): {
            u16 objectKind;
            u16 value [[comment("Passed as value / 100 (float)")]];
            u8 objectParam;
            u8 unk09;
            s16 unk0A[3];
        }
        (PlayerMotionEventType::StateSet): {
            u16 stateSlot [[comment("0-2")]];
            s16 stateValue;
            u8 unk08;
            u8 unk09;
            s16 unk0A[3];
        }
        (_): {
            u16 effectId;
            u16 effectVariant;
            u8 bone;
            u8 follow;
            s16 offset[3] [[comment("x, y, z; read by types 6 and 7")]];
        }
    }
};

struct PlayerMotionEventMotion {
    u16 motion;
    u16 eventCount;
    PlayerMotionEvent *events[eventCount] : u32;
};

struct PlayerMotionEventBank {
    u16 motionCount;
    padding[2];
    PlayerMotionEventMotion *motions[motionCount] : u32;
};

PlayerMotionEventBank playerMotionEventBanks[header.ptrs.playerSoundBankCount + 0x12]
    @ header.ptrs.playerMotionEventBanks
    [[name("Player Motion Event Banks")]];
