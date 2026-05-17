SMODS.Joker {
    key = "suicide",
    rarity = 3,
    atlas = "<3",
    pos = { x = 0, y = 0 },
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            mult = 0,
            chips = 0,
            xmult = 1,
            money = 0
        }
    },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"mult","xmult","chips","economy","hearts","scaling"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips,
                card.ability.extra.xmult,
                card.ability.extra.money
            }
        }
    end,

    calculate = function(self, card, context)

        if context.remove_playing_cards
        and context.removed
        and not context.blueprint then

            for _, removed_card in ipairs(context.removed) do

                if removed_card:is_suit("Hearts") then

                    local rand_stat = pseudorandom_element({
                        "mult",
                        "chips",
                        "xmult",
                        "money"
                    }, pseudoseed("i thought i could trust you"))

                    if rand_stat == "mult" then

                        local gain = pseudorandom(
                            pseudoseed("i trusted you, i stayed for you"),
                            2,
                            15
                        )

                        gain = math.floor(gain)

                        card.ability.extra.mult =
                            card.ability.extra.mult + gain

                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "+" .. gain .. " Mult",
                            colour = G.C.MULT
                        })

                    elseif rand_stat == "chips" then

                        local gain = pseudorandom(
                            pseudoseed("i thought we're eternal"),
                            20,
                            150
                        )

                        gain = math.floor(gain)

                        card.ability.extra.chips =
                            card.ability.extra.chips + gain

                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "+" .. gain .. " Chips",
                            colour = G.C.CHIPS
                        })

                    elseif rand_stat == "xmult" then

                        local gain = pseudorandom(
                            pseudoseed("you pinky promised"),
                            0.1,
                            0.75
                        )

                        gain = math.floor(gain * 100) / 100

                        card.ability.extra.xmult =
                            card.ability.extra.xmult + gain

                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "+" .. gain .. " XMult",
                            colour = G.C.MULT
                        })

                    elseif rand_stat == "money" then

                        local gain = pseudorandom(
                            pseudoseed("why ruby, why"),
                            1,
                            10
                        )

                        gain = math.floor(gain)

                        card.ability.extra.money =
                            card.ability.extra.money + gain

                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = "$" .. gain,
                            colour = G.C.MONEY
                        })
                    end
                end
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
                xmult = card.ability.extra.xmult
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.money
    end
}
