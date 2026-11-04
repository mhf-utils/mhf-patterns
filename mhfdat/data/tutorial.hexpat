#pragma once

#include <std/string.pat>
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
