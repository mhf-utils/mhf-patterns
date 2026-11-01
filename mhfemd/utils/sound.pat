#pragma once

#include <mhfemd/utils/index.pat>

struct EmSndEntry {
    u16 frame;
    s16 seId;
    s8 joint;
    u8 motionLayer;
    u8 chancePct;
    u8 useSoundCall2;
    s16 emParam1;
    s16 emParam2;
    s16 altSeId;
    s16 emChannelFlag;
};

struct EmSndMot {
    u32 n = rd32($ + 4);
    if (rd32($) != 0 && n > 0)
        EmSndEntry *entries[n] : u32;
    else
        u32 entriesNone;
    u32 count;
};
