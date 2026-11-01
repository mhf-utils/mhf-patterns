#pragma once

#include <mhfemd/utils/index.pat>

struct EmArenaChance {
    u8 levelUpChance[20];
};

struct EmArenaRow {
    MonsterID monsterId;
    u8 pad01[3];
    if (rd32($) != 0)
        EmArenaChance *chances : u32;
    else
        u32 chancesNone;
    float hpMult;
};

EmArenaRow arenaEmTable[counts.arenaEmCount] @ header.pArenaEmTable [[name("Arena Monster Table")]];
float arenaNandoVital[counts.arenaNandoVitalCount] @ header.pArenaNandoVital [[name("Arena Nando Vital")]];
