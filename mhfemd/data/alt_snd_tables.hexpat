#pragma once

#include <mhfemd/utils/index.pat>
#include <mhfemd/utils/ai.pat>
#include <mhfemd/utils/sound.pat>

/*
    Unreferenced sound tables, sitting right after the last AI script
    (aligned to 0x20)
*/

struct EmAltSndTbl {
    u16 monsterId;
    u16 unk02;
    if (rd32($) != 0)
        EmSndMot *sndTbl[200] : u32;
    else
        u32 sndTblNone;
};

fn altSndTblsAt() {
    u32 m = 0;
    u32 i = 0;
    while (i < counts.aiContentsCount) {
        u32 p = rd32(header.pAiContents + 4 * i);
        if (p > m) m = p;
        i = i + 1;
    }
    i = 0;
    while (i < counts.aiOverrideCount) {
        u32 q = rd32(header.pAiOverrideScripts + 8 * i + 4);
        if (q > m) m = q;
        i = i + 1;
    }
    return (aiScriptEnd(m) + 31) / 32 * 32;
};

EmAltSndTbl unusedAltSndTbls[while(rd32($ + 4) != 0)] @ altSndTblsAt() [[name("Unused Alt Sound Tables")]];
