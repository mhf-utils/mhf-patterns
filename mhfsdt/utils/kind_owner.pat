#pragma once

/// Owner of a shell kind (descriptor id), as reverse engineered
fn kind_owner(s16 k) {
    match (k) {
        (0): return "Player: generic hit shell";
        (6): return "Player: bowgun ammo (sub_id = WeaponType: 1 HBG / 5 LBG)";
        (24): return "Unknown";
        (85): return "Player: weapon attack hitbox";
        (99): return "Rukodiora (em99)";
        (100): return "Player: melee weapon shell";
        (106): return "Player: weapon shell";
        (107): return "Player: weapon shell";
        (108): return "Player: bow shell";
        (110): return "Hyujikiki (em110)";
        (111): return "Midogaron family (em91 Kamu/Nono Orugaron, em111)";
        (112): return "Abiorugu family (em104 Abiorugu / Giaorugu)";
        (113): return "Mi-Ru (em113)";
        (120): return "Player: weapon shell";
        (121): return "Shared monster shell (Garuba Daora, Akura Vashimu, Rathian, Yian Garuga...)";
        (125): return "Forokururu (em125)";
        (127): return "Diorex (em127)";
        (128): return "Garuba Daora (em128)";
        (130): return "Varusaburosu (em130)";
        (139): return "Gureadomosu (em139)";
        (140): return "Harudomerugu (em140), table D only";
        (141): return "Toridcless (em141)";
        (142): return "Gasurabazura (em142)";
        (145): return "Duremudira Block 2 (em145)";
        (146): return "Zinogre / Stygian Zinogre (em146, em153)";
        (147): return "Deviljho / Savage Deviljho (em147, em155)";
        (148): return "Brachydios (em148)";
        (150): return "Toa Tesukatora (em150)";
        (151): return "Barioth (em151)";
        (152): return "Uragaan (em152)";
        (154): return "Shared monster shell (mostly Guanzorumu em154; also White Fatalis, Inagami, Egyurasu...)";
        (158): return "Voljang (em158)";
        (159): return "Nargacuga / Blinking Nargacuga (em159, em163)";
        (160): return "Keoaruboru (em160)";
        (161): return "Zenaserisu (em161)";
        (162): return "Gore Magala (em162)";
        (164): return "Shagaru Magala (em164)";
        (165): return "Amatsu (em165)";
        (166): return "Eruzerion (em166)";
        (167): return "Musou Duremudira (em167)";
        (169): return "Seregios (em169)";
        (170): return "Bogabadorumu / Musou Bogabadorumu (em170, em172)";
        (171): return "Probably Bogabadorumu family (to confirm)";
        (172): return "Musou Bogabadorumu (em172)";
        (174): return "Musou Zerureusu (em174)";
        (175): return "Rappy (id 175, get_hzv_info only)";
        (300): return "Shared monster shell (Daimyo Hermitaur, Rukodiora, Pariapuria, Lavasioth...)";
        (302): return "Kirin (em33)";
        (303): return "Shared monster shell (Rathian/Rathalos family, Odibatorasu, Gypceros, Chameleos...)";
        (304): return "Hypnocatrice (em74)";
        (305): return "Shared monster shell (Espinas, Blangonga...)";
        (306): return "Akura Vashimu (em83)";
        (307): return "Tigrex (em76)";
        (315): return "Khezu (em15)";
        (317): return "Gravios (em17)";
        (321): return "Plesioth (em21)";
        (371): return "White Fatalis (em71)";
        (395): return "Doragyurosu (em95)";
        (403): return "Taikun Zamuza (em103)";
        (409): return "Anorupatisu (em109)";
        (421): return "Baruragaru (em121)";
        (429): return "Inagami (em129)";
        (440): return "Harudomerugu (em140)";
        (441): return "Toridcless (em141), Zenith/D7C code";
        (442): return "Gasurabazura (em142), Zenith";
        (500 | 502 | 503 | 504 | 505 | 506 | 507 | 508 | 509 | 510 | 511 | 512 | 513 | 514 | 515 | 516 | 518 | 519 | 520 | 522 | 524 | 528 | 529 | 531 | 532 | 533 | 534 | 535 | 536 | 537 | 539 | 541 | 542 | 546 | 547 | 549 | 553): return std::format("Object entity: 500 + objEmSubType {} of the monster-133 object slot (spawned from code 0x111A-0x111D)", k - 500);
        (999): return "Shared player-attached effect shells (blind fog visuals, Gore Magala, Chameleos...)";
        (_): return "?";
    }
};

fn kind_fmt(s16 k) { return std::format("kind {} = {}", k, kind_owner(k)); };
fn desc_fmt(ref auto d) { return kind_fmt(d.id); };
