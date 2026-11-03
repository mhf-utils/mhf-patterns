#pragma once

/**
	Item combining. Two ingredients: the smaller item id is looked up in the
	list of header 0x108 (sorted, ending at 0), and the record at the same
	index in header 0x104 must hold the larger one. Three ingredients, sorted:
	the smallest is looked up in header 0x114 (ending at 0), the bucket at the
	same index in header 0x110 must hold the middle one, and `count` records
	from `firstRecord` in header 0x10C are scanned for the largest.
	The base success rate is a client table indexed by baseSuccessRate (90, 85,
	70, 60, 50, 100 percent); skills and the moon phase change it. The quantity
	made comes from a client table indexed by quantityTable.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

fn combineBaseRate(u8 i) {
    match (i) {
        (0): return "90%";
        (1): return "85%";
        (2): return "70%";
        (3): return "60%";
        (4): return "50%";
        (5): return "100%";
        (_): return std::format("{}", i);
    }
};

bitfield CombineFlags {
    unk0            : 1;
    sureWithSkill   : 1;
    hunterTypeGated : 1;
    unk3            : 5;
};

struct CombineRecord {
    u16 lastIngredient          [[format("getItemName")]];
    u16 result                  [[format("getItemName")]];
    u8  baseSuccessRate         [[format("combineBaseRate")]];
    u8  quantityTable;
    u8  unk06;
    CombineFlags flags;
};

ItemId combinePairIngredientA[while(std::mem::read_unsigned($, 2) != 0)]
    @ header.ptrs.combinePairIngredientA
    [[name("Combine Pair: First Ingredients")]];

CombineRecord combinePairRecords[std::core::member_count(combinePairIngredientA)]
    @ header.ptrs.combinePairRecords
    [[name("Combine Pair: Records")]];

ItemId combineTripleIngredientA[while(std::mem::read_unsigned($, 2) != 0)]
    @ header.ptrs.combineTripleIngredientA
    [[name("Combine Triple: First Ingredients")]];

struct CombineTripleBucket {
    u16 middleIngredient        [[format("getItemName")]];
    u8  count;
    u8  firstRecord;
};

CombineTripleBucket combineTripleBuckets[std::core::member_count(combineTripleIngredientA)]
    @ header.ptrs.combineTripleBuckets
    [[name("Combine Triple: Buckets")]];

fn combineTripleRecordCount() {
    u32 n = 0;
    u32 i = 0;
    while (i < std::core::member_count(combineTripleBuckets)) {
        u32 end = combineTripleBuckets[i].firstRecord + combineTripleBuckets[i].count;
        if (end > n) n = end;
        i += 1;
    }
    return n;
};

CombineRecord combineTripleRecords[combineTripleRecordCount()]
    @ header.ptrs.combineTripleRecords
    [[name("Combine Triple: Records")]];
