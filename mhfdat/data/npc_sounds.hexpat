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
    u16 npcId;
    u16 unk02;
    u32 listOffset;
    if (listOffset != 0)
        NpcMotionSoundList list @ listOffset;
};

NpcMotionSounds npcMotionSounds[importantNums.numNpcMotionSounds] @ header.ptrs.npcMotionSounds [[name("NPC Motion Sounds")]];
