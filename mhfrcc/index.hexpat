// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>

// DEFAULT DISPLAY: Include header pointers and counts
#include <mhfrcc/header.hexpat>

// CONDITIONAL DISPLAY: Include specific modules based on defined flags
#ifdef __DATA_ENTRIES
#include <mhfrcc/data/entries.hexpat>
#endif

#ifdef __DATA_ORDER
#include <mhfrcc/data/order.hexpat>
#endif

#ifdef __DATA_STRINGS
#include <mhfrcc/data/strings.hexpat>
#endif
