---@diagnostic disable: undefined-field
BadDirector.MisprintedDecks = {}

local back_apply_to_run_ref = Back.apply_to_run
function Back:apply_to_run()
	local self_in_use = self
	if BadDirector.do_misprint_deck then
		local key = self.effect.center.key
		if BadDirector.MisprintedDecks[key] then
			self_in_use = {effect = {
				center = {apply = self.effect.center.apply},
				config = self.effect.config
			}}
			if not BadDirector.MisprintedDecks[key].keep_apply then
				self_in_use.effect.center.apply = BadDirector.MisprintedDecks[key].apply
			end
			if not BadDirector.MisprintedDecks[key].keep_config then
				self_in_use.effect.config = BadDirector.MisprintedDecks[key].config or {}
			end
		end
	end
	return back_apply_to_run_ref(self_in_use)
end

--[[

Assign an effect to a deck by doing
function BadDirector.MisprintedDecks.deck_key = {
	apply? = function(self), -- new apply function
	keep_apply? = boolean, -- don't overwrite the old apply
	config? = table, -- new config table,
	keep_config? = boolean -- don't overwrite the old config
}
both apply and config are the same as making a normal deck

]]

--[[

TODO:
- implement loc_vars and loc_key
- create effects for each misprinted deck
- implement unlock requirement (win a run on Missing Deck)

]]

-- example


--[[
___  __      __   __  
 |  /  \ __ |  \ /  \ 
 |  \__/    |__/ \__/
---------------------

[ ] Red: Discarding a hand has a medium chance to not use any Discards 

[ ] Blue: Playing a hand has a very low chance to increase Hand Size permanently 

[ ] Yellow: Create The Hermit and Temperance at the start of every Ante, medium chance to be Misprinted 

[ ] Green: Interests are randomized each Ante, only gains Hands/Discards rewards after every Boss Blind 

[ ] Black: Negative Edition is 5X more common, -1 Hand for each owned Non-Negative Joker 

[X] Magic: Start with the Counterfeit Ink and 2 copies of Misprinted Fool 

[ ] Nebula: At the start of every Boss Blind, create up to 5 Negative Misprinted Planet Cards 

[ ] Ghost: Spectral cards may appear in the shop and has a high chance to be Misprinted, 
start with a random Common Joker and Misprinted Wraith (Feli, i think Misprinted Wraith is not working as intended) 

[X] Abandoned: Start run with no Numbered/Face/Aces Cards in your deck (maybe changes each Ante?) 

[X] Checkered: Bad Director's Jokers are now 4X more common, start with 52 Hearts in Deck 

[ ] Zodiac: Voucher ideas from Feli (+1 Voucher/Booster slot, etc) 

[ ] Painted: Selling/Destroying a Joker has a low chance to Increase Hand Size permanently 

[ ] Anaglyph: All Skip Tags are Escort Tag, Tag requirements are decreased 

[ ] Plasma: Each chips and mutt are randomized between X1 X3 /Either unbalance or balance between 50-200% 

[ ] Erratic: Ranks and Suits are randomized after playing a hand 
]]--
BadDirector.MisprintedDecks.b_red = {
	apply = function(self)
		G.E_MANAGER:add_event(Event{
			func = function ()
				local tag = Tag("bd_charm")
				tag:set_ability()
				add_tag(tag)
			end
		})
	end,
	config = {
		hands = 10
	}
}

BadDirector.MisprintedDecks.b_blue = {}
BadDirector.MisprintedDecks.b_black = {}
BadDirector.MisprintedDecks.b_yellow = {
	apply = function(self, back)
		local hermit = (pseudorandom("b_yellow_hermit",1,5) == 1) and "c_bd_herprint" or "c_hermit"
		local temperance = (pseudorandom("b_yellow_temperance",1,5) == 1) and "c_bd_temprint" or "c_temperance"
        local consumables = {hermit, temperance}
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, consumable_key in ipairs(consumables) do
                    SMODS.add_card({ key = consumable_key })
                end
                return true
            end
        }))
    end,
	calculate = function(self,back,context)
		if context.ante_change and context.ante_end then
			local hermit = (pseudorandom("b_yellow_hermit",1,5) == 1) and "c_bd_herprint" or "c_hermit"
			local temperance = (pseudorandom("b_yellow_temperance",1,5) == 1) and "c_bd_temprint" or "c_temperance"
			local consumables = {hermit, temperance}
			delay(0.4)
			G.E_MANAGER:add_event(Event({
				func = function()
					for _, consumable_key in ipairs(consumables) do
						SMODS.add_card({ key = consumable_key })
					end
					return true
				end
			}))
		end
	end



}

BadDirector.MisprintedDecks.b_magic = {
	apply = function(self, back)
        G.GAME.used_vouchers[v_bd_counterfeitink] = true
        G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
        G.E_MANAGER:add_event(Event({ -- Adding back objects of any type from a deck MUST be done within an event
            func = function()
                Card.apply_to_run(nil, G.P_CENTERS[self.config.voucher])
                return true
            end
        }))

        -- Apply the consumables
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, consumable_key in ipairs(self.config.consumables) do
                    SMODS.add_card({ key = consumable_key })
                end
                return true
            end
        }))
    end,
	config = {
		consumables = {"c_bd_foolprint","c_bd_foolprint"}
	}
}

BadDirector.MisprintedDecks.b_checkered = {
	apply = function(self)
		G.E_MANAGER:add_event(Event({
            func = function()
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card.base.suit == 'Diamonds' or playing_card.base.suit == 'Clubs' or playing_card.base.suit == 'Spades' then
                        playing_card:change_suit('Hearts')
                    end
                end
                return true
            end
        }))
	end,
	config = {
	}
}

BadDirector.MisprintedDecks.b_abandoned = {
	apply = function(self)
		G.E_MANAGER:add_event(Event({
            func = function()
				local roll = pseudorandom("b_abandoned_misprint",1,3)
				local even = pseudorandom("b_abandoned_misprint55",0,1)
                for _, playing_card in ipairs(G.playing_cards) do
					if roll == 1 then
						if playing_card:is_face() then
							SMODS.destroy_cards({playing_card})
						end
					elseif roll == 2 then
						if playing_card.base.value == "Ace" then
							SMODS.destroy_cards({playing_card})
						end
					else
						if not playing_card:is_face() and playing_card.base.nominal % 2 == even then
							SMODS.destroy_cards({playing_card})
						end
					end
                end
                return true
            end
        }))
	end,
	config = {
	}
}