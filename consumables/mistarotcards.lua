SMODS.Sound {
    key = "inapmit",
    path = "inapmit.ogg",
    volume = 1.5
} 
 
SMODS.ConsumableType({
    key = "mistarot",
    collection_rows = { 5, 6 },
    primary_colour = G.C.SECONDARY_SET.Tarot,
    secondary_colour = SMODS.Gradients.bd_rotta,--SMODS.Gradient(rotta),
    default = "c_bd_foolprint",
    cards = {},
    shop_rate = 4,
    loc_txt = {
		undiscovered = {
			name = "Not Discovered",
			text = {
				"Purchase or use",
				"this card in an",
				"unseeded run to",
				"learn what it does"
			},
		},
	},
	
})

BadDirector.MisprTarots = SMODS.Consumable:extend {
    discovered = false,
	unlocked = true,
    set = 'mistarot',
--    hidden = true,
    soul_set = "Tarot",
    soul_rate = 0.01,
    in_pool = function (self, args)
       return true
    end,
	
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'defaultprint',
    set = 'mistarot',
    draw = function(self, card, layer) card.children.center:draw_shader('hologram', nil, card.ARGS.send_to_shader) end,
    pos = { x = 9, y = 2 },
    config = { extra = { count = 2 }, },
    can_use = function(self, card)
        return #G.consumeables.cards > 0
    end,

    use = function(self, card, area, copier)
        for i = 1, #G.consumeables.cards do
            local target = G.consumeables.cards[i]

            if target and target.config then
                BadDirector.manipulate(target, {
                    min = 0.5,
                    max = 3,
                    type = "X",
                    dont_stack = true,
                    no_deck_effects = true,
                    seed = "giggity" .. G.GAME.round
                })
            end
        end

        play_sound('bd_inapmit')
    end
}

