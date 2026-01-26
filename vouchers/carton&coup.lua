local _set_cost = Card.set_cost
function Card:set_cost(...)
    _set_cost(self, ...)
    if self.area == G.jokers and G.GAME and G.GAME.carton_bonus then
        self.sell_cost = (self.sell_cost or 0) + G.GAME.carton_bonus
    end
end


SMODS.Voucher{
    key = 'carton',
    pos = { x = 8, y = 2 },
    cost = 10,
    config = { extra = { sell_gain = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.sell_gain } }
    end,
    redeem = function(self, card)
        G.GAME.carton_bonus = G.GAME.carton_bonus or 0
    end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind and G.GAME.blind.boss and not context.blueprint and context.main_eval then
            return {
                func = function()
                    G.GAME.carton_bonus = (G.GAME.carton_bonus or 0) + card.ability.extra.sell_gain
                    for _, j in ipairs(G.jokers.cards) do
                        j:juice_up()
                        j:set_cost()
                    end
                end
            }
        end
    end
}

SMODS.Voucher{
    key = 'coup',
    pos = { x = 8, y = 2 },
    cost = 10,
    config = { extra = { sell_gain = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.sell_gain } }
    end,
    unlocked = false,
    requires = { 'v_bd_carton' },
    redeem = function(self, card)
        G.GAME.carton_bonus = G.GAME.carton_bonus or 0
    end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind and not context.blueprint and context.main_eval then
            return {
                func = function()
                    G.GAME.carton_bonus = (G.GAME.carton_bonus or 0) + card.ability.extra.sell_gain
                    for _, j in ipairs(G.jokers.cards) do
                        j:juice_up()
                        j:set_cost()
                    end
                end
            }
        end
    end
}
