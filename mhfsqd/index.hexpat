// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>

// DEFAULT DISPLAY: Include header pointers and entry counts
#include <mhfsqd/header.hexpat>

// CONDITIONAL DISPLAY: Include specific modules based on defined flags
#ifdef __DATA_FOLLOWERS
#include <mhfsqd/data/followers.hexpat>
#endif

#ifdef __DATA_MISC
#include <mhfsqd/data/misc.hexpat>
#endif

#ifdef __DATA_PARAMS
#include <mhfsqd/data/params.hexpat>
#endif

#ifdef __DATA_SHOP
#include <mhfsqd/data/shop.hexpat>
#endif

#ifdef __DATA_UD
#include <mhfsqd/data/ud.hexpat>
#endif
