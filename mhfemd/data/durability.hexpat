#pragma once

#include <mhfemd/utils/index.pat>

struct EmDurRow {
    s16 partDur[9];
    s16 durMode;
    s16 pad14[7];
};

struct DurTableRef {
    EmDurRow *rows[counts.monsterCount] : u32;
};

DurTableRef durTables[counts.durTableCount] @ header.pDur [[name("Durability Tables")]];
