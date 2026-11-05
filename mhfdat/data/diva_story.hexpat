#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Diva Story gifts (header 0x7D0): the liking change of an item given to the
// Diva (divaStory_gift_liking). The item is looked up in the pairs; an item
// not listed takes the delta of the item 0 row. Liking (save +0x21327 +
// 0x1A81) stays in 0-999; the reaction text is 9 (up), 10 (no change), 11
// (down), 12 (999 reached) or 13 (0 reached). Important numbers + 0x2DE count
// u16 values, so the rows are half of it.
// =======================

struct DivaStoryGiftLiking {
    ItemId item [[comment("0: default row")]];
    s16 liking;
};

DivaStoryGiftLiking divaStoryGiftLiking[importantNums.numDivaStoryGiftLikingValues / 2] @ header.ptrs.divaStoryGiftLiking [[name("Diva Story Gift Liking")]];

// =======================
// Diva Hall cameras (header 0x7CC): the cameras a Diva Story scene cuts to.
// An actor block of a scenario node (types 0x10 and 0x11) gives a from row, a
// to row and a frame count (version < 8: one byte, used as from and to, with
// 1 frame); divaStory_actor_block_apply and diva_hall_camera_start keep them
// when the player is in the Diva Hall and from is not 0.
// camera_special_scene_handler then calls diva_hall_camera_blend each frame:
// eye and target go from the from row to the to row over the frames. On the
// 135 local scripts every camera change has from = to and 1 frame (ids 1-46).
// No count: 49 rows fit before the next table (8 bytes of zeros after them).
// =======================

struct DivaHallCamera {
    float eye[3];
    float target[3];
};

DivaHallCamera divaHallCameras[49] @ header.ptrs.divaHallCameras [[name("Diva Hall Cameras"), comment("Row 0 is all zeros; from = 0 starts no camera")]];

// Diva Hall actor points (header 0x7C8): where a Diva Story scene puts the
// player (actor 0) or an NPC, and which way it faces. Indexed by a scenario
// byte: the script header entries {u16 actor, u8 point, u8 flag}
// (divaStory_run_scenario warps them on the Diva Hall stage) and the actor block
// entries of nodes 0x10 / 0x11 (divaStory_actor_block_run_entries: tag 3 warps
// to the point, tags 4 / 12 turn to it, divaStory_actor_turn_update turning
// 0x400 a frame from the x / z of the point). No count: 28 rows fit before the
// next table; rows 0 and 27 are zeros; the 135 local scripts use points 0-26.
struct DivaHallActorPoint {
    float pos[3] [[comment("Entity position and pl_destPos (divaStory_actor_set_point_pos)")]];
    u16 yaw [[comment("pl_targetYaw (+0xE) and rotation (+0xA4)")]];
    u16 unk0E [[comment("no reader")]];
};

DivaHallActorPoint divaHallActorPoints[28] @ header.ptrs.divaHallActorPoints [[name("Diva Hall Actor Points")]];
