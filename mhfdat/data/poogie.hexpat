#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Poogie costumes and Skill Cuffs (header 0x224): one byte per costume 0-30
// (names mhfpac pManagerNames[1000 + costume], "First Costume" ...). 1: the
// costume takes Skill Cuffs; 0: it does not (the item check FUN_105511C0
// refuses items of equipType 2, 9 or 12 for the worn costume, and the costume
// list draws those names white, the "restricted" mark of pManagerNames[0x107]).
// The worn costume byte is clamped to 30 by the readers.
// =======================

struct PoogieCostumeSkillCuffs {
    u8 allowsSkillCuffs[31];
    padding[1];
};

PoogieCostumeSkillCuffs poogieCostumeSkillCuffs @ header.ptrs.poogieCostumeSkillCuffs [[name("Poogie Costume Skill Cuffs")]];
