#pragma once

#include <mhfdat/utils/index.pat>

// =======================
// Header 0x340 / 0x344 / 0x348: one 8-byte row each, the same bytes on the
// 3 files. No reader on HD (no read through the mhfdat global) or Wii U
// (slots 0x368 - 0x370); only rd_mhfdat relocates them.
// =======================

struct TicketRow {
    u16 unk00 [[format("getItemName"), comment("No reader; 0x65E HL Tkt, 0x65F EX Tkt, 0x660 CA Tkt")]];
    u16 unk02 [[comment("No reader; 5 on the 3 files")]];
    u32 unk04 [[comment("0 on the 3 files")]];
};

TicketRow header340Row @ header.ptrs.hd_dll_af5c3c [[name("Header 0x340 Row")]];
TicketRow header344Row @ header.ptrs.hd_dll_af5c42 [[name("Header 0x344 Row")]];
TicketRow header348Row @ header.ptrs.hd_dll_af5c48 [[name("Header 0x348 Row")]];
