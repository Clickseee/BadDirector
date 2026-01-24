SMODS.Consumable {
    atlas = "consumisprints",
    key = 'planetprint',
    set = 'misplanet',
    draw = function(self, card, layer) card.children.center:draw_shader('hologram', nil, card.ARGS.send_to_shader) end,
    pos = { x = 9, y = 4 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'mercprint',
    set = 'misplanet',
    pos = { x = 0, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("Pair", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_mercprint')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_mercprint2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_mercury"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'venprint',
    set = 'misplanet',
    pos = { x = 1, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("Three of a Kind", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_venprint')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_venprint2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_venus"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'earprint',
    set = 'misplanet',
    pos = { x = 2, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("Full House", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_earprint')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_earprint2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_earth"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'marsprint',
    set = 'misplanet',
    pos = { x = 3, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("Four of a Kind", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_marsprint')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_marsprint2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_mars"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'juprint',
    set = 'misplanet',
    pos = { x = 4, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("Flush", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_juprint')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_juprint2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_jupiter"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'satprint',
    set = 'misplanet',
    pos = { x = 5, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("Straight", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_satprint')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_satprint2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_saturn"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'uraprint',
    set = 'misplanet',
    pos = { x = 6, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("Two Pair", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_uraprint')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_uraprint2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_uranus"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'nepprint',
    set = 'misplanet',
    pos = { x = 7, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("Straight Flush", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_nepprint')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_nepprint2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_neptune"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'printo',
    set = 'misplanet',
    pos = { x = 8, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("High Card", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_printo')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_printo2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_pluto"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'cerprint',
    set = 'misplanet',
    pos = { x = 9, y = 3 },
    use = function(self, card)
        BadDirector.misprint_hand("Flush House", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_cerprint')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_cerprint2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_ceres"
}
SMODS.Consumable {
    atlas = "consumisprints",
    key = 'printx',
    set = 'misplanet',
    pos = { x = 0, y = 4 },
    use = function(self, card)
        BadDirector.misprint_hand("Five of a Kind", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_printx')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_printx2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_planet_x"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'peris',
    set = 'misplanet',
    pos = { x = 1, y = 4 },
    use = function(self, card)
        BadDirector.misprint_hand("Flush Five", card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_peris')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_peris2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_eris"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'blackprint',
    set = 'mispectral',
    pos = { x = 2, y = 4 },
    use = function(self, card)
        BadDirector.misprint_all(card)
    end,
    can_use = function() return true end,
    loc_vars = function(self, q, card)
        local n, d = SMODS.get_probability_vars(card, 1, 4, 'bd_bh')
        local n2, d2 = SMODS.get_probability_vars(card, 1, 2, 'bd_bh2')
        return {
            n, d, n2, d2
        }
    end,
    misprint_original = "c_black_hole"
}