-- Tweak the rates here, this is for rate of misprints to appear in the respective normal booster (see the take_ownership_by_kind below)
-- XOXO, Feli
local MISPRINT_RATE_PLANET = 10
local MISPRINT_RATE_SPECTRAL = 10
local MISPRINT_RATE_TAROT = 10
local MISPRINT_RATE_STANDARD = 10
local MISPRINT_RATE_BUFFOON = 20

BadDirector.Booster = SMODS.Booster:extend{
    atlas = "bd_misprintpacks",
}


-- Arcana Packs
BadDirector.Booster {
    key = "bd_misarcana_normal_1",
    weight = 1,
    kind = 'bd_arcanapack', -- You can also use Arcana if you want it to belong to the vanilla kind
    cost = 4,
    pos = { x = 0, y = 0 },
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    config = { extra = 3, choose = 1 },
    group_key = "k_bd_arcana_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "mispectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar2"
            }
        else
            _card = {
                set = "mistarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_misarcana_normal_2",
    weight = 1,
    kind = 'bd_arcanapack', -- You can also use Arcana if you want it to belong to the vanilla kind
    cost = 4,
    pos = { x = 1, y = 0 },
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    config = { extra = 3, choose = 1 },
    group_key = "k_bd_arcana_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)

        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "mispectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar2"
            }
        else
            _card = {
                set = "mistarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_misarcana_normal_3",
    weight = 1,
    kind = 'bd_arcanapack', -- You can also use Arcana if you want it to belong to the vanilla kind
    cost = 4,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    pos = { x = 2, y = 0 },
    config = { extra = 3, choose = 1 },
    group_key = "k_bd_arcana_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "mispectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar2"
            }
        else
            _card = {
                set = "mistarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_misarcana_normal_4",
    weight = 1,
    kind = 'bd_arcanapack', -- You can also use Arcana if you want it to belong to the vanilla kind
    cost = 4,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    pos = { x = 3, y = 0 },
    config = { extra = 3, choose = 1 },
    group_key = "k_bd_arcana_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "mispectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar2"
            }
        else
            _card = {
                set = "mistarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_misarcana_jumbo_1",
    weight = 1,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_arcanapack', -- You can also use Arcana if you want it to belong to the vanilla kind
    cost = 6,
    pos = { x = 0, y = 2 },
    config = { extra = 5, choose = 1 },
    group_key = "k_bd_arcana_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "mispectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar2"
            }
        else
            _card = {
                set = "mistarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_misarcana_jumbo_2",
    weight = 1,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_arcanapack', -- You can also use Arcana if you want it to belong to the vanilla kind
    cost = 6,
    pos = { x = 1, y = 2 },
    config = { extra = 5, choose = 1 },
    group_key = "k_bd_arcana_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "mispectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar2"
            }
        else
            _card = {
                set = "mistarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_misarcana_mega_1",
    weight = 0.25,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_arcanapack', -- You can also use Arcana if you want it to belong to the vanilla kind
    cost = 8,
    pos = { x = 2, y = 2 },
    config = { extra = 5, choose = 2 },
    group_key = "k_bd_arcana_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "mispectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar2"
            }
        else
            _card = {
                set = "mistarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_misarcana_mega_2",
    weight = 0.25,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_arcanapack', -- You can also use Arcana if you want it to belong to the vanilla kind
    cost = 8,
    pos = { x = 3, y = 2 },
    config = { extra = 5, choose = 2 },
    group_key = "k_bd_arcana_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = "mispectral",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar2"
            }
        else
            _card = {
                set = "mistarot",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_ar1"
            }
        end
        return _card
    end,
}



