// Very large limits just in case, feel free to make these more sensible
#pragma pattern_limit 5000000
#pragma array_limit 200000
#include <std/sys.pat>
#include <std/io.pat>
#include <std/mem.pat>
#include <std/core.pat>
#include <misc/s32p.pat>
#include <misc/types.pat>

#include <misc/ItemIDs.hexpat>
#include <misc/MonsterIDs.hexpat>
#include <misc/MapIDs.hexpat>

#include <quest/objective.hexpat>
#include <quest/block.hexpat>

//#define __DECOMPILE 1

str __header_fail_msg = "File header does not match expected mhfinf header";
u32 header1 @ 0x0 [[comment("Must equal 1A 66 6E 69")]];
u32 header2 @ 0x4 [[comment("Must equal 00 00 00 06")]];
u32 header3 @ 0xC [[comment("Must equal 00 00 00 88")]];

std::assert_warn(header1 == 0x1A666E69, __header_fail_msg);
std::assert_warn(header2 == 0x00000006, __header_fail_msg);
std::assert_warn(header3 == 0x00000088, __header_fail_msg);

u32 hd_dll_afa411 @ 0x10 
    [[name("Inf Quantities")]];
num hd_dll_afa421 @ hd_dll_afa411
    [[name("Number of quest table entries"), comment("Then the sizes of the 28 counter lists")]];

ptr ptQuestTable @ 0x14
    [[name("Pointer to quest table")]];

#ifdef __DECOMPILE
#include <mhfinf/decompile.hexpat>
#endif

// a quest's main block (quest/block.hexpat), the same bytes as in its quest file
struct QuestData {
    // If current address is 0x0, we read a bad pointer, skip to next
    if($==0x00000000) continue;

    QuestBlock block [[inline]];
} [[inline]];

/// Pointer to quest data struct
struct ptQuestData {
    QuestData *qd : u32 [[inline]];
};

// ZZ EN: 44 groups, 3050 slots, 211 null; a quest's id is its block's QuestID
// (most often the previous group's end + its index, not always)
struct QuestTableEntry {
    u16 endID;
    u16 count;
    ptQuestData *ql[count] : u32 [[inline]];
};

QuestTableEntry questTable[hd_dll_afa421] @ ptQuestTable;

// The counters' lists: 28 header pointers (0x18 to 0x84), each to a list of
// tabs whose size follows the group count; a tab is a list of quest ids ending
// at 0 (ZZ EN: 2781 ids, all of them quests of the groups but 8).
struct CounterTab {
    u16 *questIds[while(std::mem::read_unsigned($, 2) != 0)] : u32;
};

struct CounterList {
    ptr tabs;
    u16 count @ hd_dll_afa411 + 2 * (std::core::array_index() + 1);
    CounterTab entries[count] @ tabs;
};

CounterList counterLists[28] @ 0x18 [[name("Counter lists")]];
