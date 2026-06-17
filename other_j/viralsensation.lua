SMODS.Joker {
    key = "viralsensation",
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = "feliAtlas",
    artist = {"La Ginger"},
    coder = { "Nxkoo" },
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        'mult',
        'chips',
        'rank',
        'six',
        'seven'
    },

    config = {
        extra = {
            mult = 6,
            chips = 7
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual
            and context.cardarea == G.play
            and context.other_card then
            local id = context.other_card:get_id()

            if id == 6 then
                return {
                    mult = card.ability.extra.mult,
                    colour = G.C.MULT,
                    card = context.other_card
                }
            elseif id == 7 then
                return {
                    chips = card.ability.extra.chips,
                    colour = G.C.CHIPS,
                    card = context.other_card
                }
            end
        end
    end
}
