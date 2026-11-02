#pragma once

#include <type/time.pat>
#include <mhfdat/data/equipment_counts.hexpat>

/// Seasonal event timing (header 0x54C): important numbers + 0x1DA rows (136 on
/// ZZ), an event id (0 to 17) and its start and end as Unix times
struct Event_Time {
    u32 event;
    type::time_t start;
    type::time_t end;
} [[static]];

Event_Time seaonalEvents[importantNums.numSeasonalEvents] @ header.ptrs.seasonalEventTiming;
