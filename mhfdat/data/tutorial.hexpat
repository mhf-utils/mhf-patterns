#pragma once

#include <std/mem.pat>

#include <std/string.pat>
#include <misc/MonsterIDs.hexpat>
#include <mhfdat/utils/index.pat>
#include <mhfdat/data/equipment_counts.hexpat>

// =======================
// Instructor (教官) tutorial. Header 0x1B0: the lessons, a title and its pages
// (tutorial_lesson_page_count, tutorial_lesson_page_get, drawn by
// tutorial_lesson_draw). Header 0x1B4: the lesson groups, a list of lesson ids
// (tutorial_group_lesson_count, tutorial_group_lesson_get); a group whose first
// id is 0xFFFF is tested against a bit set instead (FUN_10B9A890).
// =======================

struct TutorialText {
    std::string::NullString *text : u32;
} [[inline]];

struct TutorialLesson {
    TutorialText title;
    u8 pageCount;
    padding[3];
    TutorialText *pages[pageCount] : u32;
};

struct TutorialLessonGroup {
    u16 firstLesson [[comment("0xFFFF: bit-set group")]];
    u8 lessonCount;
    padding[1];
    u16 *lessons[lessonCount] : u32;
};

TutorialLesson tutorialLessons[importantNums.numTutorialLessons] @ header.ptrs.tutorialLessons [[name("Tutorial Lessons")]];
TutorialLessonGroup tutorialLessonGroups[importantNums.numTutorialLessonGroups] @ header.ptrs.tutorialLessonGroups [[name("Tutorial Lesson Groups")]];

// Instructor challenges (header 0x2A4 / 0x2A8 / 0x2AC). instructor_challenge_pick
// takes the pick list [hrBand * 3 + metBand] of 0x2A8 (hrBand: HR 1 -> 0, HR 2-4
// -> 1, else 2; metBand: challenges met < 4 -> 0, 4-10 -> 1, else 2) and one of
// its task indexes at random. instructor_challenge_progress counts the task's
// actions in a quest (consume_item_handler ...); reaching count marks it met
// (mhfpac pTutorialTexts[54] You met the challenge; [55] Challenge: [%d] Left)
// and adds one to the met counter (max 999). instructor_challenge_reward_give
// draws a reward of list [hrBand * 3 + metBand] of 0x2AC by weight (a roll % 100
// against the running sum) into the pouch or the box ([49] / [50]) and resets
// the challenge and the met counter. instructor_challenge_task_draw prints the
// task with mhfpac pTaskFormats[type]. Identical on the EN, JP and rain files.
enum InstructorTaskType : u16 {
    Deliver = 0, // item
    Obtain = 1, // item
    Catch = 2, // item
    Slay = 3, // monster
    Gather = 4, // monster (the code shows a monster name)
    BreakPart = 5, // monster, no count
    Stun = 6,
    Paralyze = 7,
    Sleep = 8,
    Poison = 9,
    PitfallTrap = 10,
    ShockTrap = 11,
    Combine = 12, // item
    ThreeIngredientCombos = 13, // count only
    Cook = 14, // item
    Carve = 15, // monster
    Hunt = 16 // monster
};

struct InstructorTask {
    InstructorTaskType type;
    u16 target [[comment("An item (types 0, 1, 2, 12, 14), a monster (3-11, 15, 16) or unused (13)")]];
    u16 count;
} [[format("instructorTaskName")]];

fn instructorTaskName(ref auto t) {
    u16 type = t.type;
    if (type == 0 || type == 1 || type == 2 || type == 12 || type == 14)
        return std::format("{} | {} x{}", t.type, getItemName(t.target), t.count);
    if (type == 13) return std::format("{} | x{}", t.type, t.count);
    MonsterID m = u8(t.target);
    return std::format("{} | {} x{}", t.type, fmtMonsterID(m), t.count);
};

struct InstructorTaskIndexList {
    s16 tasks[while(std::mem::read_signed($, 2) != -1)] [[comment("Rows of the task table")]];
    s16 end;
};

struct InstructorTaskIndexListPtr {
    InstructorTaskIndexList *list : u32;
};

struct InstructorChallengeReward {
    ItemId item;
    u8 quantity;
    u8 weight [[comment("Percent; a list sums to 100")]];
};

fn instructorRewardCount(u32 at) {
    u32 n = 0;
    u32 sum = 0;
    while (sum < 100 && n < 64) {
        sum += std::mem::read_unsigned(at + n * 4 + 3, 1);
        n += 1;
    }
    return n;
};

struct InstructorChallengeRewardListPtr {
    u32 count = instructorRewardCount(std::mem::read_unsigned($, 4));
    InstructorChallengeReward *rewards[count] : u32;
};

InstructorTask instructorChallengeTasks[178] @ header.ptrs.instructorChallengeTasks [[name("Instructor Challenge Tasks"), comment("178 = rows the pick lists use; 3 zero rows follow")]];
InstructorTaskIndexListPtr instructorChallengePicks[9] @ header.ptrs.instructorChallengePicks [[name("Instructor Challenge Picks"), comment("[hrBand * 3 + metBand]")]];
InstructorChallengeRewardListPtr instructorChallengeRewards[9] @ header.ptrs.instructorChallengeRewards [[name("Instructor Challenge Rewards"), comment("[hrBand * 3 + metBand]")]];