-- Celestial Packs
BadDirector.Booster {
    key = "bd_miscelestial_normal_1",
    weight = 1,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_celestialpack', -- You can also use Celestial if you want it to belong to the vanilla kind
    cost = 4,
    pos = { x = 0, y = 1 },
    config = { extra = 3, choose = 1 },
    group_key = "k_bd_celestial_pack", -- Delete this if you're using `group_name` in `loc_txt`
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "bd_pl1"
            }
        else
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_pl1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_miscelestial_normal_2",
    weight = 1,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_celestialpack', -- You can also use Celestial if you want it to belong to the vanilla kind
    cost = 4,
    pos = { x = 1, y = 1 },
    config = { extra = 3, choose = 1 },
    group_key = "k_bd_celestial_pack", -- Delete this if you're using `group_name` in `loc_txt`
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "bd_pl1"
            }
        else
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_pl1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_miscelestial_normal_3",
    weight = 1,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_celestialpack', -- You can also use Celestial if you want it to belong to the vanilla kind
    cost = 4,
    pos = { x = 2, y = 1 },
    config = { extra = 3, choose = 1 },
    group_key = "k_bd_celestial_pack", -- Delete this if you're using `group_name` in `loc_txt`
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "bd_pl1"
            }
        else
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_pl1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_miscelestial_normal_4",
    weight = 1,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_celestialpack', -- You can also use Celestial if you want it to belong to the vanilla kind
    cost = 4,
    pos = { x = 3, y = 1 },
    config = { extra = 3, choose = 1 },
    group_key = "k_bd_celestial_pack", -- Delete this if you're using `group_name` in `loc_txt`
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "bd_pl1"
            }
        else
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_pl1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_miscelestial_jumbo_1",
    weight = 1,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_celestialpack', -- You can also use Celestial if you want it to belong to the vanilla kind
    cost = 6,
    pos = { x = 0, y = 3 },
    config = { extra = 5, choose = 1 },
    group_key = "k_bd_celestial_pack", -- Delete this if you're using `group_name` in `loc_txt`
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "bd_pl1"
            }
        else
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_pl1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_miscelestial_jumbo_2",
    weight = 1,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_celestialpack', -- You can also use Celestial if you want it to belong to the vanilla kind
    cost = 6,
    pos = { x = 1, y = 3 },
    config = { extra = 5, choose = 1 },
    group_key = "k_bd_celestial_pack", -- Delete this if you're using `group_name` in `loc_txt`
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "bd_pl1"
            }
        else
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_pl1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_miscelestial_mega_1",
    weight = 0.25,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_celestialpack', -- You can also use Celestial if you want it to belong to the vanilla kind
    cost = 8,
    pos = { x = 2, y = 3 },
    config = { extra = 5, choose = 2 },
    group_key = "k_bd_celestial_pack", -- Delete this if you're using `group_name` in `loc_txt`
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "bd_pl1"
            }
        else
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_pl1"
            }
        end
        return _card
    end,
}


BadDirector.Booster {
    key = "bd_miscelestial_mega_2",
    weight = 0.25,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_celestialpack', -- You can also use Celestial if you want it to belong to the vanilla kind
    cost = 8,
    pos = { x = 3, y = 3 },
    config = { extra = 5, choose = 2 },
    group_key = "k_bd_celestial_pack", -- Delete this if you're using `group_name` in `loc_txt`
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.PLANET_PACK)
    end,
    particles = function(self)
        G.booster_pack_stars = Particles(1, 1, 0, 0, {
            timer = 0.07,
            scale = 0.1,
            initialize = true,
            lifespan = 15,
            speed = 0.1,
            padding = -4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, HEX('a7d6e0'), HEX('fddca0') },
            fill = true
        })
        G.booster_pack_meteors = Particles(1, 1, 0, 0, {
            timer = 2,
            scale = 0.05,
            lifespan = 1.5,
            speed = 4,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE },
            fill = true
        })
    end,
    create_card = function(self, card, i)
        local _card
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append =
                "bd_pl1"
            }
        else
            _card = {
                set = "misplanet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "bd_pl1"
            }
        end
        return _card
    end,
}



