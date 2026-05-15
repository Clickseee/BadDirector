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

            local destroyed_heart = false

            for _, removed_card in ipairs(context.removed) do
                if removed_card:is_suit("Hearts") then
                    destroyed_heart = true
                    break
                end
            end

            if destroyed_heart then

                for _, hand_card in ipairs(G.hand.cards) do

                    if hand_card:is_suit("Hearts") then

                        hand_card.ability.perma_mult =
                            (hand_card.ability.perma_mult or 0) + 1

                        hand_card:juice_up()
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