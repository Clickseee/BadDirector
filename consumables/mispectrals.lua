SMODS.ConsumableType({
    key = "mispectral",
    collection_rows = { 4, 5 },
    primary_colour = G.C.SECONDARY_SET.Spectral,
    secondary_colour = SMODS.Gradients.bd_ralspect,
    default = "c_bd_familiarprint",
    cards = {},
    shop_rate = 0,
    discovered = false,
    unlocked = true,
    --hidden = true,
    soul_set = "Spectral",
    soul_rate = 0.01,
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
local function BadDirector_reset_crt_smooth()
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        blocking = false,
        func = function()
            BadDirector_crt_glitch = math.max(0, BadDirector_crt_glitch - 0.1)
            BadDirector_crt_noise = math.max(0, BadDirector_crt_noise - 0.1)
            BadDirector_crt_intensity = math.max(0, BadDirector_crt_intensity - 0.1)

            if BadDirector_crt_glitch > 0 then
                return false
            end

            return true
        end
    }))
end

BadDirector.MisSpect = SMODS.Consumable:extend {
    atlas = "bd_consumisprints",
    set = 'mispectral',
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
}

SMODS.UndiscoveredSprite {
    key = "mispectral",
    atlas = "consumisprints",
    pos = { x = 9, y = 6 },
}

BadDirector.MisSpect {
    key = 'spectralprint',
    pos = { x = 9, y = 6 },
    can_use = function(self, card)
        return #G.jokers.cards > 0
    end,
    use = function(self, card, area, copier)
        BadDirector_set_crt_vals('glitch', 2)
        BadDirector_set_crt_vals('noise', 1.0)
        BadDirector_set_crt_vals('intensity', 1.5)
        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]

            if joker and joker.config then
                BadDirector.manipulate(joker, {
                    min = 0.5,
                    max = 3,
                    type = "X",
                    dont_stack = true,
                    no_deck_effects = true,
                    seed = "fuckme5sides" .. G.GAME.round
                })

                joker:juice_up(0.4, 0.4)
                play_sound('bd_inapmit')
                BadDirector_reset_crt_smooth()
            end
        end
    end
}


BadDirector.MisSpect {
    key = 'familiarprint',
    pos = { x = 0, y = 5 },
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,

    use = function(self, card, area, copier)

        play_sound('tarot1')

        local enhancement_pool = {}

        for _, center in pairs(G.P_CENTER_POOLS.Enhanced) do

            if center.key ~= 'm_stone' then
                enhancement_pool[#enhancement_pool + 1] = center.key
            end
        end

        local destroyed_cards = {}

        for _, playing_card in ipairs(G.hand.cards) do

            local id = playing_card:get_id()

            local is_face =
                id == 11 or id == 12 or id == 13

            if is_face then

                local enhancement =
                    pseudorandom_element(
                        enhancement_pool,
                        pseudoseed('im lonely.')
                    )

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        playing_card:set_ability(
                            G.P_CENTERS[enhancement],
                            nil,
                            true
                        )

                        playing_card:juice_up()

                        play_sound('gold_seal')

                        return true
                    end
                }))

            else

                destroyed_cards[#destroyed_cards + 1] =
                    playing_card

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        playing_card:juice_up()

                        return true
                    end
                }))
            end
        end

        if #destroyed_cards > 0 then

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()

                    SMODS.destroy_cards(destroyed_cards)

                    play_sound('slice1')

                    return true
                end
            }))
        end

        delay(0.8)
    end,
    misprint_original = "c_familiar"
}

BadDirector.MisSpect {
    key = 'grimprint',
    pos = { x = 1, y = 5 },
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,

    use = function(self, card, area, copier)

        play_sound('tarot1')

        local enhancement_pool = {}

        for _, center in pairs(G.P_CENTER_POOLS.Enhanced) do

            if center.key ~= 'm_stone' then
                enhancement_pool[#enhancement_pool + 1] = center.key
            end
        end

        local destroyed_cards = {}

        for _, playing_card in ipairs(G.hand.cards) do

            local id = playing_card:get_id()

            local is_ace = id == 14

            if is_ace then

                local enhancement =
                    pseudorandom_element(
                        enhancement_pool,
                        pseudoseed('im weak')
                    )

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        playing_card:set_ability(
                            G.P_CENTERS[enhancement],
                            nil,
                            true
                        )

                        playing_card:juice_up()

                        play_sound('gold_seal')

                        return true
                    end
                }))

            else

                destroyed_cards[#destroyed_cards + 1] =
                    playing_card

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        playing_card:juice_up()

                        return true
                    end
                }))
            end
        end

        if #destroyed_cards > 0 then

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()

                    SMODS.destroy_cards(destroyed_cards)

                    play_sound('slice1')

                    return true
                end
            }))
        end

        delay(0.8)
    end,
    misprint_original = "c_grim"
}

