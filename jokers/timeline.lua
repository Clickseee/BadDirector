SMODS.Joker {
    key = "timeline",
    rarity = 1,
    pos = { x = 9, y = 9 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { mult = 0, chips = 0, min_gain = 1, max_gain = 4, left = false, right = false } },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        local my_pos = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                my_pos = i
                break
            end
        end
        local left = false
        local right = false
        if context.other_card == G.jokers.cards[my_pos - 1] and context.post_trigger then
            card.ability.extra.left = true
        end
        if context.other_card == G.jokers.cards[my_pos + 1] and context.post_trigger then
            card.ability.extra.right = true
        end

        if context.after and not context.blueprint then 
            if card.ability.extra.left == true and card.ability.extra.right == true then
                local gain_mult = pseudorandom('edmundyoulittlefucker', card.ability.extra.min_gain, card.ability.extra.max_gain)
                local gain_chips = pseudorandom('youmadeashitpieceofissac', card.ability.extra.min_gain, card.ability.extra.max_gain)
                card.ability.extra.mult = card.ability.extra.mult + gain_mult
                card.ability.extra.chips = card.ability.extra.chips + gain_chips
                card.ability.extra.left = false
                card.ability.extra.right = false
                return {
                    message = "+" .. gain_mult .. " Mult",
                    colour = G.C.MULT,
                    extra = {
                        message = "+" .. gain_chips .. " Chips",
                        colour = G.C.CHIPS
                    }
                }
            else
                card.ability.extra.left = false
                card.ability.extra.right = false
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end
}
