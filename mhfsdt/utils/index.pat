#pragma once

#include <std/mem.pat>

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

#include <mhfsdt/utils/kind_owner.pat>
