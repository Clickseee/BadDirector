function BadDirector.replacecards(area, replace, bypass_eternal, keep, keeporiginal, _flip)                   --Cards not keeping editions/seals/stickers is intended. //Probably extremely inefficient /// Like why tf did i make the keep n entire seperate section. I probably wont even use "replace" or teh destruction part of this like ever.
    if G.shop_booster and area == G.shop_booster.cards or G.shop_vouchers and area == G.shop_vouchers.cards then --Setting the area as these 2 disables the entire thing below and will not have a support for them anytime soon cause NONE of the jokers does anything with destroyed booster PACKS and VOUCHERS. Including mods --???
        if area == G.shop_booster.cards then                                                                  -- shoutout to Revo btw
            for i = 1, #area do
                local tab = {}
                local _pool = get_current_pool("Booster")
                for i, v in pairs(_pool) do if v ~= "UNAVAILABLE" then tab[#tab+1] = v end end
                if area[i] ~= keeporiginal and area[i].ability.set == "Booster" then
                    local tab2 = pseudorandom_element(tab)
                    if _flip then
                        area[i]:flip()
                        G.E_MANAGER:add_event(Event({
                            trigger = "before",
                            delay = 1,
                            func = function()
                                area[i]:set_ability(tab2)
                                return true
                            end,
                        }))
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 1,
                            func = function()
                                area[i]:juice_up()
                                area[i]:flip()
                                return true
                            end,
                        }))
                    else
                        area[i]:juice_up()
                        area[i]:set_ability(pseudorandom_element(tab))
                    end
                end
                tab = {}
            end
        end
        if area == G.shop_vouchers.cards then
            for i = 1, #area do
                local tab = {}
                local _pool = get_current_pool("Voucher")
                for i, v in pairs(_pool) do if v ~= "UNAVAILABLE" then tab[#tab+1] = v end end
                if area[i] ~= keeporiginal and area[i].ability.set == "Voucher" then
                    local tab2 = pseudorandom_element(tab)
                    if _flip then
                        area[i]:flip()
                        G.E_MANAGER:add_event(Event({
                            trigger = "before",
                            delay = 1,
                            func = function()
                                area[i]:set_ability(tab2)
                                return true
                            end,
                        }))
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 1,
                            func = function()
                                area[i]:juice_up()
                                area[i]:flip()
                                return true
                            end,
                        }))
                    else
                        area[i]:juice_up()
                        area[i]:set_ability(pseudorandom_element(tab))
                    end
                end
                tab = {}
            end
        end
    else
        if keep then
            for i = 1, #area do
                if area[i].config.center.rarity then
                    local b
                    local rarity
                    if not replace then
                        for k, v in pairs(G.P_JOKER_RARITY_POOLS) do
                            if area[i].config.center.rarity == k then
                                rarity = k
                                b = k
                            end
                        end
                        if rarity == 1 then
                            rarity = "Common"
                        elseif rarity == 2 then
                            rarity = "Uncommon"
                        elseif rarity == 3 then
                            rarity = "Rare"
                        elseif rarity == 4 then
                            rarity = "Legendary"
                        end
                        local set = area[i].ability.set
                        local tab = {}
                        local _pool = get_current_pool("Joker", rarity, rarity == "Legendary")
                        for i, v in pairs(_pool) do if v ~= "UNAVAILABLE" then tab[#tab+1] = v end end

                        if area[i] ~= keeporiginal then
                            local tab2 = pseudorandom_element(tab)
                            if _flip then
                                area[i]:flip()
                                G.E_MANAGER:add_event(Event({
                                    trigger = "before",
                                    delay = 1,
                                    func = function()
                                        area[i]:set_ability(tab2)
                                        return true
                                    end,
                                }))
                                G.E_MANAGER:add_event(Event({
                                    trigger = "after",
                                    delay = 1,
                                    func = function()
                                        area[i]:juice_up()
                                        area[i]:flip()
                                        return true
                                    end,
                                }))
                            else
                                area[i]:juice_up()
                                area[i]:set_ability(pseudorandom_element(tab))
                                tab = {}
                            end
                        end
                    else
                        local set = area[i].ability.set
                        local rarity = SMODS.poll_rarity(set)
                        local b = rarity
                        if rarity == 1 then
                            rarity = "Common"
                        elseif rarity == 2 then
                            rarity = "Uncommon"
                        elseif rarity == 3 then
                            rarity = "Rare"
                        elseif rarity == 4 then
                            rarity = "Legendary"
                        end
                        local tab = {}
                        local _pool = get_current_pool("Joker", rarity, rarity == "Legendary")
                        for i, v in pairs(_pool) do if v ~= "UNAVAILABLE" then tab[#tab+1] = v end end

                        if area[i] ~= keeporiginal then
                            local tab2 = pseudorandom_element(tab)
                            if _flip then
                                area[i]:flip()
                                G.E_MANAGER:add_event(Event({
                                    trigger = "before",
                                    delay = 1,
                                    func = function()
                                        area[i]:set_ability(tab2)
                                        return true
                                    end,
                                }))
                                G.E_MANAGER:add_event(Event({
                                    trigger = "after",
                                    delay = 1,
                                    func = function()
                                        area[i]:juice_up()
                                        area[i]:flip()
                                        return true
                                    end,
                                }))
                            else
                                area[i]:juice_up()
                                area[i]:set_ability(pseudorandom_element(tab))
                            end
                        end
                        tab = {}
                    end
                elseif area[i].ability.set then
                    local set = area[i].ability.set
                    local tab = {}


                    local _pool = get_current_pool("Consumeables")
                    for i, v in pairs(_pool) do if v ~= "UNAVAILABLE" then tab[#tab+1] = v end end


                    if area[i] ~= keeporiginal then
                        local tab2 = pseudorandom_element(tab)
                        if _flip then
                            area[i]:flip()
                            G.E_MANAGER:add_event(Event({
                                trigger = "before",
                                delay = 1,
                                func = function()
                                    area[i]:set_ability(tab2)
                                    return true
                                end,
                            }))
                            G.E_MANAGER:add_event(Event({
                                trigger = "after",
                                delay = 1,
                                func = function()
                                    area[i]:juice_up()
                                    area[i]:flip()
                                    return true
                                end,
                            }))
                        else
                            area[i]:juice_up()
                            area[i]:set_ability(pseudorandom_element(tab))
                        end
                    end
                end
            end
        else
            if replace then --Doesnt stick to joker rarities
                for i = 1, #area do
                    if bypass_eternal then
                        if area[i].ability.set and area[i] ~= keeporiginal then
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i], true)
                            SMODS.add_card({
                                set = set,
                                area = G.pack_cards,
                            })
                        end
                    else
                        if area[i].ability.set and not area[i].ability.eternal and area[i] ~= keeporiginal then
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i])
                            SMODS.add_card({
                                set = set,
                                area = G.pack_cards,
                            })
                        end
                    end
                end
            else
                for i = 1, #area do
                    if bypass_eternal then
                        if area[i].config.center.rarity and area[i] ~= keeporiginal then --Reroll them while keeping the same rarity
                            local rarity
                            if area[i].config.center.rarity == 1 then
                                rarity = "Common"
                            elseif area[i].config.center.rarity == 2 then
                                rarity = "Uncommon"
                            elseif area[i].config.center.rarity == 3 then
                                rarity = "Rare"
                            elseif area[i].config.center.rarity == 4 then
                                rarity = "Legendary"
                            else
                                rarity = area[i].config.center.rarity
                            end
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i], true)
                            SMODS.add_card({
                                set = set,
                                rarity = rarity,
                                area = G.pack_cards,
                            })
                        elseif area[i].ability.set and area[i] ~= keeporiginal then
                            
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i], true)
                            SMODS.add_card({
                                set = set,
                                area = G.pack_cards,
                            })
                        end
                    else
                        if area[i].config.center.rarity and not area[i].ability.eternal and area[i] ~= keeporiginal then
                            local rarity
                            if area[i].config.center.rarity == 1 then
                                rarity = "Common"
                            elseif area[i].config.center.rarity == 2 then
                                rarity = "Uncommon"
                            elseif area[i].config.center.rarity == 3 then
                                rarity = "Rare"
                            elseif area[i].config.center.rarity == 4 then
                                rarity = "Legendary"
                            else
                                rarity = area[i].config.center.rarity
                            end
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i])
                            SMODS.add_card({
                                set = set,
                                rarity = rarity,
                                area = G.pack_cards,
                            })
                        elseif area[i].ability.set and not area[i].ability.eternal and area[i] ~= keeporiginal then
                            local set = area[i].ability.set
                            SMODS.destroy_cards(area[i])
                            SMODS.add_card({
                                set = set,
                                area = G.pack_cards,
                            })
                        end
                    end
                end
            end
        end
    end
end

function BadDirector.replace_playing_cards(area, _flip) -- FUCK
    for i = 1, #area do
        if area[i]:get_id() then
            if _flip then
                area[i]:flip()
                G.E_MANAGER:add_event(Event({
                    trigger = "before",
                    delay = 1,
                    func = function()
                        local _suit, _rank =
                            pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
                        SMODS.change_base(area[i], _suit, _rank)
                        local ed, enh = poll_edition(), SMODS.poll_enhancement()
                        if ed then
                            area[i]:set_edition(ed)
                        end
                        if enh then
                            area[i]:set_ability(enh)
                        end
                        return true
                    end,
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 1,
                    func = function()
                        area[i]:juice_up()
                        area[i]:flip()
                        return true
                    end,
                }))
            else
                area[i]:juice_up()
                local _suit, _rank = pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
                SMODS.change_base(area[i], _suit, _rank)
                local ed, enh = poll_edition(), SMODS.poll_enhancement()
                if ed then
                    area[i]:set_edition(ed)
                end
                if enh then
                    area[i]:set_ability(enh)
                end
            end
        end
    end
end
