SMODS.Joker {
    key = "futurefaking",
    rarity = 2,
    atlas = "<3",
    artist = {"IncognitoN71"},
    pos = { x = 1, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"scaling","hand_size","skip"},
    config = {
        extra = {
            handsize = 2,
            gained = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.handsize,
                card.ability.extra.gained
            }
        }
    end,

    calculate = function(self, card, context)

        if context.skip_blind then

            G.hand:change_size(card.ability.extra.handsize)

            card.ability.extra.gained =
                card.ability.extra.gained +
                card.ability.extra.handsize

            return {
                message = "+" .. card.ability.extra.handsize .. " Hand Size",
                colour = G.C.FILTER
            }
        end

        if context.ante_end
        and card.ability.extra.gained > 0 then

            G.hand:change_size(
                -card.ability.extra.gained
            )

            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = "Can't wait to meet you IRL.",
                colour = G.C.RED
            })

            card.ability.extra.gained = 0
        end
    end,
    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
			text = {
				{
                    { text = "+", colour = G.C.ORANGE},
                    { ref_table = "card.ability.extra", ref_value = "gained", colour = G.C.ORANGE },
                    { text = " hand size" }
				}
			}
        }
    end
}
