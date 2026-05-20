-- seal

SMODS.Seal {
    key = 'goldprint',
    atlas = "misprintenhanced",
    pos = { x = 2, y = 0 },
    config = { extra = { money = 2 } },
    badge_colour = G.C.GOLD,
    coder = {"squeax09"},
    get_p_dollars = function(self, card)
        return card.ability.seal.extra.money * (G.GAME.round_resets.hands - G.GAME.current_round.hands_played)
    end,
    loc_vars = function(self, info_queue, card)
        local ret = 0
        if G.GAME then ret = (G.GAME.round_resets.hands - G.GAME.current_round.hands_played) end
        return { vars = { self.config.extra.money, (self.config.extra.money * ret) } }
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end
}

SMODS.Seal {
    key = 'bluesprint',
    atlas = "misprintenhanced",
    pos = { x = 6, y = 4 },
    coder = {"squeax09"},
    badge_colour = G.C.BLUE,
    calculate = function(self, card, context)
        if context.playing_card_end_of_round and context.cardarea == G.hand and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    local selection = pseudorandom_element(G.P_CENTER_POOLS.Consumeables, pseudoseed("bluesealed" .. G.GAME.round_resets.ante)) -- curently its completely random and not weighted which may be broken ;w;
                    SMODS.add_card({
                        area = G.consumeables,
                        key = selection.key,
                        -- allow_duplicates = true, [unsure if i should]
                    })
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return { message = localize('k_bd_blueprint_seal'), colour = G.C.BLUE }
        end
    end
}