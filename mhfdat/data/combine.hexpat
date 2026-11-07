#pragma once

/**
	Item combining. Two ingredients: the smaller item id is looked up in the
	list of header 0x108 (sorted, ending at 0), and the record at the same
	index in header 0x104 must hold the larger one. Three ingredients, sorted:
	the smallest is looked up in header 0x114 (ending at 0), the bucket at the
	same index in header 0x110 must hold the middle one, and `count` records
	from `firstRecord` in header 0x10C are scanned for the largest. The record
	scans use the counts at important numbers +0x0C (pair) and +0x0E (triple);
	the buckets end at a 0 middle ingredient.
	The base success rate is a client table indexed by baseSuccessRate (90, 85,
	70, 60, 50, 100 percent); skills and the moon phase change it. The quantity
	made comes from a client table indexed by quantityTable.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

fn combineBaseRate(s8 i) {
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
    needsManual     : 1 [[comment("RenkinCheck (Wii U RenkinCheck): needs skill 0xAD or item 6 in the pouch or box (Wii U lb_itembox_mix_manual_chk(6))")]];
    sureWithSkill   : 1;
    hunterTypeGated : 1;
    excluded        : 1 [[comment("Skipped by itpre_option_chk (Wii U itpre_option_chk), combine_item_has_available_recipe and ItPre_Complete_Chk (flags & 9)")]];
    unk4            : 3;
    isTriple        : 1 [[comment("Record of header 0x10C; ItPre_GetRecipe (Wii U ItPre_GetRecipe) picks the table by it")]];
};

struct CombineRecord {
    u16 lastIngredient          [[format("getItemName")]];
    u16 result                  [[format("getItemName")]];
    s8  baseSuccessRate         [[format("combineBaseRate"), comment("Read signed (item_combination_success_rate_local_player)")]];
    u8  quantityTable;
    u8  recipeNo                [[comment("Unique over both tables: bit of the known-recipe flags at save +0x1F61B; FUN_108d4d20 finds a record by it")]];
    CombineFlags flags;
};

ItemId combinePairIngredientA[while(std::mem::read_unsigned($, 2) != 0)]
    @ header.ptrs.combinePairIngredientA
    [[name("Combine Pair: First Ingredients")]];

CombineRecord combinePairRecords[std::mem::read_unsigned(header.ptrs.important_nums + 0xC, 2)]
    @ header.ptrs.combinePairRecords
    [[name("Combine Pair: Records")]];

ItemId combineTripleIngredientA[while(std::mem::read_unsigned($, 2) != 0)]
    @ header.ptrs.combineTripleIngredientA
    [[name("Combine Triple: First Ingredients")]];

struct CombineTripleBucket {
    u16 middleIngredient        [[format("getItemName")]];
    s8  count                   [[comment("Read signed (movsx)")]];
    u8  firstRecord;
};

CombineTripleBucket combineTripleBuckets[std::core::member_count(combineTripleIngredientA)]
    @ header.ptrs.combineTripleBuckets
    [[name("Combine Triple: Buckets")]];

CombineRecord combineTripleRecords[std::mem::read_unsigned(header.ptrs.important_nums + 0xE, 2)]
    @ header.ptrs.combineTripleRecords
    [[name("Combine Triple: Records")]];
