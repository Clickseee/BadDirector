local check_for_buy_space_old = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
	if card.config.center.key == "j_bd_belovedprince" then
		if (#G.consumeables.cards < G.consumeables.config.card_limit) then
			return true
		else
			alert_no_space(card, G.consumeables)
			return false
		end
    end
    return check_for_buy_space_old(card)
end

local buy_from_shop_old = G.FUNCS.buy_from_shop
G.FUNCS.buy_from_shop = function(e, ...)
    local card = e.config.ref_table
    if card and card:is(Card) and card.config.center.key == "j_bd_belovedprince" then
        card.area:remove_card(card)
        G.consumeables:emplace(card)
    end
    buy_from_shop_old(e)
end

local cardarea_emplace_ref = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
    if self == G.jokers and (card.config.center.key == "j_bd_belovedprince") then
		 if card.area then card.area:remove_card(card) end
        G.consumeables:emplace(card, location, stay_flipped)
        return
    end

	cardarea_emplace_ref(self, card, location, stay_flipped)
end