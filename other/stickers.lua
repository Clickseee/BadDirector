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
    end
}