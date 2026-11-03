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
