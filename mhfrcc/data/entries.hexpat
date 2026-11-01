#pragma once

#include <mhfrcc/utils/index.pat>

struct Entry {
    u32      flags;
    s16      diva_x;
    s16      diva_y;
    s16      diva_z;
    s16      diva_rot;
    s16      player_pos_x;
    s16      player_pos_y;
    s16      player_pos_z;
    s16      player_rot;
    RString  pTitle;
    RString  pDescription;
    RString  pExtend1;
    RString  pExtend2;
};

Entry entries[header.lenData] @ header.pData [[name("Entries")]];
