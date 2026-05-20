SMODS.Joker {
    key = "redflag",
    rarity = 1,
    atlas = "<3",
    artist = {"IncognitoN71"},
    pos = { x = 1, y = 2 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"mult","hearts","scaling","discard"},

    config = {
        extra = {
            mult = 0,
            gain = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.gain
            }
        }
    end,

    calculate = function(self, card, context)

        if context.discard
        and context.other_card
        and not context.blueprint then

            if context.other_card:is_suit("Hearts") then

                card.ability.extra.mult =
                    card.ability.extra.mult +
                    card.ability.extra.gain

                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = "+" .. card.ability.extra.gain,
                    colour = G.C.MULT
                })
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}