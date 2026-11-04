#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Stage objects placed at quest start (stage_objects_place, from gGame11).
// Header 0x2BC gives each stage its object budget and its range of points in
// header 0x2B0. For each category (1, 2, then 0) the points of that category
// are tried: shape 0 or 3 takes a random position in the min-max box, other
// shapes the min point; the point's pickGroup draws a result by weight in
// header 0x2B8 (stage_object_pick, rows with a passing condition), and the
// object is added (FUN_1139C550). What the objects are is not traced yet
// (results 300-304 have own rules); header 0x2B4 is part of the system and
// not typed.
// =======================

struct StageObjectIndexEntry {
    s16 stage;
    s16 budget [[comment("Category 1 takes 2, category 2 takes 1, category 0 a share of the rest")]];
    s16 firstPoint;
    s16 pointCount;
};

struct StageObjectIndex {
    StageObjectIndexEntry entries[while(std::mem::read_signed($, 2) >= 0)];
    s16 end[4];
};

enum StageObjectPointShape : s16 {
    RandomBox = 0,
    Fixed1 = 1,
    Fixed2 = 2,
    RandomBox3 = 3
};

struct StageObjectPoint {
    StageObjectPointShape shape;
    u16 category;
    s16 unk04;
    s16 pickGroup;
    float min[3];
    float max[3];
};

struct StageObjectPick {
    s16 group;
    s16 result;
    u8 weight;
    u8 condition [[comment("Tested by stage_object_pick_condition")]];
};

struct StageObjectPicks {
    StageObjectPick picks[while(std::mem::read_signed($, 2) >= 0)];
    s16 end[3];
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
