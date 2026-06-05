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
                local flag = false
                for _, enh in ipairs(BadDirector.misprint_enhancements) do
                    if SMODS.has_enhancement(playing_card, enh.key) then 
                        misprint_tally = misprint_tally + 1 
                    end
                end
                if not flag and playing_card.edition and playing_card.edition.key == "e_bd_misprinted" then 
                    misprint_tally = misprint_tally + 1 
                end
            end
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.chips * misprint_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local misprint_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                local flag = false
                for _, enh in ipairs(BadDirector.misprint_enhancements) do
                    if SMODS.has_enhancement(playing_card, enh.key) then 
                        misprint_tally = misprint_tally + 1 
                    end
                end
                if not flag and playing_card.edition and playing_card.edition.key == "e_bd_misprinted" then 
                    misprint_tally = misprint_tally + 1 
                end
            end
            return { chips = card.ability.extra.chips * misprint_tally }
        end
        
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_stone'` (but less broken and more flexible lol)
        for _, playing_card in ipairs(G.playing_cards) do
            local flag = false
            for _, enh in ipairs(BadDirector.misprint_enhancements) do
                if SMODS.has_enhancement(playing_card, enh.key) then 
                    return true
                end
            end
            if not flag and playing_card.edition and playing_card.edition.key == "e_bd_misprinted" then 
                return true
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

SMODS.Joker {
	atlas = 'feliPlushtrap',
	pos = { x = 0, y = 0 },
	pools = {["BadDirector_Jokers"] = true, ["FNAF"] = true, },
	key = "bd_plushtrap",
    coder = {"LasagnaFelidae"},
    partner = {"Chair"},
	rarity = 2,
	cost = 6,
	config = {
		extra = {

        },
        plush = { 
            state = 0,  --  0 = seated, 
                        --  1 = highlighted, 
                        --  2 = gone
            movementOpportunity = 4, -- 4 is the first value on purchase, but this is set to a random value between opportunityMin and opportunityMax when the card is highlighted and after each movement opportunity passes
            opportunityMin = 2.8, -- this is min seconds before a movement opportunity
            opportunityMax = 4, -- this is max seconds before a movement opportunity
            saved_time = 0, -- do not change as this is set by G.TIMERS.REAL
            enabled = false, -- do not change as this starts the timer on card add
            movementChance_num = 1, -- this is the numerator for the movement chance fraction
            movementChance_den = 5, -- this is the denominator for the movement chance fraction
        },
        
	},	
	loc_vars = function(self, info_queue, card)
		return { 
            vars = {

            } 
        }
	end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.plush.enabled = true
        card.ability.plush.saved_time = G.TIMERS.REAL
    end,

    in_pool = function(self,args)
        return false -- remember to set to true or inpool func you want, this is so ppl who update bd dont just loot this
    end,

    update = function(self, card, dt)
        --[[
        A l'intention de Pup <3

        Movement opportunities work this way:
        - When the card is added to the deck, the plushtrap ability is enabled and the timer starts counting.
            - The first ever movement opportunity occurs once the timer reaches the initial movementOpportunity value (4 seconds).
            - If the card is highlighted and Plushtrap is not already "gone", it will reroll the max time between 2.8 and 4
            - This works because G.TIMERS.REAL despite the name is not a Real number but a fucking float.
        - Once the timer strikes, it will roll a random number between chance num and den. 
            - If it succeds, Plushtrap is "gone" 
            - Otherwise, the timer resets (and rerolls a max time) and Plushtrap waits for the next movement opportunity.
        
        Reminder for the Plushtrap states
        --  0 = seated, (initial)
        --  1 = highlighted,
        --  2 = gone
            
        All of this is in a separate table from extra so that the misprint doesnt fuck with the values.
            
        -- If you read this, 
        I could make it more FNAF-accurate and give different states 
        before he's completely gone, but that would require you to 
        draw 3 more cards.

        There is nothing in calculate yet 
        except a local var to directly check plush state
        remember that if you want to change the state for whatever reason:
        - DO NOT set "state = 2"
        - SET "card.ability.plush.state = 2" instead

        There is a joker_main context check but I can't be assed to figure out what your joker should do and when.


        Je t'aime comme un fou,
        Forever Yours,

        Feli
          __  __
        /***V***\
        \      /
         \   /
          \/

        ]]
        if card and card.ability and card.ability.plush and card.ability.plush.enabled then
            local state = card.ability.plush.state
            if state ~= 2 then
                card.ability.plush.state = 0
                card.children.center:set_sprite_pos({x = 0, y = 0})
                if G.jokers and G.jokers.highlighted then
                    for _, joker in ipairs(G.jokers.highlighted) do
                        if joker == card and state ~= 2 then
                            card.ability.plush.saved_time, card.ability.plush.movementOpportunity = G.TIMERS.REAL, pseudorandom("movementOpportunity",card.ability.plush.opportunityMin,card.ability.plush.opportunityMax)
                            print ("PlushTrap: Highlighted, setting movementOpportunity to " .. card.ability.plush.movementOpportunity)
                            
                            card.ability.plush.state = 1
                            card.children.center:set_sprite_pos({x = 1, y = 0})
                        end   
                    end
                end
                if G.TIMERS.REAL - card.ability.plush.saved_time > card.ability.plush.movementOpportunity then
                if pseudorandom("movementOpportunity",card.ability.plush.movementChance_num, card.ability.plush.movementChance_den) <= card.ability.plush.movementChance_num then
                    card.ability.plush.state = 2
                    card.children.center:set_sprite_pos({x = 2, y = 0})
                else
                    card.ability.plush.saved_time, card.ability.plush.movementOpportunity = G.TIMERS.REAL, pseudorandom("movementOpportunity",card.ability.plush.opportunityMin,card.ability.plush.opportunityMax)
                end
            end
                
            end
        end
        
    end,

	calculate = function(self, card, context)
        local state = card.ability.plush.state

        if context.joker_main then

        end
	end,
	blueprint_compat = true,
}