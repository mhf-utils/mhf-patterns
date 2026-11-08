#pragma once

#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

// =======================
// Welcome Back items (header 0x16C; Wii U slot 0x170). The Wii U
// draw__15cCA_WELCOMEBACKFv (0x02D5EF18) prints them on its state 3 screen,
// one "%-30.30s%3d" line per row (item name from the item name table, count),
// up to the row whose item is 0. No reader on HD: only the rd_mhfdat walk to
// that row. Same bytes on the EN, JP and rain files.
// =======================

struct WelcomeBackItem {
    u16 item [[format("getItemName"), comment("0 ends the list")]];
    s16 count [[comment("Read signed (Wii U (short) cast, endian type 0xE)")]];
};

struct WelcomeBackItems {
    WelcomeBackItem rows[while(std::mem::read_unsigned($, 2) != 0)];
    WelcomeBackItem end;
};

WelcomeBackItems welcomeBackItems @ header.ptrs.welcomeBackItems [[name("Welcome Back Items")]];
