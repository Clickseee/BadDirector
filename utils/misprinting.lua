--is this necessaryoid or just utilslop
function BadDirector.build_misprint_table()
    BadDirector.Misprints = {}
    for i, v in pairs(G.P_CENTERS) do
        if v.misprint_original then
            BadDirector.Misprints[v.misprint_original] = v.key
        end
    end
end

function BadDirector.misprint(card)
    if card.ability.consumeable and BadDirector.Misprints[card.config.center.key] then
        G.E_MANAGER:add_event(Event{
            trigger = "after",
            delay = 0.25,
            func = function()
                play_sound("bd_inapmit")
                card:flip()
                return true
            end
        })
        G.E_MANAGER:add_event(Event{
            delay = 1.25,
            trigger = "after",
            func = function()
                card:set_ability(BadDirector.Misprints[card.config.center.key])
                return true
            end
        })
        G.E_MANAGER:add_event(Event{
            delay = 0.65,
            trigger = "after",
            func = function()
                card:flip()
                return true
            end
        })
        delay(0.75)
    else    
        --card:set_edition("e_bd_misprint")
    end
end

local loadmodsref = SMODS.injectItems
function SMODS.injectItems(...)
    local ret = loadmodsref(...)
    BadDirector.build_misprint_table()
    return ret
end