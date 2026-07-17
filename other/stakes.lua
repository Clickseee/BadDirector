SMODS.Stake {
    name = "Offbrand Stake",
    key = "offbrand",
    unlocked_stake = "white",
    unlocked = true,
	atlas = "bdstakes",
	applied_stakes = {},
    coder = {"squeax09"},
    order = 1,
    pos = { x = 0, y = 0 },
	hide_from_run_info = true,
	--prefix_config = { applied_stakes = { mod = false } },
	sticker_atlas = "bdstickers",
    sticker_pos = { x = 0, y = 0 },
    colour = HEX("fcf2c6"),
	modifiers = function()
        if SMODS.stake_from_index(G.GAME.stake) == "stake_bd_offbrand" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    ease_ante(-1)
                    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
                    return true
                end
            }))
        end
    end,
}

SMODS.Stake:take_ownership('stake_white', {
    --above_stake = "bd_offbrand",
	applied_stakes = { "bd_offbrand" },
    prefix_config = { applied_stakes = { mod = false, } },
},
true
)

SMODS.Stake:take_ownership('stake_gold', {
	applied_stakes = { "bd_tin" },
	prefix_config = { applied_stakes = { mod = false, } },
	unlocked_stake = "bd_platinum",
	above_stake = "bd_tin"
},
true
)

SMODS.Stake:take_ownership('stake_orange', {
	unlocked_stake = "bd_tin",
},
true
)

SMODS.Stake {
    name = "Tin Stake",
    key = "tin",
	atlas = "bdstakes",
    pos = { x = 1, y = 0 },
    coder = {"squeax09"},
	applied_stakes = { "orange" },
	prefix_config = { applied_stakes = { mod = false, } },
	sticker_atlas = "bdstickers",
    sticker_pos = { x = 1, y = 0 },
    colour = HEX("cbc2ba"),
	modifiers = function()
        G.GAME.modifiers.bd_tin = 4
    end,
	shiny = true,
	above_stake = "orange",
    calculate = function(self, context)
        if context.first_hand_drawn then
            local marked = {}
            for i=1, #G.hand.cards do
                if pseudorandom("tin_stake") < 1 / G.GAME.modifiers.bd_tin then
                    marked[#marked+1] = G.hand.cards[i]
                end
            end
            for i=1, #marked do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.05,
                    func = function()
                        marked[i].debuff = true
                        marked[i]:juice_up()
                        return true
                    end
                }))
            end
        end
    end
}



SMODS.Stake {
    name = "Platinum Stake",
    key = "platinum",
    coder = {"squeax09"},
    applied_stakes = { "gold" },
	atlas = "bdstakes",
    pos = { x = 2, y = 0 },
	prefix_config = { applied_stakes = { mod = false, } },
	sticker_atlas = "bdstickers",
    sticker_pos = { x = 2, y = 0 },
    colour = HEX("dddcc7"),
    shiny = true,
	above_stake = "gold",
    config = {
        purchase = false
    },
    calculate = function(self, context)
        if G.GAME.blind.boss and context.end_of_round and context.main_eval then
            self.config.purchase = false
		end
        if context.buying_card and context.card.config.center.set == "Joker" then
            if not self.config.purchase then
                context.card:add_sticker('bd_weakened', true)
                context.card:juice_up()
                self.config.purchase = true
            end
        end
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            for i=1, #G.jokers.cards do
                if G.jokers.cards[i].ability["bd_weakened"] then
                    return {
                        message = "Refreshed!",
                        colour = G.C.FILTER,
                        delay = 0.25,
                        message_card = G.jokers.cards[i],
                        func = function()
                            G.jokers.cards[i]:remove_sticker("bd_weakened")
                            G.jokers.cards[i]:set_debuff(false)
                        end
                    }
                end
            end
		end
    end
}