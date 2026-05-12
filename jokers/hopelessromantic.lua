SMODS.Joker {
    key = "hopelessromantic",
    rarity = 3,
    atlas = "<3",
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1.7
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:get_id() == 14
            and context.other_card:is_suit("Hearts") then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
