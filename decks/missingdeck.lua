SMODS.Back {
    key = "missingdeck",
    pos = { x = 1, y = 0 },
    calculate = function(self, back, context)
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            play_sound('bd_inapmit')
            local replace_table = {}
            for k, v in pairs(G.jokers.cards) do
                replace_table[#replace_table + 1] = v
                v:juice_up()
            end
            BadDirector.replacecards(replace_table, nil, nil, true)
        end
    end
}
