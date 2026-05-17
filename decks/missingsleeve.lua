if CardSleeves then
    CardSleeves.Sleeve {
        key = "missingdeck",
        atlas = "bdsleeves",
        pos = { x = 0, y = 0 },
        unlocked = false,
        unlock_condition = { deck = "b_bd_missingdeck", stake = "stake_white" },
        set_badges = function(self, card, badges)
		    badges[#badges+1] = create_badge(localize('k_felijo_ins'), HEX('7f1232'), HEX('f2a655'), 1 )
	    end,
        loc_vars = function (self, info_queue, card)
            local key = self.key
            if self.get_current_deck_key() == "b_bd_missingdeck" then
                self.config = { joker_slot = 1 }
                key = self.key .. "_alt"
                vars = { self.config.joker_slot} 
            else
                vars = {}
            end

            return {
                key = key,
                vars = vars
            }
        end,
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
end