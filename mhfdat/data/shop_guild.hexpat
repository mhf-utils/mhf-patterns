#pragma once

/**
	Shop catalogs (header 0xC8): 14 records of three list pointers and a count
	(the client reads 0xE of them, decompile.hexpat). Record 7 holds the Guild
	Shop: 20 pages of u16 lists ending at 0. Pages 3, 4, 5 and 18 are the item
	lists of its halls (Lv1, Lv2, Lv Max, the Diva event hall) and pages 6, 7,
	8 and 19 their prices in Guild Tickets, at the same index: on ZZ each price
	list is as long as its item list (37, 56, 76, 89). Page lengths come from
	header 0x0CC (pages 10-15 have 0 inside their rows).
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

// Header 0x0CC: one pointer per shop catalog record (only record 7 is set) to
// the u16 length of each of its pages, the ending 0 included. Pages 10-15 hold
// {item, count} groups split by 0, so a page ends at its length, not at its
// first 0. guild_hall_reward_pick_event reads the lengths of pages 16 and 17
// ((length - 1) / 6 rows of 6 values).
u32 shopCatalogPageLengths[16] @ header.ptrs.shopCatalogPageLengths [[name("Shop Catalog Page Lengths")]];
u16 guildShopPageLengths[shopCatalogs[7].count] @ shopCatalogPageLengths[7] [[name("Guild Shop Page Lengths")]];

struct GuildShopPage<auto N> {
    u16 values[N - 1];
    u16 end;
};

struct ptGuildShopPage {
    u32 n = guildShopPageLengths[std::core::array_index()];
    GuildShopPage<n> *page : u32 [[inline]];
};

ptGuildShopPage guildShopPages[shopCatalogs[7].count]
    @ shopCatalogs[7].lists[0]
    [[name("Guild Shop Pages"), comment("Items: pages 3, 4, 5, 18; their prices: 6, 7, 8, 19")]];
