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
    --artist = {"IncognitoN71"}, ? i think
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

SMODS.Seal {
    key = 'purpleprint',
    atlas = "misprintenhanced",
    pos = { x = 4, y = 4 },
    coder = {"squeax09"},
    badge_colour = G.C.PURPLE,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    local cards_pool = {}
                    local enhancement = SMODS.poll_enhancement { guaranteed = true, options = cen_pool, key = "bd_purpleprint_seal" }
                    for k, v in ipairs(G.hand.cards) do
                        if SMODS.has_enhancement(v, 'c_base') then
                            table.insert(cards_pool, v)
                        end
                    end
                    local select = pseudorandom_element(cards_pool, pseudoseed("ourpleseal" .. G.GAME.round_resets.ante))
                    select:set_ability(enhancement)
                    select:juice_up()
                    return true
                end
            }))
            return { message = localize('k_bd_purpleprint_seal'), colour = G.C.PURPLE }
        end
    end
}

SMODS.Seal {
    key = 'redprint',
    atlas = "misprintenhanced",
    pos = { x = 5, y = 4 },
    coder = {"squeax09"},
    badge_colour = G.C.RED,
    config = { extra = { retriggers = 0, retrigger_increase = 1, goal = 3, destroyed = 0 } },
    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = card.ability.seal.extra.retriggers,
            }
        end
        if context.remove_playing_cards and not context.blueprint then
            cards = 0
            for _, removed_card in ipairs(context.removed) do
                cards = cards + 1 
            end
            card.ability.seal.extra.destroyed = card.ability.seal.extra.destroyed + cards
            if card.ability.seal.extra.destroyed >= card.ability.seal.extra.goal then 
                card.ability.seal.extra.destroyed = card.ability.seal.extra.destroyed - card.ability.seal.extra.goal
                card.ability.seal.extra.retriggers = card.ability.seal.extra.retriggers + card.ability.seal.extra.retrigger_increase
                return { message = localize('k_upgrade_ex'), colour = G.C.RED }
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = {
        card.ability.seal.extra.retriggers or self.config.extra.retriggers,
        card.ability.seal.extra.retrigger_increase or self.config.extra.retrigger_increase, 
        card.ability.seal.extra.goal or self.config.extra.goal,
        card.ability.seal.extra.destroyed or self.config.extra.destroyed } }
    end
}