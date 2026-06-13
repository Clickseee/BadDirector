local _set_cost = Card.set_cost
function Card:set_cost(...)
    _set_cost(self, ...)
    if self.area == G.jokers and G.GAME and G.GAME.carton_bonus then
        self.sell_cost = (self.sell_cost or 0) + G.GAME.carton_bonus
    end
end

--[[
Smell you later :)))




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
]]

SMODS.Voucher{
    key = 'counterfeitink',
    pos = { x = 0, y = 0 },
    atlas = "vouchers",
    cost = 10,
    config = { imm = {multiplier = 0.5}},
    loc_vars = function(self, info_queue, card)
        return { vars = { 1/card.ability.imm.multiplier } }
    end,
    redeem = function(self, card)
        --it does fuck all
    end,
    calculate = function(self, card, context)

    end
}

SMODS.Voucher{
    key = 'brokenprinter',
    pos = { x = 1, y = 0 },
    atlas = "vouchers",
    cost = 10,
    config = { imm = {multiplier = 0.25}},
    requires = { 'v_bd_counterfeitink'},
    loc_vars = function(self, info_queue, card)
        return { vars = { 1/card.ability.imm.multiplier } }
    end,

    in_pool = function(self,args)
        if G.GAME.round_resets.ante >= 4 then
            return true
        end

        return false
    end,
    redeem = function(self, card)
        --it does fuck all
    end,
    calculate = function(self, card, context)

    end
}

SMODS.Voucher{
    key = 'gacha_addiction',
    pos = { x = 0, y = 1 },
    atlas = "vouchers",
    cost = 10,
    config = { extra = {slot = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slot } }
    end,
    redeem = function(self, card)
        if G.shop_booster then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_booster_to_shop()
                    return true
                end
            }))
        end
    end,
    calculate = function(self, card, context)
        if context.starting_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_booster_to_shop()
                    return true
                end
            }))
        end
    end
}

SMODS.Voucher{
    key = 'coupon_collector',
    pos = { x = 1, y = 1 },
    atlas = "vouchers",
    cost = 10,
    config = { extra = {slot = 1}},
    requires = { 'v_bd_gacha_addiction'},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slot } }
    end,

    redeem = function(self, card)
        if G.shop_vouchers then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_voucher_to_shop()
                    return true
                end
            }))
        end
    end,
    calculate = function(self, card, context)
        if context.starting_shop then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_voucher_to_shop()
                    return true
                end
            }))
        end
    end
}

