SMODS.Joker {
    key = "stakeholder",
    rarity = 2,
    atlas = "holders",
    coder = { "Nxkoo" },
    artist = { "Inky" },
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "economy",
        "passive"
    },

    config = {
        extra = {
            sell_threshold = 3,
            dollars_per_joker = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars_per_joker,
                card.ability.extra.sell_threshold
            }
        }
    end,

    calc_dollar_bonus = function(self, card)
        if not G.jokers then
            return 0
        end

        local dollars = 0

        for _, joker in ipairs(G.jokers.cards) do
            if joker ~= card
                and joker.sell_cost
                and joker.sell_cost >= card.ability.extra.sell_threshold then
                dollars = dollars + card.ability.extra.dollars_per_joker
            end
        end

        return dollars
    end
}
