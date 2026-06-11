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

    config = {
        extra = {
            negative_chance = 1,
            negative_denominator = 3
        }
    },

    loc_vars = function(self, info_queue, card)

        local num, den = SMODS.get_probability_vars(
            card,
            1,
            3,
            "negatie"
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
        and context.booster.config
        and context.booster.config.center
        and context.booster.config.center.kind == "Buffoon"
        then

            G.E_MANAGER:add_event(Event({
                func = function()

                    for _, joker in ipairs(G.jokers.cards) do
                        if joker ~= card then
                            joker:start_dissolve()
                        end
                    end

                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                func = function()

                    for _, pack_card in ipairs(G.pack_cards.cards) do

                        if pack_card.ability
                        and pack_card.ability.set == "Joker"
                        then

                            if SMODS.pseudorandom_probability(
                                card,
                                "purge",
                                1,
                                3
                            ) then

                                pack_card:set_edition(
                                    {negative = true},
                                    true
                                )

                            end
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
