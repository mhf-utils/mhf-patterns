#pragma once

#include <mhfsqd/utils/index.pat>

struct PrayerStringEntry {
    Str pNameStr;
    Str pDescriptionStr;
    u16 unk08;
    u16 flags;
};

struct SkillShopEntry {
    u16 skill_id;
    u16 unk02;
    Str skill_name;
    Str skill_description;
    u32 flags;
};

PrayerStringEntry prayers[counts.categoryStrings] @ header.pCategoryStrings [[name("Prayers")]];
SkillShopEntry skillShop[counts.eventEntries] @ header.pEventEntries [[name("Skill Shop")]];
