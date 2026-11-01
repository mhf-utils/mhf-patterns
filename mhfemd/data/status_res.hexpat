#pragma once

#include <mhfemd/utils/index.pat>

struct EmStatusRes {
    s16 threshold;
    s16 decayInterval;
    s16 decayAmount;
    s16 duration;
    s16 thresholdAdd;
};

struct EmResDat {
    s16 poisonThreshold;
    s16 poisonDecayInterval;
    s16 poisonDecayAmount;
    s16 poisonDamage;
    s16 poisonDuration;
    s16 poisonTickInterval;
    s16 poisonThresholdAdd;
    EmStatusRes mahi;
    EmStatusRes piyo;
    EmStatusRes sleep;
    EmStatusRes sleep2;
    s16 exStatus1Threshold;
    s16 exStatus1Damage;
    s16 exStatus1ThresholdAdd;
    s16 magnetThreshold;
    s16 magnetWindow;
    s16 magnetThresholdGrowthPct;
    s16 pad42;
    u8 resMaxLv[8];
    u32 etcFlags;
};

struct ResTableRef {
    EmResDat *rows[counts.monsterCount] : u32;
};

ResTableRef resDatTables[counts.resDatTableCount] @ header.pResDat [[name("Status Resistance Tables")]];
