SMODS.Joker {
    key = "powerbreaker",
    rarity = 2,
    atlas = "breaker",
    coder = { "Nxkoo" },
    artist = {"Le Ginger"},
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "spectral",
        "generation"
    },
    
    config = {
        extra = {
            awareness = 0
        }
    },
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS["j_bd_powerfuse"]
        return {
            vars = {
                card.ability.extra.awareness
            }
        }
    end,
    
    in_pool = function(self, args)
        
        if not G.jokers then
            return false
        end
        
        for _, joker in ipairs(G.jokers.cards) do
            if joker.config.center.key == "j_bd_powerfuse" then
                return true
            end
        end
        
        return false
    end,
    
    needs_use_button = function(self,card)
        return next(SMODS.find_card("j_bd_powerfuse"))
    end,
    can_use = function(self, card)
        return BadDirector.power_fuse_active and next(SMODS.find_card("j_bd_powerfuse")) and #G.jokers.highlighted == 2 and (G.jokers.highlighted[1].config.center.key == "j_bd_powerfuse" or G.jokers.highlighted[2].config.center.key == "j_bd_powerfuse")
    end,
    
    use = function(self, card)
        
        for _, joker in ipairs(G.jokers.highlighted) do
            
            if joker.config.center.key == "j_bd_powerfuse" then
                card.ability.extra.awareness =
                card.ability.extra.awareness +
                (joker.ability.extra.awareness or 0)
                
                BadDirector.power_fuse_active = false
                joker.ability.power.is_active = false
                
                G.jokers:remove_from_highlighted(card)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        
                        joker:start_dissolve()
                        
                        return true
                    end
                }))
                
                card_eval_status_text(
                card,
                'extra',
                nil,
                nil,
                nil,
                {
                    message = "ON",
                    colour = G.C.GREEN
                }
            )
            break
            
        end
    end
    
    
    
end,

calculate = function(self, card, context)
    
    if context.setting_blind
    and card.ability.extra.awareness > 0 then
        
        card.ability.extra.awareness =
        card.ability.extra.awareness - 1
        
        G.E_MANAGER:add_event(Event({
            func = function()
                
                local spectral =
                create_card(
                'Spectral',
                G.consumeables,
                nil,
                nil,
                nil,
                nil,
                nil,
                'power_breaker'
            )
            
            spectral:add_to_deck()
            
            G.consumeables:emplace(spectral)
            
            return true
        end
    }))
    
    return {
        message = "+1 Spectral",
        colour = G.C.SECONDARY_SET.Spectral
    }
end
end
}
