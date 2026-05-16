SMODS.Joker {
    key = "silenttreatment",
    rarity = 3,
    atlas = "<3",
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            mult = 15
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)

        if context.individual
        and context.cardarea == G.play then

            if context.other_card:is_suit("Hearts") then

                context.other_card.debuff = true

                return {
                    mult = card.ability.extra.mult,
                    card = context.other_card
                }
            end
        end
    end,

    update = function(self, card, dt)

        if G.play then
            for _, playing_card in ipairs(G.play.cards) do

                if playing_card:is_suit("Hearts") then
                    playing_card.debuff = true
                end
            end
        end
    end
}