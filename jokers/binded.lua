SMODS.Atlas {
    key = "jisaac",
    path = "crucify.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "binded",
    rarity = 2,
    atlas = "jisaac",
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { odds = 2, enhrep = 1 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'imadeyouasteak')
        return { vars = { card.ability.extra.enhrep, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local c = context.other_card
            if c.ability and c.ability.set == "Enhanced" then
                if SMODS.pseudorandom_probability(card, "imissmyex", 1, 2) then
                    c:set_ability(G.P_CENTERS.c_base)
                end
                return {
                    repetitions = card.ability.extra.enhrep
                }
            end
        end
    end
}