-- Spectral Packs
BadDirector.Booster {
    key = "bd_misspectral_normal_1",
    weight = 0.3,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_spectralpack', -- You can also use Spectral if you want it to belong to the vanilla kind
    cost = 4,
    pos = { x = 0, y = 4},
    config = { extra = 2, choose = 1 },
    group_key = "k_bd_spectral_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "mispectral",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append =
            "bd_spe"
        }
    end,
}


BadDirector.Booster {
    key = "bd_misspectral_normal_2",
    weight = 0.3,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_spectralpack', -- You can also use Spectral if you want it to belong to the vanilla kind
    cost = 4,
    pos = { x = 1, y = 4 },
    config = { extra = 2, choose = 1 },
    group_key = "k_bd_spectral_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "mispectral",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append =
            "bd_spe"
        }
    end,
}


BadDirector.Booster {
    key = "bd_misspectral_jumbo_1",
    weight = 0.3,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_spectralpack', -- You can also use Spectral if you want it to belong to the vanilla kind
    cost = 6,
    pos = { x = 2, y = 4 },
    config = { extra = 4, choose = 1 },
    group_key = "k_bd_spectral_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "mispectral",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append =
            "bd_spe"
        }
    end,
}


BadDirector.Booster {
    key = "bd_misspectral_mega_1",
    weight = 0.07,
    artist = {"IncognitoN71"},
    coder = {"LasagnaFelidae"},
    kind = 'bd_spectralpack', -- You can also use Spectral if you want it to belong to the vanilla kind
    cost = 8,
    pos = { x = 3, y = 4 },
    config = { extra = 4, choose = 2 },
    group_key = "k_bd_spectral_pack", -- Delete this if you're using `group_name` in `loc_txt`
    draw_hand = true,
    loc_vars = function(self, info_queue, card)
        -- This loc_vars is here to show how it would normally be structured and use the `key` return
        -- If you don't need that you can omit the loc_vars and SMODS will handle the default variables for you
        local cfg = (card and card.ability) or self.config
        return {
            vars = {
                math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
                    math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
                math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0)) },
            key = self.key:sub(1, -3), -- This uses the description key of the booster without the number at the end. Remove this if your booster doesn't have artwork variants like vanilla
        }
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.SPECTRAL_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.1,
            initialize = true,
            lifespan = 3,
            speed = 0.2,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return {
            set = "mispectral",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append =
            "bd_spe"
        }
    end,
}


SMODS.Booster:take_ownership_by_kind("Arcana",
{
    create_card = function(self, card, i)
        local _card
        local TRUE_RATE = 4+(MISPRINT_RATE_TAROT 
        * (next(SMODS.find_card("v_bd_counterfeitink")) and 0.5 or 1)
        * (next(SMODS.find_card("v_bd_brokenprinter")) and 0.25 or 1))
        --print(TRUE_RATE)
        local misprint = SMODS.pseudorandom_probability(card, 'misprint', 1, TRUE_RATE)
        local tarot = (misprint == true) and "mistarot" or "Tarot"
        local keyapp_ar = (misprint == true) and "bd_ar" or "ar"
        local spectral = (misprint == true) and "mispectral" or "Spectral"
        if G.GAME.used_vouchers.v_omen_globe and pseudorandom('omen_globe') > 0.8 then
            _card = {
                set = spectral,
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = keyapp_ar.."2",
            }
        else
            _card = {
                set = tarot,
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append = keyapp_ar.."1",
                
            }
        end
        return _card
    end,

}
, true)

SMODS.Booster:take_ownership_by_kind("Celestial",
{
    create_card = function(self, card, i)
        local _card
        local TRUE_RATE = 4+(MISPRINT_RATE_PLANET
        * (next(SMODS.find_card("v_bd_counterfeitink")) and 0.5 or 1)
        * (next(SMODS.find_card("v_bd_brokenprinter")) and 0.25 or 1))
        local misprint = SMODS.pseudorandom_probability(card, 'misprint', 1, TRUE_RATE)
        local planet = (misprint == true) and "misplanet" or "Planet"
        local keyapp_ar = (misprint == true) and "bd_pl" or "pl"
        if G.GAME.used_vouchers.v_telescope and i == 1 then
            local _planet, _hand, _tally = nil, nil, 0
            for _, handname in ipairs(G.handlist) do
                if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > _tally then
                    _hand = handname
                    _tally = G.GAME.hands[handname].played
                end
            end
            if _hand then
                for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                    if planet_center.config.hand_type == _hand then
                        _planet = planet_center.key
                    end
                end
            end
            _card = {
                set = "Planet",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key = _planet,
                key_append = "pl1"
            }
        else
            _card = {
                set = planet,
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                keyapp_ar.."1",
            }
        end
        return _card
    end,

}
, true)

