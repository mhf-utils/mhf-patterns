#pragma once

#include <mhfemd/utils/index.pat>

struct EmUnk50Row {
    u8 unk00[20];
};

struct EmChance5C {
    u16 chance1;
    u16 chance2;
    u16 bonus;
    u16 pad06[13];
};

EmUnk50Row unk50[counts.unk50RowCount] @ header.unk50 [[name("Unknown 0x50 Table")]];
u16 questResultGroups[counts.questResultGroupCount] @ header.pQuestResultGroups [[name("Quest Result Groups")]];
EmChance5C chance5C @ header.pChance5C [[name("Chance 0x5C")]];
