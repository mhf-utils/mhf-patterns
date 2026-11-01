#pragma once

struct RString {
    u32 pStr;
    if (pStr != 0) {
        char value[] @ pStr [[name("str")]];
    }
};
