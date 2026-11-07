#pragma once

#include <mhfsdt/utils/index.pat>

/*
    The file starts directly with the descriptor table (no header), 0x1C bytes
    per entry, ended by an entry whose id is 0xFFFF. Pointers are only followed
    when the matching __DATA_* module is enabled.
*/
struct Descriptor {
    s16 sub_id;
    s16 id [[color("FF7043")]];
    u16 count_a;
    u16 count_groups;
#ifdef __DATA_SHELL_ROWS_A
    if (rd32($) != 0) ShellRowA *table_a[count_a] : FileOffset; else FileOffset table_a;
#endif
#ifndef __DATA_SHELL_ROWS_A
    FileOffset table_a;
#endif
#ifdef __DATA_SHELL_ROWS_B
    if (rd32($) != 0) ShellRowB *table_b[count_a] : FileOffset; else FileOffset table_b;
#endif
#ifndef __DATA_SHELL_ROWS_B
    FileOffset table_b;
#endif
#ifdef __DATA_HIT_VOLUMES
    if (rd32($) != 0) GroupSlots *groups[count_groups] : FileOffset; else FileOffset groups;
#endif
#ifndef __DATA_HIT_VOLUMES
    FileOffset groups;
#endif
#ifdef __DATA_RECORDS_D
    if (rd32($) != 0) RecordD *table_d[rd32(addressof(sub_id) + 0x18)] : FileOffset; else FileOffset table_d;
#endif
#ifndef __DATA_RECORDS_D
    FileOffset table_d;
#endif
    u32 count_d;
} [[format("desc_fmt")]];

Descriptor descriptors[while(!isTerminator($))] @ 0x00 [[name("Descriptors")]];
s16 terminator_sub_id @ sizeof(descriptors);
u16 terminator_id @ (sizeof(descriptors) + 2) [[color("E53935")]];
