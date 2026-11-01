#pragma once

#include <mhfemd/utils/index.pat>

using EmMultRow;
fn fmtEmMultRow(EmMultRow r) {
    MonsterID m = u8(r.monsterId);
    return std::format("{} | {}", fmtMonsterID(m), r.hagiLv);
};

struct EmMultRow {
    u16 monsterId;
    /**
        0 = Low-rank
        1 = High-rank
        3 = Gou
        7 = G-Rank
        -1 = ???
     */
    s16 hagiLv;
    float attack;
    float defense;
    float enragedAttack;
    float enragedDefense;
    float hp;
    float flinch;
} [[format("fmtEmMultRow")]];

struct EmVariantMult {
    u16 monsterId;
    u16 variant;
    u32 statKind;
    float mult;
};

EmMultRow hcValues[counts.hcRowCount] @ header.pHcValues [[name("HC Values")]];
EmMultRow ulValues[counts.ulRowCount] @ header.pUlValues [[name("UL Values")]];
EmVariantMult variantMults[counts.variantMultCount] @ header.pVariantMults [[name("Variant Multipliers")]];
