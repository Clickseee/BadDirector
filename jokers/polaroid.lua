SMODS.Atlas {
    key = "polaroid",
    path = "polaroid.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "polaroid",
    rarity = 2,
    atlas = "polaroid",
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { xchips = 3.5, triggered = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            card.ability.extra.triggered = false
        end
        if context.individual and context.cardarea == 'unscored' and not context.blueprint then
            if not card.ability.extra.triggered and context.other_card:is_face() then
                card.ability.extra.triggered = true
                context.other_card.scored = true
                return {
                    xchips = card.ability.extra.xchips,
                    colour = G.C.BLUE
                }
            end
        end
        if context.end_of_round and not context.blueprint then
            card.ability.extra.triggered = false
        end
    end
}
