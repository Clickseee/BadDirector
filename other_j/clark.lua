SMODS.Joker { -- Mostly helped with Neato's code
    key = "clark",
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = "architect",
    artist = { "La Ginger" },
    coder = { "Nxkoo" },
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "retrigger",
        "editions"
    },

    config = {
        extra = {
            retriggers = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bd_blueprint

        return {
            vars = {
                localize{type = "name_text", set = "Joker", key = self.key},
                card.ability.extra.retriggers
            }
        }
    end,

    calculate = function(self, card, context)
        if context.retrigger_joker_check
            and context.other_card
            and context.other_card ~= card
            and context.other_card.edition
            and context.other_card.edition.key == "e_bd_blueprint" then
            if not (
                    context.other_ret
                    and context.other_ret.jokers
                    and context.other_ret.jokers.was_blueprinted
                ) then
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra.retriggers,
                    message_card = context.blueprint_card or card,
                    was_blueprinted = context.blueprint,
                }
            end
        end

        if context.repetition
            and not context.repetition_only
            and context.other_card
            and context.other_card.edition
            and context.other_card.edition.key == "e_bd_blueprint" then
            return {
                message = localize("k_again_ex"),
                repetitions = card.ability.extra.retriggers,
                card = card,
                was_blueprinted = context.blueprint,
            }
        end
    end
}
