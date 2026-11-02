#pragma once

/**
	Shop catalogs (header 0xC8): 14 records of three list pointers and a count
	(the client reads 0xE of them, decompile.hexpat). Record 7 holds the Guild
	Shop: 20 pages of u16 lists ending at 0. Pages 3, 4, 5 and 18 are the item
	lists of its halls (Lv1, Lv2, Lv Max, the Diva event hall) and pages 6, 7,
	8 and 19 their prices in Guild Tickets, at the same index: on ZZ each price
	list is as long as its item list (37, 56, 76, 89).
	Hall pages from ezemania2/mhf-file-editor; the other pages are not mapped.
*/

#include <std/core.pat>
#include <std/mem.pat>
#include <mhfdat/utils/index.pat>

struct ShopCatalog {
    u32 lists[3];
    u16 count;
    padding[2];
};

ShopCatalog shopCatalogs[0xE] @ header.ptrs.shopCatalogs [[name("Shop Catalogs")]];

struct GuildShopPage {
    u16 values[while(std::mem::read_unsigned($, 2) != 0)];
};

struct ptGuildShopPage {
    GuildShopPage *page : u32 [[inline]];
};

ptGuildShopPage guildShopPages[shopCatalogs[7].count]
    @ shopCatalogs[7].lists[0]
    [[name("Guild Shop Pages"), comment("Items: pages 3, 4, 5, 18; their prices: 6, 7, 8, 19")]];
