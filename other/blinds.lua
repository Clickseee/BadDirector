SMODS.ScreenShader {
    key = "upside_down",
    path = "australia.fs",

    should_apply = function(self)
        return G.GAME
            and G.GAME.blind
            and G.GAME.blind.config
            and G.GAME.blind.config.blind
            and G.GAME.blind.config.blind.key == "bl_bd_australia"
            and not G.GAME.blind.config.blind.disabled
    end
}

SMODS.Blind{
    key = "australia",
    atlas = "bdblinds",
    pos = { x = 0, y = 2 },

    boss = { min = 1 },

    dollars = 5,
    mult = 2,

    boss_colour = HEX("012169"),

    set_blind = function(self)
        self.disabled = false
    end,

    disable = function(self)
        self.disabled = true
    end,

    defeat = function(self)
        self.disabled = true
    end,
}

SMODS.Blind {
    key = 'ache',
    atlas = 'bdblinds',
    pos = { x = 0, y = 0 },
    dollars = 5,
    mult = 2,
    boss = { min = 2 },
    boss_colour = HEX('ad0055'),
    artist = {"squeax09"},
    coder = {"squeax09"},
    calculate = function(self, blind, context)
        if context.setting_blind then
            if not blind.disabled then
				self.triggered = true
                if G.GAME.ache_capture == nil then G.GAME.ache_capture = {} end
                for i, blarg in ipairs(G.deck.cards) do
                    if i % 3 == 0 then
                        G.GAME.ache_capture[#G.GAME.ache_capture+1] = blarg
                       SMODS.destroy_cards(blarg)
                    end
                end
            end
        end
        if context.end_of_round and context.main_eval and not blind.disabled then
            if G.GAME.ache_capture and #G.GAME.ache_capture > 0 then
                for i=1, #G.GAME.ache_capture do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local hearty = copy_card(G.GAME.ache_capture[i], nil, nil, G.playing_card) -- too lazy to rename the loc vars given it was initially 4 hearts lmao,,,
                    hearty:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, hearty)
                    G.deck:emplace(hearty)
                    hearty.states.visible = nil
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            hearty:start_materialize()
                            return true
                        end
                    }))
                end
            end
		end
    end,
    disable = function(self)
        if G.GAME.ache_capture and #G.GAME.ache_capture > 0 then
            for i=1, #G.GAME.ache_capture do
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local hearty = copy_card(G.GAME.ache_capture[i], nil, nil, G.playing_card)
                hearty:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, hearty)
                G.deck:emplace(hearty)
                hearty.states.visible = nil
                G.E_MANAGER:add_event(Event({
                    func = function()
                        hearty:start_materialize()
                        return true
                    end
                }))
            end
            G.GAME.ache_capture = {}
        end
    end
}

SMODS.Blind {
    key = 'ivory_isolate',
    atlas = 'bdblinds',
    pos = { x = 0, y = 1 },
    dollars = 5,
    mult = 2,
    no_collection = true,
    boss = { min = 99999999999, showdown = true },
    boss_colour = HEX('949494'),
    artist = {"squeax09"},
    coder = {"squeax09"},
    calculate = function(self, blind, context)
        if context.setting_blind then
            if G.GAME and G.GAME.challenge and G.GAME.challenge == "c_bd_genocide" then
                G.GAME.blind.chips = 350
            end
            if not blind.disabled then
                ease_hands_played(95)
            end
        end
        if pseudorandom('the void consumes all') < 1 / 100 and not blind.disabled and not context.press_play and not context.joker_main and G.hand and #G.hand.cards > 0 then
            local target = pseudorandom_element(G.hand.cards, pseudoseed("blue"))
            target:start_dissolve()
            self.triggered = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function()
                    SMODS.juice_up_blind()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot1', 1, 0.4)
                            return true
                        end
                    }))
                    return true
                end)
            }))
        end
        if context.press_play and not blind.disabled then
            ease_hands_played(1)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    for i = 1, #G.play.cards do
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                if pseudorandom('the void consumes all') < 2 / 3 then
                                    if G.play.cards[i] then
                                        G.play.cards[i].debuff = true
                                        G.play.cards[i]:juice_up()
                                    end
                                end
                                return true
                            end,
                        }))
                        delay(0.23)
                    end
                    return true
                end
            }))
            blind.triggered = true
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function()
                    SMODS.juice_up_blind()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    return true
                end)
            }))
            delay(0.4)
        end
    end,
    disable = function(self)
        
    end,
    in_pool = function(self, args)
        return false
    end
}