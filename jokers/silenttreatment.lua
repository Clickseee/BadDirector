local debuff = BadDirector.set_debuff or function(card)
    return nil
end
BadDirector.set_debuff = function(card)
    if next(SMODS.find_card("j_bd_silenttreatment")) then
        for i,v in ipairs(SMODS.find_card("j_bd_silenttreatment")) do
            if card:is_suit("Hearts") then
                return true
            end
        end
    end
    return debuff(card)
end

SMODS.Joker {
    key = "silenttreatment",
    rarity = 3,
    atlas = "<3",
    artist = {"IncognitoN71"},
    pos = { x = 2, y = 2 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            mult = 15
        }
    },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"mult","hearts","debuff","modify_card"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)

        if context.other_joker and context.other_joker.debuff then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.initial_scoring_step then
            local triggered = false
            for i,v in ipairs(G.play.cards) do
                if v.debuff then
                    triggered = true
                    SMODS.calculate_effect({mult = card.ability.extra.mult, juice_card = v, message_card = v}, card)
                end
            end
            if triggered then return nil, true end
        end
    end,
	joker_display_def = function(JokerDisplay)
		---@type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
			},
			text_config = { colour = G.C.MULT },
			reminder_text = {
				{ text = "(" },
				{ text = "Debuffed Hearts", colour = G.C.RED },
				{ text = ")" },
			},
			calc_function = function(card)
				local mult = 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= 'Unknown' then
					for _, _card in pairs(G.play and #G.play.cards > 0 and G.play.cards or G.hand.highlighted ) do
						if _card:is_suit("Hearts") then
							mult = mult + card.ability.extra.mult
						end
					end
				end
				card.joker_display_values.mult = mult
			end
		}
	end
}