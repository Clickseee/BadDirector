local is_suit_ref = Card.is_suit

function Card:is_suit(suit, bypass_debuff, flush_calc)

    if self.ability.identity_crisis_suit then
        return suit == self.ability.identity_crisis_suit
    end

    return is_suit_ref(self, suit, bypass_debuff, flush_calc)
end

SMODS.Joker {
    key = "diesexy",
    rarity = 2,
    atlas = "dyslexia",
    coder = { "Nxkoo" },
    artist = {"LasagnaFelidae"},
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"hand_type","generation","hearts","tarot"},
    config = {
        extra = {
            odds = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        local num, den = SMODS.get_probability_vars(
            card,
            1,
            card.ability.extra.odds,
            "identity_crisis"
        )

        return {
            vars = {
                num,
                den
            }
        }
    end,

    calculate = function(self, card, context)

        if context.press_play and #G.hand.highlighted >= 2 then

            local first = G.hand.highlighted[1]
            local second = G.hand.highlighted[2]

            local chosen_suit

            if SMODS.pseudorandom_probability(
                card,
                "identity_crisis",
                1,
                card.ability.extra.odds,
                "identity_crisis"
            ) then
                chosen_suit = first.base.suit
            else
                chosen_suit = second.base.suit
            end

            for _, playing_card in ipairs(G.hand.highlighted) do
                playing_card.ability.identity_crisis_suit = chosen_suit
            end

            return {
                message = localize(chosen_suit, 'suits_plural')
            }
        end

        if context.after then
            for _, playing_card in ipairs(context.full_hand) do
                playing_card.ability.identity_crisis_suit = nil
            end
        end
    end
}