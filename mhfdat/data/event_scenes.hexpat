#pragma once

#include <std/mem.pat>
#include <std/core.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Event scenes (header 0x514 / 0x518): scripts run by event_scene_vm_tick
// (event_scene_init picks the script). 0x518 = one pointer per script (24, the
// last 6 null); 0x514 starts with the size of each script in u32 words (24 u16),
// the bytecode follows in the same block. An instruction is a u32 header
// {u16 op, u16 size in words, header included} and its arguments.
// Fixed point: positions and lengths are value / 4096, angles value / 4096
// degrees, scales and the camera zoom value * 0.00001.
// Entity slots index the scene entity table (g_event_scene_entity_ptr, filled by
// BindEntity); handlers that loop with event_scene_foreach_entity_by_type also
// take -1 (all), -2 (players), -3 to -6 (entities of type 3 to 6).
// =======================

enum EventSceneOp : u16 {
    Nop = 0x00, // no handler
    WaitFrame = 0x01, // wait while the scene frame < frame (0 = no wait), unless the end flag is set
    SetEndFrame = 0x02,
    LoadCameraMotion = 0x03, // load_camera_motion_file
    PlayCameraTrack = 0x04, // event_camera_start_playback; end frame = track length when not set
    ResetAimCounters = 0x05,
    SetEventCameraFlag = 0x06, // event camera state bit 8
    LoadEventMotion = 0x07, // load_event_motion_file
    SpawnObject = 0x08, // FUN_113E8F80 -> FUN_113E7BE0
    RemoveObject = 0x09, // FUN_113E7B50: frees the objects whose +0xCE == id
    BindEntity = 0x0A, // event_scene_bind_entity_slot
    BindMonsterBySpawn = 0x0B, // event_scene_bind_monster_by_spawn_index
    BindSpecialEntity = 0x0C, // the travel menu entity, else the monster with unique work 0xE9 (type 5)
    SelectCameraMotion = 0x0D, // event_camera_select_motion
    SetCameraTrackLayout = 0x0E,
    CameraLookAtEntity = 0x0F,
    SetEntityPosition = 0x10, // +0xAC (players also +0x9F0)
    SetEntityPositionOnGround = 0x11, // y from collision_find_ground_heights_at_pos
    SetEntityRotX = 0x12, // +0xA0
    SetEntityYaw = 0x13, // +0xA4 and +0x0E
    SetEntityRotZ = 0x14, // +0xA8
    SetEntityRotation = 0x15,
    MoveEntityX = 0x16,
    MoveEntityY = 0x17,
    MoveEntityZ = 0x18,
    MoveEntity = 0x19,
    RotateEntityYaw = 0x1A,
    RotateEntityPitch = 0x1B,
    RotateEntityRoll = 0x1C,
    RotateEntity = 0x1D,
    SetEntityScale = 0x1E, // event_scene_cb_set_entity_scale_uniform
    SetMonsterCB3 = 0x1F, // monster (type 3) byte +0xCB3
    MonsterStartAction = 0x20, // Monster_StartAction_Seeded (types 3, 6)
    MonsterActionTransition = 0x21, // Monster_ActionTransition_RNG (type 3)
    StartEntityMotion = 0x22, // entity_action_start_motion
    StartEntityMotionLayer = 0x23, // FUN_10850120 (entity_motion_layer_start)
    SetEntityScaleFactor = 0x24, // event_scene_cb_set_entity_scale_factor
    ActivateMonsterHitSphere = 0x25, // Monster_ActivateHitboxSphere
    SetEntityMotion = 0x26, // +0x32C motion, +0x324 blend / 2, +0x31C (FUN_106A8390 / FUN_106A82D0)
    SetEntityAction = 0x27, // FUN_106AAFA0: actCategory / actType
    RequestEntityMotion = 0x28, // entity_request_motion
    RequestEntityOrWeaponMotion = 0x29, // entity_request_motion, else player_set_weapon_motion_id_and_duration
    SetEntityActionState = 0x2A, // set_entity_action_state
    StartEntityMotions = 0x2B, // event_scene_start_entity_motions
    StageObjectsReset = 0x2C, // FUN_113E9210: every gNsoObjectsArr object
    StageObjectsSet = 0x2D, // FUN_113E92A0: every gNsoObjectsArr object
    SpawnEffectAt = 0x2E, // FUN_113D6500 -> FUN_113D6250
    QueueEffectMessage = 0x2F, // effect_msg_queue_request
    SetEntityVisible = 0x30, // event_scene_cb_set_entity_visibility
    PlaySequencerTrack = 0x31, // event_camera_play_sequencer_track
    SetMonsterRecognition = 0x32, // FUN_10854BF0: per-player bits, recognition timers from mhfemd prmsys
    SetMonsterAiState = 0x33, // Monster_AI_SetActiveState
    SetEntityMoveMode = 0x34, // entity byte +0x410
    ReleaseMonster = 0x35, // FUN_1085C310 / FUN_10851D70
    Op36 = 0x36, // FUN_10BAE9D0; no script uses it
    SetEntityShadow = 0x37, // event_scene_cb_set_entity_shadow_flag
    SetEntityStance = 0x38, // toggles entity +0x12 bit 0, resets the action state
    BgmPlay = 0x39, // FUN_10B6D190: g_bgm_target_volume, g_bgm_current_track_id
    BgmOp3A = 0x3A, // FUN_10817670; no script uses it
    BgmOp3B = 0x3B, // FUN_10816EA0; no script uses it
    BgmChannelPlay = 0x3C, // FUN_10816E70: channel target volume 0, music_enqueue_play_task
    BgmApplyVolume = 0x3D, // music_apply_volume
    BgmOp3E = 0x3E, // FUN_10817640; no script uses it
    BgmFadeIn = 0x3F, // music_start_fade_in
    LocalPlayerOp40 = 0x40, // FUN_10B6B7A0(local player); no script uses it
    BgmOp41 = 0x41, // FUN_10816F60; no script uses it
    BgmChannelControl = 0x42, // FUN_10817290: music_cmd_slot_control 1 on the channel's slot
    PlaySe = 0x43, // gSeReq
    SetOnlineMenuRestore = 0x44, // FUN_10B58920: g_event_scene_online_menu_restore
    BgmSelectByArea = 0x45, // bgm_select_track_by_area
    SetA558 = 0x46, // *(DAT_1E73F8B0 + 0xA558) = value
    SetEntityModelEntry = 0x47, // FUN_1078B530 (entity +0x678 rows of 0x1C0, index <= 0x75)
    WaitEnd = 0x48, // wait until the scene frame >= the end frame
    If = 0x49, // event_scene_eval_branch_condition
    Else = 0x4A,
    EndIf = 0x4B,
    End = 0x4C,
    EmActSet = 0x4D, // em_type_act_set
    SetEntityMoveTarget = 0x4E, // players +0x9F0, monsters +0xB24
    SetEntityMoveTargetXZ = 0x4F, // same, y = current y
    SetMonsterParams = 0x50, // monster +0xC9F/+0xA15, +0xCA0/+0xA16, +0xCA2/+0xA18, +0x722
    SetUiMask = 0x51, // g_event_scene_ui_mask; bit 1 (town) locks the menus, bit 8 (town) DAT_11A6F32C
    SetFogNear = 0x52, // render context +0xB4 (saved once)
    RestoreEntityPositions = 0x53, // event_scene_cb_restore_entity_position
    RestoreEntityRotations = 0x54, // event_scene_cb_restore_entity_rotation
    SetCameraPreviewMode = 0x55, // event_camera_set_preview_mode
    SetCameraAngle = 0x56, // g_event_cam_script_angles, camera_transform_and_update
    SetCameraZoom = 0x57, // town only: camera_active_zoom_value, clamped to 0 .. zoom_scale_factor
    PlayEntitySound = 0x58, // entity_bank6_sound_play
    HalkSetAction = 0x59, // FUN_10ACECD0 on a Halk (type 6, +3 == '+')
    HalkSetTarget = 0x5A, // Halk +0x540 = the target slot's sub id (| 0x80 for players)
    ConstructEntity = 0x5B // event_scene_entity_ctor_dispatch (kind < 7)
};

