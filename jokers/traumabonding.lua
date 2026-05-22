SMODS.Joker {
    key = "traumabonding",
    rarity = 3,
    atlas = "<3",
    artist = {"IncognitoN71"},
    pos = { x = 4, y = 2 },
    config = {extra = {increment = 1}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.increment}
        }
    end,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"joker","hearts","scaling"},
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)

        if context.remove_playing_cards
        and context.removed then

            local destroyed_heart = false

            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_suit("Hearts") then
                    destroyed_heart = true
                    break
                end
            end

            if destroyed_heart then
                for _, joker in ipairs(G.jokers.cards) do
                    if joker ~= card then
                        if joker.ability.extra and type(joker.ability.extra) == "table" then
                            for _, v in pairs(joker.ability.extra) do
                                if type(v) == "number" and v ~= 0 then
                                    joker.ability.extra[_] = joker.ability.extra[_] + card.ability.extra.increment
                                end
                            end
                        end
                        if joker.ability and type(joker.ability) == "table" then
                            for _, v in pairs(joker.ability) do
                                if type(v) == "number" and _ ~= "order" and _ ~= "rarity" and v ~= 0 and v ~= 1 then
                                    joker.ability[_] = joker.ability[_] + card.ability.extra.increment
                                end
                            end
                        end
                    end
                end

                return {
                    message = "I'm here for you.",
                    colour = G.C.MULT
                }
            end
        end
    end
}