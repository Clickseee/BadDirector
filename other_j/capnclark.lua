local sell_card_ref = Card.sell_card -- you're a whore

function Card:sell_card(...)
    if self.config
    and self.config.center
    and self.config.center.set == "Joker" then
        G.GAME.last_sold_joker = self.config.center.key
    end

    return sell_card_ref(self, ...)
end

SMODS.Joker {
    key = "capnclark",
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = "ottomen",
    coder = { "Nxkoo" },
    artist = { "Nxkoo" },
    pos = { x = 0, y = 0 },
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
            weaken_factor = 0.50,
            clarkeaten = 0
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                math.floor((card.ability.extra.weaken_factor + card.ability.extra.clarkeaten) * 100)
            }
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then

            local target = nil

            -- prioritize Clark
            for _, v in ipairs(G.jokers.cards) do
                if v ~= card and v.config.center.key == "j_bd_clark" then
                    target = v
                    break
                end
            end

            if not target then
                local valid = {}

                for _, v in ipairs(G.jokers.cards) do
                    if v ~= card then
                        valid[#valid+1] = v
                    end
                end

                if #valid > 0 then
                    target = pseudorandom_element(valid, pseudoseed("itsthewaywewired"))
                end
            end

            if target then
                G.E_MANAGER:add_event(Event({
                    func = function()

                        if target.config.center.key == "j_bd_clark" then
                            card.ability.extra.clarkeaten =
                                card.ability.extra.clarkeaten + 0.15
                        end

                        target:start_dissolve()
                        return true
                    end
                }))
            end

            local last_sold = G.GAME.last_sold_joker

            if last_sold and G.P_CENTERS[last_sold] then

                G.E_MANAGER:add_event(Event({
                    func = function()

                        local new_card = SMODS.add_card{
                            key = last_sold,
                            area = G.jokers
                        }

                        if new_card then
                            new_card:set_edition({negative = true}, true)
                            new_card:add_sticker("bd_anomalous",true)

                            BadDirector.manipulate(new_card, {
                                value = card.ability.extra.weaken_factor + card.ability.extra.clarkeaten,
                                type = "X",
                                dont_stack = true
                            })
                        end

                        return true
                    end
                }))
            end

            return {
                message = "..."
            }
        end
    end
}
