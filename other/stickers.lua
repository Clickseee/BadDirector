local end_round_ref = end_round

function end_round()
    end_round_ref()

    for _, area in ipairs({
        G.jokers,
        G.hand,
        G.consumeables,
        G.discard,
        G.deck
    }) do
        if area and area.cards then
            for _, card in ipairs(area.cards) do

                if card.ability
                and card.ability.anomalous then

                    card.ability.anomalous_counter =
                        (card.ability.anomalous_counter or 0) + 1

                    card.ability.anomalous_debuffed =
                        card.ability.anomalous_counter %
                        4 == 0

                end
            end
        end
    end
end

local set_debuff_ref = Card.set_debuff

function Card:set_debuff(should_debuff)

    if self.ability
    and self.ability.anomalous_debuffed then
        should_debuff = true
    end

    return set_debuff_ref(self, should_debuff)
end

SMODS.Sticker {
    key = "weakened",
    badge_colour = HEX('9fb5ba'),
    needs_enable_flag = true,
    atlas = "bdstickers",
    pos = { x = 0, y = 1 },
    name = "Weakened",
    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end,


    apply = function(self, card, val)
        card.ability[self.key] = val
        card:set_debuff(true)
    end,
    calculate = function(self, card, context)
        if card.ability[self.key] and not card.debuff then
            card:set_debuff(true)
        end
    end,
}



SMODS.Sticker {
    key = "anomalous",
    badge_colour = HEX('D3C1A0'),
    needs_enable_flag = true,
    atlas = "bdstickers",
    pos = { x = 1, y = 1 },
    name = "Anomalous",
    config = {
        debuff_period = 4,
        debuff_duration = 1
    },

    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end,

    apply = function(self, card, val)
        card.ability[self.key] = val

        if val then
            card.ability.anomalous_counter = 0
            card.ability.anomalous_debuffed = false
        end
    end,

    loc_vars = function(self, info_queue, card)
        local counter = card and card.ability and card.ability.anomalous_counter or 0

        return {
            key = self.key,
            vars = {
                self.config.debuff_period,
                self.config.debuff_duration,
                counter
            }
        }
    end
}