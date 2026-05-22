SMODS.Joker {
    key = "lovesick",
    rarity = 3,
    atlas = "<3",
    artist = {"LasagnaFelidae"},
    pos = { x = 2, y = 1 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1,
            gain = 0.5
        }
    },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"reset","scaling","xmult","hearts",},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.gain,
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local hearts_only = true

            for _, played_card in ipairs(context.full_hand) do
                if not played_card:is_suit("Hearts") then
                    hearts_only = false
                    break
                end
            end

            if hearts_only and #context.full_hand > 0 then
                card.ability.extra.xmult =
                    card.ability.extra.xmult + card.ability.extra.gain

                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.MULT
                })
            else
                card.ability.extra.xmult = 1

                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_reset'),
                    colour = G.C.RED
                })
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
