// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>

// DEFAULT DISPLAY: Include header pointer table
#include <mhfpac/header.hexpat>

#ifdef __DECOMPILE
#include <mhfpac/decompile.hexpat>
#endif

// CONDITIONAL DISPLAY: Include specific modules based on defined flags
#ifdef __DATA_CRAFTING
#include <mhfpac/data/crafting.hexpat>
#endif

#ifdef __DATA_DIALOGS
#include <mhfpac/data/dialogs.hexpat>
#endif

#ifdef __DATA_FIXED_TEXTS
#include <mhfpac/data/fixed_texts.hexpat>
#endif

#ifdef __DATA_GUIDE_TOPICS
#include <mhfpac/data/guide_topics.hexpat>
#endif

#ifdef __DATA_KEY_CONFIG
#include <mhfpac/data/key_config.hexpat>
#endif

#ifdef __DATA_PLAYER
#include <mhfpac/data/player.hexpat>
#endif

#ifdef __DATA_TEXT_GROUPS
#include <mhfpac/data/text_groups.hexpat>
#endif

#ifdef __DATA_TEXT_LISTS
#include <mhfpac/data/text_lists.hexpat>
#endif

#ifdef __DATA_UI_TABLES
#include <mhfpac/data/ui_tables.hexpat>
#endif
