SMODS.Joker {
    key = "pregnantchad",
    rarity = 3,
    pos = { x = 9, y = 9 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { reps = 2 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.reps } }
    end,

    calculate = function(self, card, context)
        if context.retrigger_joker_check and not card.ability.triggered then
            card.ability.triggered = true
            return {
                repetitions = card.ability.extra.reps
            }
        end
        if context.end_of_round then card.ability.triggered = nil end
    end
}
