SMODS.Joker {
    key = "scorchedearth",
    rarity = 2,
    cost = 5,
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
        'hand_type',
        'destroy_card'
    },

    config = {

    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {

            }
        }
    end,

    calculate = function(self, card, context)

        if context.after
        and not context.blueprint
        and context.scoring_name == "Full House"
        and SMODS.last_hand_oneshot then

            local destroyed_cards = {}

            for _, v in ipairs(context.scoring_hand) do
                destroyed_cards[#destroyed_cards + 1] = v
            end

            SMODS.smart_level_up_hand(card, "Full House", nil, 1)

            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.destroy_cards(destroyed_cards)
                    return true
                end
            }))

            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED,
                card = card
            }
        end
    end
}
