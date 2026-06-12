SMODS.Joker {
    key = "darkforesttheory",
    rarity = 2,
    cost = 4,
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
        "joker",
        "destroy_card",
        "generation",
        "editions",
        "chance",
        "passive"
    },
    loc_vars = function(self, info_queue, card)

        local num, den = SMODS.get_probability_vars(
            card,
            1,
            3,
            "negative"
        )

        return {
            vars = {
                num,
                den
            }
        }
    end,

    calculate = function(self, card, context)

        if context.open_booster
        and context.booster
        and context.booster.kind == "Buffoon"
        then

            G.E_MANAGER:add_event(Event({
                func = function()

                    for _, joker in ipairs(G.jokers.cards) do
                        if joker ~= card then
                            SMODS.destroy_cards(joker)
                        end
                    end

                    return true
                end
            }))

            return {
                message = "?!",
                colour = G.C.DARK_EDITION
            }
        end
    end
}
