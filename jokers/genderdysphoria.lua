SMODS.Joker {
    key = "genderdysphoria",
    rarity = 2,
    atlas = "<3",
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before then
            for _, played_card in ipairs(context.full_hand) do
                local id = played_card:get_id()

                if id == 12 or id == 13 then
                    SMODS.change_base(played_card, nil, "Jack")
                end
            end
        end
    end
}
