SMODS.Atlas{
	key = 'MACHINE I WILL STRIKE YOU DOWN',
	path = "divine rivaly.png",
	px = 1919,
	py = 1079
}

SMODS.Joker{
	key = "divine_rivaly",
	atlas = "misprintenhanced",
    pos = { x = 1, y = 0 },
	rarity = 2,
	cost = 7,
	pools = {
		["BadDirector_Jokers"] = true,
	},
	coder = {"Foo54"},
	attributes = {"boss blind"},
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if context.debuffed_hand or context.joker_main then
			if G.GAME.blind.triggered then
				G.GAME.perscribed_bosses = G.GAME.perscribed_bosses or {}
				if not G.GAME.perscribed_bosses[G.GAME.round_resets.ante + 1] then
					G.GAME.perscribed_bosses[G.GAME.round_resets.ante + 1] = G.GAME.blind.config.blind.key
					return {
						message = localize("ph_bd_divine_rivaly")
					}
				end
			end
		end
	end,
}