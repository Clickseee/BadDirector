SMODS.Joker {
    key = "longface",
    rarity = 1,
    cost = 3,
    atlas = "whythe",
    coder = { "Nxkoo" },
    artist = {"SDM_0"},
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = {
        "mult",
        "scaling",
        "tarot"
    },

    config = {
        extra = {
            mult = 0,
            gain = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.gain,
                card.ability.extra.mult
            }
        }
    end,

    calculate = function(self, card, context)

        if context.using_consumeable
        and context.consumeable
        and context.consumeable.ability
        and context.consumeable.ability.set == "mistarot"
        then

            card.ability.extra.mult =
                card.ability.extra.mult + card.ability.extra.gain

            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                card = card
            }
        end

        if context.joker_main
        and card.ability.extra.mult > 0 then

            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
