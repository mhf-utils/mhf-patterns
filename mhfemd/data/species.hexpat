#pragma once

#include <mhfemd/utils/index.pat>

struct EmSpeciesRow {
    u16 respawnSizeMaxPct;
    s16 rewardPoints;
    s8 speciesClass;
    u8 pad05;
};

EmSpeciesRow species[counts.speciesCount] @ header.pSpecies [[name("Species Table")]];
