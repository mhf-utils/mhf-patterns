#pragma once

#include <std/core.pat>
#include <std/string.pat>
#include <mhfdat/utils/index.pat>
#include <misc/MonsterIDs.hexpat>

// =======================
// Quiz Quest (quest 0xCFD8, mhfpac pQuizQuestTexts). Header 0x0AF0 gives the
// sizes of the other three slots. 0x0AF4 / 0x0AF8: what the quest places in
// its stages (quiz_quest_spawns_place): a monster, or with monster 0 a carve
// point (quest_add_carve_reward_entry); the 0x0AF8 monsters also get entity
// +0x41C |= 0x10. 0x0AFC: 5 question sets (the set is quest work +0xD10 /
// +0xD11, the question +0xD12 / +0xD13), each question with 4 answers;
// answer flag 2 is the right one (quiz_quest_answer_check: action 0xD,
// otherwise 0xC and pQuizQuestTexts[4]).
// =======================

struct QuizQuestHeader {
    u16 spawnsACount;
    u16 spawnsBCount;
    u16 questionCounts[5];
    u16 unk0E;
    u16 unk10;
    u16 unk12;
};

struct QuizQuestSpawn {
    u16 stage;
    MonsterID monster [[comment("0: carve point")]];
    u8 unk03;
    u16 param04 [[comment("Carve item for a carve point, else passed to initialize_monster_entity")]];
    padding[2];
    float position[3];
    u32 unk14;
    u16 unk18;
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
