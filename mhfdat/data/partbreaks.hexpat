#pragma once

#include <mhfdat/utils/index.pat>
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

struct PartBreakDropTable {
    PartBreakDrop breakDrops [while(std::mem::read_signed($,2)!=-1)] 
        [[inline]];
} [[inline]];

struct CarveDrop {
    u16 percentage;
    u16 itemID[[format("getItemName")]];
} [[format("carveDropFmt")]];

using CarveDrop;
fn carveDropFmt (CarveDrop n) {
    return std::format("{:02}% {}", n.percentage, getItemName(n.itemID));
};

struct CarveDropTable {
    CarveDrop carves [while(std::mem::read_signed($,2)!=-1)] [[inline]];
} [[inline]];

ptVar<PartBreakDropTable> ptPartBreakDTs[numPartBreakDTs] @ header.ptrs.partBreakItemDrops;
ptVar<CarveDropTable> ptCarveDTs[numCarveDTs] @ header.ptrs.carveItemDrops;

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
