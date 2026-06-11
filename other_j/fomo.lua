SMODS.Joker {
    key = "fomo",
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = "misprintenhanced",
    coder = { "Nxkoo" },
    pos = { x = 1, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        'chips',
        'scaling',
        'joker'
    },

    config = {
        extra = {
            chips = 0,
            chip_gain = 5
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chip_gain
            }
        }
    end,

    calculate = function(self, card, context)
        if context.other_joker
            and context.other_joker ~= card
            and not context.blueprint
            and not context.retrigger_joker then
            local my_pos

            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end

            if my_pos then
                local left = G.jokers.cards[my_pos - 1]
                local right = G.jokers.cards[my_pos + 1]

                if context.other_joker == left
                    or context.other_joker == right then
                    card.ability.extra.chips =
                        card.ability.extra.chips +
                        card.ability.extra.chip_gain

                    return {
                        message = "+5",
                        colour = G.C.CHIPS,
                        card = card
                    }
                end
            end
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
