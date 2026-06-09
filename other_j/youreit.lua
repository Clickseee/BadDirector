SMODS.Joker {
    key = "youreit",
    rarity = 2,
    atlas = "yourturn",
    coder = { "Nxkoo" },
    artist = {"Inky"},
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "xmult",
        "scaling",
        "reset",
        "skip"
    },
    cost = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            xmult = 1,
            gain = 0.15,
            rounds = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.gain,
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            card.ability.extra.rounds = 0
            card.ability.extra.xmult = 1

            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end

        if context.setting_blind
            and not context.individual
            and not context.repetition
            and not G.GAME.blind.boss
            and not context.blueprint then
            card.ability.extra.rounds =
                card.ability.extra.rounds + 1

            card.ability.extra.xmult =
                card.ability.extra.xmult +
                card.ability.extra.gain

            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
