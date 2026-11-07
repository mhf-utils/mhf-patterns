#pragma once

#include <std/string.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// My House renovation themes (header 0x260, docs/reverse/my_house.md §3).
// Purchase costs `cost` GCP and sets bit theme - 1 of g_houseOwnedThemes;
// theme 0 is always owned. Each theme gives one model id per part
// (pFacilityRenovationTextGroups[0]), read by lbb_remodel_set and the other
// lbb_remodel_* menus (Wii U slot 0x290).
// =======================

struct MyHouseThemeName {
    std::string::NullString *name : u32;
} [[inline]];

struct MyHouseTheme {
    MyHouseThemeName name;
    u32 cost [[comment("GCP")]];
    u16 floorWallCeiling;
    u16 tableSmall;
    u16 tableLarge;
    u16 kitchen;
    u16 bed;
    u16 bookshelf;
};

MyHouseTheme myHouseThemes[importantNums.numMyHouseThemes] @ header.ptrs.myHouseThemes [[name("My House Themes")]];

// Secret Book armor displays (header 0x52C, Lb_st_mymission_init, Wii U slot 0x558):
// one list per weapon class (className order, 14), until an armor of 0; each
// class's gem armor series (Garnet ... Seiryu GX for Sword and Shield), 18
// pieces of each armor type. A class's display is built only when its Secret
// Book is owned (save ctx +0x23BFC + class, bit 0x80): a piece in the
// equipment box (same kind and id) switches on its stage object (gNsoObjectsArr)
// after the class's base object (DLL table 0x118E75DC) is reset. With 5 armor
// types shown (> 4) the class is complete; all of classes 0-11 complete the
// Hunter Navi task (tab 7, task 5). Visitors see the owner's pieces sent with
// the house. Identical on the EN, JP and rain files.
struct MyHouseArmorDisplayPiece {
    u16 armor [[comment("Row of the armor table of this kind")]];
    u8 kind [[format("getEquipType")]];
    u8 object [[comment("Stage object switched on when the piece is in the box")]];
} [[format("myHouseArmorDisplayPieceName")]];

fn myHouseArmorDisplayPieceName(ref auto p) {
    return std::format("{} | {} | object {}", getEquipType(p.kind), getEquipKindName(p.kind, p.armor), p.object);
};

struct MyHouseArmorDisplay {
    MyHouseArmorDisplayPiece pieces[while(std::mem::read_unsigned($, 2) != 0)];
    u32 end;
};

struct MyHouseArmorDisplays {
    MyHouseArmorDisplay *greatSword : u32;
    MyHouseArmorDisplay *heavyBowgun : u32;
    MyHouseArmorDisplay *hammer : u32;
    MyHouseArmorDisplay *lance : u32;
    MyHouseArmorDisplay *swordAndShield : u32;
    MyHouseArmorDisplay *lightBowgun : u32;
    MyHouseArmorDisplay *dualBlades : u32;
    MyHouseArmorDisplay *longSword : u32;
    MyHouseArmorDisplay *huntingHorn : u32;
    MyHouseArmorDisplay *gunlance : u32;
    MyHouseArmorDisplay *bow : u32;
    MyHouseArmorDisplay *tonfa : u32;
    MyHouseArmorDisplay *switchAxe : u32;
    MyHouseArmorDisplay *magnetSpike : u32;
    u32 unused[2] [[comment("0: the loop stops at 14 classes")]];
};

MyHouseArmorDisplays myHouseArmorDisplays @ header.ptrs.myHouseArmorDisplays [[name("My House Secret Book Armor Displays")]];
