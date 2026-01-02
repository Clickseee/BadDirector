SMODS.Joker {
    key = "counterfeitslab",
    rarity = 3,
    pos = { x = 9, y = 9 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { odds = 32 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "edition_splitter")
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.game_over and G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind
        and G.GAME.blind.config.blind.boss and G.GAME.blind.config.blind.boss.showdown and not context.blueprint then
            for _, j in ipairs(G.jokers.cards) do
                if j.edition
                and SMODS.pseudorandom_probability(card, "huh", 1, card.ability.extra.odds)
                and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit
                then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{
                                set = "Joker",
                                base = j.ability.name,
                                edition = j.edition
                            }
                            G.GAME.joker_buffer = 0
                            return true
                        end
                    }))
                end
            end
        end
    end
}
