#pragma once

#include <misc/types.pat>

struct mhfrcc_header {
    ptr pData       [[name("Entries Pointer")]];
    u32 lenData     [[name("Number of entries")]];
    ptr pStrings    [[name("String Pointer Table Pointer")]];
    u32 lenStrings  [[name("Number of strings")]];
    ptr pOrder      [[name("Display Order Pointer")]];
};

mhfrcc_header header @ 0x00 [[name("mhfrcc Header")]];
