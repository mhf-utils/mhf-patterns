// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>

// DEFAULT DISPLAY: Include header pointers and counts
#include <mhfgao/header.hexpat>

// CONDITIONAL DISPLAY: Include specific modules based on defined flags
#ifdef __DATA_EQUIPMENT
#include <mhfgao/data/equipment.hexpat>
#endif

#ifdef __DATA_FORGING
#include <mhfgao/data/forging.hexpat>
#endif

#ifdef __DATA_MYTRA
#include <mhfgao/data/mytra.hexpat>
#endif

#ifdef __DATA_PARTNYAA
#include <mhfgao/data/partnyaa.hexpat>
#endif

#ifdef __DATA_TREASURE_CORP
#include <mhfgao/data/treasure_corp.hexpat>
#endif
