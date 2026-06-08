SMODS.Joker {
    key = "burntpassport",
    rarity = 2,
    atlas = "burnedpassport",
    artist = {"La Ginger"},
    coder = {"Nxkoo"},
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"chance", "mod_chance"},
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            odds = 3,
            last_ante = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(
            card,
            1,
            card.ability.extra.odds,
            "itgoesitgoesitgoesitgoes"
        )

        return {
            vars = {
                num,
                den
            }
        }
    end,

    calculate = function(self, card, context)

        if context.setting_blind
        and G.GAME.round_resets.ante > card.ability.extra.last_ante then

            card.ability.extra.last_ante = G.GAME.round_resets.ante

            if SMODS.pseudorandom_probability(
                card,
                "guillotineeeeeeeeeeee",
                1,
                card.ability.extra.odds,
                "YEAH"
            ) then

                local most_played = nil
                local highest = -1

                for hand_name, hand_data in pairs(G.GAME.hands) do
                    if hand_data.played > highest then
                        highest = hand_data.played
                        most_played = hand_name
                    end
                end

                if most_played then

                    update_hand_text(
                        { sound = "button", volume = 0.7, pitch = 0.8 },
                        {
                            handname = localize(most_played, "poker_hands"),
                            chips = G.GAME.hands[most_played].chips,
                            mult = G.GAME.hands[most_played].mult,
                            level = G.GAME.hands[most_played].level
                        }
                    )

                    level_up_hand(card, most_played, nil, 1)

                    return {
                        message = localize("k_level_up"),
                        colour = G.C.MULT
                    }
                end
            end
        end
    end
}