BadDirector.MisSpect {
    key = 'incantaprint',
    pos = { x = 2, y = 5 },
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,

    use = function(self, card, area, copier)

        play_sound('tarot1')

        local enhancement_pool = {}

        for _, center in pairs(G.P_CENTER_POOLS.Enhanced) do

            if center.key ~= 'm_stone' then
                enhancement_pool[#enhancement_pool + 1] = center.key
            end
        end

        local destroyed_cards = {}

        for _, playing_card in ipairs(G.hand.cards) do

            local id = playing_card:get_id()

            local is_numbered =
                id >= 2 and id <= 10

            if is_numbered then

                local enhancement =
                    pseudorandom_element(
                        enhancement_pool,
                        pseudoseed('im tired')
                    )

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        playing_card:set_ability(
                            G.P_CENTERS[enhancement],
                            nil,
                            true
                        )

                        playing_card:juice_up()

                        play_sound('gold_seal')

                        return true
                    end
                }))

            else

                destroyed_cards[#destroyed_cards + 1] =
                    playing_card

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        playing_card:juice_up()

                        return true
                    end
                }))
            end
        end

        if #destroyed_cards > 0 then

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()

                    SMODS.destroy_cards(destroyed_cards)

                    play_sound('slice1')

                    return true
                end
            }))
        end

        delay(0.8)
    end,
    misprint_original = "c_incantation"
}

BadDirector.MisSpect {
    key = 'talisprint',

    pos = { x = 3, y = 5 },
    misprint_original = "c_talisman",
    config = { extra = { seal = 'Gold', seal_m = 'bd_goldprint' }, odds = 6 }, -- can be adjusted as need be ofc
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal_m]
        return { vars = { G.GAME.probabilities.normal, card.ability.odds } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        play_sound('bd_inapmit') -- was unsure if it should play every time a seal is applied lol
        for i = 1, #G.hand.cards do
            local woah = G.hand.cards[i]
            if pseudorandom('blud is golden') < G.GAME.probabilities.normal / card.ability.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        if SMODS.pseudorandom_probability(card,"goodboy",1,5,nil,true) then
                            woah:set_seal(card.ability.extra.seal_m, nil, true)
                        else
                            woah:set_seal(card.ability.extra.seal, nil, true)
                        end
                        return true
                    end
                }))
                delay(0.5)
            else -- we probably dont HAVE to have the Nope! here so i can remove if need be i just thought it might help visually
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.6,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1,
                            hold = 1,
                            major = woah,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = 'cm',
                            offset = { x = 0 + ((G.hand.cards[(math.floor(#G.hand.cards / 2))].T.x - woah.T.x) / -50), y = -2 },
                            silent = true,
                        })
                        play_sound('generic1')
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end
    end
}


BadDirector.MisSpect {
    key = 'auraprint',
    pos = { x = 4, y = 5 },
    config = {
        odds = 4
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        local num, den = SMODS.get_probability_vars(
            card,
            1,
            card.ability.odds,
            'i cant stop thinking about you'
        )

        return {
            vars = {
                num,
                den
            }
        }
    end,

    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,

    use = function(self, card, area, copier)
        play_sound('tarot1')

        local edition_pool = {
            'e_foil',
            'e_holo',
            'e_polychrome'
        }

        for i = 1, #G.hand.cards do
            local target = G.hand.cards[i]

            if SMODS.pseudorandom_probability(
                    card,
                    'you left me to rot',
                    1,
                    card.ability.odds,
                    'i thought we pinky promised'
                ) then
                local chosen_edition =
                    pseudorandom_element(
                        edition_pool,
                        pseudoseed('why did you lie to me')
                    )

                G.E_MANAGER:add_event(Event({
                    func = function()
                        target:juice_up(0.3, 0.5)

                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        target:set_edition(
                            {
                                foil = chosen_edition == 'e_foil',
                                holo = chosen_edition == 'e_holo',
                                polychrome = chosen_edition == 'e_polychrome'
                            },
                            true
                        )

                        play_sound('generic1')

                        return true
                    end
                }))
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1,
                            hold = 0.8,
                            major = target,
                            backdrop_colour = G.C.SECONDARY_SET.Spectral,
                            align = 'cm',
                            offset = {
                                x = 0,
                                y = -2
                            },
                            silent = true,
                        })

                        play_sound('cancel')

                        target:juice_up(0.3, 0.5)

                        return true
                    end
                }))
            end
        end

        delay(0.6)
    end,
    misprint_original = "c_aura"
}


