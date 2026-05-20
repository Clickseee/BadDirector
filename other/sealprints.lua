-- seal

SMODS.Seal {
    key = 'goldprint',
    atlas = "misprintenhanced",
    pos = { x = 2, y = 0 },
    config = { extra = { money = 2 } },
    badge_colour = G.C.GOLD,
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