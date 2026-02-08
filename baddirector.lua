--#region this fucking sucks, death to Talisman, CDATAMAN RULES GRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHH

to_big = to_big or function(n)
    return n
end

to_number = to_number or function(n)
    return n
end

BadDirector = SMODS.current_mod

local function _load_folder(folder)
    local upath = SMODS.current_mod.path .. folder
    for _, v in pairs(NFS.getDirectoryItems(upath)) do
        assert(SMODS.load_file(folder .. v))()
    end
end

_load_folder("utils/")
_load_folder("decks/")
_load_folder("consumables/")
_load_folder("vouchers/")
_load_folder("enhancements/")
_load_folder("other/")
--_load_folder("jokers/")

BadDirector.optional_features = {
    cardareas = {},
    retrigger_joker = true,
    post_trigger = true
}

SMODS.Atlas {
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34,
}

SMODS.Atlas {
    key = "modlogo",
    path = "modlogo.png",
    px = 516,
    py = 387,
}

SMODS.Atlas { -- ALL ARTS BELONG TO RATTLINGSNOW353 WITH PERMISSION
    key = "rattlingsnow",
    path = "rattling.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "nxkooselfinsert",
    path = "nxkoo.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "rubyselfinsert",
    path = "lordruby.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "nickselfinsert",
    path = "incognito.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "nhselfinsert",
    path = "nh.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "nxkoojoker",
    rarity = 4,
    atlas = "nxkooselfinsert",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end
}

SMODS.Joker {
    key = "rubyjoker",
    rarity = 4,
    atlas = "rubyselfinsert",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end
}

SMODS.Joker {
    key = "nickjoker",
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    atlas = "nickselfinsert",
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end
}

SMODS.Joker {
    key = "nhjoker",
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    atlas = "nhselfinsert",
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end
}

SMODS.Joker {
    key = "thunderjoker",
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    atlas = "thunderselfinsert",
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end
}

SMODS.Joker:take_ownership("j_misprint", {
    partner = "Nxkoo"
})