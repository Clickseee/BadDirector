SMODS.Stake {
    name = "Offbrand Stake",
    key = "offbrand",
    unlocked_stake = "white",
    unlocked = true,
    applied_stakes = {},
	atlas = "bdstakes",
    pos = { x = 0, y = 0 },
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
	unlocked = false,
	applied_stakes = { "bd_offbrand" },
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

SMODS.Stake {
    name = "Platinum Stake",
    key = "platinum",
    applied_stakes = { "gold" },
	atlas = "bdstakes",
    pos = { x = 2, y = 0 },
	prefix_config = { applied_stakes = { mod = false } },
	sticker_atlas = "bdstickers",
    sticker_pos = { x = 2, y = 0 },
    colour = HEX("dddcc7"),
	--modifiers = function()

    --end,
	shiny = true,
	above_stake = "gold"
}