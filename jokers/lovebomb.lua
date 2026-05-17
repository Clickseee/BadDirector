SMODS.Atlas {
    key = "<3",
    path = "lessthanthree.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "lovebomb",
    rarity = 1,
    atlas = "<3",
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"hand_type","hearts","modify_card"},
    loc_vars = function(self, info_queue, card)
        return {}
    end,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            local is_flush = next(context.poker_hands["Pair"])
            local has_heart = false

            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_suit("Hearts") then
                    has_heart = true
                    break
                end
            end

            if is_flush and has_heart then
                for _, played_card in ipairs(context.full_hand) do
                    SMODS.change_base(played_card, "Hearts")
                end

                return {
                    message = "I love you.",
                    colour = G.C.SUITS.Hearts
                }
            end
        end
    end
}
