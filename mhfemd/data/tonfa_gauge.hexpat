#pragma once

#include <mhfemd/utils/index.pat>

struct EmPartGaugeRow {
    u16 threshold[9];
    u16 step[9];
    u16 unk24[9];
    u16 unk36[9];
    s16 effectType[9];
};

struct PartGaugeRef {
    if (rd32($) != 0)
        EmPartGaugeRow *rows[counts.monsterCount] : u32;
    else
        u32 end;
};

PartGaugeRef tonfaGaugeLists[count0(header.pTonfaGaugeLists)] @ header.pTonfaGaugeLists [[name("Tonfa Gauge Lists")]];
s16 tonfaGaugeGroup[counts.monsterCount * 9] @ header.pTonfaGaugeGroup [[name("Tonfa Gauge Group")]];
float tonfaGaugeDamageRate[counts.monsterCount * 9] @ header.pTonfaGaugeDamageRate [[name("Tonfa Gauge Damage Rate")]];
