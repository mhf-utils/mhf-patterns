#pragma once

#include <mhfemd/utils/index.pat>
#include <mhfemd/utils/sound.pat>

const u32 MONSTAT_ROW_SIZE = 0xC0;
const u32 MONSTAT_MEAT_DAT = 0x0C;
const u32 MONSTAT_MEAT_SET_COUNT = 0x3C;
const u32 MONSTAT_MOT_ADJ = 0xB0;

struct monsterStatRow {
    float vital [[comment("This is a multiplier for the base hp, which varies by monster!")]];
    float attack;
    float defence;
    float dur;
    float torabasami;
    float ana;
};

struct HzvPart {
    u8 unk00;
    u8 cut;
    u8 impact;
    u8 shot;
    s8 fire;
    s8 water;
    s8 ice;
    s8 thunder;
    s8 dragon;
    u8 stun;
};

struct IkariData {
    u16 rageThreshold;
    u16 duration [[comment("How long enrage lasts in frames")]];
    float speedMult;
    float attackMult;
    float defenseMult;
    float rageGainMult[11] [[comment("How quickly enrage builds. Starts at 100% hp, then 90%, etc.")]];
    float pad3C;
};

struct MonsterMotionEffectEntry {
    float fParam[8];
    s16 sParam[4];
};

/// meatDat[i] holds 7 * meatSetCount[i] hitzones, the count lives later in the same row
struct HzvSetRef {
    u32 o = $ - header.pMonStatTable;
    u32 row = header.pMonStatTable + (o / MONSTAT_ROW_SIZE) * MONSTAT_ROW_SIZE;
    u32 n = rd8(row + MONSTAT_MEAT_SET_COUNT + ((o % MONSTAT_ROW_SIZE) - MONSTAT_MEAT_DAT) / 4);
    if (rd32($) != 0 && n > 0)
        HzvPart *sets[7 * n] : u32;
    else
        u32 none;
};

struct IkariRef {
    if (rd32($) != 0)
        IkariData *data : u32;
    else
        u32 none;
};

/// Number of 200-entry motion effect blocks at p, guessed from the next known pointer
fn motAdjTypes(u32 p) {
    u32 next = std::mem::size();
    u32 i = 0;
    while (i < HEADER_SIZE) {
        u32 t = rd32(i);
        if (t > p && t < next) next = t;
        i = i + 4;
    }
    u32 m = 0;
    while (m < counts.monsterCount) {
        u32 q = rd32(header.pMonStatTable + m * MONSTAT_ROW_SIZE + MONSTAT_MOT_ADJ);
        if (q > p && q < next) next = q;
        m = m + 1;
    }
    if (next - p < 8000) return 1;
    return (next - p) / 8000;
};

// [mhfo-hd.dll + 0xaf96d8]
struct MonStatRow {
    u8 nandoTableIdx[2];
    s8 nandoAdd[3];
    s8 sclAdd[3];
    monsterStatRow *stats[84] : u32;
    HzvSetRef meatDat[12];
    u8 meatSetCount[12];
    /**
        [3]  = Goushu
        [7]  = GR
        [8]  = Something
        [9]  = Zenith
        [11] = Something
     */
    IkariRef ikari[12];
    float hinshiPer[12];
    s16 vital[4];
    u32 motAdjTypeCount = motAdjTypes(rd32($));
    if (rd32($) != 0)
        MonsterMotionEffectEntry *motAdj[200 * motAdjTypeCount] : u32;
    else
        u32 motAdjNone;
    u32 unkB4;
    if (rd32($) != 0)
        EmSndMot *sndTbl[200] : u32;
    else
        u32 sndTblNone;
    u8 groundProbeRadiusPct;
    u8 padBD[3];
} [[format("fmtMonsterIndex")]];

MonStatRow monStatTable[counts.monsterCount] @ header.pMonStatTable [[name("Monster Stat Table")]];