BadDirector.MisSpect {
    key = 'wrathprint',
    pos = { x = 5, y = 5 },
    config = {
        max_highlighted = 1
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.max_highlighted
            }
        }
    end,

    can_use = function(self, card)
        if not G.jokers then
            return false
        end

        if #G.jokers.highlighted ~= 1 then
            return false
        end

        local selected = G.jokers.highlighted[1]

        if not selected.config.center.rarity then
            return false
        end

        return selected.config.center.rarity < 4
    end,

    use = function(self, card, area, copier)
        local selected = G.jokers.highlighted[1]
        local _edition = G.jokers.highlighted[1].edition
        if not selected then
            return
        end

        local rarity = selected.config.center.rarity

        if rarity >= 4 then
            return
        end

        local target_rarity = rarity + 1

        local money_loss = math.floor(G.GAME.dollars * 0.5)

        ease_dollars(-money_loss)

        local created_joker = nil

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')

                selected:start_dissolve()

                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.6,
            func = function()
                created_joker = SMODS.create_card({
                    set = 'Joker',
                    area = G.jokers,
                    legendary = true,
                    rarity = target_rarity,
                    skip_materialize = nil,
                    soulable = nil,
                    key=  nil,
                    key_append = 'hostile_takeover',
                    edition = _edition,
                }
                )

                created_joker:add_to_deck()

                G.jokers:emplace(created_joker)

                created_joker:start_materialize()

                created_joker:juice_up()

                play_sound('timpani')

                return true
            end
        }))

        delay(0.8)

        G.jokers:unhighlight_all()
    end,
    misprint_original = "c_wrath"
}

