// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>
#include <misc/s32p.pat>

// DEFAULT DISPLAY: Include common data headers and constants
#include <mhfdat/header.hexpat>

#ifdef __DECOMPILE
#include <mhfdat/decompile.hexpat>
#endif

// CONDITIONAL DISPLAY: Include specific modules based on defined flags
#ifdef __DATA_ARENA
#include <mhfdat/data/arena.hexpat>
#endif

#ifdef __DATA_AUTOMATIC_SKILLS
#include <mhfdat/data/automatic_skills.hexpat>
#endif

#ifdef __DATA_CRAFTING
#include <mhfdat/data/crafting.hexpat>
#endif

#ifdef __DATA_DATA_COUNTERS
#include <mhfdat/data/data_counters.hexpat>
#endif

#ifdef __DATA_DECOID
#include <mhfdat/data/decoID.hexpat>
#endif

#ifdef __DATA_EQUIPMENTS
#include <mhfdat/data/equipments.hexpat>
#endif

#ifdef __DATA_EQUIPMENT_COUNTS
#include <mhfdat/data/equipment_counts.hexpat>
#endif

#ifdef __DATA_EXTRA_COUNTERS
#include <mhfdat/data/extra_counters.hexpat>
#endif

#ifdef __DATA_ITEMS
#include <mhfdat/data/items.hexpat>
#endif

#ifdef __DATA_MISSIONS
#include <mhfdat/data/missions.hexpat>
#endif

#ifdef __DATA_MONSTERS
#include <mhfdat/data/monsters.hexpat>
#endif

#ifdef __DATA_PART_BREAKS
#include <mhfdat/data/part_breaks.hexpat>
#endif

#ifdef __DATA_QUESTS
#include <mhfdat/data/quests.hexpat>
#endif

#ifdef __DATA_SEASONAL_EVENTS
#include <mhfdat/data/seasonalevents.hexpat>
#endif

#ifdef __DATA_SHARPNESS
#include <mhfdat/data/sharpness.hexpat>
#endif

#ifdef __DATA_SHOP_ROAD_CAT
#include <mhfdat/data/shop_road_cat.hexpat>
#endif

#ifdef __DATA_SHOP_TOWER_MEDAL
#include <mhfdat/data/shop_tower_medal.hexpat>
#endif

#ifdef __DATA_SHOP
#include <mhfdat/data/shop.hexpat>
#endif

#ifdef __DATA_WEAPONS
#include <mhfdat/data/weapons.hexpat>
#endif