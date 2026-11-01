// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>

// DEFAULT DISPLAY: Include header pointers and counts
#include <mhfnav/header.hexpat>

// CONDITIONAL DISPLAY: Include specific modules based on defined flags
#ifdef __DATA_CONFIG
#include <mhfnav/data/config.hexpat>
#endif

#ifdef __DATA_DISPLAY_ORDER
#include <mhfnav/data/display_order.hexpat>
#endif

#ifdef __DATA_TABS
#include <mhfnav/data/tabs.hexpat>
#endif
