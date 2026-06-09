SMODS.Joker {
    key = "polaroid",
    rarity = 1,
    cost = 3,
    atlas = "negphoto",
    coder = { "Nxkoo" },
    artist = {"IncognitoN71"},
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = {
        "xchips",
        "face"
    },

    config = {
        extra = {
            xchips = 2.5
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xchips
            }
        }
    end,

    calculate = function(self, card, context)

        if context.before then

            card.ability.extra.triggered = false

            local scored_ids = {}

            for _, scored_card in ipairs(context.scoring_hand) do
                scored_ids[scored_card] = true
            end

            for _, played_card in ipairs(context.full_hand) do

                if not scored_ids[played_card]
                and played_card:is_face()
                then
                    card.ability.extra.target = played_card
                    break
                end
            end
        end

        if context.individual
        and context.cardarea == G.play
        and context.other_card == card.ability.extra.target
        and not card.ability.extra.triggered then

            card.ability.extra.triggered = true

            return {
                x_chips = card.ability.extra.xchips,
                card = context.other_card
            }
        end
    end
}
