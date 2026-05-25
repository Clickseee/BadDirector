SMODS.Joker {
    key = "forgery",
    rarity = 2,
    atlas = "forgery",
    artist = {"Astro"},
    coder = {"squeax09"},
    pos = { x = 0, y = 0 },
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"generation"},
    cost = 7,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = { extra = { copy = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.copy } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local card_copied = copy_card(pseudorandom_element(G.hand.cards, pseudoseed("forgery!!!!")), nil, nil, G.playing_card)
            local new_rank = (pseudorandom('forgeRANK', -1, 1))
            if new_rank == 0 then new_rank = (pseudorandom('forgeRANK', -1, 1)) end
            assert(SMODS.modify_rank(card_copied, new_rank))
            if not SMODS.has_enhancement(card_copied, 'c_base') then
                local cen_pool = {}
                for _, enhancement_center in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                    if enhancement_center.key ~= 'm_stone' and not enhancement_center.overrides_base_rank then
                        cen_pool[#cen_pool + 1] = enhancement_center.key
                    end
                end
                local enhancement = SMODS.poll_enhancement { guaranteed = true, options = cen_pool, key = "bd_forgery_enhance_tweak" }
                card_copied:set_ability(enhancement)
            end
            card_copied:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, card_copied)
            G.hand:emplace(card_copied)
            card_copied.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    card_copied:start_materialize()
                    return true
                end
            }))
            return {
                message = localize('k_copied_ex'),
                colour = G.C.CHIPS,
                func = function() -- This is for timing purposes, it runs after the message
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                            return true
                        end
                    }))
                end
            }
        end
    end
}