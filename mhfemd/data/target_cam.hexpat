#pragma once

#include <mhfemd/utils/index.pat>

struct EmNoTargetMotion {
    u8 allowTarget;
    u8 match15;
    u8 match14;
    u8 pad03;
};

struct EmTargetCamRow {
    u16 flags;
    u16 monsterId;
    s16 joint;
    s16 offset[3];
    s16 unk0C[3];
    s16 stateFrames1;
    s16 stateFrames2;
    s16 cameraParam16;
    s16 cameraParam18;
    u16 noTargetCount;
    if (noTargetCount != 0 && rd32($) != 0)
        EmNoTargetMotion *noTargetMotions[noTargetCount] : u32;
    else
        u32 noTargetMotionsNone;
};

EmTargetCamRow targetCamTable[counts.targetCamRowCount] @ header.pTargetCamTable [[name("Target Camera Table")]];
