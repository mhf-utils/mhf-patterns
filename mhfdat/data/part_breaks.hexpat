#pragma once

#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>
#include <misc/MonsterIDs.hexpat>

struct PartBreakDrop {
    u16 percentage;
    u16 itemID [[format("getItemName")]];
    u16 number;
} [[format("partBreakDropFmt"), single_color]];

using PartBreakDrop;
fn partBreakDropFmt (PartBreakDrop n) {
    return std::format("{:02}% {}x {}", n.percentage, n.number, 
        getItemName(n.itemID));
};

// drop rows end at a 0xFFFF percentage (ZZ: 10 part break rows at most, 15 carve rows)
struct PartBreakDropTable {
    PartBreakDrop breakDrops[while (std::mem::read_unsigned($, 2) != 0xFFFF)] [[inline]];
};

struct CarveDrop {
    u16 percentage;
    u16 itemID[[format("getItemName")]];
} [[format("carveDropFmt")]];

using CarveDrop;
fn carveDropFmt (CarveDrop n) {
    return std::format("{:02}% {}", n.percentage, getItemName(n.itemID));
};

struct CarveDropTable {
    CarveDrop carves[while (std::mem::read_unsigned($, 2) != 0xFFFF)] [[inline]];
};

ptVar<PartBreakDropTable> ptPartBreakDTs[importantNums.numPartBreakDTs] @ header.ptrs.partBreakItemDrops;
ptVar<CarveDropTable> ptCarveDTs[importantNums.numCarveDTs] @ header.ptrs.carveItemDrops;

struct MachaPotReward {
    u16 itemID [[format("getItemName")]];
    u16 number;
};

// 6 rewards per set; the list of sets ends at a null pointer (ZZ: 33 sets)
struct MachaPotSet {
    MachaPotReward rewards[6] [[inline]];
};

ptVar<MachaPotSet> machaPotRewards[while (std::mem::read_unsigned($, 4) != 0)]
    @ header.ptrs.machaPotRewards [[name("Macha Pot Rewards")]];

// The pot item of each set (header 0x164), in the same order, ending at -1:
// collecting a pot looks its item up here and takes the set at that index
ItemId machaPotItems[while (std::mem::read_signed($, 2) != -1)]
    @ header.ptrs.machaPotItems [[name("Macha Pot Items")]];

struct HC_GR_Carve {
    MonsterID monId;
    padding[1];
    u16 item [[format("getItemName")]];
};

HC_GR_Carve GRHCCarves[while(std::mem::read_signed($,2)!=-1)] 
    @ header.ptrs.carveGRHCItemDrops;

struct HC_Carve {
    MonsterID monId;
    padding[1];
    u16 item1 [[format("getItemName")]];
    u16 item2 [[format("getItemName")]];
    u16 item3 [[format("getItemName")]];
    u16 item4 [[format("getItemName")]];
};

HC_Carve HCCarves[while(std::mem::read_signed($,2)!=-1)] @ header.ptrs.carveHCItemDrops;

// Carve kind chances (header 0x6AC): per monster and rank, the percent
// chance of each carve reward kind (carve_kind_roll). The block is picked by
// HR, Secret Book rank (SbGetRank), G rank or G Secret Book rank (GsbGetRank);
// in it the entry whose range holds the rank (from minRank to the next
// entry's minRank - 1, the last range ending at the 999 entry). The rolled
// kind goes to carve_roll_item_by_rank: 0 / 1 / 2 / 6 carve_roll_item slots
// 0 / 1 / 3 / 7, 3-5 the HC drops (carveHCItemDrops), 7 the G HC
// drops, 8 FUN_105DA140; for a locked Zenith (road_spawn_is_locked_zenith)
// kind 8 is skipped and its chance added to kind 2. All chances 0: the
// default reward (FUN_105D9E30).
struct CarveKindEntry {
    u16 minRank;
    u16 unk02;
    u8 chances[16] [[comment("Percent by carve kind")]];
};

struct CarveKindBlock {
    CarveKindEntry entries[8];
};

struct CarveKindChances {
    MonsterID monster;
    padding[3];
    CarveKindBlock hr;
    CarveKindBlock secretBook;
    CarveKindBlock gRank;
    CarveKindBlock gSecretBook;
};

CarveKindChances carveKindChances[importantNums.numCarveKindChanceMonsters] @ header.ptrs.carveKindChances [[name("Carve Kind Chances")]];

// Carve normal items (header 0x6C4; Wii U get_normal_item): the fallback carve
// reward, rolled when the monster's carve list is empty or every item in it is
// filtered out (carve_roll_item, carve_roll_item_zenith), or when all carve
// kind chances are 0 (carve_kind_roll). The first row whose running weight is
// above a % 100 roll is given; the 20 rows of weight 5 sum to 100, so the zero
// rows after them are never reached. The loop bound is important numbers
// +0x262 / 2 (numCarveKindChanceMonsters, another table's count): the rows are
// typed up to the next table instead.
struct CarveNormalItem {
    u16 itemID [[format("getItemName")]];
    u16 weight;
};

CarveNormalItem carveNormalItems[(nextTable(header.ptrs.carveNormalItems) - header.ptrs.carveNormalItems) / 4] @ header.ptrs.carveNormalItems [[name("Carve Normal Items")]];
