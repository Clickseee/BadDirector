SMODS.Joker {
    key = "heartburn",
    rarity = 3,
    atlas = "<3",
    pos = { x = 4, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"hearts","modify_card"},
    calculate = function(self, card, context)

        if context.after and SMODS.last_hand_oneshot then

            for _, held_card in ipairs(G.hand.cards) do
                held_card:change_suit("Hearts")
            end

            for _, held_card in ipairs(G.hand.cards) do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        held_card:juice_up()
                        return true
                    end
                }))
            end

            return {
                message = "I care about you.",
                colour = G.C.SUITS.Hearts
            }
        end
    end
}
