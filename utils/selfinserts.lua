SMODS.Joker {
    key = "nxkoojoker",
    selfinsert = true,
    rarity = 4,
    atlas = "nxkooselfinsert",
    pos = { x = 0, y = 0 },
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
    selfinsert = true,
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
    selfinsert = true,
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
    selfinsert = true,  
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
    selfinsert = true,
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

SMODS.Joker {
    key = "nixjoker",
    selfinsert = true,
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    atlas = "nixselfinsert",
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
    key = "felijoker",
    selfinsert = true,
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = {
		x = 1, y = 0, draw = function (card, scale_mod, rotate_mod)
			card.children.floating_sprite:draw_shader('dissolve',0, nil, nil, card.children.center,scale_mod, rotate_mod,0,0 - 0.1,nil, 0.2)
			card.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, card.children.center, scale_mod, rotate_mod,0,0-0.2)
		end
	},
    atlas = "feliselfinsert",
    cost = 190678,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end,
}