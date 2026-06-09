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
        "economy",
        "joker"
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
    end
}
