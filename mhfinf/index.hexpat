// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>

// DEFAULT DISPLAY: Include header pointers and counts
#include <mhfinf/header.hexpat>

// CONDITIONAL DISPLAY: Include specific modules based on defined flags
#ifdef __DATA_QUESTS
#include <mhfinf/data/quests.hexpat>
#endif

#ifdef __DATA_QUEST_LISTS
#include <mhfinf/data/quest_lists.hexpat>
#endif
