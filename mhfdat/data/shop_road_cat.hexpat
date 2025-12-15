#pragma once

struct ShopRoadCat {
    u16 itemId;
    u32 unk1;
    u16 pad1;
    u16 itemId2;
    u32 unk2;
    u16 pad2;
};

u32 ShopRoadCatPointer @ 0xB10 [[name("Road Cat Shop Pointer")]];

ShopRoadCat shopRoadCat[while (std::mem::read_unsigned($ + 2, 4) != 0xFFFFFFFF)] @ ShopRoadCatPointer [[name("Data")]];
