SMODS.Shader {
    key = "thermal",
    path = "thermal.fs"
}

SMODS.Shader {
    key = "colorsplash",
    path = "colorsplash.fs"
}

SMODS.Shader {
    key = "xray",
    path = "xray.fs"
}

SMODS.Shader {
    key = "blueprint",
    path = "blueprint.fs"
}


SMODS.Edition {
    key = "thermal", --i hate you niko (jk)
    order = 1,
    weight = 21,
    shader = "thermal",
    in_shop = true,
    extra_cost = 3,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    on_apply = function(card)
		if not card.edition or not card.edition.lowres then
			Cryptid.manipulate(card, {
				value = 2
			}, nil, true)
		end
	end,
	on_remove = function(card)
		Cryptid.manipulate(card, {
            value = 0.5
        }, nil, true)
	end,
}

local calculate_repetitions_ref = SMODS.calculate_repetitions
SMODS.calculate_repetitions = function(card, context, reps)
    if card.edition and card.edition.bd_thermal then return 0 end
    return calculate_repetitions_ref(card, context, reps)
end

SMODS.Edition {
    key = "colorsplash",
    order = 2,
    loc_txt = {
        name = "Colorsplash",
        label = "Colorsplash",
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
    shader = "colorsplash",
    in_shop = true,
    extra_cost = 3,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Edition {
    key = "xray",
    order = 3,
    weight = 21,
    shader = "xray",
    in_shop = true,
    extra_cost = 3,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
        if (context.post_trigger and context.other_card == card) or (context.main_scoring and context.cardarea == G.play) then
            local cards = {}
            for i, v in pairs({G.jokers, G.hand, G.consumeables}) do
                for _, c in pairs(v.cards) do
                    cards[#cards+1] = c
                end
            end
            pseudoshuffle(cards, pseudoseed("bd_xray_shuffle"))
            return {
                func = function()
                    for i = 1, math.min(2, #cards) do
                        BadDirector.misprint(cards[i])
                    end
                end
            }
        end
    end
}

SMODS.Edition {
    key = "blueprint",
    order = 3,
    loc_txt = {
        name = '"Blueprint"?',
        label = '"Blueprint"?',
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
    shader = "blueprint",
    in_shop = true,
    extra_cost = 3,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}
