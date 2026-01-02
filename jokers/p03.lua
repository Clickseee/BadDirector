SMODS.Joker {
    key = "p03",
    rarity = 2,
    atlas = "rattlingsnow",
    pos = { x = 1, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { threshold = 5, murderodds = 2 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.murderodds, 'bryh')
        local count = BadDirector.count_browsers()
        return { vars = { numerator, denominator, count, card.ability.extra.threshold } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = BadDirector.count_browsers()
            return {
                 xmult = count
            }
        end
        if context.end_of_round 
        and not context.game_over 
        and not context.blueprint 
        then
            local count = BadDirector.count_browsers()
            if count > card.ability.extra.threshold then
                if SMODS.pseudorandom_probability(card, 'computerdivorce', 1, card.ability.extra.murderodds) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve()
                            return true
                        end
                    }))
                    return { 
                        message = "Murdered.",
                        colour = G.C.RED 
                    }
                end
            end
        end
    end
}
