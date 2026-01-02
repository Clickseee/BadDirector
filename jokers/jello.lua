SMODS.Joker {
    key = "jello",
    rarity = 1,
    pos = { x = 9, y = 9 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { mult_min = 1, mult_max = 20, chips_min = 10, chips_max = 100, destroy_odds = 6 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.destroy_odds, 'bryh')
        local r_mults, r_chips = {}, {}
        for i = card.ability.extra.mult_min, card.ability.extra.mult_max do
            r_mults[#r_mults + 1] = tostring(i)
        end
        for i = card.ability.extra.chips_min, card.ability.extra.chips_max, 5 do
            r_chips[#r_chips + 1] = tostring(i)
        end
        local loc_mult = ' ' .. localize('k_mult') .. ' '
        local loc_chips = ' ' .. "Chips" .. ' '
        local deck_info = (G.deck and G.deck.cards[#G.deck.cards]) or { base = { id = 9, suit = 'S' } }

        main_start = {
            { n = G.UIT.T, config = { text = '+', colour = G.C.MULT, scale = 0.32 } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = r_mults,
                        colours = { G.C.MULT },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.4,
                        scale = 0.32,
                        min_cycle_time = 0,
                        vert = true
                    })
                }
            },
            { n = G.UIT.O, config = {
                    object = DynaText({
                        string = {
                            { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.MULT },
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                } },
            { n = G.UIT.T, config = { text = ' and ', colour = G.C.UI.TEXT_DARK, scale = 0.32 } },
            { n = G.UIT.T, config = { text = '+', colour = G.C.CHIPS, scale = 0.32 } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = r_chips,
                        colours = { G.C.CHIPS },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.25,
                        scale = 0.32,
                        min_cycle_time = 0,
                        vert = true
                    })
                }
            },
            { n = G.UIT.O, config = {
                    object = DynaText({
                        string = {
                            { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.CHIPS },
                            loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips, loc_chips,
                            loc_chips, loc_chips, loc_chips, loc_chips },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                } },
        }

        return { main_start = main_start, vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local rand_mult = pseudorandom('bruh', card.ability.extra.mult_min, card.ability.extra
            .mult_max)
            local rand_chips = pseudorandom('bruh', card.ability.extra.chips_min,
                card.ability.extra.chips_max)
            return {
                mult = rand_mult,
                chips = rand_chips
            }
        end


        if context.end_of_round and not context.blueprint and not context.game_over then
            if SMODS.pseudorandom_probability(card, 'bruh', 1, card.ability.extra.destroy_odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.3
                        card:juice_up(0.5, 0.5)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = "Slurped!",
                    colour = G.C.RED
                }
            end
        end
    end
}
