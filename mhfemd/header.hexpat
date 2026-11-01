#pragma once

#include <misc/types.pat>

const u32 HEADER_SIZE = 0x60;

struct ptr_table {
    // [mhfo-hd.dll + 0xaf96a1]
    ptr pEntryCounts            [[name("Entry Counts Pointer")]];
    ptr pDur                    [[name("Durability Tables Pointer")]];          // hd_dll_af96ab
    ptr pPrmsys                 [[name("Monster Params (prmsys) Pointer")]];    // hd_dll_af975c
    ptr pMonStatTable           [[name("Monster Stat Table Pointer")]];

    // + 0x10
    ptr pResDat                 [[name("Status Resistance Tables Pointer")]];   // hd_dll_af975f
    ptr pSpecies                [[name("Species Table Pointer")]];              // hd_dll_af977b
    ptr pNando                  [[name("Nando Tables Pointer")]];               // hd_dll_af96be
    ptr pArenaEmTable           [[name("Arena Monster Table Pointer")]];        // hd_dll_af9778

    // + 0x20
    ptr pArenaNandoVital        [[name("Arena Nando Vital Pointer")]];          // hd_dll_af97a3
    ptr pAiContents             [[name("AI Contents Pointer")]];                // hd_dll_af97a0
    ptr pTonfaGaugeLists        [[name("Tonfa Gauge Lists Pointer")]];          // hd_dll_af97c4
    ptr pTonfaGaugeGroup        [[name("Tonfa Gauge Group Pointer")]];          // hd_dll_af97fa

    // + 0x30
    ptr pTonfaGaugeDamageRate   [[name("Tonfa Gauge Damage Rate Pointer")]];    // hd_dll_af97fd
    ptr pHcValues               [[name("HC Values Pointer")]];
    ptr pVariantMults           [[name("Variant Multipliers Pointer")]];        // hd_dll_af9803
    ptr pAiStatusPackRowCounts  [[name("AI Status Pack Row Counts Pointer")]];  // hd_dll_af9806

    // + 0x40
    ptr pAiStatusPacks          [[name("AI Status Packs Pointer")]];            // hd_dll_af97f7
    ptr pAiOverrideScripts      [[name("AI Override Scripts Pointer")]];        // hd_dll_af982b
    ptr pDamageRates            [[name("Damage Rates Pointer")]];               // hd_dll_af984b
    ptr pTargetCamTable         [[name("Target Camera Table Pointer")]];        // hd_dll_af9854

    // + 0x50
    ptr unk50                   [[name("Unknown 0x50 Table Pointer")]];         // hd_dll_af987c
    ptr pQuestResultGroups      [[name("Quest Result Groups Pointer")]];        // hd_dll_af987f
    ptr pUlValues               [[name("UL Values Pointer")]];
    ptr pChance5C               [[name("Chance 0x5C Pointer")]];                // hd_dll_af9885
};

struct entry_counts {
    u16 durTableCount;
    u16 prmsysCount;
    u8  monsterCount;
    u8  pad05;
    u16 resDatTableCount;
    u16 speciesCount;
    u16 nandoTableCount;
    u16 arenaEmCount;
    u16 arenaNandoVitalCount;
    u16 aiContentsCount;
    u16 hcRowCount;
    u16 variantMultCount;
    u16 aiStatusPackCount;
    u16 aiOverrideCount;
    u16 damageRateRowCount;
    u16 targetCamRowCount;
    u16 unk50RowCount;
    u16 questResultGroupCount;
    u16 ulRowCount;
    u16 chance5CCount;
};

ptr_table header @ 0x0                      [[name("Top level pointer table")]];
entry_counts counts @ header.pEntryCounts   [[name("Entry Counts")]];
