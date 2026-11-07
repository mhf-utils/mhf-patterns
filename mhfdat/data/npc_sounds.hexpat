#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Town NPC motion sounds (header 0x7A8, lb_npc_idle_move -> npc_motion_sounds_play).
// One row per NPC id (EnemyWork +0x510, the id PutNextNpc spawns from the
// stage NPC lists), ended by a 0 row (important numbers + 0x2CA counts it).
// Each event fires while the NPC plays motion 1000 + motion and the frame
// window of `frame` is on: sound `sound` of sound bank `kind` is played at the
// NPC position with sound type 2 (header 0x540). A list ends with motion -1.
// =======================

struct NpcMotionSoundEvent {
    s16 motion [[comment("entity +0x32C - 1000")]];
    u16 kind [[comment("Sound bank (DAT_1E3CBD68 index): 0 -> bank 6 (through npc_motion_sound_bank6_play, more mode checks), 1 -> 1, 2 -> 0, 3 -> 3")]];
    s32 frame;
    s32 sound [[comment("0xFFFF: none")]];
};

struct NpcMotionSoundList {
    NpcMotionSoundEvent events[while(std::mem::read_signed($, 2) != -1)];
    s16 end;
    padding[10];
};

struct NpcMotionSounds {
    s16 npcId [[comment("Compared as a short with EnemyWork +0x510; 0 ends the rows (important numbers +0x2CA has no reader)")]];
    u16 unk02;
    u32 listOffset;
    if (listOffset != 0)
        NpcMotionSoundList list @ listOffset;
};

NpcMotionSounds npcMotionSounds[importantNums.numNpcMotionSounds] @ header.ptrs.npcMotionSounds [[name("NPC Motion Sounds")]];

// =======================
// Entity motion sounds (header 0x50C, entity_motion_sounds_play): rows keyed by
// the entity kind (entity +0x03: 0x2B for town NPC 0xED, 0x2F for the NPCs of
// player_action_update_tick and FUN_10662230, the entity's own kind for
// FUN_10AC6030); every row of the kind runs. A row points to 200 motions
// (motion id 1000-1199), each a cue list. A cue fires at its frame (when
// chance is 0, above 100 or rolled) at the given bone; cues of one group
// (non-zero) play one of them, picked by entity +0x448. The sound is played
// with the row's sound bank and a sound type chosen by FUN_1090EC90.
// =======================

struct EntityMotionSoundCue {
    u16 frame;
    u16 sound [[comment("0xFFFF: none")]];
    u8 bone;
    u8 halkAreaMute [[comment("Kind 0x2F (partnyaa_motion_sound_events), default variant: 1 = silent in HalkArea while DAT_1E76B026 is set")]];
    u8 chance [[comment("Percent; 0 or > 100: always")]];
    u8 soundVariant [[comment("Kind 0x2F: 1 = + mhfgao pGroundSoundTypes of the ground, 2 = + body armor mhfgao pBodyRows .unk08 x 2 + random bit (skipped when >= 9), 3 = town + 2 for Great Sword / field face motion, 4 = BoomBarrelToss / VolpakkunParty only")]];
    u16 group [[comment("Main path: cues of one non-zero group play one of them. Kind 0x2B: 1 = skipped in the field, 2 = skipped in town (entity_motion_sound_cue_condition). Kind 0x2F: alternate sound A")]];
    u16 param0A [[comment("Kind 0x2B: 0 = any, else town == halk_element_get(), field - 1 == FUN_10ACE750() (entity element, 0x1E6CCD6A & 0xF). Kind 0x2F: s16 chance of sound A, out of 8")]];
    u16 param0C [[comment("Kind 0x2B: 0 = any, else town == save ctx +0x21384 byte, field - 1 == byte 0x1E6CCD68 of entity +0x575. Kind 0x2F: alternate sound B")]];
    u16 param0E [[comment("Kind 0x2F: s16 chance of sound B, out of 8 (after A); random 0-7 past both = no sound; +8 to +0xE all 0 = use sound")]];
};

struct EntityMotionSoundMotion {
    u32 cuesOffset;
    s32 cueCount [[comment("test + jle (signed); partnyaa_motion_sound_events reads only the low s16 and also stops at a frame 0 cue")]];
    if (cuesOffset != 0 && cueCount != 0)
        EntityMotionSoundCue cues[cueCount] @ cuesOffset;
};

struct EntityMotionSounds {
    s16 entityKind [[comment("movsx (entity_motion_sound_row_count, entity_motion_sounds_play)")]];
    s16 soundBank [[comment("movsx before the play call")]];
    EntityMotionSoundMotion *motions[200] : u32;
};

EntityMotionSounds entityMotionSounds[importantNums.numEntityMotionSounds] @ header.ptrs.entityMotionSounds [[name("Entity Motion Sounds")]];
