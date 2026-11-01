#pragma once

#include <std/mem.pat>
#include <std/core.pat>
#include <misc/MonsterIDs.hexpat>

fn rd8(u32 p) { return std::mem::read_unsigned(p, 1); };
fn rd16(u32 p) { return std::mem::read_unsigned(p, 2); };
fn rd32(u32 p) { return std::mem::read_unsigned(p, 4); };

/// Counts the u32 entries up to and including the 0 terminator
fn count0(u32 p) {
    u32 n = 0;
    while (rd32(p + 4 * n) != 0)
        n = n + 1;
    return n + 1;
};

/// Names entries of tables indexed by monster ID
fn fmtMonsterIndex(auto n) {
    MonsterID m = u8(std::core::array_index());
    return std::format("{}", fmtMonsterID(m));
};
