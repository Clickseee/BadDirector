function BadDirector_obfuscate(len)
    local chars = "!@#$%^&*()_+-=[]{}|;:,.<>?/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local s = ""
    for i = 1, len do
        local r = math.random(#chars)
        s = s .. chars:sub(r, r)
    end
    return s
end


function BadDirector_glitch_hand_text(times)
    times = times or 12

    for i = 1, times do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0,
            func = function()

                update_hand_text(
                    { delay = 0 },
                    {
                        handname = BadDirector_obfuscate(math.random(4, 9)),
                        chips    = BadDirector_obfuscate(math.random(3, 6)),
                        mult     = BadDirector_obfuscate(math.random(3, 6)),
                        level    = BadDirector_obfuscate(math.random(2, 5))
                    }
                )

                return true
            end
        }))
    end
end

function BadDirector_reset_hand_text()
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0,
        func = function()

            local hand = nil

            if G.GAME and G.GAME.current_round then
                hand = G.GAME.current_round.current_hand
            end

            if hand and G.GAME.hands[hand] then

                local data = G.GAME.hands[hand]

                update_hand_text(
                    { delay = 0 },
                    {
                        handname = localize(hand, 'poker_hands'),
                        chips    = data.chips,
                        mult     = data.mult,
                        level    = data.level
                    }
                )

            else
                update_hand_text(
                    { delay = 0 },
                    {
                        handname = '',
                        chips = 0,
                        mult = 0,
                        level = ''
                    }
                )
            end

            return true
        end
    }))
end

