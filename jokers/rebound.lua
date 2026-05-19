SMODS.Joker {
    key = "rebound",
    rarity = 3,
    atlas = "<3",
    pos = { x = 0, y = 2 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"generation",},
    calculate = function(self, card, context)

        if context.remove_playing_cards
        and context.removed then

            for _, removed_card in ipairs(context.removed) do

                local copied_card = copy_card(removed_card)

                copied_card:add_to_deck()
                G.playing_card = (
                    G.playing_card and G.playing_card + 1
                ) or 1

                G.deck.config.card_limit =
                    G.deck.config.card_limit + 1

                table.insert(G.playing_cards, copied_card)

                G.hand:emplace(copied_card)

                copied_card.states.visible = false

                G.E_MANAGER:add_event(Event({
                    func = function()

                        copied_card:start_materialize()

                        copied_card.states.visible = true

                        copied_card:juice_up()

                        return true
                    end
                }))
            end

            return {
                message = "Traumatized.",
                colour = G.C.RED
            }
        end
    end
}