enum EventSceneEntityType : u16 {
    LocalPlayer = 1,
    Player = 2, // by index (< 100)
    Monster = 3, // event_scene_bind_monster_by_species; not in town
    EnemyByVariant = 4,
    EnemyByUniqueWork = 5, // the index-th match
    Halk = 6 // halk_structs id at +3, the index-th match; spawned when none and index 0
};

enum EventSceneCondition : s32 {
    Daytime = 1, // gCurrentTime < 0xA8C0
    Nighttime = 2, // gCurrentTime >= 0xA8C0
    EntityFlag11Off = 3, // entity +0x11 == 0
    EntityFlag11On = 4 // entity +0x11 == 1
};

struct EventSceneInstr {
    EventSceneOp op;
    u16 size;
    match (op) {
        (EventSceneOp::WaitFrame | EventSceneOp::SetEndFrame): s32 frame;
        (EventSceneOp::LoadCameraMotion): s32 cameraMotionId;
        (EventSceneOp::PlayCameraTrack): s32 track;
        (EventSceneOp::SetEventCameraFlag): s32 on;
        (EventSceneOp::SpawnObject): { s32 objectId; s32 position[3]; s32 yaw; }
        (EventSceneOp::RemoveObject): s32 objectId;
        (EventSceneOp::BindEntity): { u16 slot; EventSceneEntityType type; u16 id; u16 index; }
        (EventSceneOp::BindMonsterBySpawn): { u16 slot; u16 spawnIndex; }
        (EventSceneOp::BindSpecialEntity | EventSceneOp::CameraLookAtEntity): s32 slot;
        (EventSceneOp::SelectCameraMotion): s32 motion;
        (EventSceneOp::SetEntityPosition | EventSceneOp::SetEntityMoveTarget): { s32 slot; s32 position[3]; }
        (EventSceneOp::SetEntityPositionOnGround | EventSceneOp::SetEntityMoveTargetXZ): { s32 slot; s32 x; s32 z; }
        (EventSceneOp::SetEntityRotX | EventSceneOp::SetEntityYaw | EventSceneOp::SetEntityRotZ): { s32 slot; s32 angle; }
        (EventSceneOp::SetEntityRotation): { s32 slot; s32 rotX; s32 yaw; s32 rotZ; }
        (EventSceneOp::MoveEntityX | EventSceneOp::MoveEntityY | EventSceneOp::MoveEntityZ): { u16 slot; u16 ticks; s32 delta; }
        (EventSceneOp::MoveEntity): { u16 slot; u16 ticks; s32 delta[3]; }
        (EventSceneOp::RotateEntityYaw | EventSceneOp::RotateEntityPitch | EventSceneOp::RotateEntityRoll): { u16 slot; u16 ticks; s32 angle; }
        (EventSceneOp::RotateEntity): { u16 slot; u16 ticks; s32 angles[3]; }
        (EventSceneOp::SetEntityScale | EventSceneOp::SetEntityScaleFactor): { s32 slot; s32 scale; }
        (EventSceneOp::SetMonsterCB3): { s32 slot; s32 value; }
        (EventSceneOp::MonsterStartAction): { u16 slot; u16 category; s32 action; }
        (EventSceneOp::StartEntityMotion | EventSceneOp::RequestEntityMotion): { s32 slot; s32 motion; s32 arg2; s32 arg3; }
        (EventSceneOp::SetEntityMotion | EventSceneOp::RequestEntityOrWeaponMotion): { s32 slot; s32 motion; s32 blend; s32 param; }
        (EventSceneOp::SetEntityAction | EventSceneOp::SetEntityActionState): { s32 slot; s32 category; s32 type; }
        (EventSceneOp::StartEntityMotions): { s32 slot; s32 motions[3]; }
        (EventSceneOp::QueueEffectMessage): { s32 slot; s32 msgId; s32 variant; s32 soundId; s32 duration; s32 flags; }
        (EventSceneOp::SetEntityVisible | EventSceneOp::SetEntityShadow): { s16 slot; u16 on; }
        (EventSceneOp::SetEntityMoveMode | EventSceneOp::SetEntityStance): { u16 slot; u16 value; }
        (EventSceneOp::BgmPlay): { s32 track; s32 volume; }
        (EventSceneOp::BgmChannelControl): s32 channel;
        (EventSceneOp::PlaySe): { s32 seKind; s32 seId; s32 unk03; }
        (EventSceneOp::SetOnlineMenuRestore | EventSceneOp::SetA558 | EventSceneOp::SetFogNear): s32 value;
        (EventSceneOp::If): { EventSceneCondition condition; s32 slot; }
        (EventSceneOp::SetUiMask): { u32 mask; s32 on; }
        (EventSceneOp::RestoreEntityPositions | EventSceneOp::RestoreEntityRotations | EventSceneOp::PlayEntitySound): s32 slot;
        (EventSceneOp::SetCameraAngle): s32 angle;
        (EventSceneOp::SetCameraZoom): s32 zoom;
        (EventSceneOp::HalkSetTarget): { u16 halkSlot; u16 targetSlot; }
        (EventSceneOp::ConstructEntity): s32 kind;
    }
    u32 used = ($ - addressof(this)) / 4;
    if (size > used) s32 args[size - used] [[comment("Read by the handler's callee, not named")]];
} [[format("eventSceneInstrName")]];

fn eventSceneInstrName(ref auto i) {
    return std::format("{}", i.op);
};

struct EventSceneCode<auto Words> {
    EventSceneInstr instrs[while($ < addressof(this) + Words * 4)];
};

struct EventSceneScript {
    u32 index = std::core::array_index();
    u16 words = std::mem::read_unsigned(header.ptrs.eventSceneScriptSizes + index * 2, 2);
    EventSceneCode<words> *code : u32;
};

u16 eventSceneScriptSizes[24] @ header.ptrs.eventSceneScriptSizes [[name("Event Scene Script Sizes"), comment("u32 words; the bytecode follows")]];
EventSceneScript eventSceneScripts[24] @ header.ptrs.eventSceneScripts [[name("Event Scene Scripts")]];
