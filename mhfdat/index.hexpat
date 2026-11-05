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

#ifdef __DATA_ARMOR_VISUALS
#include <mhfdat/data/armor_visuals.hexpat>
#endif

#ifdef __DATA_AUTOMATIC_SKILLS
#include <mhfdat/data/automatic_skills.hexpat>
#endif

#ifdef __DATA_CARAVAN
#include <mhfdat/data/caravan.hexpat>
#endif

#ifdef __DATA_CLAN
#include <mhfdat/data/clan.hexpat>
#endif

#ifdef __DATA_COMBINE
#include <mhfdat/data/combine.hexpat>
#endif

#ifdef __DATA_COMBINE_SHOP
#include <mhfdat/data/combine_shop.hexpat>
#endif

#ifdef __DATA_COOKING
#include <mhfdat/data/cooking.hexpat>
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

#ifdef __DATA_DIVA_STORY
#include <mhfdat/data/diva_story.hexpat>
#endif

#ifdef __DATA_EQUIPMENTS
#include <mhfdat/data/equipments.hexpat>
#endif

#ifdef __DATA_EQUIPMENT_COUNTS
#include <mhfdat/data/equipment_counts.hexpat>
#endif

#ifdef __DATA_EQUIPMENT_EFFECTS
#include <mhfdat/data/equipment_effects.hexpat>
#endif

#ifdef __DATA_EQUIP_SHOP
#include <mhfdat/data/equip_shop.hexpat>
#endif

#ifdef __DATA_EVENT_SCENES
#include <mhfdat/data/event_scenes.hexpat>
#endif

#ifdef __DATA_EVOLUTION
#include <mhfdat/data/evolution.hexpat>
#endif

#ifdef __DATA_EXTRA_COUNTERS
#include <mhfdat/data/extra_counters.hexpat>
#endif

#ifdef __DATA_GATHERING
#include <mhfdat/data/gathering.hexpat>
#endif

#ifdef __DATA_GOOCOO
#include <mhfdat/data/goocoo.hexpat>
#endif

#ifdef __DATA_GUILD_ADVENTURE
#include <mhfdat/data/guild_adventure.hexpat>
#endif

#ifdef __DATA_GUILD_COOKING
#include <mhfdat/data/guild_cooking.hexpat>
#endif

#ifdef __DATA_GUILD_HALL_REWARDS
#include <mhfdat/data/guild_hall_rewards.hexpat>
#endif

#ifdef __DATA_GUILD_WEEKLY_BONUS
#include <mhfdat/data/guild_weekly_bonus.hexpat>
#endif

#ifdef __DATA_HALK
#include <mhfdat/data/halk.hexpat>
#endif

#ifdef __DATA_HELP_CAT
#include <mhfdat/data/help_cat.hexpat>
#endif

#ifdef __DATA_HUNTER_GUIDE
#include <mhfdat/data/hunter_guide.hexpat>
#endif

#ifdef __DATA_HUNTING_INFO
#include <mhfdat/data/hunting_info.hexpat>
#endif

#ifdef __DATA_HUNTING_MEDALS
#include <mhfdat/data/hunting_medals.hexpat>
#endif

#ifdef __DATA_ITEMS
#include <mhfdat/data/items.hexpat>
#endif

#ifdef __DATA_ITEM_LISTS
#include <mhfdat/data/item_lists.hexpat>
#endif

#ifdef __DATA_KORYO
#include <mhfdat/data/koryo.hexpat>
#endif

#ifdef __DATA_LEGEND_RASTA
#include <mhfdat/data/legend_rasta.hexpat>
#endif

#ifdef __DATA_LOST_ITEM_REWARDS
#include <mhfdat/data/lost_item_rewards.hexpat>
#endif

#ifdef __DATA_MEOWKA_POT
#include <mhfdat/data/meowka_pot.hexpat>
#endif

#ifdef __DATA_MISSIONS
#include <mhfdat/data/missions.hexpat>
#endif

#ifdef __DATA_MONSTERS
#include <mhfdat/data/monsters.hexpat>
#endif

#ifdef __DATA_MONSTER_SOUNDS
#include <mhfdat/data/monster_sounds.hexpat>
#endif

#ifdef __DATA_MYTRA
#include <mhfdat/data/mytra.hexpat>
#endif

#ifdef __DATA_MY_HOUSE
#include <mhfdat/data/my_house.hexpat>
#endif

#ifdef __DATA_NPC_HUNTERS
#include <mhfdat/data/npc_hunters.hexpat>
#endif

