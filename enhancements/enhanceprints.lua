SMODS.Enhancement {
    key = "misprintstone",
    atlas = "misprintenhanced",
    pos = { x = 5, y = 0 },
    config = { bonus = 40, extra = { original_bonus = 40, max = 20, min = -10 } }, -- can also be adjusted as need be ofc
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true, -- as im guessing this is still adjacent to stones this way
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.original_bonus } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            card.ability.bonus = card.ability.bonus + pseudorandom('tmtrainuh', card.ability.extra.min, card.ability.extra.max)
            if card.ability.bonus < card.ability.extra.original_bonus then card.ability.bonus = card.ability.extra.original_bonus end
            return {
                message = localize('k_upgrade_q'),
                colour = G.C.CHIPS,
                message_card = card,
            }
        end
    end
}

SMODS.Enhancement {
    key = "misprintgold",
    atlas = "misprintenhanced",
    pos = { x = 6, y = 0 },
    config = {},
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Enhancement {
    key = "misprintbonus",
    atlas = "misprintenhanced",
    pos = { x = 1, y = 1 },
    config = { extra = { max = 53, min = 0 } },
    loc_vars = function(self, info_queue, card)
        local r_mults = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_mults[#r_mults + 1] = tostring(i)
        end
        local loc_mult = ' ' .. ("Chips") .. ' '
        main_start = {
            { n = G.UIT.T, config = { text = '+', colour = G.C.CHIPS, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.BLUE }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.BLUE },
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        return { main_start = main_start }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = pseudorandom('tmtrainuh', card.ability.extra.min, card.ability.extra.max)
            }
        end
    end
}


SMODS.Enhancement {
    key = "misprintmult",
    atlas = "misprintenhanced",
    pos = { x = 2, y = 1 },
    config = { extra = { max = 23, min = 0 } },
    loc_vars = function(self, info_queue, card)
        local r_mults = {}
        for i = card.ability.extra.min, card.ability.extra.max do
            r_mults[#r_mults + 1] = tostring(i)
        end
        local loc_mult = ' ' .. (localize('k_mult')) .. ' '
        main_start = {
            { n = G.UIT.T, config = { text = '+', colour = G.C.MULT, scale = 0.32 } },
            { n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.RED }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
            {
                n = G.UIT.O,
                config = {
                    object = DynaText({
                        string = {
                            { string = 'rand()', colour = G.C.JOKER_GREY }, { string = "#@" .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.id or 11) .. (G.deck and G.deck.cards[1] and G.deck.cards[#G.deck.cards].base.suit:sub(1, 1) or 'D'), colour = G.C.RED },
                            loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult, loc_mult,
                            loc_mult, loc_mult, loc_mult, loc_mult },
                        colours = { G.C.UI.TEXT_DARK },
                        pop_in_rate = 9999999,
                        silent = true,
                        random_element = true,
                        pop_delay = 0.2011,
                        scale = 0.32,
                        min_cycle_time = 0
                    })
                }
            },
        }
        return { main_start = main_start }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = pseudorandom('tmtrainuh', card.ability.extra.min, card.ability.extra.max)
            }
        end
    end
}

SMODS.Enhancement {
    key = "misprintwild",
    atlas = "misprintenhanced",
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            wildrep = 1, -- repetitions total
            wildstep = 1 --  increase in repetitions
        }
    },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.suitwash or {}).suit or 'Spades'
        return { vars = { card.ability.extra.xmult, localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            local suit = G.GAME.current_round.suitwash.suit
            card.ability.extra.wildrep = 0
            for i=1, #context.scoring_hand do 
                if context.scoring_hand[i]:is_suit(suit) then
                    card.ability.extra.wildrep = card.ability.extra.wildrep + card.ability.extra.wildstep
                end
            end
            print(card.ability.extra.wildrep)
        end
        if context.repetition and context.cardarea == G.play then
            return { repetitions = card.ability.extra.wildrep }
        end
    end
}

local function reset_suitwash()
    G.GAME.current_round.suitwash = G.GAME.current_round.suitwash or { suit = 'Spades' }
    local suits = {}
    for _, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if v ~= G.GAME.current_round.suitwash.suit then
            suits[#suits + 1] = v
        end
    end
    G.GAME.current_round.suitwash.suit =
        pseudorandom_element(suits, 'suitwash' .. G.GAME.round_resets.ante)
end


SMODS.Enhancement {
    key = "misprintluckycard",
    atlas = "misprintenhanced",
    pos = { x = 4, y = 1 },
    config = {
        extra = {
            mult = 4,
            mult_odds = 4,
            dollars_odds = 6
        }
    },
    loc_vars = function(self, info_queue, card)
        local mult_num, mult_den = SMODS.get_probability_vars(
            card, 1, card.ability.extra.mult_odds, 'ohmygod'
        )
        local money_num, money_den = SMODS.get_probability_vars(
            card, 1, card.ability.extra.dollars_odds, 'imhumpingmyCOUCH' -- WHAT are we doing
        )
        return {
            vars = {
                mult_num,
                money_num,
                card.ability.extra.mult,
                mult_den,
                nil,
                money_den
            }
        }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play and context.scoring_hand then
            local ret = {}

            if SMODS.pseudorandom_probability(card, 'ouuughhhh', 1, card.ability.extra.mult_odds) then
                card.lucky_trigger = true
                for _, c in ipairs(context.scoring_hand) do
                    if c ~= card then
                        c.ability.perma_mult = (c.ability.perma_mult or 0) + card.ability.extra.mult
                        c:juice_up()
                    end
                end
            end

            if SMODS.pseudorandom_probability(card, 'ahhhfuck', 1, card.ability.extra.dollars_odds) then
                card.lucky_trigger = true
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + G.GAME.dollars
                ret.dollars = G.GAME.dollars
            end

            if next(ret) then
                return ret
            end
        end
    end
}

SMODS.Enhancement {
    key = "misprintglass",
    atlas = "misprintenhanced",
    pos = { x = 5, y = 1 },
    config = { Xmult = 2.5, extra = { odds = 4, location = 1 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'the fitnessgram pacer test is a')
        return { vars = { card.ability.Xmult, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play then
            local to_destroy = {}
            local proper_flag = false
            for i = 1, #G.play.cards do
                if G.play.cards[i] == card then
                    card.ability.extra.location = i
                    proper_flag = true
                end
            end
            if proper_flag then
                if G.play.cards[card.ability.extra.location - 1] then
                    table.insert(to_destroy, G.play.cards[card.ability.extra.location - 1])
                end
                table.insert(to_destroy, G.play.cards[card.ability.extra.location])
                if G.play.cards[card.ability.extra.location + 1] then
                    table.insert(to_destroy, G.play.cards[card.ability.extra.location + 1])
                end
                for i = 1, #to_destroy do
                    if SMODS.pseudorandom_probability(card, 'multistage aerobic capacity test', 1, card.ability.extra.odds) then
                        G.E_MANAGER:add_event(Event {
                            func = function()
                                if SMODS.has_enhancement(to_destroy[i], 'm_glass') then -- should it have its own shatter now that i think of it lol
                                    to_destroy[i]:shatter()
                                else
                                    to_destroy[i]:start_dissolve()
                                end
                                return true
                            end
                        })
                    end
                end
            end
        end
    end
}

SMODS.Enhancement {
    key = "misprintsteel",
    atlas = "misprintenhanced",
    pos = { x = 6, y = 1 },
    config = {
        extra = {
            base = 1.5,
            gain = 1.5
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.base,
                card.ability.extra.gain
            }
        }
    end,

    calculate = function(self, card, context)
        if context.main_scoring
            and context.cardarea == G.hand then
            for _, pcard in ipairs(context.full_hand) do
                message = "?niagA"
                SMODS.calculate_effect({ xchips = 1.5 }, pcard)
            end
        end
    end
}

function SMODS.current_mod.reset_game_globals(run_start)
    reset_suitwash()
end
