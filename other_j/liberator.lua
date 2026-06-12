SMODS.Joker {
    key = "liberator",
    rarity = 2,
    atlas = "misprintenhanced",
    coder = { "Nxkoo" },
    pos = { x = 0, y = 0 },
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "generation",
        "destroy_card",
        "joker"
    },

    config = {
        extra = {

        }
    },

    needs_use_button = function(self, card)
        return true
    end,

    can_use = function(self, card)
        return #G.jokers.highlighted == 2
            and G.jokers.highlighted[1]
            and G.jokers.highlighted[2]
            and (
                G.jokers.highlighted[1] == card
                or
                G.jokers.highlighted[2] == card
            )
    end,

    use = function(self, card)

        local target

        for _, joker in ipairs(G.jokers.highlighted) do
            if joker ~= card then
                target = joker
                break
            end
        end

        if not target then
            return
        end

        G.jokers:unhighlight_all()

        card_eval_status_text(
            card,
            "extra",
            nil,
            nil,
            nil,
            {
                message = "BANG!",
                colour = G.C.RED
            }
        )

        G.E_MANAGER:add_event(Event({
            func = function()

                target:start_dissolve()

                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.3,
            func = function()

                local new_joker = create_card(
                    "Joker",
                    G.jokers,
                    0.9,
                    0,
                    true,
                    true,
                    nil,
                    "hitman"
                )

                new_joker:set_rarity(3)

                new_joker:add_to_deck()
                G.jokers:emplace(new_joker)

                card_eval_status_text(
                    new_joker,
                    "extra",
                    nil,
                    nil,
                    nil,
                    {
                        message = "Rare!",
                        colour = G.C.RARITY.Rare
                    }
                )

                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.6,
            func = function()

                card:start_dissolve()

                return true
            end
        }))
    end,

    loc_vars = function(self, info_queue, card)
        return {}
    end
}
