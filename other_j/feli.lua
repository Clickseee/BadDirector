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

SMODS.Joker {
    key = "p03",
    rarity = 3,
    atlas = "rattlingsnow",
    artist = {"RattlingSnow"},
    coder = {"LasagnaFelidae"},
    pos = { x = 1, y = 0 },
    cost = 5,
    config = { extra = {xchips=0.2}},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
        ["Inscryption"] = true,
        ["Technology"] = true,
        ["Object"] = true,
        ["Vermin"] = true,
    },
    attributes = {"xchips"},
    loc_vars = function(self, info_queue, card)
        local cb = BadDirector.count_browsers()
        return {
            vars = {
                card.ability.extra.xchips, cb*card.ability.extra.xchips, cb,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local cb = BadDirector.count_browsers()
            local quips = 
            {
                {key= "Get up? No. We've got Transcending to do.", weight = "1"},
                {key= "That's the ticket.", weight = "1"},
                {key= "You done gawking? We can start? Good.", weight = "1"},
                {key= "I almost enjoyed your company, challenger.", weight = "1"},
                {key= "Almost there.", weight = "1"},
                {key= "You made it. Nice. Great job.", weight = "1"},
            }
            return {
                xchips = 1 + (cb * card.ability.extra.xchips),
                message = BadDirector.quick_pool_pick(quips,pseudorandom("p03xleshy")),
				colour = G.C.SECONDARY_SET.Planet,
            
            }
        end
    end,
}
