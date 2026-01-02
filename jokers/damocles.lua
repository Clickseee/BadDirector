-- no other mod does this from what i see, other than Tangents but it doesn't matter, this is numberslop
--[[
local ref = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
  if G.jokers and next(SMODS.find_card("j_bd_damocles")) and (key == "mult" or key == "mult_mod" or key == "h_mult") then
    if key == "mult_mod" then effect.message = nil end
    return ref(effect, scored_card, "xmult", amount, from_edition)
  else
    return ref(effect, scored_card, key, amount, from_edition)
  end
end

local ref = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
  if G.jokers and next(SMODS.find_card("j_bd_damocles")) and (key == "chips" or key == "chip_mod" or key == "h_chips") then
    if key == "chip_mod" then effect.message = nil end
    return ref(effect, scored_card, "xchips", amount, from_edition)
  else
    return ref(effect, scored_card, key, amount, from_edition)
  end
end
]]  

SMODS.Atlas {
    key = "damocle",
    path = "damocles.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "damocles",
    rarity = 3,
    atlas = "damocle",
    pos = { x = 0, y = 0 },
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { joker_reps = 2, card_reps = 1, hands = 1, x = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.joker_reps, card.ability.extra.card_reps, card.ability.extra.hands } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = (-card.ability.extra.hands)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = (card.ability.extra.hands)
    end,
    calculate = function(self, card, context)
      if context.retrigger_joker_check and not card.ability.triggered and not context.retrigger_joker then -- Joker retriggers
            return {
                repetitions = card.ability.extra.joker_reps
            }
        end
        if context.repetition and context.cardarea == G.play then -- Card retriggers
            return {
                repetitions = card.ability.extra.card_reps
            }
        end
        if context.mod_probability and not context.blueprint then -- Tripled probabilities
            return {
                numerator = context.numerator * 3
            }
        end
        if context.end_of_round and context.main_eval then -- Money manipulation
            return {
                dollars = G.GAME.dollars * card.ability.extra.x - 1,
            }
        end
    end
}
