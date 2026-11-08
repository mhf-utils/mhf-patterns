#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Control (button prompt) icons, Wii U MHF_CTL_ICN_TBL (header 0x2F4 - 0x314,
// Wii U slots 0x320 - 0x338). setupMHFIconControlContainer builds up to 4
// icon rows from a descriptor (translateMHFIcon* functions), each row draws
// up to 4 primitives of header 0x2F4.
// 0x2F8: rows by icon id (translateMHFIconSubFunctionManualIconIndex, ids
// 0x72 / 0x73 also take row 0xE5 - id; translateMHFHoldIcon row 99;
// translateMHFArrowIcon, DLL table 0x119A1874; row 24 when nothing matched).
// 0x2FC: rows by DirectInput key code (translateMHFIconKeyConfig keyboard
// branch, ManualKeyboard, EditAssignGroupKeyboard).
// 0x300: rows by pad button bit 0-31 for the bits the 24 assign entries do
// not cover (KeyConfig, AssignController, EditAssignGroupController).
// 0x304 / 0x308 / 0x30C / 0x314: pad rows by icon type (default, 1 and 4
// (also 2 in AssignController), 3, 5), indexed by button bit or by the
// assign row table DLL 0x1185A468 (rows 0-31). HD getIconType always gives
// type 0, so only 0x304 is reached there. 0x310 has no reader (HD or Wii U).
// Rows 32-34 of 0x300 - 0x314 are past every reader bound.
// Counts: important numbers +0xC6 to +0xD6.
// =======================

enum ControlIconPrimitiveKind : u16 {
    Default = 0,
    ArrowMove = 1,
    Blink = 2,
    Shift = 3
};

struct ControlIconPrimitive {
    u8 texture [[comment("0-4: texture id of DLL table 0x1199FC18 (FUN_108F50C0)")]];
    u8 unk01 [[comment("No reader; 0 on all 186 rows")]];
    u16 u [[comment("Texture x (MOVZX), copied to the sprite; u + width = right edge")]];
    u16 v [[comment("Texture y (MOVZX), copied to the sprite; v + height = bottom edge")]];
    s16 width [[comment("MOVSX; drawn width = width x scale >> 12")]];
    s16 height [[comment("MOVSX; drawn height = height x scale >> 12")]];
    s16 scaleDivisor [[comment("The icon scale is divided by it")]];
    ControlIconPrimitiveKind kind;
    match (kind) {
        (ControlIconPrimitiveKind::ArrowMove): {
            u16 direction [[comment("0 up, 1 down, 2 left, 3 right (DLL table 0x1199FC08); above 3 = 0")]];
            s16 periodFrames;
            s16 startDistance [[comment("Times the scale")]];
            s16 endDistance [[comment("Times the scale")]];
        }
        (ControlIconPrimitiveKind::Blink): {
            s16 hiddenFrames;
            s16 shownFrames;
            s16 fadeFrames [[comment("Alpha = step x 0xFF / fadeFrames")]];
            s16 unk14 [[comment("No reader")]];
        }
        (ControlIconPrimitiveKind::Shift): {
            s16 offsetX [[comment("Times the scale")]];
            s16 offsetY [[comment("Times the scale")]];
            s16 unk12 [[comment("No reader")]];
            s16 unk14 [[comment("No reader")]];
        }
        (_): {
            s16 unk0E [[comment("No reader: Default has no handler that reads +0x0E-+0x14")]];
            s16 unk10;
            s16 unk12;
            s16 unk14;
        }
    }
};

enum ControlIconKind : s16 {
    Default = 0,
    Animate = 1
};

struct ControlIcon {
    u8 primitives[4] [[comment("Rows of header 0x2F4; 0 draws nothing")]];
    ControlIconKind kind [[comment("Default draws the 4 primitives, Animate one per frame")]];
    s16 ticksPerFrame [[comment("Animate")]];
    s16 frameCount [[comment("Animate")]];
    u16 unk0A [[comment("No reader; 0 except rows 8 and 9 of header 0x300 (3)")]];
};

struct UnreadControlIcon {
    u8 unk00[4];
    s16 unk04;
    s16 unk06;
    s16 unk08;
    u16 unk0A;
};

ControlIconPrimitive controlIconPrimitives[importantNums.numControlIconPrimitives] @ header.ptrs.controlIconPrimitives [[name("Control Icon Primitives")]];
ControlIcon controlIcons[importantNums.numControlIcons] @ header.ptrs.controlIcons [[name("Control Icons")]];
ControlIcon keyboardControlIcons[importantNums.numKeyboardControlIcons] @ header.ptrs.keyboardControlIcons [[name("Keyboard Control Icons")]];
ControlIcon padButtonBitIcons[importantNums.numPadButtonBitIcons] @ header.ptrs.padButtonBitIcons [[name("Pad Button Bit Icons")]];
ControlIcon padControlIcons[importantNums.numPadControlIcons] @ header.ptrs.padControlIcons [[name("Pad Control Icons")]];
ControlIcon padControlIconsType1[importantNums.numPadControlIconsType1] @ header.ptrs.padControlIconsType1 [[name("Pad Control Icons (Type 1)")]];
ControlIcon padControlIconsType3[importantNums.numPadControlIconsType3] @ header.ptrs.padControlIconsType3 [[name("Pad Control Icons (Type 3)")]];
UnreadControlIcon header310Rows[importantNums.num310Rows] @ header.ptrs.hd_dll_af5c0c [[name("Header 0x310 Rows")]];
ControlIcon padControlIconsType5[importantNums.numPadControlIconsType5] @ header.ptrs.padControlIconsType5 [[name("Pad Control Icons (Type 5)")]];
