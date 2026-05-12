SMODS.Consumable:take_ownership(
    "c_sun",
    {
        use = function(self, card, area, copier)

            local used_tarot = copier or card
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()

                    for i = 1, #G.hand.highlighted do
                        local _card = G.hand.highlighted[i]

                        if next(SMODS.find_card("j_bd_fakepromises")) then
                            _card:set_ability(G.P_CENTERS.m_wild, nil, true)
                        else
                            _card:change_suit("Hearts")
                        end

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:juice_up()
                                return true
                            end
                        }))
                    end

                    return true
                end
            }))
        end
    },
    true
)

SMODS.Joker {
    key = "fakepromises",
    rarity = 2,
    atlas = "<3",
    pos = { x = 0, y = 0 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_sun
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
        return { }
    end,
    calculate = function(self, card, context)
    end
}