SMODS.UndiscoveredSprite {
  key = "mistarot",
  atlas = "consumisprints",
  pos = { x = 9, y = 2 },
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'foolprint',
    set = 'mistarot',
    config = {  },
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        local last_key = G.GAME.bd_last_used_cons
        local last_c = last_key and G.P_CENTERS[last_key] or nil
        local last_type = last_c 
		and ((last_c.set == "Tarot" 
			or last_c.set == "Planet" 
			or last_c.set == "Spectral")
			and last_c.set 
			or localize('k_'..last_c.set))
		or localize('k_what')

        local colour = (not last_c or (not last_c.set ~= "Spectral" or not last_c.set ~= "mispectral")) and G.C.RED or G.C.GREEN

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
        local last_key = G.GAME.bd_last_used_cons
        local last_c = last_key and G.P_CENTERS[last_key]

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('bd_inapmit')
                    SMODS.add_card({ set = last_c.set })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,

    can_use = function(self, card)
		if G.GAME.bd_last_used_cons and (G.P_CENTERS[G.GAME.bd_last_used_cons].set == "Spectral" or
			G.P_CENTERS[G.GAME.bd_last_used_cons].set == "mispectral") then
			return false
		end
		
		if #G.consumeables.cards >= G.consumeables.config.card_limit then return false end
		
		if (not G.GAME.bd_last_used_cons) then return false end
		
		return true
    end,
    misprint_original = "c_fool"
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'magicprint',
    set = 'mistarot',
    config = {max_highlighted = 2,mod_conv = "m_bd_misprintluckycard"},
    pos = { x = 1, y = 0 },
    misprint_original = "c_magician",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize{ type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'highestprintess',
    set = 'mistarot',
    pos = { x = 2, y = 0 },
    config = { extra = { min = 1, max = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.max } }
    end,
    use = function(self, card, area, copier)
        local amount = pseudorandom('highestprintess', card.ability.extra.min, card.ability.extra.max)

        for i = 1, amount do
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
    end,
    misprint_original = "c_highest_priestess"
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'emperints',
    set = 'mistarot',
    config = {max_highlighted = 2, mod_conv = "m_bd_misprintmult"},
    pos = { x = 3, y = 0 },
    misprint_original = "c_empress",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'emprints',
    set = 'mistarot',
    pos = { x = 4, y = 0 },
    config = { extra = { min = 1, max = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.max } }
    end,
    use = function(self, card, area, copier)
        local amount = pseudorandom('emprints', card.ability.extra.min, card.ability.extra.max)

        for i = 1, amount do
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
    end,
    misprint_original = "c_emperor"
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'hieroprint',
    set = 'mistarot',
    pos = { x = 5, y = 0 },
    misprint_original = "c_heirophant",
    config = {max_highlighted = 2,mod_conv = "m_bd_misprintbonus"},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'loverprints',
    set = 'mistarot',
    pos = { x = 6, y = 0 },
    misprint_original = "c_lovers",
    config = {max_highlighted = 1 ,mod_conv = "m_bd_misprintwild"},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'charprints',
    set = 'mistarot',
    pos = { x = 7, y = 0 },
    misprint_original = "c_chariot",
    config = {max_highlighted = 1,mod_conv = "m_bd_misprintsteel"},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'printice',
    set = 'mistarot',
    pos = { x = 8, y = 0 },
    misprint_original = "c_justice",
    config = {max_highlighted = 1,mod_conv = "m_bd_misprintglass"},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

BadDirector.MisprTarots {
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
    end,
    misprint_original = "c_hermit"
}

BadDirector.MisprTarots {
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
    end,
    misprint_original = "c_wheel_of_fortune"
}

BadDirector.MisprTarots {
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
    end,
    misprint_original = "c_strength"
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'hangedprint',
    set = 'mistarot',
    pos = { x = 2, y = 1 },
    config = {
        max_highlighted = 2,
        extra_destroy = 3
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.max_highlighted, self.config.extra_destroy } }
    end,
    use = function(self, card, area, copier)
        local selected = {}
        for _, c in ipairs(G.hand.cards) do
            if c.highlighted then
                selected[#selected + 1] = c
            end
        end
        if #selected ~= self.config.max_highlighted then return end

        local pool = {}
        for _, c in ipairs(G.hand.cards) do
            if not c.highlighted then
                pool[#pool + 1] = c
            end
        end
        if #pool < self.config.extra_destroy then return end

        for i = 1, self.config.extra_destroy do
            local idx = pseudorandom("double_cull", 1, #pool)
            selected[#selected + 1] = table.remove(pool, idx)
        end

        for _, c in ipairs(selected) do
            c:start_dissolve()
        end
    end,
    misprint_original = "c_hanged_man"
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'deathprint',
    set = 'mistarot',
    pos = { x = 3, y = 1 },
    config = { extra = { odds =  4 } },
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
    end,
    misprint_original = "c_death"
}

BadDirector.MisprTarots {
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
    end,
    misprint_original = "c_temperance"
}


BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'devprint',
    set = 'mistarot',
    pos = { x = 5, y = 1 },
    misprint_original = "c_devil",
    config = {max_highlighted = 1,mod_conv = "m_bd_misprintgold"},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,

}


BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'towprint',
    set = 'mistarot',
    pos = { x = 6, y = 1 },
    misprint_original = "c_tower",
    config = {max_highlighted = 1,mod_conv = "m_bd_misprintstone"},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'starprint',
    set = 'mistarot',
    pos = { x = 7, y = 1 },
    config = { max_highlighted = 3, suit_allowed1 = 'Diamonds', suit_allowed2 = 'Hearts' },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.suit_allowed1, card.ability.suit_allowed2 } }
    end,

    use = function(self, card, area, copier)
        local count = #G.consumeables.cards
        local xchips = count * 0.5
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local chips = G.hand.highlighted[i]:get_chip_bonus() or 0
                    local x_mult_gain = (chips * 0.1)
                    G.hand.highlighted[i].ability.perma_x_mult = (G.hand.highlighted[i].ability.perma_x_mult or 0) +
                    x_mult_gain
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
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
        delay(0.5)
    end,

    can_use = function(self, card)
        local true_suit = false
        local wrong_suit = true
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
            for i = 1, #G.hand.highlighted do
                if (G.hand.highlighted[i]:is_suit(card.ability.suit_allowed1) or G.hand.highlighted[i]:is_suit(card.ability.suit_allowed2)) then
                    true_suit = true
                end
                if not (G.hand.highlighted[i]:is_suit(card.ability.suit_allowed1) or G.hand.highlighted[i]:is_suit(card.ability.suit_allowed2)) then
                    wrong_suit = false
                end
            end
        end
        return true_suit and wrong_suit
    end,
    misprint_original = "c_star"
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'moonprint',
    set = 'mistarot',
    pos = { x = 8, y = 1 },
    config = { max_highlighted = 3, suit_allowed1 = 'Clubs', suit_allowed2 = 'Spades' },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.suit_allowed1, card.ability.suit_allowed2 } }
    end,

    use = function(self, card, area, copier)
        local count = #G.consumeables.cards
        local xchips = count * 0.5
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i].ability.perma_x_chips = (G.hand.highlighted[i].ability.perma_x_chips or 1) +
                    xchips
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
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
        delay(0.5)
    end,

    can_use = function(self, card)
        local true_suit = false
        local wrong_suit = true
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
            for i = 1, #G.hand.highlighted do
                if (G.hand.highlighted[i]:is_suit(card.ability.suit_allowed1) or G.hand.highlighted[i]:is_suit(card.ability.suit_allowed2)) then
                    true_suit = true
                end
                if not (G.hand.highlighted[i]:is_suit(card.ability.suit_allowed1) or G.hand.highlighted[i]:is_suit(card.ability.suit_allowed2)) then
                    wrong_suit = false
                end
            end
        end
        return true_suit and wrong_suit
    end,
    misprint_original = "c_moon"
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'sunprint',
    set = 'mistarot',
    pos = { x = 9, y = 1 },
    config = { max_highlighted = 3, suit_allowed1 = 'Hearts', suit_allowed2 = 'Diamonds' },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.suit_allowed1, card.ability.suit_allowed2 } }
    end,

    use = function(self, card, area, copier)
        local count = #G.consumeables.cards
        local xchips = count * 0.5
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local chips = G.hand.highlighted[i]:get_chip_bonus() or 0
                    local mult_gain = (chips / 2)
                    G.hand.highlighted[i].ability.perma_mult = (G.hand.highlighted[i].ability.perma_mult or 0) +
                    mult_gain
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
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
        delay(0.5)
    end,

    can_use = function(self, card)
        local true_suit = false
        local wrong_suit = true
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
            for i = 1, #G.hand.highlighted do
                if (G.hand.highlighted[i]:is_suit(card.ability.suit_allowed1) or G.hand.highlighted[i]:is_suit(card.ability.suit_allowed2)) then
                    true_suit = true
                end
                if not (G.hand.highlighted[i]:is_suit(card.ability.suit_allowed1) or G.hand.highlighted[i]:is_suit(card.ability.suit_allowed2)) then
                    wrong_suit = false
                end
            end
        end
        return true_suit and wrong_suit
    end,
    misprint_original = "c_sun"
}

