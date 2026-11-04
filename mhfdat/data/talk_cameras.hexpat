#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Talk cameras (header 0xB5C to 0xB6C): the camera used when the player talks
// to a town NPC while the "conversation zoom" setting is on (settings state
// +0x11B, save settings +0x68 bit 0x8000). A row is keyed by a town stage id
// (DLL table 0x118C9448 [talk_camera_town_index_get]) and an NPC id. The index
// (0xB60) says which table holds the NPC's camera; NPCs with no index row use
// the DLL default rows (0x11A50590, talk_camera_row_get). Every target is the
// NPC's spawn position (DLL NPC table, lb_set_npc) raised by 75 to 157. talk_camera_npc_excluded
// skips some NPCs (0xC9, 0xF4, 0xF9, 0xFA ... by state). Values are identical
// on the EN, JP and rain files.
// =======================

struct TalkCameraCounts {
    u16 indexCount;
    u16 fixedCount;
    u16 orbitCount;
    u16 sideCount;
    u16 unk08[12];
};

enum TalkCameraKind : u16 {
    Fixed = 0, // talkCamerasFixed (0xB64), talk_camera_fixed_get
    Orbit = 1, // talkCamerasOrbit (0xB68), talk_camera_orbit_apply
    Side = 2 // talkCamerasSide (0xB6C), talk_camera_side_apply
};

struct TalkCameraIndexEntry {
    u32 stage;
    u16 npc;
    TalkCameraKind kind;
};

// talk_camera_fixed_get: copies eye, target and fov into the talk camera
// (eye -> 0x1EDBA024, target -> 0x1EDBA030, fov -> 0x1EDBA03C);
// talk_camera_update then moves the eye along the target-eye line.
struct TalkCameraFixed {
    u16 stage;
    u16 npc;
    float eye[3];
    float eyeAlt[3] [[comment("Used instead of eye when talk_camera_use_alt_check holds: stage 204, NPC 152, HR < 14")]];
    float target[3];
    float targetAlt[3] [[comment("Used with eyeAlt")]];
    float fov;
};

// talk_camera_orbit_apply: the eye circles the target at distance and height,
// its angle taken from the target (FUN_10855830), computed once per talk.
struct TalkCameraOrbit {
    u16 stage;
    u16 npc;
    float distance;
    float height;
    float target[3];
    float fov;
};

// talk_camera_side_apply / talk_camera_side_eye_get: the eye depends on the
// side the player stands on: angle = (player angle from the NPC - NPC yaw)
// + 90 degrees, in 0-359; 91-269 uses eyeB, others eyeA. An all-zero eye
// falls back to the other one.
struct TalkCameraSide {
    u16 stage;
    u16 npc;
    float eyeA[3];
    float eyeB[3];
    float target[3];
    float fov;
    s16 npcYawOffset [[comment("Degrees added to the NPC's yaw when it turns to the player (FUN_106AE4C0)")]];
    u16 unk2E;
};

TalkCameraCounts talkCameraCounts @ header.ptrs.talkCameraCounts [[name("Talk Camera Counts")]];
TalkCameraIndexEntry talkCameraIndex[talkCameraCounts.indexCount] @ header.ptrs.talkCameraIndex [[name("Talk Camera Index")]];
TalkCameraFixed talkCamerasFixed[talkCameraCounts.fixedCount] @ header.ptrs.talkCamerasFixed [[name("Talk Cameras Fixed")]];
TalkCameraOrbit talkCamerasOrbit[talkCameraCounts.orbitCount] @ header.ptrs.talkCamerasOrbit [[name("Talk Cameras Orbit")]];
TalkCameraSide talkCamerasSide[talkCameraCounts.sideCount] @ header.ptrs.talkCamerasSide [[name("Talk Cameras Side")]];
