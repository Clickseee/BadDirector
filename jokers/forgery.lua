SMODS.Atlas {
    key = "forge",
    path = "forgery.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "forgery",
    rarity = 2,
    atlas = "forge",
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { odds = 2, rankup = 1 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'blacksmith')
        return { vars = { numerator, denominator, card.ability.extra.rankup } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if SMODS.has_enhancement(context.other_card, 'm_steel') then
                if SMODS.pseudorandom_probability(card, 'blacksmith', 1, card.ability.extra.odds) then
                    local thecard = context.other_card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            assert(SMODS.modify_rank(thecard, card.ability.extra.rankup))
                            thecard:juice_up(0.5, 0.5)
                            return true
                        end
                    }))
                    return {
                        message = localize { type = 'variable', key = 'k_rank_up', vars = { original_rank, context.other_card.base.value } },
                        colour = G.C.SECONDARY_SET.Enhanced
                    }
                end
            end
        end
    end
}
