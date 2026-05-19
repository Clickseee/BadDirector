SMODS.Enhancement:take_ownership(
    'glass',
    {
        calculate = function(self, card, context)

            if context.destroy_card
            and context.cardarea == G.play
            and context.destroy_card == card
            and SMODS.pseudorandom_probability(
                card,
                'glass',
                1,
                card.ability.extra
            ) then

                if next(SMODS.find_card("j_bd_heartbreak")) then

                    card:change_suit("Hearts")

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:juice_up()
                            return true
                        end
                    }))

                    return {
                        message = "I'm sorry.",
                        colour = G.C.SUITS.Hearts
                    }

                else
                    card.glass_trigger = true

                    return {
                        remove = true
                    }
                end
            end
        end,
    },
    true
)


SMODS.Joker {
    key = "heartbreak",
    rarity = 2,
    atlas = "<3",
    pos = { x = 3, y = 0 },
    cost = 4,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"enhancements","hearts","modify_card"},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
    end
}
