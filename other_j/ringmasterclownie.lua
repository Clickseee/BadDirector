if not Cryptid then 
    SMODS.Joker {
        key = "ringmasterclownie",
        rarity = 2,
        cost = 5,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        atlas = "misprintenhanced",
        coder = { "Nxkoo" },
        artist = { "Nxkoo" },
        pos = { x = 1, y = 0 },
        pools = {["BadDirector_Jokers"] = true, ["FNAF"] = true, },
        attributes = {
            "economy",
            "passive",
            "generation"
        },
        
        
        config = {
            fazcoins = {
                amount = 0,
                cost = 5,
                
                min = 2,
                max = 4,
                
                coins = {},
                
                spawn_timer = 0,
                spawn_interval = 2,
                
                awake = false,
                
                payment_timer = 33,
                payment_timer_base = 33,
                payment_scale = 0.9,
                
                payments = 0
            }
        },
        
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.fazcoins.amount,
                    card.ability.fazcoins.cost,
                    math.floor(card.ability.fazcoins.payment_timer)
                }
            }
        end,
        
        in_pool = function(self, args)
            return false
        end,
        no_collection = true,
        
        calculate = function(self, card, context)
            
            if context.setting_blind then
                card.ability.fazcoins.coins = {}
                
                local spawn_count = pseudorandom("fazcoin_spawn",
                card.ability.fazcoins.min,
                card.ability.fazcoins.max
            )
            
            for i = 1, spawn_count do
                table.insert(card.ability.fazcoins.coins,{
                    x = pseudorandom("fazcoin_x") * G.ROOM.T.w,
                    y = pseudorandom("fazcoin_y") * G.ROOM.T.h
                })
            end
        end
        
        if context.end_of_round
        and not context.blueprint
        and card.ability.fazcoins.awake then
            
            return {
                message = "Please deposit!"
            }
        end
    end,
    
    update = function(self, card, dt)
        
        if not G.STATE
        or not G.STATES.SELECTING_HAND
        or G.STATE ~= G.STATES.SELECTING_HAND then
            return
        end
        
        local faz = card.ability.fazcoins
        
        if not faz.awake then
            
            faz.spawn_timer = faz.spawn_timer + dt
            
            if faz.spawn_timer >= faz.spawn_interval then
                faz.spawn_timer = 0
                
                table.insert(faz.coins,{
                    x = pseudorandom("fazcoin_x") * G.ROOM.T.w,
                    y = pseudorandom("fazcoin_y") * G.ROOM.T.h
                })
            end
            
            local mx = love.mouse.getX()
            local my = love.mouse.getY()
            
            for i = #faz.coins, 1, -1 do
                local coin = faz.coins[i]
                
                if math.abs(mx - coin.x) < 24
                and math.abs(my - coin.y) < 24 then
                    
                    faz.amount = faz.amount + 1
                    
                    play_sound("coin1", 1, 1)
                    
                    table.remove(faz.coins, i)
                    
                    card:juice_up()
                end
            end
            
            if faz.amount >= faz.cost then
                faz.awake = true
                faz.payment_timer = faz.payment_timer_base
                
                play_sound("tarot1", 1, 1)
                
                card:juice_up(1,1)
            end
            
        else
            
            faz.payment_timer = faz.payment_timer - dt
            
            if math.floor(faz.payment_timer * 4) % 4 == 0 then
                card:juice_up(0.15,0.15)
            end
            
            if faz.amount >= faz.cost then
                
                faz.amount = faz.amount - faz.cost
                
                faz.payments = faz.payments + 1
                
                faz.awake = false
                
                faz.payment_timer_base =
                faz.payment_timer_base
                * faz.payment_scale
                
                G.E_MANAGER:add_event(Event({
                    func = function()
                        
                        ease_dollars(5)
                        
                        return true
                    end
                }))
                
                return
            end
            
            if faz.payment_timer <= 0 then
                
                card:start_dissolve()
                
                play_sound("tarot1",1,1)
                
                for i = 1, 10 do
                    table.insert(faz.coins,{
                        x = pseudorandom("death_x") * G.ROOM.T.w,
                        y = pseudorandom("death_y") * G.ROOM.T.h
                    })
                end
            end
        end
    end
}

-- draw hook for rendering the coins.

local card_draw_ref = Card.draw

function Card:draw(...)
    card_draw_ref(self, ...)
    
    if not self.config
    or not self.config.center
    or self.config.center.key ~= "j_bd_ringmasterclownie" then
        return
    end
    
    local faz = self.ability.fazcoins
    
    if not faz then
        return
    end
    
    for _, coin in ipairs(faz.coins) do
        
        love.graphics.draw(
        G.ASSET_ATLAS["bd_jcoins"].image,
        coin.x,
        coin.y,
        0,
        0.5,
        0.5
    )
end
end

end