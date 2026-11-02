// Very large limits just in case, feel free to make these more sensible
#pragma pattern_limit 5000000
#pragma array_limit 200000
#include <std/sys.pat>
#include <std/mem.pat>
#include <std/io.pat>
#include <misc/types.pat>
#include <misc/s32p.pat>

//#define __DECOMPILE 1

str __header_fail_msg = "File header does not match expected mhfpac header";
u32 header1 @ 0x0 [[comment("Must equal 1A 63 61 70")]];
u32 header2 @ 0x4 [[comment("Must equal 00 00 00 0A")]];

std::assert_warn(header1 == 0x1A636170, __header_fail_msg);
std::assert_warn(header2 == 0x0000000A, __header_fail_msg);

// The ZZ layout (version 10): each list runs from one header pointer to
// another (ZZ EN: 232 trees, 536 activations, 120 Zenith skills).
ptr soStringSkillPt @ 0xA20;
ptr eoStringSkillPt @ 0xA1C;

ptr soStringSkillActivate @ 0xA1C;
ptr eoStringSkillActivate @ 0xBC0;

ptr soStringZSkill @ 0xFBC;
ptr eoStringZSkill @ 0xFB0;

s32p skills[(eoStringSkillPt - soStringSkillPt)/4] @ soStringSkillPt;
s32p skillActive[(eoStringSkillActivate - soStringSkillActivate)/4] @ soStringSkillActivate;
s32p zskills[(eoStringZSkill - soStringZSkill)/4] @ soStringZSkill;

// One description per activation, from the table header 0xCC8 points to.
// The trees' descriptions have no pointer of their own: they follow the 0x180
// bytes of the table header 0x10C0 points to. (0xB8/0xC0 bound no description.)
ptr ptSkillActivateDesc @ 0xCC8;
ptr ptSkillTreeDescTable @ 0x10C0;

s32p skillActiveDesc[(eoStringSkillActivate - soStringSkillActivate)/4] @ ptSkillActivateDesc;
s32p skillDesc[(eoStringSkillPt - soStringSkillPt)/4] @ (ptSkillTreeDescTable + 0x180);

#ifdef __DECOMPILE
#include <mhfpac/decompile.hexpat>
#endif
