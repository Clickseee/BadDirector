SMODS.Stake {
    name = "Offbrand Stake",
    key = "offbrand",
    unlocked_stake = "white",
    unlocked = true,
	atlas = "bdstakes",
	applied_stakes = {},
    pos = { x = 0, y = 0 },
	hide_from_run_info = true,
	prefix_config = { applied_stakes = { mod = false } },
	sticker_atlas = "bdstickers",
    sticker_pos = { x = 0, y = 0 },
    colour = HEX("fcf2c6"),
	modifiers = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                ease_ante(-1)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
                return true
            end
        }))
    end,
}

SMODS.Stake:take_ownership('stake_white', {
	above_stake = "offbrand",
	applied_stakes = { "bd_offbrand" },
	prefix_config = { applied_stakes = { mod = false, } },
	modifiers = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                ease_ante(1)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + 1
                return true
            end
        }))
    end,
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
	above_stake = "bd_tin"
},
true
)

SMODS.Stake {
    name = "Tin Stake",
    key = "tin",
	atlas = "bdstakes",
    pos = { x = 1, y = 0 },
	applied_stakes = { "orange" },
	prefix_config = { applied_stakes = { mod = false, } },
	sticker_atlas = "bdstickers",
    sticker_pos = { x = 1, y = 0 },
    colour = HEX("cbc2ba"),
	modifiers = function()
        G.GAME.modifiers.bd_tin = 6
    end,
	shiny = true,
	above_stake = "orange",
    calculate = function(self, context)
        if context.end_of_round and context.game_over == false then
            local marked = {}
            for i=1, #G.hand.cards do
                if pseudorandom("tin_stake") < 1 / G.GAME.modifiers.bd_tin then
                    marked[#marked+1] = G.hand.cards[i]
                end
            end
            for i=1, #marked do
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.75,
                    func = function()
                        marked[i]:start_dissolve()
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
    applied_stakes = { "gold" },
	atlas = "bdstakes",
    pos = { x = 2, y = 0 },
	prefix_config = { applied_stakes = { mod = false, } },
	sticker_atlas = "bdstickers",
    sticker_pos = { x = 2, y = 0 },
    colour = HEX("dddcc7"),
	--modifiers = function()

    --end,
	shiny = true,
	above_stake = "gold"
}