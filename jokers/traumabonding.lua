SMODS.Joker {
    key = "traumabonding",
    rarity = 3,
    atlas = "<3",
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)

        if context.remove_playing_cards
        and context.removed then

            local triggered = false

            for _, removed_card in ipairs(context.removed) do

                if removed_card:is_suit("Hearts") then
                    triggered = true
                    break
                end
            end

            if triggered then

                for _, joker in ipairs(G.jokers.cards) do

                    if joker ~= card
                    and joker.ability
                    and joker.ability.extra then

                        for k, v in pairs(joker.ability.extra) do

                            if type(v) == "number" then

                                if v >= 1 then
                                    joker.ability.extra[k] =
                                        joker.ability.extra[k] + 1
                                end
                            end
                        end

                        joker:juice_up()
                    end
                end

                return {
                    message = "I'm here for you.",
                    colour = G.C.RED
                }
            end
        end
    end
}