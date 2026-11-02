#include <std/mem.pat>

#include <misc/types.pat>
#include <misc/ItemIDs.hexpat>
// Hunter Navi. ZZ EN: 14 tabs, 164 tasks, 456 reward lines; what a task asks
// and its texts are not decoded. Tab fields named after
// var-username/Monster-Hunter-Frontier-Patterns.
ptr hd_dll_afad7f @ 0x00 [[name("pTabs")]];

ptr ptr_at_0x04 @ 0x04 [[name("pUnk")]];
u32 num_at_0x08 @ 0x08 [[name("lenUnk")]];
ptr ptr_at_0x0C @ 0x0C [[name("pUnk1")]];
ptr ptr_at_0x10 @ 0x10 [[name("pUnk2")]];

/** Since this number is right next to 0x10, which points to an array
    of size 0x1A, I assume the elements are size 2 and this is the array len
**/
u32 unk_shorts_len @ 0x14   [[comment("This is an assumption")]];
u16 unk_shorts_lst [unk_shorts_len] @ ptr_at_0x10;

using ItemQuantity;
fn itemQuantityFmt (ItemQuantity n) {
    return std::format("{:02}x {:04X}", n.quantity, n.item);
};

struct ItemQuantity {
    if (std::mem::read_unsigned($,2) == 0) {
        // If item id is 0, just skip this entry
        padding[4];
        continue;
    } else {
        ItemID item;
        u16 quantity;
    }
} [[sealed, format("itemQuantityFmt")]];

// A reward is two entries: {0, 1}, then {item, quantity} (ZZ EN: 456 rewards
// in 912 entries); the list ends at an entry whose second u16 is 0
struct TaskRewards {
    ptr ptr;
    ItemQuantity taskRewards [while(std::mem::read_unsigned($+2,2)!=0)] @ ptr
        [[name("Rewards and Quantity")]]
        ;
};

// a task's rewards end at a quantity of 0
struct NaviTab {
    u32 group;
    u32 index;
    u32 pData;
    u32 lenTasks1;
    ptr unk10 [[name("Pointer to Navi Tasks")]];
    u32 unk14 [[name("Number of Navi Tasks")]];
    ptr unk18 [[name("Pointer to unk_char_lst")]];
    ptr unk1C;
    u32 unk20;

    if (unk14 != 0) {
        TaskRewards unk_ptr_lst [unk14] @ unk10
            [[name("Hunter Navi Rewards per Task in tab??")]]
            ;
    }

    if (unk18 != 0) {
        varPaddT<u8, 1> unk_char_lst[while(std::mem::read_signed($,1)!=-1)] 
            @ unk18;
    }

    // If unk20 == 0, set unk1C to 0. Delete that pointer.
    // I guess unk1C is a pointer to a list of length unk20?
};

NaviTab naviTabs[14] @ hd_dll_afad7f
    [[name("Hunter Navi Tabs??")]]
    ;
