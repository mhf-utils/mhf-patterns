#pragma once

bitfield NaviHeaderFlags {
    introDone : 1;
    padding   : 7;
};

bitfield NaviTabState {
    seen      : 1;
    locked    : 1;
    padding   : 1;
    completed : 1;
    padding   : 4;
};

bitfield NaviTaskFlags {
    done          : 1;
    rewardClaimed : 1;
    detailViewed  : 1;
    tracked       : 1;
    padding       : 4;
};

fn naviTabName(u32 i) {
    match (i) {
        (0):  return "0 Disabled";
        (1):  return "1 HR";
        (2):  return "2 Old SR";
        (3):  return "3 GR";
        (4):  return "4 Sigils";
        (5):  return "5 Conquest";
        (6):  return "6 Diva";
        (7):  return "7 Longplay";
        (8):  return "8 HR4";
        (9):  return "9 Ravi";
        (10): return "10 Various";
        (11): return "11 GR 2";
        (12): return "12 GR 3";
        (13): return "13 Novices";
        (_):  return "Unused";
    }
};

struct NaviTask {
    u32 taskIndex = ($ - addressof(parent) - 2) / 2;
    NaviTaskFlags flags;
    if (parent.tabIndex == 7 && taskIndex >= 8 && taskIndex <= 10)
        u8 gClassWeaponCount;
    else
        padding[1];
};

fn fmtNaviTab(ref auto t) {
    return naviTabName(t.tabIndex);
};

struct NaviTab {
    u32 tabIndex = ($ - addressof(parent) - 8) / 0x22;
    NaviTabState state;
    padding[1];
    NaviTask tasks[16];
} [[format("fmtNaviTab")]];
