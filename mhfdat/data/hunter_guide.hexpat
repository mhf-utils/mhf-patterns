#pragma once

#include <std/mem.pat>
#include <std/string.pat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Hunter Guide (ハンターの心得) books of My House (header 0x1A0; menu text mhfpac
// pHunterInfoMenuTexts[9]): 4 volumes (Introduction, Items, Advanced, Weapons),
// drawn by hunter_guide_volumes_draw. hunter_guide_topics_page lists the
// chosen volume's topics, 10 a page; hunter_guide_page_draw prints page n of a
// topic (topic +4 [n]). The text is EN, traditional Chinese or JP by file.
// =======================

struct HunterGuidePage {
    std::string::NullString *text : u32;
} [[inline]];

struct HunterGuideTopic {
    std::string::NullString *title : u32;
    u32 n = std::mem::read_unsigned($ + 4, 4);
    HunterGuidePage *pages[n] : u32;
    u32 pageCount;
};

struct HunterGuideVolume {
    std::string::NullString *title : u32;
    s32 n = std::mem::read_signed($ + 4, 4);
    HunterGuideTopic *topics[n] : u32;
    s32 topicCount;
};

HunterGuideVolume hunterGuideVolumes[4] @ header.ptrs.hunterGuideVolumes [[name("Hunter Guide Volumes")]];

// Hunting Horn melody books of the My House bookshelf (header 0x180, 0x184;
// Wii U lbb_putHummerText): one text pointer per page, printed as
// pages[work +0xB2C]. 0x180: "Hunting Horn Songs" (pHunterInfoMenuTexts[0xE],
// listed when item 705 HH Info is owned), 17 pages. 0x184: the ancient Hunting
// Horn score (pHunterInfoMenuTexts[0xF], item 706 Ancient HH Info), 4 pages.
struct HornMelodyPage {
    std::string::NullString *text : u32;
} [[inline]];

HornMelodyPage huntingHornSongPages[importantNums.numHuntingHornSongPages] @ header.ptrs.huntingHornSongPages [[name("Hunting Horn Song Pages")]];
HornMelodyPage ancientHuntingHornScorePages[importantNums.numAncientHuntingHornScorePages] @ header.ptrs.ancientHuntingHornScorePages [[name("Ancient Hunting Horn Score Pages")]];
