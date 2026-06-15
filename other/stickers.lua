SMODS.Sticker {
    key = "weakened",
    badge_colour = HEX('9fb5ba'),
    needs_enable_flag = true,
    atlas = "bdstickers",
    pos = { x = 0, y = 1 },
    name = "Weakened",
    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end,


    apply = function(self, card, val)
        card.ability[self.key] = val
        card:set_debuff(true)
    end,
    calculate = function(self, card, context)
        if card.ability[self.key] and not card.debuff then
            card:set_debuff(true)
        end
    end,
}



SMODS.Sticker {
    key = "anomalous",
    badge_colour = HEX('D3C1A0'),
    needs_enable_flag = true,
    atlas = "bdstickers",
    pos = { x = 1, y = 1 },
    name = "Anomalous",
    should_apply = function(self, card, center, area, bypass_roll)
        return false
    end,
    config = {
        ct = 0,
        debuff_period = 4,
        xmult = 0.5,
    },
        loc_vars = function(self,info_queue_card)
        local key = self.key

        
        return {key = key,vars = {self.config.xmult, self.config.debuff_period, self.config.ct}}
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
    calculate = function(self, card, context)
        
        if context.joker_main then
            self.config.ct = self.config.ct + 1
            if self.config.ct > self.config.debuff_period then self.config.ct = 1 end
            if (self.config.ct % self.config.debuff_period == 0) and self.config.ct ~= 0 then
                return { xmult = self.config.xmult,}
            end
		end

        

    end
}