BadDirector.MisSpect {
    key = 'sigilprint',
    pos = { x = 6, y = 5 },
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,

    use = function(self, card, area, copier)

        local suit_count = {
            Hearts = 0,
            Diamonds = 0,
            Clubs = 0,
            Spades = 0
        }

        for _, playing_card in ipairs(G.hand.cards) do

            if not SMODS.has_no_suit(playing_card) then

                local suit = playing_card.base.suit

                if suit_count[suit] then
                    suit_count[suit] =
                        suit_count[suit] + 1
                end
            end
        end

        local highest = 0
        local valid_suits = {}

        for suit, amount in pairs(suit_count) do

            if amount > highest then

                highest = amount
                valid_suits = { suit }

            elseif amount == highest then

                valid_suits[#valid_suits + 1] = suit

            end
        end

        if #valid_suits <= 0 then
            return
        end

        local chosen_suit =
            pseudorandom_element(
                valid_suits,
                pseudoseed('lyingfuck_suit')
            )

        local possible_effects = {

            'perma_mult',
            'money',
            'chips',
            'mult',
            'xmult',
            'hands',
            'discards'

        }

        local chosen_effect =
            pseudorandom_element(
                possible_effects,
                pseudoseed('lyingfuck_effect')
            )

        local amount = nil

        if chosen_effect == 'perma_mult' then
            amount = pseudorandom(
                pseudoseed('lyingfuck_pm'),
                1,
                5
            )

        elseif chosen_effect == 'money' then
            amount = pseudorandom(
                pseudoseed('lyingfuck_cash'),
                3,
                20
            )

        elseif chosen_effect == 'chips' then
            amount = pseudorandom(
                pseudoseed('lyingfuck_chips'),
                20,
                150
            )

        elseif chosen_effect == 'mult' then
            amount = pseudorandom(
                pseudoseed('lyingfuck_mult'),
                5,
                40
            )

        elseif chosen_effect == 'xmult' then
            amount = pseudorandom(
                pseudoseed('lyingfuck_xmult'),
                1,
                4
            ) / 2

        elseif chosen_effect == 'hands' then
            amount = 1

        elseif chosen_effect == 'discards' then
            amount = 1
        end

        play_sound('tarot1')

        local affected_cards = {}

        for _, playing_card in ipairs(G.hand.cards) do

            if playing_card.base.suit == chosen_suit then
                affected_cards[#affected_cards + 1] =
                    playing_card
            end
        end

        if chosen_effect == 'perma_mult' then

            for _, playing_card in ipairs(affected_cards) do

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        playing_card.ability.perma_mult =
                            (playing_card.ability.perma_mult or 0)
                            + amount

                        playing_card:juice_up()

                        return true
                    end
                }))
            end

        elseif chosen_effect == 'money' then

            ease_dollars(amount)

        elseif chosen_effect == 'chips' then

            G.GAME.chips =
                G.GAME.chips + amount

        elseif chosen_effect == 'mult' then

            G.GAME.round_resets.mult =
                (G.GAME.round_resets.mult or 0)
                + amount

        elseif chosen_effect == 'xmult' then

            G.GAME.current_round.current_hand.mult =
                G.GAME.current_round.current_hand.mult
                * amount

        elseif chosen_effect == 'hands' then

            G.GAME.round_resets.hands =
                G.GAME.round_resets.hands + amount

        elseif chosen_effect == 'discards' then

            ease_discard(amount)
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            func = function()

                local text = ''

                if chosen_effect == 'perma_mult' then

                    text =
                        '+' ..
                        amount ..
                        ' Perma Mult'

                elseif chosen_effect == 'money' then

                    text =
                        '$' ..
                        amount

                elseif chosen_effect == 'chips' then

                    text =
                        '+' ..
                        amount ..
                        ' Chips'

                elseif chosen_effect == 'mult' then

                    text =
                        '+' ..
                        amount ..
                        ' Mult'

                elseif chosen_effect == 'xmult' then

                    text =
                        'X' ..
                        amount ..
                        ' Mult'

                elseif chosen_effect == 'hands' then

                    text =
                        '+' ..
                        amount ..
                        ' Hands'

                elseif chosen_effect == 'discards' then

                    text =
                        '+' ..
                        amount ..
                        ' Discards'
                end

                attention_text({
                    text = text,
                    scale = 1,
                    hold = 1,
                    major = card,
                    backdrop_colour = G.C.SUITS[chosen_suit],
                    align = 'cm',
                    offset = { x = 0, y = -2 },
                    silent = true
                })

                card:juice_up()

                return true
            end
        }))

        delay(0.8)
    end,
    misprint_original = "c_sigil"
}

BadDirector.MisSpect {
    key = 'ouijaprint',
    pos = { x = 7, y = 5 },
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,

    use = function(self, card, area, copier)

        play_sound('tarot1')

        G.hand:change_size(1)

        local rank_order = {
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
            '9',
            '10',
            'Jack',
            'Queen',
            'King',
            'Ace'
        }

        local rank_indexes = {
            [2] = 1,
            [3] = 2,
            [4] = 3,
            [5] = 4,
            [6] = 5,
            [7] = 6,
            [8] = 7,
            [9] = 8,
            [10] = 9,
            [11] = 10,
            [12] = 11,
            [13] = 12,
            [14] = 13
        }

        for _, playing_card in ipairs(G.hand.cards) do

            local current_id = playing_card:get_id()

            local current_index =
                rank_indexes[current_id]

            if current_index then

                local decrease =
                    pseudorandom(
                        pseudoseed('fuck you ruby'),
                        1,
                        4
                    )

                local new_index =
                    current_index - decrease
                
                while new_index < 1 do
                    new_index =
                        new_index + #rank_order
                end

                local new_rank =
                    rank_order[new_index]

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        assert(SMODS.change_base(
                            playing_card,
                            nil,
                            new_rank
                        ))

                        playing_card:juice_up()

                        attention_text({
                            text = "-" .. decrease,
                            scale = 0.8,
                            hold = 0.6,
                            major = playing_card,
                            backdrop_colour = G.C.RED,
                            align = 'cm',
                            offset = {
                                x = 0,
                                y = -1.8
                            },
                            silent = true
                        })

                        play_sound('card1')

                        return true
                    end
                }))
            end
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()

                attention_text({
                    text = "+1 Hand Size",
                    scale = 1,
                    hold = 1,
                    major = card,
                    backdrop_colour = G.C.BLUE,
                    align = 'cm',
                    offset = { x = 0, y = -2 },
                    silent = true
                })

                return true
            end
        }))

        delay(0.8)
    end,
    misprint_original = "c_ouija"
}

