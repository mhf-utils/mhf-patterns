#pragma endian little

#include <std/mem.pat>
#include <save/navi.hexpat>

struct HunterNaviSave {
    NaviHeaderFlags flags;
    padding[7];
    NaviTab tabs[14];
    u8 unusedTabs[std::mem::size() - $];
};

HunterNaviSave hunterNavi @ 0x00;
