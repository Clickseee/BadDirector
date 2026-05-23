

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
                    if blarg:is_suit("Hearts") then
                        G.GAME.ache_capture[#G.GAME.ache_capture+1] = blarg
                        blarg:start_dissolve()
                    end
                end
            end
        end
        if context.end_of_round and context.main_eval then
            if G.GAME.ache_capture and #G.GAME.ache_capture > 0 then
                for i=1, #G.GAME.ache_capture do
                    local heart = BadDirector.copy_card(G.GAME.ache_capture[i], nil, G.hand)
                    heart:add_to_deck()
                    table.insert(G.playing_cards, heart)
                end
            end
		end
    end,
    disable = function(self)
        if G.GAME.ache_capture and #G.GAME.ache_capture > 0 then
            for i=1, #G.GAME.ache_capture do
                local heart = BadDirector.copy_card(G.GAME.ache_capture[i], nil, G.hand)
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, heart)
            end
            G.GAME.ache_capture = {}
        end
    end
}