BadDirector.MisSpect {
    key = 'ectoprint',
    pos = { x = 8, y = 5 },
    config = {
        neg_odds = 3,
        sell_odds = 2
    },
    loc_vars = function(self, info_queue, card)

        local neg_num, neg_den =
            SMODS.get_probability_vars(
                card,
                1,
                card.ability.neg_odds,
                'negative'
            )

        local sell_num, sell_den =
            SMODS.get_probability_vars(
                card,
                1,
                card.ability.sell_odds,
                'sell'
            )

        return {
            vars = {
                neg_num,
                neg_den,
                sell_num,
                sell_den
            }
        }
    end,

    can_use = function(self, card)

        return
            G.jokers
            and #G.jokers.cards > 0
    end,

    use = function(self, card, area, copier)

        play_sound('tarot1')

        for _, joker in ipairs(G.jokers.cards) do

            local got_negative =
                SMODS.pseudorandom_probability(
                    card,
                    'negative',
                    1,
                    card.ability.neg_odds,
                    'negative'
                )

            local lost_sell_value =
                SMODS.pseudorandom_probability(
                    card,
                    'sell',
                    1,
                    card.ability.sell_odds,
                    'sell'
                )

            if got_negative then

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        joker:set_edition(
                            {
                                negative = true
                            },
                            true
                        )

                        joker:juice_up()

                        play_sound('negative')

                        attention_text({
                            text = "Negative",
                            scale = 1,
                            hold = 0.8,
                            major = joker,
                            backdrop_colour = G.C.DARK_EDITION,
                            align = 'cm',
                            offset = {
                                x = 0,
                                y = -2
                            },
                            silent = true
                        })

                        return true
                    end
                }))
            end

            if lost_sell_value then

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()

                        joker.sell_cost = 0

                        joker:juice_up()

                        play_sound('cancel')

                        attention_text({
                            text = "$0",
                            scale = 1,
                            hold = 0.8,
                            major = joker,
                            backdrop_colour = G.C.MONEY,
                            align = 'cm',
                            offset = {
                                x = 0,
                                y = -1
                            },
                            silent = true
                        })

                        return true
                    end
                }))
            end

            if not got_negative
            and not lost_sell_value then

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()

                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 0.9,
                            hold = 0.6,
                            major = joker,
                            backdrop_colour = G.C.SECONDARY_SET.Spectral,
                            align = 'cm',
                            offset = {
                                x = 0,
                                y = -2
                            },
                            silent = true
                        })

                        joker:juice_up()

                        return true
                    end
                }))
            end
        end

        delay(0.8)
    end,
    misprint_original = "c_ectoplasm"
}

BadDirector.MisSpect {
    key = 'immoprint',
    pos = { x = 9, y = 5 },
    can_use = function(self, card)

        return
            G.hand
            and #G.hand.cards > 0
    end,

    use = function(self, card, area, copier)

        local total_rank = 0
        local counted_cards = 0

        for _, playing_card in ipairs(G.hand.cards) do

            local id = playing_card:get_id()

            local value = nil

            if id >= 2 and id <= 10 then
                value = id

            elseif id == 11 then
                value = 11

            elseif id == 12 then
                value = 12

            elseif id == 13 then
                value = 13

            elseif id == 14 then
                value = 14
            end

            if value then

                total_rank =
                    total_rank + value

                counted_cards =
                    counted_cards + 1
            end
        end

        if counted_cards <= 0 then
            return
        end

        local average_rank =
            total_rank / counted_cards

        local best_hand = nil
        local best_level = 1

        for hand, data in pairs(G.GAME.hands) do

            if data.played > 0 then

                local level =
                    data.level or 1

                if level > best_level then

                    best_level = level
                    best_hand = hand
                end
            end
        end

        local payout =
            math.floor(
                average_rank * best_level
            )

        play_sound('coin1')

        ease_dollars(payout)

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()

                attention_text({
                    text = "$" .. payout,
                    scale = 1.2,
                    hold = 1,
                    major = card,
                    backdrop_colour = G.C.MONEY,
                    align = 'cm',
                    offset = {
                        x = 0,
                        y = -2
                    },
                    silent = true
                })

                card:juice_up()

                return true
            end
        }))

        delay(0.6)
    end,
    misprint_original = "c_immolate"
}

