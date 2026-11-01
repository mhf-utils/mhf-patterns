#pragma once

#include <mhfemd/utils/index.pat>

// [mhfo-hd.dll + 0xaf975c]
struct MhfEmdEntry {
    u8 unk00;
    u8 isLarge;
    u8 baseId;
    u8 baseId2;
    u8 bodyGroup;
    u8 sizeClass;
    u8 speciesId;
    u8 sclSetFlag;
    u8 monsterClass;
    u8 eggFlag;
    u8 unk0A;
    u8 pushWeight;
    float baseSize;
    float baseScale;
    float eft01SizeX;
    float eft01SizeZ;
    float mahiEffScale;
    float durVitalResetRate;
    s16 erstimeDie;
    s16 erstimeHokaku;
    s16 atkModeTimer;
    s16 eyeDmgTimer;
    s16 ninshikiModeTimer;
    s16 torabasamiTimer;
    s16 anaLoopTimer;
    u8 unk32;
    u8 elementBlightFlag;
};

MhfEmdEntry prmsys[counts.prmsysCount] @ header.pPrmsys [[name("Monster Params (prmsys)")]];
