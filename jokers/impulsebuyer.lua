SMODS.Joker {
    key = 'impulsebuyer',
    pos = { x = 9, y = 9 },
    rarity = 2,
    cost = 6,
    config = {
        extra = {
            xmult = 1,
            gain = 0.2
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.gain
            }
        }
    end,
    calculate = function(self, card, context)
        if (context.buying_card or context.open_booster) and not context.buying_self and card.ability.active then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain
            card:juice_up()
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end

        if context.ending_shop and card.ability.active then
            if (context.buying_card or context.open_booster) and not context.buying_self then
                card.ability.extra.xmult = 1
                card.ability.active = false
                card:juice_up()
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT,
                }
            end
        end

        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint then
            card.ability.active = true
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    
    add_to_deck = function(self, card, from_debuff)
        card.ability.active = true
    end
}