BadDirector.MisSpect {
    key = 'ankhprint',
    pos = { x = 0, y = 6 },
    can_use = function(self, card)
        if not G.jokers then
            return false
        end

        if #G.jokers.cards <= 0 then
            return false
        end

        if #G.jokers.cards >= G.jokers.config.card_limit then
            return false
        end

        return true
    end,

    use = function(self, card, area, copier)
        local rarity_order = {
            Common = 1,
            Uncommon = 2,
            Rare = 3,
            Legendary = 4
        }

        local highest_rarity = -1
        local candidates = {}

        for _, joker in ipairs(G.jokers.cards) do
            if joker.config.center.rarity then
                local rarity_key = joker.config.center.rarity

                local rarity_name =
                    rarity_key == 1 and "Common"
                    or rarity_key == 2 and "Uncommon"
                    or rarity_key == 3 and "Rare"
                    or rarity_key == 4 and "Legendary"

                local rarity_value = rarity_order[rarity_name] or 0

                if rarity_value > highest_rarity then
                    highest_rarity = rarity_value
                    candidates = { joker }
                elseif rarity_value == highest_rarity then
                    candidates[#candidates + 1] = joker
                end
            end
        end

        if #candidates <= 0 then
            return
        end

        local chosen =
            pseudorandom_element(candidates, pseudoseed('i miss her'))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local copied_joker = copy_card(chosen)

                copied_joker:add_to_deck()
                G.jokers:emplace(copied_joker)

                copied_joker:start_materialize()
                copied_joker:juice_up()

                play_sound('bd_inapmit')

                card:juice_up(0.3, 0.5)

                return true
            end
        }))

        delay(0.6)
    end,
    misprint_original = "c_ankh"
}