#ifdef __DATA_NPC_SOUNDS
#include <mhfdat/data/npc_sounds.hexpat>
#endif

#ifdef __DATA_PARTNER
#include <mhfdat/data/partner.hexpat>
#endif

#ifdef __DATA_PART_BREAKS
#include <mhfdat/data/part_breaks.hexpat>
#endif

#ifdef __DATA_PIONEER
#include <mhfdat/data/pioneer.hexpat>
#endif

#ifdef __DATA_PLAYER_MOTION_EVENTS
#include <mhfdat/data/player_motion_events.hexpat>
#endif

#ifdef __DATA_PLAYER_SOUNDS
#include <mhfdat/data/player_sounds.hexpat>
#endif

#ifdef __DATA_PLAYER_UNIQUE_PARAMS
#include <mhfdat/data/player_unique_params.hexpat>
#endif

#ifdef __DATA_POOGIE
#include <mhfdat/data/poogie.hexpat>
#endif

#ifdef __DATA_PUBLIC_BAR
#include <mhfdat/data/public_bar.hexpat>
#endif

#ifdef __DATA_QUESTS
#include <mhfdat/data/quests.hexpat>
#endif

#ifdef __DATA_QUEST_REWARDS
#include <mhfdat/data/quest_rewards.hexpat>
#endif

#ifdef __DATA_QUIZ_QUEST
#include <mhfdat/data/quiz_quest.hexpat>
#endif

#ifdef __DATA_RASTA_GUILD
#include <mhfdat/data/rasta_guild.hexpat>
#endif

#ifdef __DATA_ROAD
#include <mhfdat/data/road.hexpat>
#endif

#ifdef __DATA_SEASONAL_EVENTS
#include <mhfdat/data/seasonalevents.hexpat>
#endif

#ifdef __DATA_SECRET_BOOK
#include <mhfdat/data/secret_book.hexpat>
#endif

#ifdef __DATA_SHARPNESS
#include <mhfdat/data/sharpness.hexpat>
#endif

#ifdef __DATA_SHOP
#include <mhfdat/data/shop.hexpat>
#endif

#ifdef __DATA_SHOP_GUILD
#include <mhfdat/data/shop_guild.hexpat>
#endif

#ifdef __DATA_SHOP_ROAD_CAT
#include <mhfdat/data/shop_road_cat.hexpat>
#endif

#ifdef __DATA_SHOP_ROAD_GM
#include <mhfdat/data/shop_road_gm.hexpat>
#endif

#ifdef __DATA_SHOP_TOWER_MEDAL
#include <mhfdat/data/shop_tower_medal.hexpat>
#endif

#ifdef __DATA_SIGILS
#include <mhfdat/data/sigils.hexpat>
#endif

#ifdef __DATA_SIGIL_GEM_CRAFTING
#include <mhfdat/data/sigil_gem_crafting.hexpat>
#endif

#ifdef __DATA_SKILLS
#include <mhfdat/data/skills.hexpat>
#endif

#ifdef __DATA_STAGE_OBJECTS
#include <mhfdat/data/stage_objects.hexpat>
#endif

#ifdef __DATA_STAMP_CARD
#include <mhfdat/data/stamp_card.hexpat>
#endif

#ifdef __DATA_TALK_CAMERAS
#include <mhfdat/data/talk_cameras.hexpat>
#endif

#ifdef __DATA_TITLE_UNLOCKS
#include <mhfdat/data/title_unlocks.hexpat>
#endif

#ifdef __DATA_TOWER
#include <mhfdat/data/tower.hexpat>
#endif

#ifdef __DATA_TRANSCEND
#include <mhfdat/data/transcend.hexpat>
#endif

#ifdef __DATA_TREASURE_CORP
#include <mhfdat/data/treasure_corp.hexpat>
#endif

#ifdef __DATA_TREASURE_HUNT
#include <mhfdat/data/treasure_hunt.hexpat>
#endif

#ifdef __DATA_TUTORIAL
#include <mhfdat/data/tutorial.hexpat>
#endif

#ifdef __DATA_VEGGIE_ELDER
#include <mhfdat/data/veggie_elder.hexpat>
#endif

#ifdef __DATA_WEAPONS
#include <mhfdat/data/weapons.hexpat>
#endif

#ifdef __DATA_WEAPON_ACTIONS
#include <mhfdat/data/weapon_actions.hexpat>
#endif

#ifdef __DATA_WEAPON_PARAMS
#include <mhfdat/data/weapon_params.hexpat>
#endif