BadDirector.MisprTarots {
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
    end,
    misprint_original = "c_judgement"
}

BadDirector.MisprTarots {
    atlas = "consumisprints",
    key = 'worldprint',
    set = 'mistarot',
    pos = { x = 1, y = 2 },
    config = { max_highlighted = 3, suit_allowed1 = 'Spades', suit_allowed2 = 'Clubs' },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted, card.ability.suit_allowed1, card.ability.suit_allowed2 } }
    end,

    use = function(self, card, area, copier)
        local chips = 0
        for _, j in ipairs(G.jokers.cards) do
            if j.sell_cost then
                chips = chips + j.sell_cost
            end
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
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i].ability.perma_bonus = (G.hand.highlighted[i].ability.perma_bonus or 0) + chips
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
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
        delay(0.5)
    end,

    can_use = function(self, card)
        local true_suit = false
        local wrong_suit = true
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
            for i = 1, #G.hand.highlighted do
                if (G.hand.highlighted[i]:is_suit(card.ability.suit_allowed1) or G.hand.highlighted[i]:is_suit(card.ability.suit_allowed2)) then
                    true_suit = true
                end
                if not (G.hand.highlighted[i]:is_suit(card.ability.suit_allowed1) or G.hand.highlighted[i]:is_suit(card.ability.suit_allowed2)) then
                    wrong_suit = false
                end
            end
        end
        return true_suit and wrong_suit
    end,
    misprint_original = "c_world"
}
