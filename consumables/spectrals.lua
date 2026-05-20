BadDirector.Spectral = SMODS.Consumable:extend {
    atlas = "bd_spectrals_ghost",
    set = 'Spectral',
    artist = 'GhostSalt',
}


-- Heat
BadDirector.Spectral {
    key = 'bd_heat',
    artist = {"GhostSalt"},
    coder = {"LasagnaFelidae"},
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bd_thermal
        return { vars = { G.GAME.bd_heat_minus or 1 } }
    end,
    use = function(self, card, area, copier)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'im glad to have worked on this with you - mon toutou')
                eligible_card:set_edition("e_bd_thermal")

                G.GAME.bd_heat_minus = G.GAME.bd_heat_minus or 1
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - G.GAME.bd_heat_minus
                G.GAME.bd_heat_minus = G.GAME.bd_heat_minus + 1

                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
}

-- Transluscent
BadDirector.Spectral {
    key = 'bd_transluscent',
    artist = {"GhostSalt"},
    coder = {"LasagnaFelidae"},
    pos = { x = 1, y = 0 },
    config = { extra = { mod_slots = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bd_xray
        return { vars = { card.ability.extra.mod_slots } }
    end,
    use = function(self, card, area, copier)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'talking to you is always enjoyable')
                eligible_card:set_edition("e_bd_xray")

                G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1

                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
}

--Project
BadDirector.Spectral {
    key = 'bd_project',
    artist = {"GhostSalt"},
    coder = {"LasagnaFelidae"},
    pos = { x = 2, y = 0 },
    config = { extra = { mod_slots = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bd_blueprint
        return { vars = { card.ability.extra.mod_slots } }
    end,
    use = function(self, card, area, copier)
        SMODS.destroy_cards(G.jokers.cards[#G.jokers.cards],nil,true,nil)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'you keep making my day')
                eligible_card:set_edition("e_bd_blueprint")

                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        if #SMODS.Edition:get_edition_cards(G.jokers, true) < 2 then return false end
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
}

--ZZZZ
BadDirector.Spectral {
    key = 'bd_zzzz',
    artist = {"GhostSalt"},
    coder = {"LasagnaFelidae"},
    pos = { x = 3, y = 0 },
    config = { extra = { mod_slots = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bd_misprinted
        return { vars = { card.ability.extra.mod_slots } }
    end,
    use = function(self, card, area, copier)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'xoxo')
                eligible_card:set_edition("e_bd_misprinted")

                G.jokers.config.card_limit = G.jokers.config.card_limit - 1

                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
}