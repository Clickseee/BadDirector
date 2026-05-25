SMODS.Joker {
    key = "marcel",
    rarity = 2,
    atlas = "rattlingsnow",
    artist = {"RattlingSnow"},
    coder = {"LasagnaFelidae"},
    pos = { x = 5, y = 0 },
    cost = 5,
    config = { extra = { chips = 25 } },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"chips", "enhancements",},
    loc_vars = function(self, info_queue, card)
        local misprint_tally = 0
        info_queue[#info_queue+1] = {key = 'bd_enhanced_info', set = 'Other'}
        info_queue[#info_queue+1] = G.P_CENTERS.e_bd_misprinted
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                for _, enh in ipairs(BadDirector.misprint_enhancements) do
                    if SMODS.has_enhancement(playing_card, enh.key) then misprint_tally = misprint_tally + 1 
                    elseif playing_card.edition.key == "e_bd_misprinted" then misprint_tally = misprint_tally + 1 end
                end
            end
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.chips * misprint_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local misprint_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                for _, enh in ipairs(BadDirector.misprint_enhancements) do
                    if SMODS.has_enhancement(playing_card, enh.key) then misprint_tally = misprint_tally + 1 
                    elseif playing_card.edition.key == "e_bd_misprinted" then misprint_tally = misprint_tally + 1 end
                end
            end
            return { vars = { card.ability.extra.chips, card.ability.extra.chips * misprint_tally } }
        end
        
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_stone'` (but less broken and more flexible lol)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            for _, enh in ipairs(BadDirector.misprint_enhancements) do
                    if SMODS.has_enhancement(playing_card, enh.key) then return true 
                    elseif playing_card.edition.key == "e_bd_misprinted" then return true end
                end
        end
        return false
    end
}

SMODS.Joker {
    key = "bienvenues_batard_montrachet",
    rarity = 2,
    atlas = "rattlingsnow",
    artist = {"RattlingSnow"},
    coder = {"LasagnaFelidae"},
    pos = { x = 3, y = 0 },
    cost = 5,
    config = { extra = {xblindsize=0.4, mod=0.1}},
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pools = {
        ["BadDirector_Jokers"] = true,
        ["Food"] = true,
    },
    attributes = {"xblindsize"},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xblindsize, card.ability.extra.mod,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                xblindsize = card.ability.extra.xblindsize
            }    
        end
        if context.end_of_round and context.main_eval and not context.game_over and not context.blueprint then
            if (card.ability.extra.xblindsize + card.ability.extra.mod) >= 1 then
				SMODS.destroy_cards(card, nil, nil, true)
				return {
                    message = "Empty!",
                    colour = G.C.FILTER,
                }     
			else
				card.ability.extra.xblindsize = card.ability.extra.xblindsize + card.ability.extra.mod
                return {
                    message = "+0.2 xBlind",
                    colour = G.C.DYN_UI.DARK,
                }
			end
            
        end
    end,
}

SMODS.Joker {
    key = "mpreg",
    rarity = 3,
    atlas = "pregnantchad",
    artist = {"LasagnaFelidae"},
    coder = {"LasagnaFelidae"},
    pos = { x = 0, y = 0 },
    config = {
        extra = { repetitions = 2 }, states = { retriggered = false },},
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"retrigger", "joker"},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not card.ability.states.retriggered == true then
            card.ability.states.retriggered = true
            return { repetitions = card.ability.extra.repetitions }
        end
        if context.after then
            card.ability.states.retriggered = false
        end
    end,
}

SMODS.Joker {
    key = "p03",
    rarity = 3,
    atlas = "rattlingsnow",
    artist = {"RattlingSnow"},
    coder = {"LasagnaFelidae"},
    pos = { x = 1, y = 0 },
    cost = 6,
    config = { extra = {xchips=0.2}},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
        ["Inscryption"] = true,
        ["Technology"] = true,
        ["Object"] = true,
        ["Vermin"] = true,
    },
    attributes = {"xchips"},
    loc_vars = function(self, info_queue, card)
        local cb = BadDirector.count_browsers()
        return {
            vars = {
                card.ability.extra.xchips, cb*card.ability.extra.xchips, cb,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local cb = BadDirector.count_browsers()
            local quips = 
            {
                {key= "Get up? No. We've got Transcending to do.", weight = "1"},
                {key= "That's the ticket.", weight = "1"},
                {key= "You done gawking? We can start? Good.", weight = "1"},
                {key= "I almost enjoyed your company, challenger.", weight = "1"},
                {key= "Almost there.", weight = "1"},
                {key= "You made it. Nice. Great job.", weight = "1"},
            }
            return {
                xchips = 1 + (cb * card.ability.extra.xchips),
                message = BadDirector.quick_pool_pick(quips,pseudorandom("p03xleshy")),
				colour = G.C.SECONDARY_SET.Planet,
            
            }
        end
    end,
}

SMODS.Joker {
    key = "alberto",
    rarity = 3,
    atlas = "rattlingsnow",
    artist = {"RattlingSnow"},
    coder = {"LasagnaFelidae"},
    pos = { x = 0, y = 0 },
    cost = 6,
    config = { extra = {xmult=1.5}, imm = {rank=2}},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"xmult", "rank"},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult, card.ability.imm.rank.key,
            }
        }
    end,
    set_ability = function(self, card, initial, info_queue)
        card.ability.imm.rank = pseudorandom_element(SMODS.Ranks, pseudoseed('j_bd_alberto'))
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            if context.other_card:get_id() == card.ability.imm.rank.nominal then
                return {
                    xmult = card.ability.extra.xmult
                }
            end     
        end
        if context.end_of_round and context.main_eval and not context.game_over then
            card.ability.imm.rank = pseudorandom_element(SMODS.Ranks, pseudoseed('j_bd_alberto'))
            return {
                    message = "Changed!",
                    colour = G.C.FILTER,
                }
        end
    end,
}