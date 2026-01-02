SMODS.Joker {
    key = "contents",
    rarity = 2,
    pos = { x = 9, y = 9 },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult_gain = 0.2,
            xmult = 1,
            mult_gain = 2,
            mult = 0,
            hand_types = { 'High Card', 'Pair', 'Two Pair' },
            completed_hands = {}
        }
    },
    loc_vars = function(self, info_queue, card)
        local hand_display = {}
        for i, hand_type in ipairs(card.ability.extra.hand_types) do
            local is_completed = card.ability.extra.completed_hands[hand_type]
            local color = is_completed and G.C.GREEN or G.C.UI.TEXT_INACTIVE
            local symbol = is_completed and "[O] " or "[X] "
            hand_display[#hand_display + 1] = {
                n = G.UIT.T,
                config = {
                    text = symbol .. localize(hand_type, 'poker_hands'),
                    colour = color,
                    scale = 0.3
                }
            }
            if i < #card.ability.extra.hand_types then
                hand_display[#hand_display + 1] = {
                    n = G.UIT.T,
                    config = { text = " - ", scale = 0.3, colour = G.C.UI.TEXT_INACTIVE }
                }
            end
        end
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.mult_gain,
                card.ability.extra.xmult,
                card.ability.extra.mult
            },
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.1 },
                    nodes = hand_display
                }
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.completed_hands = {}
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) then
                    local is_current = false
                    for _, current_hand in ipairs(card.ability.extra.hand_types) do
                        if handname == current_hand then
                            is_current = true
                            break
                        end
                    end
                    if not is_current then
                        _poker_hands[#_poker_hands + 1] = handname
                    end
                end
            end
            if #_poker_hands >= 3 then
                local new_hand_types = {}
                new_hand_types[1] = pseudorandom_element(_poker_hands, 'inthestripclub')
                local remaining_hands_1 = {}
                for _, hand in ipairs(_poker_hands) do
                    if hand ~= new_hand_types[1] then
                        remaining_hands_1[#remaining_hands_1 + 1] = hand
                    end
                end
                new_hand_types[2] = pseudorandom_element(remaining_hands_1, 'straightup')
                local remaining_hands_2 = {}
                for _, hand in ipairs(remaining_hands_1) do
                    if hand ~= new_hand_types[2] then
                        remaining_hands_2[#remaining_hands_2 + 1] = hand
                    end
                end
                new_hand_types[3] = pseudorandom_element(remaining_hands_2, 'jorkingit')
                card.ability.extra.hand_types = new_hand_types
            end
            return {
                message = localize('k_reset')
            }
        end
        if context.before and context.main_eval and not context.blueprint then
            local current_hand = context.scoring_name
            local matched_hand = false
            for _, hand_type in ipairs(card.ability.extra.hand_types) do
                if current_hand == hand_type then
                    if not card.ability.extra.completed_hands[hand_type] then
                        card.ability.extra.completed_hands[hand_type] = true
                        matched_hand = true
                    end
                    break
                end
            end
            if matched_hand then
                local completed_count = 0
                for _, completed in pairs(card.ability.extra.completed_hands) do
                    if completed then completed_count = completed_count + 1 end
                end
                if completed_count == #card.ability.extra.hand_types then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult_gain } },
                        colour = G.C.MULT,
                        juice = true
                    }
                else
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                    return {
                        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_gain } },
                        colour = G.C.MULT,
                        juice = true
                    }
                end
            end
        end
        if context.joker_main then
            local completed_count = 0
            for _, completed in pairs(card.ability.extra.completed_hands) do
                if completed then completed_count = completed_count + 1 end
            end

            if completed_count == #card.ability.extra.hand_types then
                return {
                    mult = card.ability.extra.mult,
                    xmult = card.ability.extra.xmult
                }
            elseif completed_count > 0 then
                return {
                    mult = card.ability.extra.mult,
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,

    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.completed_hands = card.ability.extra.completed_hands or {}
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        if #_poker_hands >= 3 then
            local new_hand_types = {}
            new_hand_types[1] = pseudorandom_element(_poker_hands, 'byitimean')
            local remaining_hands_1 = {}
            for _, hand in ipairs(_poker_hands) do
                if hand ~= new_hand_types[1] then
                    remaining_hands_1[#remaining_hands_1 + 1] = hand
                end
            end
            new_hand_types[2] = pseudorandom_element(remaining_hands_1, 'hehletsjustsay')
            local remaining_hands_2 = {}
            for _, hand in ipairs(remaining_hands_1) do
                if hand ~= new_hand_types[2] then
                    remaining_hands_2[#remaining_hands_2 + 1] = hand
                end
            end
            new_hand_types[3] = pseudorandom_element(remaining_hands_2, 'mypeanits')
            card.ability.extra.hand_types = new_hand_types
        end
    end
}
