SMODS.Joker {
    key = "breathalyzer",
    rarity = 1,
    atlas = "breathalyzer",
    artist = {"La Ginger"},
    coder = { "Nxkoo" },
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "xmult",
        "passive"
    },

    config = {
        extra = {
            xmult = 3,
            activated = false
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = 'bd_screenshader_info',
            set = 'Other'
        }
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if not card.ability.extra.activated
            and SMODS.ScreenShaders then
            for _, shader in pairs(SMODS.ScreenShaders) do
                if shader.should_apply and shader:should_apply() then
                    card.ability.extra.activated = true

                    return {
                        message = "Burp",
                        colour = G.C.ATTENTION
                    }
                end
            end
        end

        if context.joker_main
            and card.ability.extra.activated then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}
