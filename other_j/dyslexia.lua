local is_suit_ref = Card.is_suit

function Card:is_suit(suit, bypass_debuff, flush_calc)

    if self.ability.identity_crisis_suit then
        return suit == self.ability.identity_crisis_suit
    end

    return is_suit_ref(self, suit, bypass_debuff, flush_calc)
end

SMODS.Joker {
    key = "diesexy",
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
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

        if context.before and #context.full_hand >= 2 then

            local first = context.full_hand[1]
            local second = context.full_hand[2]

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

            for _, playing_card in ipairs(context.full_hand) do
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