SMODS.Joker {
    key = "mpreg",
    rarity = 3,
    atlas = "pregnantchad",
    artist = {"LasagnaFelidae"},
    coder = {"LasagnaFelidae"},
    pos = { x = 0, y = 0 },
    config = {
        extra = { repetitions = 2 }, states = { retriggered = false },},
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"retrigger", "joker"},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.repetitions,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and not card.ability.states.retriggered == true then
            card.ability.states.retriggered = true
            return { repetitions = card.ability.extra.repetitions }
        end
        if context.after then
            card.ability.states.retriggered = false
        end
    end,
}
