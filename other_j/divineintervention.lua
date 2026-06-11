SMODS.Joker {
    key = "divineintervention",
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
        "tarot",
        "generation",
        "hands"
    },

    config = {
        extra = {
            played_first_hand = false
        }
    },

    calculate = function(self, card, context)

        if context.end_of_round
        and not context.individual
        and not context.repetition then
            card.ability.extra.played_first_hand = false
        end

        if context.after
        and not card.ability.extra.played_first_hand then

            card.ability.extra.played_first_hand = true

            if not SMODS.last_hand_oneshot then

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()

                        local fool = create_card(
                            "Tarot",
                            G.consumeables,
                            nil,
                            nil,
                            nil,
                            nil,
                            "c_fool",
                            "behold"
                        )

                        fool:add_to_deck()
                        G.consumeables:emplace(fool)

                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.8,
                    func = function()

                        local fool

                        for _, v in ipairs(G.consumeables.cards) do
                            if v.config.center.key == "c_fool" then
                                fool = v
                                break
                            end
                        end

                        if fool then
                            fool:use_consumeable()
                        end

                        return true
                    end
                }))

                return {
                    message = localize('k_again_ex'),
                    colour = G.C.SECONDARY_SET.Tarot
                }
            end
        end
    end
}
