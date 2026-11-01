// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>
#include <std/mem.pat>
#include <std/core.pat>

// DEFAULT DISPLAY: Include header pointers and entry counts
#include <mhfemd/header.hexpat>

#ifdef __DECOMPILE
#include <mhfemd/decompile.hexpat>
#endif

// CONDITIONAL DISPLAY: Include specific modules based on defined flags
#ifdef __DATA_AI
#include <mhfemd/data/ai.hexpat>
#endif

#ifdef __DATA_ALT_SND_TABLES
#include <mhfemd/data/alt_snd_tables.hexpat>
#endif

#ifdef __DATA_ARENA
#include <mhfemd/data/arena.hexpat>
#endif

#ifdef __DATA_DAMAGE_RATES
#include <mhfemd/data/damage_rates.hexpat>
#endif

#ifdef __DATA_DURABILITY
#include <mhfemd/data/durability.hexpat>
#endif

#ifdef __DATA_ENTRIES
#include <mhfemd/data/entries.hexpat>
#endif

#ifdef __DATA_MISC
#include <mhfemd/data/misc.hexpat>
#endif

#ifdef __DATA_MONSTER_STATS
#include <mhfemd/data/monster_stats.hexpat>
#endif

#ifdef __DATA_MULTIPLIERS
#include <mhfemd/data/multipliers.hexpat>
#endif

#ifdef __DATA_NANDO
#include <mhfemd/data/nando.hexpat>
#endif

#ifdef __DATA_SPECIES
#include <mhfemd/data/species.hexpat>
#endif

#ifdef __DATA_STATUS_RES
#include <mhfemd/data/status_res.hexpat>
#endif

#ifdef __DATA_TARGET_CAM
#include <mhfemd/data/target_cam.hexpat>
#endif

#ifdef __DATA_TONFA_GAUGE
#include <mhfemd/data/tonfa_gauge.hexpat>
#endif
