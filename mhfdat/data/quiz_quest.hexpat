#pragma once

#include <std/core.pat>
#include <std/string.pat>
#include <mhfdat/utils/index.pat>
#include <misc/MonsterIDs.hexpat>

// =======================
// Quiz Quest (quest 0xCFD8, mhfpac pQuizQuestTexts). Header 0x0AF0 gives the
// sizes of the other three slots. 0x0AF4 / 0x0AF8: what the quest places in
// its stages (quiz_quest_spawns_place): a monster, or with monster 0 a carve
// point (quest_add_carve_reward_entry). quiz_quest_spawns_a_place places all the 0x0AF4
// rows at once (no stage test) and sets entity +0x41C |= 0x10 on their
// monsters; FUN_10AABA30 places the 0x0AF8 rows of the stage it sets up.
// FUN_10AAB4A0 / FUN_10AAAB10 look up both lists' monster ids. 0x0AFC: 5 question sets (the set is quest work +0xD10 /
// +0xD11, the question +0xD12 / +0xD13), each question with 4 answers;
// answer flag 2 is the right one (quiz_quest_answer_check: action 0xD,
// otherwise 0xC and pQuizQuestTexts[4]).
// =======================

struct QuizQuestHeader {
    u16 spawnsACount;
    u16 spawnsBCount;
    u16 questionCounts[5];
    u16 unk0E;
    u16 end [[comment("0: rd_mhfdat scans the header's u16 list up to this 0")]];
    u16 unk12;
};

struct QuizQuestSpawn {
    u16 stage;
    MonsterID monster [[comment("0: carve point")]];
    u8 unk03;
    u16 param04 [[comment("Carve item for a carve point; for a monster initialize_monster_entity stores its low byte in EnemyWork +0x1B (variantNibble)")]];
    padding[2];
    float position[3];
    u32 rotation [[comment("Spawn record +0x1C -> EnemyWork +0xA4 (initialize_monster_entity)")]];
    u16 sizePercent [[comment("Spawn record +0x30 -> EnemyWork +0xC86, size % (monster_size.md)")]];
    u8 entityFlags [[comment("OR-ed into entity +0x8C3")]];
    u8 unk1B;
};

struct QuizText {
    std::string::NullString *text : u32;
} [[inline]];

struct QuizAnswer {
    QuizText text;
    u32 flags [[comment("2: right answer, 1: wrong")]];
};

struct QuizQuestion {
    QuizText question;
    QuizAnswer answers[4];
};

QuizQuestHeader quizQuestHeader @ header.ptrs.quizQuestHeader [[name("Quiz Quest Header")]];
QuizQuestSpawn quizQuestSpawnsA[quizQuestHeader.spawnsACount] @ header.ptrs.quizQuestSpawnsA [[name("Quiz Quest Spawns A")]];
QuizQuestSpawn quizQuestSpawnsB[quizQuestHeader.spawnsBCount] @ header.ptrs.quizQuestSpawnsB [[name("Quiz Quest Spawns B")]];

struct QuizQuestionSet {
    u32 n = quizQuestHeader.questionCounts[std::core::array_index()];
    QuizQuestion *questions[n] : u32;
};

QuizQuestionSet quizQuestQuestions[5] @ header.ptrs.quizQuestQuestions [[name("Quiz Quest Questions")]];

// Quiz Quest time limits (header 0xB00): the answer time of question set
// QuestWork +0xD10. quest_work_init loads row 0 and quiz_quest_msg_set_start
// the row of the new set into the countdown QuestWork +0xD14, which
// quiz_quest_timer_tick decrements (quest PeakOfKnowledge only) and
// quiz_quest_hud_draw prints as frames / 30; at 0 the quest state goes to 5.
// No bound in the code: 6 rows fill the gap to the 0xAFC table.
struct QuizQuestTimeLimit {
    u16 frames;
    u16 unk02 [[comment("no reader")]];
};

QuizQuestTimeLimit quizQuestTimeLimits[6] @ header.ptrs.quizQuestTimeLimits [[name("Quiz Quest Time Limits"), comment("Row = question set")]];
