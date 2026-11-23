#pragma once

#include <std/mem.pat>
#include <std/io.pat>

using FileOffset = u32;

const u32 DESCRIPTOR_SIZE = 0x1C;
const u32 ROW_A_SIZE = 0x28;
const u32 ROW_B_SIZE = 0x10;
const u32 GROUP_SLOTS_SIZE = 0x20;
const u32 RECORD_D_SIZE = 0x20;

fn rd16(u32 p) { return std::mem::read_unsigned(p, 2); };
fn rd32(u32 p) { return std::mem::read_unsigned(p, 4); };

/// Whether the descriptor at o is the 0xFFFF terminator
fn isTerminator(u32 o) { return rd16(o + 2) == 0xFFFF; };

/// Offset of the descriptor whose table (offset at descriptor +table_field, row count at
/// +count_field, count_size bytes wide) holds addr; 0xFFFFFFFF when no descriptor does.
fn owner_descriptor(u32 addr, u32 table_field, u32 count_field, u32 count_size, u32 row_size) {
    u32 o = 0;
    while (!isTerminator(o)) {
        u32 t = rd32(o + table_field);
        u32 n = std::mem::read_unsigned(o + count_field, count_size);
        if (t != 0 && addr >= t && addr < t + n * row_size)
            return o;
        o = o + DESCRIPTOR_SIZE;
    }
    return 0xFFFFFFFF;
};

/// Shell kind (descriptor id) of the descriptor at o
fn kind_at(u32 o) { return std::mem::read_signed(o + 2, 2); };

#include <mhfsdt/utils/row_owner.pat>
#include <mhfsdt/utils/kind_owner.pat>
