SMODS.Joker {
    key = "hyperspecific",
    rarity = 1,
    atlas = "veryspecific",
    coder = { "Nxkoo" },
    artist = {"Le Ginger"},
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
    "mult",
    "chips",
    "xmult",
    "xchips",
    "score",
    "xscore",
    "blindsize",
    "xblindsize",
    "balance",
    "swap",
    "retrigger",
    "scaling",
    "reset",
    "suit",
    "diamonds",
    "hearts",
    "spades",
    "clubs",
    "hand_type",
    "rank",
    "ace",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "jack",
    "queen",
    "king",
    "face",
    "economy",
    "generation",
    "destroy_card",
    "hands",
    "discard",
    "hand_size",
    "chance",
    "mod_chance",
    "joker",
    "joker_slot",
    "tarot",
    "planet",
    "spectral",
    "enhancements",
    "seals",
    "editions",
    "tag",
    "skip",
    "modify_card",
    "perma_bonus",
    "prevents_death",
    "boss_blind",
    "reroll",
    "on_sell",
    "sell_value",
    "food",
    "space",
    "passive",
},
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {
        extra = {
            dollars = 14,
            required_matches = 2
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = 'bd_attrib_info',
            set = 'Other'
        }
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.required_matches
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round
            and not context.individual
            and not context.repetition then
            local jokers = {}

            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    jokers[#jokers + 1] = joker
                end
            end

            if #jokers < 2 then
                return
            end

            local valid = true

            for i = 1, #jokers do
                for j = i + 1, #jokers do
                    local attrs1 = jokers[i].config.center.attributes or {}
                    local attrs2 = jokers[j].config.center.attributes or {}

                    local matches = 0

                    for _, attr1 in ipairs(attrs1) do
                        for _, attr2 in ipairs(attrs2) do
                            if attr1 == attr2 then
                                matches = matches + 1
                            end
                        end
                    end

                    if matches < card.ability.extra.required_matches then
                        valid = false
                        break
                    end
                end

                if not valid then
                    break
                end
            end

            if valid then
                return {
                    dollars = card.ability.extra.dollars,
                    message = "$" .. card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
            end
        end
    end,
    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
            text = {
                {text = "$"},
                {ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult"}
            },
            reminder_text = {
                {text = "("},
                {ref_table = "card.ability.extra", ref_value = "required_matches"},
                {text = " matches)"}
            },
            text_config = {colour = G.C.CHIPS},
            calc_function = function (card)
                local jokers = {}

                for _, joker in ipairs(G.jokers.cards) do
                    if joker ~= card then
                        jokers[#jokers + 1] = joker
                    end
                end
                local valid = true

                for i = 1, #jokers do
                    for j = i + 1, #jokers do
                        local attrs1 = jokers[i].config.center.attributes or {}
                        local attrs2 = jokers[j].config.center.attributes or {}

                        local matches = 0

                        for _, attr1 in ipairs(attrs1) do
                            for _, attr2 in ipairs(attrs2) do
                                if attr1 == attr2 then
                                    matches = matches + 1
                                end
                            end
                        end

                        if matches < card.ability.extra.required_matches then
                            valid = false
                            break
                        end
                    end

                    if not valid then
                        break
                    end
                end
                if #jokers < 2 then valid = false end
                card.joker_display_values.dollars = valid and card.ability.extra.dollars or 0
            end
        }
    end
}
