SMODS.Joker {
    key = "nxkoojoker",
    partner = {"Death"},
    selfinsert = true,
    discovered = true,
    rarity = 4,
    atlas = "nxkooselfinsert",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {"#1"}}
    end,
}

SMODS.Joker {
    key = "rubyjoker",
    selfinsert = true,
    discovered = true,
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
    key = "incognitojoker",
    selfinsert = true,
    discovered = true,
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    atlas = "incognitoselfinsert",
    cost = 71,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {elements = {
            SMODS.create_sprite(0, 0, 2, 350/175, "bd_corobo")
        }}}
    end,
}

SMODS.Joker {
    key = "nhjoker",
    selfinsert = true,
    discovered = true,
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
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {elements = {
            SMODS.create_sprite(0, 0, 5596/1100, 5596/1100, "bd_njoyousspring")
        }}}
    end
}

SMODS.Joker {
    key = "thunderjoker",
    selfinsert = true,
    discovered = true,
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
    key = "gabbyjoker",
    selfinsert = true,
    discovered = true,
    rarity = 4,
    pos = { x = 0, y = 0 },
    atlas = "gabbyselfinsert",
    cost = 69420,
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
    discovered = true,
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

SMODS.Joker {
    key = "ghostjoker",
    selfinsert = true,
    discovered = true,
    rarity = 4,
    pos = { x = 0, y = 0 },
    atlas = "ghostselfinsert",
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
    key = "metajoker",
    selfinsert = true,
    discovered = true,
    rarity = 4,
    no_collection = true,
    atlas = "metaselfinsert",
    cost = 314159,
    in_pool = function(self, args)
        return false
    end,
}

SMODS.Sound{
    key = "teto",
    path = "teto_Track1.wav"
}

SMODS.Joker {
    key = "foojoker",
    selfinsert = true,
    discovered = true,
    rarity = 1,
    pos = {x = 0, y = 0},
    soul_pos = {x = 1, y = 0},
    config = {
        immutable = {
            has_teto = false
        }
    },
    atlas = "fooselfinsert",
    cost = 401,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {elements = {
            SMODS.create_sprite(0, 0, 2, 5596/1100, "bd_footeto")
        }}}
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if SynthB then
            local mem = SynthB.mod.config.allow_covers_on_any_card
            SynthB.mod.config.allow_covers_on_any_card = true
            card:set_edition("e_synthb_cover_teto")
            SynthB.mod.config.allow_covers_on_any_card = mem
        else
            card:set_edition("e_polychrome")
        end
    end,
    calculate = function(self, card, context)
        play_sound("bd_teto")
    end,
    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
            text = {
                {text = "teto"}
            },
            reminder_text = {
                {text = "teto"}
            },
            style_function = function(card, text, reminder_text, extra)
                if not card.ability.immutable.has_teto and not card.area.config.collection then
                    extra.UIBox:add_child({n = G.UIT.O, config = {object = SMODS.create_sprite(0, 0, 2, 5596/1100, "bd_footeto")}}, extra.extra)
                    card.ability.immutable.has_teto = true
                end
            end
        }
    end
}

SMODS.Joker {
    key = "vegajoker",
    selfinsert = true,
    discovered = true,
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    atlas = "vegaselfinserts",
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
    key = "gingerjoker",
    selfinsert = true,
    discovered = true,
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    atlas = "gingerselfinsert",
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {elements = {
            SMODS.create_sprite(0, 0, 5596/1100, 5596/1100, "bd_theonepiece")
        }}}
    end
}

SMODS.Joker {
    key = "keljoker",
    selfinsert = true,
    discovered = true,
    rarity = 4,
    pos = { x = 0, y = 0 },
    atlas = "kelselfinsert",
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
    key = "kaneparsons",
    selfinsert = true,
    discovered = true,
    rarity = 4,
    atlas = "youngestdirector",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {"#1"}}
    end,
}

SMODS.Joker {
    key = "inkyjoker",
    selfinsert = true,
    discovered = true,
    rarity = 4,
    atlas = "inkyselfinsert",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = 'bd_directornote_1',
            set = 'Other'
        }
    end,
}