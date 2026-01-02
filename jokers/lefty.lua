SMODS.Joker {
    key = "lefty",
    rarity = 3,
    pos = { x = 9, y = 9 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { dollars = 5 } },
    loc_vars = function(self, info_queue, card)
        local data = G.GAME.current_round.vremade_leftmost or { rank = 'Ace', suit = 'Spades' }
        return {
            vars = {
                card.ability.extra.dollars,
                localize(data.rank, 'ranks'),
                localize(data.suit, 'suits_plural'),
                colours = { G.C.SUITS[data.suit] }
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local scored = context.scored or context.full_hand
            local leftmost = scored and scored[1]

            if not leftmost then return end

            local target = G.GAME.current_round.vremade_leftmost

            if leftmost:get_id() == target.id and leftmost:is_suit(target.suit) then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars


                reset_vremade_leftmost()

                return {
                    dollars = card.ability.extra.dollars,
                    message = "$" .. card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end
}



local function reset_vremade_leftmost()
    G.GAME.current_round.vremade_leftmost = G.GAME.current_round.vremade_leftmost or { rank = 'Ace', suit = 'Spades' }

    local prev = G.GAME.current_round.vremade_leftmost

    local valid = {}
    for _, c in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(c) and not SMODS.has_no_rank(c) then
            if c.base.id ~= prev.id or c.base.suit ~= prev.suit then
                valid[#valid + 1] = c
            end
        end
    end

    local new = pseudorandom_element(valid, 'vremade_leftmost_' .. G.GAME.round_resets.ante)

    if new then
        prev.rank = new.base.value
        prev.suit = new.base.suit
        prev.id   = new.base.id
    end
end


function SMODS.current_mod.reset_game_globals(run_start)
    reset_vremade_leftmost()
end
