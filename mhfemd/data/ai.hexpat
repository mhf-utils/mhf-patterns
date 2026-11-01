#pragma once

#include <mhfemd/utils/index.pat>
#include <mhfemd/utils/ai.pat>

struct EmAiStatusRow {
    u32 pad00;
    u32 statusKind;
    u32 unk08;
    u16 actionCat;
    u16 actionSub;
    u16 monsterId;
    s16 stage;
    s16 departTimer;
    s16 pad16;
    u32 pad18[2];
};

/// Row count of pack i is pAiStatusPackRowCounts[i]
struct AiPackRef {
    u32 i = ($ - header.pAiStatusPacks) / 4;
    EmAiStatusRow *rows[rd16(header.pAiStatusPackRowCounts + 2 * i)] : u32;
};

struct EmAiOverride {
    MonsterID monsterId;
    u8 mode;
    u8 slot;
    u8 pad03;
    if (rd32($) != 0)
        AiScript *script : u32;
    else
        u32 scriptNone;
};

AiScriptRef aiContents[counts.aiContentsCount] @ header.pAiContents [[name("AI Contents")]];
u16 aiStatusPackRowCounts[counts.aiStatusPackCount] @ header.pAiStatusPackRowCounts [[name("AI Status Pack Row Counts")]];
AiPackRef aiStatusPacks[counts.aiStatusPackCount] @ header.pAiStatusPacks [[name("AI Status Packs")]];
EmAiOverride aiOverrideScripts[counts.aiOverrideCount] @ header.pAiOverrideScripts [[name("AI Override Scripts")]];
