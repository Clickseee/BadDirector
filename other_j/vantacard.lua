SMODS.Joker {
    key = "vantacard",
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = "vantablack",
    coder = { "Nxkoo" },
    artist = { "Nxkoo" },
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "economy",
        "passive",
        "joker_slot"
    },

    config = {
        extra = {
            interest_per_missing_slot = 1,
            current_bonus = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        local bonus = math.max(0, (G.jokers and G.jokers.config.card_limit or 5)) * card.ability.extra.interest_per_missing_slot

        return {
            vars = {
                card.ability.extra.interest_per_missing_slot,
                bonus
            }
        }
    end,

    update = function(self, card, dt)
        if not G.GAME or not G.jokers then return end

        local target_bonus =
            math.max(0, 5 - G.jokers.config.card_limit)
            * card.ability.extra.interest_per_missing_slot

        if target_bonus ~= card.ability.extra.current_bonus then
            G.GAME.interest_cap =
                G.GAME.interest_cap
                - card.ability.extra.current_bonus
                + target_bonus

            card.ability.extra.current_bonus = target_bonus
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        local bonus =
            math.max(0, 5 - G.jokers.config.card_limit)
            * card.ability.extra.interest_per_missing_slot

        G.GAME.interest_cap = G.GAME.interest_cap + bonus
        card.ability.extra.current_bonus = bonus
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.interest_cap =
            G.GAME.interest_cap - card.ability.extra.current_bonus

        card.ability.extra.current_bonus = 0
    end,
}
