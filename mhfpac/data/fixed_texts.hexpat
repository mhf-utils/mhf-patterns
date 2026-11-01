#pragma once

#include <mhfpac/utils/index.pat>

StrRows<3> pChatReceiveLimitTexts @ header.ptrs.pChatReceiveLimitTexts;
StrRows<4> pItemActionTexts @ header.ptrs.pItemActionTexts;
StrRows<5> pItemActionSendTexts @ header.ptrs.pItemActionSendTexts;
StrRows<3> pItemActionShortTexts @ header.ptrs.pItemActionShortTexts;
StrRows<19> pQuestInfoTexts @ header.ptrs.pQuestInfoTexts;
StrRows<8> pQuestMenuTexts @ header.ptrs.pQuestMenuTexts;
StrRows<10> pQuestMenuShoutoutTexts @ header.ptrs.pQuestMenuShoutoutTexts;
StrRows<92> pOptionItemNames @ header.ptrs.pOptionItemNames;
StrRows<4> pOptionValueTexts @ header.ptrs.pOptionValueTexts;
if (valid(header.ptrs.unk108))
    CStr unk108 @ header.ptrs.unk108;
if (valid(header.ptrs.logLabel))
    CStr logLabel @ header.ptrs.logLabel;
if (valid(header.ptrs.logFilePrefix))
    CStr logFilePrefix @ header.ptrs.logFilePrefix;
if (valid(header.ptrs.logFolderName))
    CStr logFolderName @ header.ptrs.logFolderName;
if (valid(header.ptrs.poogieLabel))
    CStr poogieLabel @ header.ptrs.poogieLabel;
if (valid(header.ptrs.onQuestText))
    CStr onQuestText @ header.ptrs.onQuestText;
if (valid(header.ptrs.lengthLabel))
    CStr lengthLabel @ header.ptrs.lengthLabel;
if (valid(header.ptrs.yesNoText))
    CStr yesNoText @ header.ptrs.yesNoText;
if (valid(header.ptrs.nextGuide))
    CStr nextGuide @ header.ptrs.nextGuide;
if (valid(header.ptrs.backGuide))
    CStr backGuide @ header.ptrs.backGuide;
if (valid(header.ptrs.confirmGuide))
    CStr confirmGuide @ header.ptrs.confirmGuide;
if (valid(header.ptrs.closeGuide))
    CStr closeGuide @ header.ptrs.closeGuide;
