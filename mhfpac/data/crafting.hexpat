#pragma once

#include <mhfpac/utils/index.pat>

struct WorkshopUpgradeRow {
    u8 materials[0x1C];
    Str title;
    Str text;
};

struct RequestCandidate {
    u16 id;
    u16 countA;
    u16 pointsA;
    u16 countB;
    u16 pointsB;
};

struct RequestCandidateRow {
    RequestCandidate candidates[9];
    u16 unk5A;
    Str texts[6];
};

Rows<WorkshopUpgradeRow,count(0x00)> pWorkshopUpgradeRows @ header.ptrs.pWorkshopUpgradeRows;
Rows<RequestCandidateRow,count(0x01)> pRequestCandidateRows @ header.ptrs.pRequestCandidateRows;
