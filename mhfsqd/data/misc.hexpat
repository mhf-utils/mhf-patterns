#pragma once

#include <mhfsqd/utils/index.pat>

struct Section14Entry {
    u32 unk00;
    Str pData1;
    Str pData2;
};

u8 activeMonsters[counts.activeMonsters] @ header.pActiveMonsters [[name("Active Monsters")]];
u16 section13[counts.section13] @ header.pSection13 [[name("Section 13")]];
Section14Entry section14[counts.section14] @ header.pSection14 [[name("Section 14")]];
