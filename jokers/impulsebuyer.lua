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
        if context.buying_card and not context.buying_self then
            card.ability.extra.x_mult = card.ability.extra.xmult + card.ability.extra.gain
            card:juice_up()
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
            }
        end

        if context.skip_shop then
            card.ability.extra.xmult = 1
            card:juice_up()
            return {
                message = localize('k_reset'),
                colour = G.C.MULT,
            }
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}