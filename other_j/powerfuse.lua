BadDirector = BadDirector or {}
BadDirector.power_fuse_active = false

SMODS.ScreenShader {
    key = "flashlight",

    path = "flashlight.fs",

    should_apply = function(self)
        return BadDirector.power_fuse_active
    end,

    send_vars = function(self)
        return {
            iTime = G.TIMERS.REAL
        }
    end
}

SMODS.Joker {
    key = "powerfuse",
    rarity = 1,
    atlas = "misprintenhanced",
    coder = { "Nxkoo" },
    pos = { x = 1, y = 0 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "xmult",
        "passive",
        "scaling"
    },

    config = {
        extra = {
            xmult = 4,
            awareness = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.awareness
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        BadDirector.power_fuse_active = true
    end,

    remove_from_deck = function(self, card, from_debuff)
        BadDirector.power_fuse_active = false
    end,

    calculate = function(self, card, context)

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.end_of_round
        and not context.individual
        and not context.repetition then

            card.ability.extra.awareness =
                card.ability.extra.awareness + 1

            return {
                message = "+1",
                colour = G.C.DARK_EDITION
            }
        end
    end,
    in_pool = function(self, args)
        return args and (args.source == "buf" or args.source == "bd_buf")
    end
}
