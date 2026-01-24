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

SMODS.Sound {
    key = "inapmit_fast",
    path = "inapmit_fast.ogg",
    volume = 1.5
}

function BadDirector.misprint_hand(hand, card, seed)
    seed = seed or hand..card.config.center.key
    update_hand_text({delay = 0}, {handname = localize(hand, "poker_hands"), level = G.GAME.hands[hand].level, 
    mult = G.GAME.hands[hand].mult, chips = G.GAME.hands[hand].chips, hand})
    delay(1)
    if SMODS.pseudorandom_probability(card, seed, 1, 4) then
        local range = math.floor((pseudorandom(seed)*1.3 + 0.7) * 100) / 100
        local range2 = math.floor((pseudorandom(seed)*1.3 + 0.7) * 100) / 100
        G.GAME.hands[hand].mult = G.GAME.hands[hand].mult * range
        G.GAME.hands[hand].chips = G.GAME.hands[hand].chips * range2
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = "X"..range, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {handname = localize(hand, "poker_hands"), level = G.GAME.hands[hand].level, 
            mult = G.GAME.hands[hand].mult, chips = G.GAME.hands[hand].chips, hand})
        update_hand_text({delay = 0}, {chips = "X"..range2, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({delay = 0}, {handname = localize(hand, "poker_hands"), level = G.GAME.hands[hand].level, 
            mult = G.GAME.hands[hand].mult, chips = G.GAME.hands[hand].chips, hand})
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
        delay(1.3)
    elseif SMODS.pseudorandom_probability(card, seed, 1, 2) then
        local range = math.floor((pseudorandom(seed)*49 + 1) * 100) / 100
        local range2 = math.floor((pseudorandom(seed)*49 + 1) * 100) / 100
        G.GAME.hands[hand].mult = G.GAME.hands[hand].mult + range
        G.GAME.hands[hand].chips = G.GAME.hands[hand].chips + range2
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
        delay(1.3)
    else    
        G.GAME.hands[hand].mult = G.GAME.hands[hand].mult + 0.5
        G.GAME.hands[hand].chips = G.GAME.hands[hand].chips + 0.5
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            return true end }))
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('bd_inapmit_fast')
            if card and card.juice_up then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
        delay(1.3)
    end
    update_hand_text({ delay = 0 }, {
        mult = 0,
        chips = 0,
        level = "",
        handname = "",
    })
end

function BadDirector.misprint_all(card, seed)
    seed = seed or card.config.center.key
    update_hand_text({delay = 0}, {handname = localize('k_all_hands'), 
    mult = "...", chips = "..."})
    delay(1)
    for hand, v in pairs(G.GAME.hands) do
        if SMODS.pseudorandom_probability(card, seed, 1, 4) then
            local range = math.floor((pseudorandom(seed)*1.3 + 0.7) * 100) / 100
            local range2 = math.floor((pseudorandom(seed)*1.3 + 0.7) * 100) / 100
            G.GAME.hands[hand].mult = G.GAME.hands[hand].mult * range
            G.GAME.hands[hand].chips = G.GAME.hands[hand].chips * range2
        elseif SMODS.pseudorandom_probability(card, seed, 1, 2) then
            local range = math.floor((pseudorandom(seed)*49 + 1) * 100) / 100
            local range2 = math.floor((pseudorandom(seed)*49 + 1) * 100) / 100
            G.GAME.hands[hand].mult = G.GAME.hands[hand].mult + range
            G.GAME.hands[hand].chips = G.GAME.hands[hand].chips + range2
        else
            G.GAME.hands[hand].mult = G.GAME.hands[hand].mult + 0.5
            G.GAME.hands[hand].chips = G.GAME.hands[hand].chips + 0.5
        end
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        play_sound('bd_inapmit_fast')
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        G.TAROT_INTERRUPT_PULSE = true
        return true end }))
    update_hand_text({delay = 0}, {mult = "???", StatusText = true})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('bd_inapmit_fast')
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        return true end }))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('bd_inapmit_fast')
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        return true end }))
    update_hand_text({delay = 0}, {chips = "???", StatusText = true})
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
        play_sound('bd_inapmit_fast')
        if card and card.juice_up then card:juice_up(0.8, 0.5) end
        G.TAROT_INTERRUPT_PULSE = nil
        return true end }))
    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level="???"})
    delay(1.3)
    update_hand_text({ delay = 0 }, {
        mult = 0,
        chips = 0,
        level = "",
        handname = "",
    })
end