BadDirector.MisSpect {
    key = 'dejaprint',
    pos = { x = 1, y = 6 },
    misprint_original = "c_deja_vu",
    config = { extra = { seal = 'Red', seal_m = 'bd_redprint' }, odds = 6 }, -- refer to the comments in talisprint as this is just the same codde copied from it LOL :sob:
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal_m]
        return { vars = { G.GAME.probabilities.normal, card.ability.odds } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        play_sound('bd_inapmit')
        for i = 1, #G.hand.cards do
            local woah = G.hand.cards[i]
            if pseudorandom('Again!') < G.GAME.probabilities.normal / card.ability.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        if SMODS.pseudorandom_probability(card,"goodboy",1,5,nil,true) then
                            woah:set_seal(card.ability.extra.seal_m, nil, true)
                        else
                            woah:set_seal(card.ability.extra.seal, nil, true)
                        end
                        return true
                    end
                }))
                delay(0.5)
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.6,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1,
                            hold = 1,
                            major = woah,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = 'cm',
                            offset = { x = 0 + ((G.hand.cards[(math.floor(#G.hand.cards / 2))].T.x - woah.T.x) / -50), y = -2 },
                            silent = true,
                        })
                        play_sound('generic1')
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end
    end
}


BadDirector.MisSpect {
    key = 'hexprint',
    pos = { x = 2, y = 6 },
    config = {
        max_highlighted = 1
    },

    can_use = function(self, card)
        if not G.jokers then
            return false
        end

        if #G.jokers.highlighted ~= 1 then
            return false
        end

        local selected = G.jokers.highlighted[1]

        if not selected.edition then
            return false
        end

        local index = nil

        for i, joker in ipairs(G.jokers.cards) do
            if joker == selected then
                index = i
                break
            end
        end

        if not index then
            return false
        end

        local left = G.jokers.cards[index - 1]
        local right = G.jokers.cards[index + 1]

        local valid_left =
            left
            and left.ability.set == 'Joker'
            and not left.edition

        local valid_right =
            right
            and right.ability.set == 'Joker'
            and not right.edition

        return valid_left or valid_right
    end,

    use = function(self, card, area, copier)
        local selected = G.jokers.highlighted[1]

        if not selected or not selected.edition then
            return
        end

        local index = nil

        for i, joker in ipairs(G.jokers.cards) do
            if joker == selected then
                index = i
                break
            end
        end

        if not index then
            return
        end

        local possible_targets = {}

        local left = G.jokers.cards[index - 1]
        local right = G.jokers.cards[index + 1]

        if left
            and left.ability.set == 'Joker'
            and not left.edition then
            possible_targets[#possible_targets + 1] = left
        end

        if right
            and right.ability.set == 'Joker'
            and not right.edition then
            possible_targets[#possible_targets + 1] = right
        end

        if #possible_targets <= 0 then
            return
        end

        local target = pseudorandom_element(
            possible_targets,
            pseudoseed('what did i do wrong to her')
        )

        local edition = copy_table(selected.edition)

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                target:set_edition(edition, true)

                selected:set_edition(nil, true)

                target:juice_up()
                selected:juice_up()

                play_sound('tarot1')

                card:juice_up(0.3, 0.5)

                return true
            end
        }))

        delay(0.6)

        G.jokers:unhighlight_all()
    end,
    misprint_original = "c_hex"
}

BadDirector.MisSpect {
    key = 'tranceprint',
    pos = { x = 3, y = 6 },
    misprint_original = "c_trance",
    config = { extra = { seal = 'Blue', seal_m = 'bd_bluesprint' }, odds = 6 }, -- refer to the comments in talisprint as this is just the same codde copied from it LOL :sob:
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal_m]
        return { vars = { G.GAME.probabilities.normal, card.ability.odds } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        play_sound('bd_inapmit')
        for i = 1, #G.hand.cards do
            local woah = G.hand.cards[i]
            if pseudorandom('WHY ARE YOU blue') < G.GAME.probabilities.normal / card.ability.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        if SMODS.pseudorandom_probability(card,"goodboy",1,5,nil,true) then
                            woah:set_seal(card.ability.extra.seal_m, nil, true)
                        else
                            woah:set_seal(card.ability.extra.seal, nil, true)
                        end
                        return true
                    end
                }))
                delay(0.5)
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.6,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1,
                            hold = 1,
                            major = woah,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = 'cm',
                            offset = { x = 0 + ((G.hand.cards[(math.floor(#G.hand.cards / 2))].T.x - woah.T.x) / -50), y = -2 },
                            silent = true,
                        })
                        play_sound('generic1')
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end
    end
}

BadDirector.MisSpect {
    key = 'mediumprint',
    pos = { x = 4, y = 6 },
    misprint_original = "c_medium",
    config = { extra = { seal = 'Purple', seal_m = 'bd_purpleprint' }, odds = 6 }, -- refer to the comments in talisprint as this is just the same codde copied from it LOL :sob:
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal_m]
        return { vars = { G.GAME.probabilities.normal, card.ability.odds } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        play_sound('bd_inapmit')
        for i = 1, #G.hand.cards do
            local woah = G.hand.cards[i]
            if pseudorandom('sealBehindTheSlaughter.mp5') < G.GAME.probabilities.normal / card.ability.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        if SMODS.pseudorandom_probability(card,"goodboy",1,5,nil,true) then
                            woah:set_seal(card.ability.extra.seal_m, nil, true)
                        else
                            woah:set_seal(card.ability.extra.seal, nil, true)
                        end
                        return true
                    end
                }))
                delay(0.5)
            else
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.6,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1,
                            hold = 1,
                            major = woah,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = 'cm',
                            offset = { x = 0 + ((G.hand.cards[(math.floor(#G.hand.cards / 2))].T.x - woah.T.x) / -50), y = -2 },
                            silent = true,
                        })
                        play_sound('generic1')
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end
    end
}


BadDirector.MisSpect {
    key = 'cryptidprint',
    pos = { x = 5, y = 6 },
    config = {
        max_highlighted = 1,
        extra = {
            odds = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(
            card,
            1,
            card.ability.extra.odds,
            'i cant believe that im not enough'
        )

        return {
            vars = {
                card.ability.max_highlighted,
                num,
                den
            }
        }
    end,

    can_use = function(self, card)
        return G.hand
            and #G.hand.highlighted > 0
            and #G.hand.highlighted <= card.ability.max_highlighted
    end,

    use = function(self, card, area, copier)
        local selected = {}

        for i = 1, #G.hand.highlighted do
            selected[#selected + 1] = G.hand.highlighted[i]
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for _, original in ipairs(selected) do
            local failed = false
            local safety = 0

            while not failed and safety < 50 do
                safety = safety + 1

                if SMODS.pseudorandom_probability(
                        card,
                        'this is your life',
                        1,
                        card.ability.extra.odds,
                        '...'
                    ) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.15,
                        func = function()
                            local copied_card = copy_card(original)

                            copied_card:add_to_deck()
                            G.hand:emplace(copied_card)

                            copied_card:start_materialize()
                            copied_card:juice_up()

                            play_sound('card1')

                            SMODS.calculate_context({
                                playing_card_added = true,
                                cards = { copied_card }
                            })

                            return true
                        end
                    }))
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
                    failed = true
                end
            end
        end

        delay(0.5)

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
    misprint_original = "c_cryptid"
}


BadDirector.MisSpect {
    key = 'soulprint',
    pos = { x = 2, y = 2 },
    soul_pos = {
        x = 3, y = 2,
        draw = function(card, scale_mod, rotate_mod)
            local t = G.TIMERS.REAL
            local frac = t - math.floor(t)

            local jitter = (math.random() - 0.5) * 0.02
            local bitflip = (math.sin(t * 37) > 0.95) and 0.05 or 0

            local _scale_mod =
                0.06
                + 0.04 * math.sin(8.3 * t)
                + 0.02 * math.sin(53 * frac)
                + jitter
                + bitflip

            local _rotate_mod =
                0.25 * math.sin(1.7 * t)
                + 0.05 * math.sin(t * 113)
                + jitter * 2
                + (math.sin(t * 19) > 0.85 and 0.12 or 0)

            card.children.floating_sprite.role.draw_major = card

            card.children.floating_sprite:draw_shader(
                'dissolve',
                0,
                nil,
                nil,
                card.children.center,
                _scale_mod,
                _rotate_mod,
                nil,
                0.15 + 0.05 * math.sin(14.2 * t),
                nil,
                0.7
            )

            card.children.floating_sprite:draw_shader(
                'dissolve',
                nil,
                nil,
                nil,
                card.children.center,
                _scale_mod,
                _rotate_mod
            )
            if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
                card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
            end
        end,
    },
    hidden = true,
    can_use = function(self, card)

        return
            G.jokers
            and #G.jokers.cards > 0
            and G.hand
            and #G.hand.cards > 0
    end,

    use = function(self, card, area, copier)

        play_sound('bd_inapmit')

        local joker_count = #G.jokers.cards

        ease_dollars(-G.GAME.dollars)

        local destroyed_jokers = {}

        for _, joker in ipairs(G.jokers.cards) do
            destroyed_jokers[#destroyed_jokers + 1] =
                joker
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()

                for _, joker in ipairs(destroyed_jokers) do
                    joker:start_dissolve()
                end

                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.8,
            func = function()

                for i = 1, joker_count do

                    local new_joker = SMODS.create_card({
                        set = 'Joker',
                        area = G.jokers,
                        legendary = true,
                        rarity = 4,
                        skip_materialize = nil,
                        soulable = nil,
                        key = nil,
                        key_append = 'cunt',}
                    )

                    new_joker:add_to_deck()

                    G.jokers:emplace(new_joker)

                    new_joker:start_materialize()

                    new_joker:juice_up()
                end

                return true
            end
        }))

        for _, playing_card in ipairs(G.hand.cards) do

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()

                    playing_card:set_edition(
                        {
                            polychrome = true
                        },
                        true
                    )

                    playing_card:juice_up()

                    play_sound('polychrome1')

                    return true
                end
            }))
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1,
            func = function()

                attention_text({
                    text = "$0",
                    scale = 1.3,
                    hold = 1,
                    major = card,
                    backdrop_colour = G.C.MONEY,
                    align = 'cm',
                    offset = { x = 0, y = -2 },
                    silent = true
                })

                card:juice_up()

                return true
            end
        }))

        delay(1.2)
    end,
    misprint_original = "c_soul"
}
