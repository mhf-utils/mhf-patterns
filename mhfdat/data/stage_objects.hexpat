#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Stage objects placed at quest start (stage_objects_place, from gGame11 through
// FUN_1139B6E0 / FUN_1139B750). Header 0x2BC gives each stage its object budget
// and its range of points in header 0x2B0. Categories are placed in the order
// 1, 2, 0: category 1 places 2 objects (6 tries each, its own random seed),
// category 2 one object (3 tries), category 0 a random share of the budget left
// (stage_objects_common_share). A point of the category is drawn with a weight of its box area
// (FixedPoint: once per run), its position is random in the box or the min
// corner, its yaw is yawDegrees +/- 20 degrees (-1: any yaw). Its pickGroup
// draws a result and a variant by weight in header 0x2B8 among the rows that
// pass stage_object_pick_condition; stage_object_position_is_free then checks
// the position, and stage_object_add adds the object (result, variant, shape,
// category, yaw, position). Header 0x2B4 says how each (result, variant) object
// is spawned. Objects whose kind has clearance > 0.99 are capped at 2 a stage
// (4 when more than one category 1 object of results 300-303 is placed).
// What the objects are in game is not traced (results 300-310 depend on server
// values of the stage).
// =======================

struct StageObjectIndexEntry {
    s16 stage;
    s16 budget [[comment("Category 1 takes 2, category 2 takes 1, category 0 a random share of the rest")]];
    s16 firstPoint;
    s16 pointCount;
};

struct StageObjectIndex {
    StageObjectIndexEntry entries[while(std::mem::read_signed($, 2) >= 0)];
    s16 end[4];
};

enum StageObjectPointShape : s16 {
    RandomInBox = 0, // random position in the min-max box, weight = box area
    FixedPoint = 1, // the min point, used once per run
    ExclusionBox = 2, // category 0 only: no object inside the box (+ its radius)
    RandomInBox3 = 3 // read as RandomInBox by every reader
};

enum StageObjectCategory : u16 {
    Common = 0, // results 400-409, 1200 and 1208 are checked against the objects already placed (stage_objects_count_result counts)
    StageState = 1, // results 300-304: allowed when the stage's server value (FUN_108E4650) is 1-5
    ScoreLevel = 2 // results 305-310: allowed when FUN_108E4800 (a score / 8 or 10) is 0-5
};

struct StageObjectPoint {
    StageObjectPointShape shape;
    StageObjectCategory category;
    s16 yawDegrees [[comment("-1: any yaw; else +/- 20 degrees (stage_object_yaw_roll)")]];
    s16 pickGroup;
    float min[3];
    float max[3];
};

struct StageObjectPick {
    s16 group [[comment("A point's pickGroup")]];
    s16 result;
    u8 weight;
    u8 variant [[comment("With result, the key of the object kind (header 0x2B4); stored on the object")]];
};

struct StageObjectPicks {
    StageObjectPick picks[while(std::mem::read_signed($, 2) >= 0)];
    s16 end[3];
};

// How each (result, variant) object is spawned (header 0x2B4,
// stage_object_kind_find); ends at a negative result. stage_objects_spawn: a
// random yaw, a random color (each channel in its range, then scaled by the
// stage light color when there is one) and a random scale. 
// stage_object_position_is_free rejects a position closer than radius + the
// other object's radius to a placed object, closer than clearance + 200 when
// clearance > 0, inside an exclusion box (+ radius) or a quest file area.
bitfield StageObjectKindFlags {
    randomYaw : 1;
    randomColor : 1;
    randomColorAlt : 1 [[comment("Tested with randomColor (mask 6); not set in the data")]];
    padding : 5;
};

struct StageObjectKind {
    s16 result;
    StageObjectKindFlags flags;
    u8 variant;
    float clearance [[comment("> 0.99: a large object (capped per stage)")]];
    float radius;
    s16 red[2] [[comment("min, max; -1: none")]];
    s16 green[2];
    s16 blue[2];
    float scaleMin [[comment("> 0: random scale up to scaleMax; -1: none")]];
    float scaleMax;
};

struct StageObjectKinds {
    StageObjectKind kinds[while(std::mem::read_signed($, 2) >= 0)];
    s16 end[16];
};

StageObjectIndex stageObjectIndex @ header.ptrs.stageObjectIndex [[name("Stage Object Index")]];
StageObjectPoint stageObjectPoints[1419] @ header.ptrs.stageObjectPoints [[name("Stage Object Points"), comment("1419 = the end of the last index range on the 3 files")]];
StageObjectPicks stageObjectPicks @ header.ptrs.stageObjectPicks [[name("Stage Object Picks")]];

// Companion stage points (header 0x8C8): where an entity tied to an owner
// player (entity +0x522; one of the kinds run by FUN_10AC6030, not identified)
// is put in the owner's stage, facing lookAt. companion_place_by_state
// (owner state 2-7) and companion_place_by_index (state 0xE + n: the n-th
// point of the stage) pick a point of the stage; companion_stage_point_count
// counts them.
struct CompanionStagePoint {
    float position[3];
    float lookAt[3];
    s16 stage;
    padding[2];
};

CompanionStagePoint companionStagePoints[importantNums.numCompanionStagePoints] @ header.ptrs.companionStagePoints [[name("Companion Stage Points")]];
StageObjectKinds stageObjectKinds @ header.ptrs.stageObjectKinds [[name("Stage Object Kinds")]];
