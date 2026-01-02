SMODS.Atlas {
    key = "consumisprints",
    path = "consumisprints.png",
    px = 71,
    py = 95,
}

SMODS.Sound {
    key = "inapmit",
    path = "inapmit.ogg"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'defaultprint',
    set = 'mistarot',
    draw = function(self, card, layer) card.children.center:draw_shader('hologram', nil, card.ARGS.send_to_shader) end,
    pos = { x = 9, y = 2 },
    config = { extra = { count = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.count } }
    end,
    use = function(self, card, area, copier)
        for i = 1, card.ability.extra.count do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('bd_inapmit')
                    card:juice_up(0.3, 0.5)

                    local types = {
                        function() SMODS.add_card({ set = 'Joker' }) end,
                        function() SMODS.add_card({ set = 'Tarot' }) end,
                        function() SMODS.add_card({ set = 'Planet' }) end,
                        function() SMODS.add_card({ set = 'Spectral' }) end
                    }
                    local choice = pseudorandom_element(types, 'everything')
                    choice()
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    no_collection = true,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'foolprint',
    set = 'mistarot',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        local last_key = G.GAME.last_tarot_planet
        local last_c = last_key and G.P_CENTERS[last_key] or nil
        local last_type = last_c and last_c.set or localize('k_what')

        local colour = (not last_c or last_c.name == 'The Fool') and G.C.RED or G.C.GREEN
        if last_c and last_c.name ~= 'The Fool' then
            info_queue[#info_queue + 1] = last_c
        end

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_type .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }

        return { vars = { last_type }, main_end = main_end }
    end,

    use = function(self, card, area, copier)
        local last_key = G.GAME.last_tarot_planet
        local last_c = last_key and G.P_CENTERS[last_key]

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('bd_inapmit')
                    if last_c.set == 'Tarot' then
                        SMODS.add_card({ set = 'Tarot' })
                    elseif last_c.set == 'Planet' then
                        SMODS.add_card({ set = 'Planet' })
                    end
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,

    can_use = function(self, card)
        return (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables)
            and G.GAME.last_tarot_planet
            and G.GAME.last_tarot_planet ~= 'c_fool'
    end

}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'magicprint',
    set = 'mistarot',
    pos = { x = 1, y = 0 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'highestprintess',
    set = 'mistarot',
    pos = { x = 2, y = 0 },
    config = { extra = { min = 1, max = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.max } }
    end,
    use = function(self, card, area, copier)
        local amount = pseudorandom('milfdetected', card.ability.extra.min, card.ability.extra.max)

        for i = 1, math.min(amount, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3 + i * 0.1,
                func = function()
                    local planet = SMODS.add_card({ set = 'Planet' })
                    if planet then
                        planet:set_edition('e_negative', true)
                        planet:juice_up(0.3, 0.4)
                    end
                    play_sound('bd_inapmit')
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'emperints',
    set = 'mistarot',
    pos = { x = 3, y = 0 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'emprints',
    set = 'mistarot',
    pos = { x = 4, y = 0 },
    config = { extra = { min = 1, max = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.max } }
    end,
    use = function(self, card, area, copier)
        local amount = pseudorandom('milfdetected', card.ability.extra.min, card.ability.extra.max)
        for i = 1, math.min(amount, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3 + i * 0.1,
                func = function()
                    local tarot = SMODS.add_card({ set = 'Tarot' })
                    if tarot then
                        tarot:set_edition('e_negative', true)
                        tarot:juice_up(0.3, 0.4)
                    end
                    play_sound('bd_inapmit')
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'hieroprint',
    set = 'mistarot',
    pos = { x = 5, y = 0 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'loverprints',
    set = 'mistarot',
    pos = { x = 6, y = 0 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'charprints',
    set = 'mistarot',
    pos = { x = 7, y = 0 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'printice',
    set = 'mistarot',
    pos = { x = 8, y = 0 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'herprint',
    set = 'mistarot',
    pos = { x = 9, y = 0 },
    config = { extra = { min = 0.5, max = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.max } }
    end,
    use = function(self, card, area, copier)
        local mult = pseudorandom('notmarioshotdeadinwelsh', card.ability.extra.min * 10, card.ability.extra.max * 10) /
        10
        local current = G.GAME.dollars
        local target = math.floor(current * mult)
        local diff = target - current

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('bd_inapmit')
                card:juice_up(0.3, 0.5)
                ease_dollars(diff, true)
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.GAME and G.GAME.dollars > 0
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'wheelofprint',
    set = 'mistarot',
    pos = { x = 0, y = 1 },
    config = { extra = { odds = 4, min = 1, max = 5 } },
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'bruh')
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { n, d, card.ability.extra.min, card.ability.extra.max } }
    end,
    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, 'keeplactatingqueen', 1, card.ability.extra.odds) then
            local pool = {}

            for i = 1, #G.jokers.cards do
                if not G.jokers.cards[i].edition then
                    pool[#pool + 1] = G.jokers.cards[i]
                end
            end

            for i = 1, #G.hand.cards do
                if not G.hand.cards[i].edition then
                    pool[#pool + 1] = G.hand.cards[i]
                end
            end

            local count = math.min(
                pseudorandom('mngh', card.ability.extra.min, card.ability.extra.max),
                #pool
            )

            for i = 1, count do
                local target = pseudorandom_element(pool, 'bruh')
                if target then
                    local edition = poll_edition(
                        'bruh',
                        nil,
                        true,
                        true,
                        { 'e_polychrome', 'e_holo', 'e_foil', 'e_negative' }
                    )
                    target:set_edition(edition, true)
                    target:juice_up(0.3, 0.4)

                    for j = #pool, 1, -1 do
                        if pool[j] == target then
                            table.remove(pool, j)
                            break
                        end
                    end
                end
            end

            play_sound('timpani')
            card:juice_up(0.3, 0.5)
            check_for_unlock({ type = 'have_edition' })
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        silent = true
                    })
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        return (G.jokers and #G.jokers.cards > 0) or (G.hand and #G.hand.cards > 0)
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'strenghtprints',
    set = 'mistarot',
    pos = { x = 1, y = 1 },
    config = { max_highlighted = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local cards = G.hand.highlighted
        local ranks = {}

        for i = 1, #cards do
            ranks[i] = cards[i].base.value
        end

        for i = #ranks, 2, -1 do
            local j = pseudorandom('[REDACTED]', 1, i)
            ranks[i], ranks[j] = ranks[j], ranks[i]
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for i = 1, #cards do
            local c = cards[i]
            local suit = c.base.suit
            local rank = ranks[i]

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    SMODS.change_base(c, suit, rank)
                    c:juice_up(0.25, 0.3)
                    play_sound('card1', 1)
                    return true
                end
            }))
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))

        delay(0.6)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted == card.ability.max_highlighted
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'hangedprint',
    set = 'mistarot',
    pos = { x = 2, y = 1 },
    config = { max_highlighted = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local enhanced = {}

        for i = 1, #G.hand.cards do
            local c = G.hand.cards[i]
            if c.ability and c.ability.effect then
                enhanced[#enhanced + 1] = c
            end
        end

        for i = #enhanced, 2, -1 do
            local j = pseudorandom('severance_shuffle', 1, i)
            enhanced[i], enhanced[j] = enhanced[j], enhanced[i]
        end

        local targets = G.hand.highlighted

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)

                for i = 1, #enhanced do
                    local c = enhanced[i]
                    c:juice_up(0.4, 0.5)
                    c:start_dissolve()
                end

                for i = 1, #targets do
                    local c = targets[i]
                    c.ability.perma_repetitions =
                        (c.ability.perma_repetitions or 0) + 1

                    card_eval_status_text(
                        c,
                        "extra",
                        nil,
                        nil,
                        nil,
                        {
                            message = "+1 Retrigger",
                            colour = G.C.MULT
                        }
                    )

                    c:juice_up(0.25, 0.3)
                end

                return true
            end
        }))

        delay(0.6)
    end,
    can_use = function(self, card)
        return G.hand and
            (not G.hand.highlighted[1].edition)
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'deathprint',
    set = 'mistarot',
    pos = { x = 3, y = 1 },
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'echo_hand')
        return { vars = { n, d } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)

                local originals = {}
                for i = 1, #G.hand.cards do
                    originals[i] = G.hand.cards[i]
                end

                for i = 1, #originals do
                    if SMODS.pseudorandom_probability(
                        card,
                        'fuck' .. i,
                        1,
                        card.ability.extra.odds
                    ) then
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1

                        local card_copied = copy_card(
                            originals[i],
                            nil,
                            nil,
                            G.playing_card
                        )

                        card_copied:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, card_copied)
                        G.hand:emplace(card_copied)
                        card_copied.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card_copied:start_materialize()
                                return true
                            end
                        }))

                        SMODS.calculate_context({
                            playing_card_added = true,
                            cards = { card_copied }
                        })
                    end
                end

                for i = 1, #G.hand.cards do
                    local forced_card = G.hand.cards[i]
                    forced_card.ability.forced_selection = true
                    G.hand:add_to_highlighted(forced_card)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'temprint',
    set = 'mistarot',
    pos = { x = 4, y = 1 },
    config = { extra = { min = 0.2, max = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.max } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('bd_inapmit')
                card:juice_up(0.3, 0.5)
                for i = 1, #G.jokers.cards do
                    local joker = G.jokers.cards[i]
                    if joker.ability.set == 'Joker' then
                        local mult = pseudorandom(
                            'ifyourereadingthisfuckyou' .. i,
                            card.ability.extra.min * 10,
                            card.ability.extra.max * 10
                        ) / 10
                        joker.sell_cost = math.max(1, math.floor(joker.sell_cost * mult))
                        joker:juice_up(0.2, 0.3)
                    end
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'devprint',
    set = 'mistarot',
    pos = { x = 5, y = 1 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'towprint',
    set = 'mistarot',
    pos = { x = 6, y = 1 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'starprint',
    set = 'mistarot',
    pos = { x = 7, y = 1 },
    config = { max_highlighted = 3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local targets = G.hand.highlighted

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)

                for i = 1, #targets do
                    local c = targets[i]
                    local chips = c:get_chip_bonus() or 0
                    local x_gain = chips / 4

                    if x_gain > 0 then
                        c.ability.perma_x_mult =
                            (c.ability.perma_x_mult or 0) + x_gain

                        c:juice_up(0.25, 0.3)
                    end
                end
                return true
            end
        }))

        delay(0.6)
    end,
    can_use = function(self, card)
        if not G.hand then return false end
        local sel = G.hand.highlighted

        if #sel == 0 or #sel > card.ability.max_highlighted then
            return false
        end

        for i = 1, #sel do
            local suit = sel[i].base and sel[i].base.suit
            if suit ~= 'Hearts' and suit ~= 'Diamonds' then
                return false
            end
        end

        return true
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'moonprint',
    set = 'mistarot',
    pos = { x = 8, y = 1 },
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'sunprint',
    set = 'mistarot',
    pos = { x = 9, y = 1 },
    config = { max_highlighted = 3 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local targets = G.hand.highlighted

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)

                for i = 1, #targets do
                    local c = targets[i]
                    local chips = c:get_chip_bonus() or 0
                    local mult_gain = chips / 2

                    if mult_gain > 0 then
                        c.ability.perma_mult =
                            (c.ability.perma_mult or 0) + mult_gain

                        c:juice_up(0.25, 0.3)
                    end
                end
                return true
            end
        }))

        delay(0.6)
    end,
    can_use = function(self, card)
        if not G.hand then return false end
        local sel = G.hand.highlighted

        if #sel == 0 or #sel > card.ability.max_highlighted then
            return false
        end

        for i = 1, #sel do
            local suit = sel[i].base and sel[i].base.suit
            if suit ~= 'Hearts' and suit ~= 'Diamonds' then
                return false
            end
        end

        return true
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'judgeprint',
    set = 'mistarot',
    pos = { x = 0, y = 2 },
    use = function(self, card, area, copier)
        local joker = G.jokers.highlighted[1]
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                joker:juice_up(0.4, 0.5)
                joker:start_dissolve()
                card:juice_up(0.3, 0.5)

                for i = 1, 2 do
                    local set = pseudorandom_element(
                        { 'mistarot', 'misplanet', 'mispectral' },
                        'iveseenfootage'
                    )

                    local c = SMODS.add_card({
                        set = set,
                        bypass_limit = true
                    })

                    if c then
                        c:juice_up(0.3, 0.4)
                    end
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.jokers and #G.jokers.highlighted == 1
    end
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'worldprint',
    set = 'mistarot',
    pos = { x = 1, y = 2 },
}
