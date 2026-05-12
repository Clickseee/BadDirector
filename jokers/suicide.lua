SMODS.Joker {
    key = "suicide",
    rarity = 1,
    atlas = "<3",
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)

        if context.remove_playing_cards
        and context.removed then

            for _, removed_card in ipairs(context.removed) do

                if removed_card:is_suit("Hearts") then
                    error("Thank you.")
                end
            end
        end
    end
}
