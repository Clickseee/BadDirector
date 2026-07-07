--is this necessaryoid or just utilslop
function BadDirector.build_misprint_table()
    BadDirector.Misprints = {}
    BadDirector.MisprintsEnh= {}
    for i, v in pairs(G.P_CENTERS) do
        if v.misprint_original then
            BadDirector.Misprints[v.misprint_original] = v.key
        end
        if v.m_misprint_original then
            BadDirector.MisprintsEnh[v.m_misprint_original] = v.key
        end
    end
end

function BadDirector.misprint(card)
    if card.ability.consumeable and (BadDirector.Misprints[card.config.center.key]) then
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
        if (BadDirector.MisprintsEnh[card.config.center.key]) then
            card:set_ability(BadDirector.MisprintsEnh[card.config.center.key])
        end
        card:set_edition("e_bd_misprinted")
    end
end

function BadDirector.misprint_clear(card)
    if card.ability.consumeable and (card.config.center.misprint_original) then
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
                card:set_ability(card.config.center.misprint_original)
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
        if (card.config.center.m_misprint_original) then
            card:set_ability(card.config.center.m_misprint_original)
        end
        card:set_edition((card.edition and card.edition.key ~= "e_bd_misprinted") and card.edition.key or "e_base")
    end
end

local loadmodsref = SMODS.injectItems
function SMODS.injectItems(...)
    local ret = loadmodsref(...)
    BadDirector.build_misprint_table()
    if Cryptid and Cryptid.manipulate then
        BadDirector.manipulate = Cryptid.manipulate
    end
    return ret
end

SMODS.Sound {
    key = "inapmit_fast",
    path = "inapmit_fast.ogg",
    volume = 1.5
}

function BadDirector.misprint_hand(hand, card, seed, silent, args)
    args = args or {}
    seed = seed or hand..card.config.center.key
    local params = SMODS.Scoring_Parameter.obj_buffer --Change this to {"chips", "mult"} if we want to actively not give a shit about glop etc

    if not silent then
        update_hand_text({delay = 0}, {handname = localize(hand, "poker_hands"), level = G.GAME.hands[hand].level, 
        mult = G.GAME.hands[hand].mult, chips = G.GAME.hands[hand].chips, hand})
        delay(1)
    end

    local total_level_result, affected_params = 0,0

    local param_action
    if SMODS.pseudorandom_probability(card, seed, 1, 4) then
        param_action = function (num, param)
            local variance = pseudorandom(seed)
            local min = args[param.."_multiply_min"] or args.multiply_min or 0.7
            local range = (args[param.."_multiply_max"] or args.multiply_max or 2.0) - min
            local outcome = num * math.floor((variance*range + min) * 100) / 100
            total_level_result = total_level_result + (outcome / G.GAME.hands[hand]["l_" .. param])
            return outcome
        end
    elseif SMODS.pseudorandom_probability(card, seed, 1, 2) then
        param_action = function (num, param)
            local variance = pseudorandom(seed)
            local min = args[param.."_add_min"] or args.add_min or 1
            local range = (args[param.."_add_min"] or args.add_max or 29) - min
            local outcome = num + math.floor((variance*range + min) * 100) / 100
            total_level_result = total_level_result + (outcome / G.GAME.hands[hand]["l_" .. param])
            return outcome
        end
    else
        param_action = function (num, param)
            local amt = args.fixed_result or 0.5
            total_level_result = total_level_result + amt
            return num + (G.GAME.hands[hand]["l_" .. param] and (G.GAME.hands[hand]["l_" .. param] * amt))
        end
    end

    for i, parameter in ipairs(params) do
        if G.GAME.hands[hand][parameter] then
            affected_params = affected_params + 1
            G.GAME.hands[hand][parameter] = param_action(G.GAME.hands[hand][parameter], parameter)
            if not silent then
                update_hand_text({ delay = 0 }, { [parameter] = G.GAME.hands[hand][parameter], StatusText = true })
                if i == 1 then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.2,
                        func = function()
                            play_sound('bd_inapmit_fast')
                            if card and card.juice_up then card:juice_up(0.8, 0.5) end
                            G.TAROT_INTERRUPT_PULSE = true
                            return true
                        end
                }))
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.9,
                    func = function()
                        play_sound('bd_inapmit_fast')
                        if card and card.juice_up then card:juice_up(0.8, 0.5) end
                        G.TAROT_INTERRUPT_PULSE = true
                        return true
                    end
            }))
            end
        end
    end

    G.GAME.hands[hand].level = G.GAME.hands[hand].level + (total_level_result / affected_params)
    if not silent then
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = G.GAME.hands[hand].level })
        delay(1.3)

        update_hand_text({ delay = 0 }, {
            mult = 0,
            chips = 0,
            level = "",
            handname = "",
        })
    end
end

function BadDirector.misprint_all(card, seed)
    seed = seed or card.config.center.key
    update_hand_text({delay = 0}, {handname = localize('k_all_hands'), 
    mult = "...", chips = "..."})
    delay(1)
    for hand, v in pairs(G.GAME.hands) do
        BadDirector.misprint_hand(hand, card, seed, true, {add_range = 40})
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