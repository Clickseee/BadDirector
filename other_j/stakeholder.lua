local function get_stake_count()
    for i = 1, 100 do
        local stake = SMODS.stake_from_index(i)

        if stake == "error" then
            break
        end

        if stake == G.GAME.stake then
            return i
        end
    end

    return 1
end

SMODS.Joker {
    key = "stakeholder",
    rarity = 1,
    atlas = "misprintenhanced",
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
        "mult"
    },

    config = {
        extra = {
            mult_per_stake = 15
        }
    },

    loc_vars = function(self, info_queue, card)
        local stakes = get_stake_count()

        return {
            vars = {
                card.ability.extra.mult_per_stake,
                stakes,
                stakes * card.ability.extra.mult_per_stake
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = get_stake_count() *
                    card.ability.extra.mult_per_stake
            }
        end
    end,
}
