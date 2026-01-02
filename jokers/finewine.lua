SMODS.Joker {
    key = "finewine",
    rarity = 1,
    atlas = "rattlingsnow",
    pos = { x = 3, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    config = { extra = { base = 30, per5 = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.base, card.ability.extra.per5 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.base
            }
        end
        if context.main_eval and context.end_of_round and not context.game_over and not context.blueprint then
            local money = G.GAME.dollars or 0
            local penalty = math.floor(money / 5) * card.ability.extra.per5
            if penalty > 0 then
                return {
                    mult = -penalty,
                    message = "-" .. penalty .. " Mult",
                    colour = G.C.RED
                }
            end
        end
    end
}
