local _end_round = end_round
function end_round()
    _end_round()
    G.GAME.round_resets.path_toggled = nil
    for _, area in pairs({
        G.jokers,
        G.hand,
        G.consumeables,
        G.discard,
        G.deck
    }) do
        for _, card in pairs(area.cards) do
            if card.ability and card.ability.debuff_timer then
                card.ability.debuff_timer = card.ability.debuff_timer - 1

                if card.ability.debuff_timer <= 0 then
                    card.ability.debuff_timer = nil
                    card.ability.debuff_timer_max = nil
                    card:set_debuff(false)

                    card_eval_status_text(
                        card,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = "Undebuffed!", colour = G.C.RED }
                    )
                else
                    card_eval_status_text(
                        card,
                        "extra",
                        nil,
                        nil,
                        nil,
                        {
                            message =
                                number_format(
                                    card.ability.debuff_timer_max - card.ability.debuff_timer
                                ) .. "/" ..
                                number_format(card.ability.debuff_timer_max),
                            colour = G.C.RED
                        }
                    )
                end
            end
        end
    end
end
