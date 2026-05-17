-- Charm Tag
SMODS.Tag {
    key = "charm",
    atlas = "misprinttags",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_bd_misarcana_mega_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.PURPLE, function()
                local booster = SMODS.create_card { key = 'p_bd_misarcana_mega_' .. math.random(1, 2), area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

-- Meteor Tag
SMODS.Tag {
    key = "meteor",
    atlas = "misprinttags",
    min_ante = 2,
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_bd_miscelestial_mega_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Planet, function()
                local booster = SMODS.create_card { key = 'p_bd_miscelestial_mega_' .. math.random(1, 2), area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

SMODS.Tag {
    key = "ethereal",
    atlas = "misprinttags",
    min_ante = 2,
    pos = { x = 2, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_bd_misspectral_normal_1
    end,
    apply = function(self, tag, context)
        if context.type == 'new_blind_choice' then
            local lock = tag.ID
            G.CONTROLLER.locks[lock] = true
            tag:yep('+', G.C.SECONDARY_SET.Spectral, function()
                local booster = SMODS.create_card { key = 'p_bd_misspectral_normal_1', area = G.play }
                booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
                booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
                booster.T.w = G.CARD_W * 1.27
                booster.T.h = G.CARD_H * 1.27
                booster.cost = 0
                booster.from_tag = true
                G.FUNCS.use_card({ config = { ref_table = booster } })
                booster:start_materialize()
                G.CONTROLLER.locks[lock] = nil
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

SMODS.Tag {
    key = "brokenheart",
    atlas = "misprinttags",
    pos = { x = 3, y = 0 },
    config = { odds = 3 },
    apply = function(self, tag, context)
        if context.type == 'store_joker_create' then
            local rares_in_posession = { 0 }
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config.center.rarity == 3 and not rares_in_posession[joker.config.center.key] then
                    rares_in_posession[1] = rares_in_posession[1] + 1
                    rares_in_posession[joker.config.center.key] = true
                end
            end
            if #G.P_JOKER_RARITY_POOLS[3] > rares_in_posession[1] then
                local card = SMODS.create_card {
                    set = "BadDirector_Jokers",
                    rarity = "Rare",
                    area = context.area,
                    key_append = "vremade_rta"
                }
                create_shop_card_ui(card, 'Joker', context.area)
                card.states.visible = false
                tag:yep('+', G.C.RED, function()
                    card:start_materialize()
                    card.ability.couponed = true
                    card:set_cost()
                    return true
                end)
                tag.triggered = true
                return card
            else
                tag:nope()
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["j_blueprint"].discovered
    end
}