SMODS.Booster:take_ownership_by_kind("Spectral",
{
    create_card = function(self, card, i)
        local TRUE_RATE = 4+(MISPRINT_RATE_SPECTRAL
        * (next(SMODS.find_card("v_bd_counterfeitink")) and 0.5 or 1)
        * (next(SMODS.find_card("v_bd_brokenprinter")) and 0.25 or 1))
        local misprint = SMODS.pseudorandom_probability(card, 'misprint', 1, TRUE_RATE)
        local spectral = (misprint == true) and "mispectral" or "Spectral"
        local keyapp_ar = (misprint == true) and "bd_spe" or "spe"
        return {
            set = spectral,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append =
            keyapp_ar,
        }
    end,


}
, true)

SMODS.Booster:take_ownership_by_kind("Standard",
{
    create_card = function(self, card, i)
        local TRUE_RATE = 4+(MISPRINT_RATE_STANDARD
        * (next(SMODS.find_card("v_bd_counterfeitink")) and 0.5 or 1)
        * (next(SMODS.find_card("v_bd_brokenprinter")) and 0.25 or 1))
        
        local misprint = SMODS.pseudorandom_probability(card, 'misprint', 1, TRUE_RATE)
        local keyapp_ar = (misprint == true) and "bd_sta" or "sta"

        local modify_type = BadDirector.quick_pool_pick(BadDirector.misprint_modify)

        
        local _edition = "e_base"
        local _enhancement = "c_base"
        local _seal = nil

        if misprint then
            if modify_type == "editioned"
            or modify_type == "enhedi"
            or modify_type == "edisealed"
            or modify_type == "everything" then
                _edition = "e_bd_misprinted"
            end

            if modify_type == "enhanced"
            or modify_type == "enhsealed"
            or modify_type == "enhedi"
            or modify_type == "everything" then
                _enhancement = BadDirector.quick_pool_pick(BadDirector.misprint_enhancements)
            end

            if modify_type == "sealed"
            or modify_type == "enhsealed"
            or modify_type == "edisealed"
            or modify_type == "everything" then
                _seal = BadDirector.quick_pool_pick(BadDirector.misprint_seals)
            end
        end
        return {
            set = "Playing Cards",
            area = G.pack_cards,
            edition =_edition,
            enhancement = _enhancement,
            seal = _seal,
            skip_materialize = true,
            soulable = true,
            key_append = keyapp_ar,
        }
    end,


}
, true)

SMODS.Booster:take_ownership_by_kind("Buffoon",
{
    create_card = function(self, card, i)
        local TRUE_RATE = 4+(MISPRINT_RATE_BUFFOON
        * (next(SMODS.find_card("v_bd_counterfeitink")) and 0.5 or 1)
        * (next(SMODS.find_card("v_bd_brokenprinter")) and 0.5 or 1))
        local negative = next(SMODS.find_card("j_bd_darkforesttheory")) and SMODS.pseudorandom_probability(dft, "purge", 1, 3) or nil
        local misprint = SMODS.pseudorandom_probability(card, 'misprint', 1, TRUE_RATE)
        local _edition = (misprint == true) and "e_bd_misprinted" or ((negative == true) and "e_negative" or nil)
        local keyapp_ar = (misprint == true) and "bd_buf" or "buf"
        return {
            set = "Joker",
            edition = _edition,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append =
            keyapp_ar,
        }
    end,


}
, true)




