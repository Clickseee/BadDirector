SMODS.Joker {
    key = "newlove",
    rarity = 1,
    atlas = "<3",
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"destroy_card","face","hearts","modify_card"},
    calculate = function(self, card, context)

        if context.before and context.cardarea == G.jokers then

            local face_cards = {}

            for _, played_card in ipairs(context.full_hand) do
                if played_card:is_face() then
                    table.insert(face_cards, played_card)
                end
            end

            if #face_cards >= 3 then

                face_cards[1]:change_suit("Hearts")
                face_cards[2]:change_suit("Hearts")

                G.E_MANAGER:add_event(Event({
                    func = function()
                        face_cards[1]:juice_up()
                        face_cards[2]:juice_up()
                        return true
                    end
                }))

                local destroyed_card = face_cards[#face_cards]

                destroyed_card.getting_sliced = true

                G.E_MANAGER:add_event(Event({
                    func = function()
                        destroyed_card:start_dissolve()
                        return true
                    end
                }))

                return {
                    message = "Why..",
                    colour = G.C.SUITS.Hearts
                }
            end
        end
    end
}
