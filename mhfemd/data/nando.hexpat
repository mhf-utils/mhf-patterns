#pragma once

#include <mhfemd/utils/index.pat>

struct NandoChoice {
    s8 weight;
    s8 add;
};

struct NandoList {
    NandoChoice choices[while(std::mem::read_signed($, 1) != -1)];
    s8 end;
};

struct NandoRef {
    NandoList *list : u32;
};

NandoRef nandoTables[counts.nandoTableCount] @ header.pNando [[name("Nando Tables")]];
