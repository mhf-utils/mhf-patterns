#pragma once

#include <mhfsdt/utils/index.pat>

/*
    Debug view: isolates the descriptor TARGET_ID (and TARGET_SUB if >= 0),
    and optionally one of its rows (TARGET_ROW) with the matching table B row
    and hit volume group.
*/

struct DescRaw { u8 raw[DESCRIPTOR_SIZE]; };
DescRaw _skip[while(!isTerminator($) &&
                    (std::mem::read_signed($ + 2, 2) != TARGET_ID ||
                     (TARGET_SUB >= 0 && std::mem::read_signed($, 2) != TARGET_SUB)))] @ 0x00 [[hidden]];
Descriptor target @ sizeof(_skip) [[color("FF7043"), name("Target Descriptor")]];

u32 T = sizeof(_skip);
bool T_OK = std::mem::read_signed(T + 2, 2) == TARGET_ID;
u32 A_OFF = rd32(T + 0x08);
u32 B_OFF = rd32(T + 0x0C);
u32 G_OFF = rd32(T + 0x10);
u32 N_A = rd16(T + 0x04);
u32 N_G = rd16(T + 0x06);
bool ROW_OK = T_OK && TARGET_ROW >= 0 && TARGET_ROW < N_A && A_OFF != 0;
u32 ROW = ROW_OK ? TARGET_ROW : 0;
u32 ROW_G = ROW_OK ? rd16(A_OFF + ROW * ROW_A_SIZE + 0x10) : 0;

#ifdef __DATA_SHELL_ROWS_A
ShellRowA row_a[ROW_OK ? 1 : 0] @ (A_OFF + ROW * ROW_A_SIZE);
#endif
#ifdef __DATA_SHELL_ROWS_B
ShellRowB row_b[(ROW_OK && B_OFF != 0) ? 1 : 0] @ (B_OFF + ROW * ROW_B_SIZE);
#endif
#ifdef __DATA_HIT_VOLUMES
GroupSlots row_group[(ROW_OK && G_OFF != 0 && ROW_G < N_G) ? 1 : 0] @ (G_OFF + ROW_G * GROUP_SLOTS_SIZE);
#endif
