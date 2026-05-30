SMODS.Joker {
    key = "diesexy",
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"hand_type","generation","hearts","tarot"},
    calculate = function(self, card, context)

        if context.before
        and context.cardarea == G.jokers
        and not context.blueprint then

            local has_heart = false

            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_suit("Hearts") then
                    has_heart = true
                    break
                end
            end

            if not has_heart then
                return
            end

            local current_hand = context.scoring_name
            local most_played = nil
            local highest = -1

            for hand_name, hand_data in pairs(G.GAME.hands) do

                if hand_data.played > highest then
                    highest = hand_data.played
                    most_played = hand_name
                end
            end

            if current_hand == most_played then

                if #G.consumeables.cards + G.GAME.consumeable_buffer
                < G.consumeables.config.card_limit then

                    G.GAME.consumeable_buffer =
                        G.GAME.consumeable_buffer + 1

                    G.E_MANAGER:add_event(Event({
                        func = function()

                            SMODS.add_card({
                                key = "c_lovers"
                            })

                            G.GAME.consumeable_buffer =
                                G.GAME.consumeable_buffer - 1

                            return true
                        end
                    }))

                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = "Hey.",
                        colour = G.C.PURPLE
                    })
                end
            end
        end
    end
}