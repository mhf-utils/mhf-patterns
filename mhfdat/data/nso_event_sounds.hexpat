#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// NSO event sounds (header 0x918): when a stage NSO object requests one of its
// events, nso_object_request_event_and_sound (ECX = object, EDI = event) calls
// FUN_113DE3F0 for the event, then nso_event_sound_find binary-searches the
// objects (importantNums.numNsoEventSoundObjects rows, sorted by objectKind)
// for the object's kind (object +0xBC; kinds 0x32 / 0x33 count as 0x19 / 0x1B).
// nso_event_sound_play_list takes the first event row of the GameWork map
// (+0x34; with the Maze Tower active, maps 71-78 of DLL table 0x119A5B68 all
// match each other) and event id, and queues each sound at the object's
// position (object +0xAC) with se_range_timer_request; gSeRangeTimerCtrl plays
// it through se_req_3D after delayFrames, on the same stage only, and keeps
// the queue slot busy holdFrames more. The queue stores bank, id, requestParam and
// soundType as bytes. FUN_111B3F00 calls nso_event_sound_find the same way.
// =======================

struct NsoEventSound {
    s32 soundBank [[comment("se_req_3D bank (DAT_1E3CBD68 index, apply_sound_shake_effect); < 0 stops the list (JS)")]];
    u32 soundId [[comment("se_req_3D sound id (+ the sound type's soundIdOffset)")]];
    u32 requestParam [[comment("se_req_3D 4th argument, copied to the sound request +4; part of the queue's duplicate key (queued as a byte)")]];
    u32 soundType [[comment("Row of soundTypes (header 0x548)")]];
    u32 requestMode [[comment("se_req_3D last argument: 0 = normal request (apply_sound_shake_effect); 0 on every row")]];
    float unk14 [[comment("Stored in the queue slot +0xC (MOVSS); nothing reads it there. 1500, 0 or 15000 in the data")]];
    s16 holdFrames [[comment("Queue slot +0x10: frames the slot stays busy after the sound plays")]];
    s16 delayFrames [[comment("Queue slot +0x12: frames before the sound plays")]];
};

struct NsoEventSoundEvent {
    s32 mapId [[format("mapIdName"), comment("GameWork map id (+0x34)")]];
    s16 eventId [[comment("Event the object requests (MOVSX)")]];
    padding[2];
    u32 n = std::mem::read_unsigned($ + 4, 4);
    NsoEventSound *sounds[n] : u32;
    u32 soundCount;
};

struct NsoEventSoundObject {
    u32 unk00 [[comment("No reader")]];
    s32 n = std::mem::read_signed($ + 4, 4);
    NsoEventSoundEvent *events[n] : u32;
    s32 eventCount;
    s32 objectKind [[comment("NSO object +0xBC, binary-search key")]];
};

NsoEventSoundObject nsoEventSounds[importantNums.numNsoEventSoundObjects] @ header.ptrs.nsoEventSounds [[name("NSO Event Sounds")]];
