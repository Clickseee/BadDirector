SMODS.Joker {
    key = "divineintervention",
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = "misprintenhanced",
    coder = { "Nxkoo" },
    pos = { x = 1, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "tarot",
        "generation",
        "hands"
    },

    loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS.c_fool
        local _key = self.key
        if not (G.GAME.last_tarot_planet and G.GAME.last_tarot_planet ~= 'c_fool') then
            _key = self.key .. "_alt"
        end
        return {key = _key}
    end,
    
    
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        
        
        if context.after and G.GAME.current_round.hands_played == 0 and not SMODS.last_hand_oneshot then
            local fool
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    
                    fool = SMODS.add_card({
                        set= "Tarot",
                        area = G.consumeables,
                        legendary = nil,
                        rarity = nil,
                        skip_materialize = nil,
                        soulable = nil,
                        key = "c_fool",
                        key_append = "behold"
                        }
                    )
                
                return true
            end
            }))
            
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.8,
                func = function()
                    if fool then
                        if (G.GAME.last_tarot_planet and G.GAME.last_tarot_planet ~= 'c_fool') then
                            fool:use_consumeable()
                        end
                        SMODS.destroy_cards(fool,true,nil)
                    end
                    
                    return true
                end
            }))

            local _message = (G.GAME.last_tarot_planet and G.GAME.last_tarot_planet ~= 'c_fool') and "k_again_ex" or "k_nope_ex"
            
            return {
                message = localize(_message),
                colour = G.C.SECONDARY_SET.Tarot,
                sound = "tarot2"
            }
        end
    end
}
