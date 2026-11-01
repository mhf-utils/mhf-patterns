// Include standard system and I/O patterns
#include <std/sys.pat>
#include <std/io.pat>

#include <mhfsdt/utils/index.pat>

// Type definitions for the tables the descriptors point to. They are included
// before the descriptor table, which links to them when the flag is enabled
#ifdef __DATA_SHELL_ROWS_A
#include <mhfsdt/data/shell_rows_a.hexpat>
#endif

#ifdef __DATA_SHELL_ROWS_B
#include <mhfsdt/data/shell_rows_b.hexpat>
#endif

#ifdef __DATA_HIT_VOLUMES
#include <mhfsdt/data/hit_volumes.hexpat>
#endif

#ifdef __DATA_RECORDS_D
#include <mhfsdt/data/records_d.hexpat>
#endif

// DEFAULT DISPLAY: the descriptor table
#include <mhfsdt/descriptors.hexpat>

#ifdef __DATA_TARGET
#include <mhfsdt/data/target.hexpat>
#endif
