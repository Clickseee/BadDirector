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

        if context.individual
        and context.cardarea == G.play then

            if context.other_card:is_suit("Hearts") then

                context.other_card.debuff = true
            end
        end
        if context.joker_main then
            local tmult = 0
            for _, playing_card in ipairs(G.play.cards) do

                if playing_card.debuff == true and playing_card:is_suit("Hearts") then
                    tmult = tmult + card.ability.extra.mult
                end
            end
            return {
                mult = tmult
            }
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