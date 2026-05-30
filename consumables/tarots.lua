SMODS.Consumable {
    atlas = "vegatarot",
    key = 'tarot_flaw',
    set = 'Tarot',
    artist = {"Vega"},
    coder = {"LasagnaFelidae"},
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 2},

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted,} }
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    BadDirector.misprint_clear(G.hand.highlighted[i])
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,

    can_use = function(self, card)
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
            for i = 1, #G.hand.highlighted do
                if not (G.hand.highlighted[i].config.center.m_misprint_original or (G.hand.highlighted[i].edition and G.hand.highlighted[i].edition.key == "e_bd_misprinted")) then
                    return false
                end
            end
            return true
        end
        return false
    end,
}

SMODS.Consumable {
    atlas = "vegatarot",
    key = 'tarot_liar',
    set = 'Tarot',
    artist = {"Vega"},
    coder = {"LasagnaFelidae"},
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 2},

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'bd_enhanced_info', set = 'Other'}
        return { vars = { card.ability.max_highlighted,} }
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(BadDirector.quick_pool_pick(BadDirector.misprint_enhancements))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,

    can_use = function(self, card)
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
            return true
        end
        return false
    end,
}

