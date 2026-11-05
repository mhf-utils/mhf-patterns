#pragma once

#include <std/mem.pat>
#include <std/string.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Hunter Dojo rules (header 0x1A8 online, 0x1AC offline; window title mhfpac
// pDojoTexts[5] "Hunter Dojo Code"; Wii U lbtr_put_okite). One text pointer per
// page, printed as pages[getPageNo(rule) + page]: getPageNo sums the page
// counts of the rules before it, from DLL tables (offline 0x118E48BC
// {4,2,3,2,2,1,2,2,1,2,7}, online 0x118E48C8 {4,2,3,2,3,1,2,2,2,2,7}); 10 rules
// are listed, 11 once unlocked. Offline the Instructor speaks, online the
// receptionist. The EN file translates only the offline list.
// =======================
struct DojoRulePage {
    std::string::NullString *text : u32;
} [[inline]];

DojoRulePage dojoRulePagesOnline[importantNums.numDojoRulePagesOnline] @ header.ptrs.dojoRulePagesOnline [[name("Dojo Rule Pages (Online)")]];
DojoRulePage dojoRulePagesOffline[importantNums.numDojoRulePagesOffline] @ header.ptrs.dojoRulePagesOffline [[name("Dojo Rule Pages (Offline)")]];

// Hunter Basics pages (header 0x1A4; window title pDojoTexts[9] "About Hunter
// Basics"; Wii U lbtt_putBasic): one text pointer per page, printed as
// pages[page]; lbtt_basic steps the page up / down modulo 10 (hardcoded, the
// count is read only by the loader).
DojoRulePage hunterBasicsPages[importantNums.numHunterBasicsPages] @ header.ptrs.hunterBasicsPages [[name("Hunter Basics Pages")]];
