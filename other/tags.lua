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

SMODS.Tag {
    key = "thermaledition",
    atlas = "misprinttags",
    pos = { x = 0, y = 1 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bd_thermal
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_bd_thermal", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_bd_thermal"].discovered
    end
}

SMODS.Tag {
    key = "xrayedition",
    atlas = "misprinttags",
    pos = { x = 1, y = 1 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bd_xray
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_bd_xray", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_bd_xray"].discovered
    end
}

SMODS.Tag {
    key = "blueprintedition",
    atlas = "misprinttags",
    pos = { x = 2, y = 1 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bd_blueprint
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_bd_blueprint", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_bd_blueprint"].discovered
    end
}

SMODS.Tag {
    key = "misprintedition",
    atlas = "misprinttags",
    pos = { x = 3, y = 1 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_bd_misprinted
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_bd_misprinted", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
    in_pool = function(self, args)
        return G.P_CENTERS["e_bd_misprinted"].discovered
    end
}

SMODS.Tag {
    key = "escort",
    atlas = "misprinttags",
    pos = { x = 0, y = 2 },
    artist = {"LasagnaFelidae"},
    coder = {"squeax09", "LasagnaFelidae"},
    config = {
        ante = "[ante]"
    },
    loc_vars = function (self, info_queue, tag)
        local key = self.key
        return {vars = {tag.ability.ante or tag.config.ante}}
    end,
    set_ability = function (self, tag)
        tag.ability.ante = G.GAME.round_resets.ante + pseudorandom('bd_escort_tag', 1, 4)
    end,
    apply = function(self, tag, context)
        if context.type == 'eval' then
            if G.GAME.last_blind and G.GAME.last_blind.boss and G.GAME.round_resets.ante >= tag.ability.ante then
                tag:yep('+', G.C.RED, function()
                    return true
                end)
                tag.triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                        local loot = {
                            {key = "im", weight = 1+(0.1*(G.GAME.tag_modifier and G.GAME.tag_modifier or 0))},
                            {key = "boutta", weight = 1+(0.1*(G.GAME.tag_modifier and G.GAME.tag_modifier or 0))},
                            {key = "blowwww", weight = 1+(0.1*(G.GAME.tag_modifier and G.GAME.tag_modifier or 0))},
                            {key = "rarestring4", weight = 0.5+(0.5*(G.GAME.tag_modifier and G.GAME.tag_modifier or 0))},
                        }
                        pick = BadDirector.quick_pool_pick(loot)
                        if pick == "im" then
                            add_tag(Tag(pseudorandom_element(G.P_TAGS, pseudoseed("the PACKAGE" .. G.GAME.round_resets.ante))))
                        elseif pick == "boutta" then
                            local selection = pseudorandom_element(G.P_CENTER_POOLS.Consumeables, pseudoseed("you're telling me it CAME?" .. G.GAME.round_resets.ante))
                            local consume = SMODS.add_card({
                                area = G.consumeables,
                                key = selection.key,
                                -- allow_duplicates = true, [unsure if i should]
                            })
                            consume:set_edition("e_negative")
                        elseif pick == "blowwww" then -- dawg WHAT am i doing here
                            local selection = pseudorandom_element(G.P_CENTER_POOLS.Joker, pseudoseed("in the MALE?" .. G.GAME.round_resets.ante))
                            local consume = SMODS.add_card({
                                area = G.jokers,
                                key = selection.key,
                                -- allow_duplicates = true, [unsure if i should]
                            })
                        else
                            local loot2 = {
                                {key = "tag_bd_meteor", weight = 1},
                                {key = "tag_bd_ethereal", weight = 0.8},
                                {key = "tag_bd_charm", weight = 1},
                            }
                            add_tag(Tag(BadDirector.quick_pool_pick(loot2)))
                            --add_tag(Tag("tag_voucher")) [replace this with the Awesome Voucher that becomes free tag :speaking_head:]
                        end
                        return true
                    end
                }))
            end
        end
    end
}