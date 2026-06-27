SMODS.Joker {
    key = "viralsensation",
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = "feliAtlas",
    artist = {"La Ginger"},
    coder = { "Nxkoo" },
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        'mult',
        'chips',
        'rank',
        'six',
        'seven'
    },

    config = {
        extra = {
            mult = 6,
            chips = 7
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual
            and context.cardarea == G.play
            and context.other_card then
            local id = context.other_card:get_id()

            if id == 6 then
                return {
                    mult = card.ability.extra.mult,
                    colour = G.C.MULT,
                    card = context.other_card
                }
            elseif id == 7 then
                return {
                    chips = card.ability.extra.chips,
                    colour = G.C.CHIPS,
                    card = context.other_card
                }
            end
        end
    end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" , colour = G.C.CHIPS},
				{ ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult", colour = G.C.CHIPS },
                { text = " "},
				{ text = "+" , colour = G.C.MULT},
				{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult", colour = G.C.MULT },
			},
			calc_function = function(card)
				local chips = 0
                local mult = 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= "Unknown" then
					for _, playing_card in ipairs(scoring_hand) do
                        local id = playing_card:get_id()
						if not playing_card.debuff then
                            if id == 7 then
							    chips = chips + card.ability.extra.chips * JokerDisplay.calculate_card_triggers(playing_card, scoring_hand)
                            elseif id == 6 then
							    mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(playing_card, scoring_hand)
                            end
						end
					end
				end
				card.joker_display_values.chips = chips
				card.joker_display_values.mult = mult
			end
		}
	end
}
