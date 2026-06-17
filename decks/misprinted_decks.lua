---@diagnostic disable: undefined-field
BadDirector.MisprintedDecks = {}

local back_apply_to_run_ref = Back.apply_to_run
function Back:apply_to_run()
	local self_in_use = self
	if BadDirector.do_misprint_deck then
		local key = self.effect.center.key
		if BadDirector.MisprintedDecks[key] then
			self_in_use = {
				effect = {
					center = { apply = self.effect.center.apply },
					config = self.effect.config
				}
			}
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

local back_trigger_effect_ref = Back.trigger_effect
function Back:trigger_effect(args, ...)
	local ret = back_trigger_effect_ref(self, args, ...)
	if BadDirector.mem_deck_name then
		self.name = BadDirector.mem_deck_name
		BadDirector.mem_deck_name = nil
	end
	return ret
end

--[[
function Back:trigger_effect(args)
	if not args then do return end
	local obj = self.effect.center
	
	if type(obj.calculate) == 'function' then
		local o = {obj:calculate(self,args)}
		if next(o) ~= nil then return unpack(o) end
	elseif type(obj.trigger_effect) == 'function' then
		
		local o = {obj:trigger_effect(args)}
		if next(o) ~= nil then
			sendWarnMessage(('Found `trigger_effect` function'))
				return unpack(o)
			end
		end
	end
end
]] --
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
	
	[F] Red: Discarding a hand has a medium chance to not use any Discards
	
	[F] Blue: Playing a hand has a very low chance to increase Hand Size permanently
	
	[F] Yellow: Create The Hermit and Temperance at the start of every Ante, medium chance to be Misprinted
	
	[F] Green: Interests are randomized each Ante, only gains Hands/Discards rewards after every Boss Blind
	
	[f] Black: Negative Edition is 5X more common, -1 Hand for each owned Non-Negative Joker
	
	[F] Magic: Start with the Counterfeit Ink and 2 copies of Misprinted Fool
	
	[F] Nebula: At the start of every Boss Blind, create up to 5 Negative Misprinted Planet Cards
	
	[F] Ghost: Spectral cards may appear in the shop and has a high chance to be Misprinted,
	start with a random Common Joker and Misprinted Wraith (Feli, i think Misprinted Wraith is not working as intended --- Its fixed, darling.)
	
	[F] Abandoned: Start run with no Numbered/Face/Aces Cards in your deck (maybe changes each Ante?)
	
	[F] Checkered: Bad Director's Jokers are now 4X more common, start with 52 Hearts in Deck
	
	[F] Zodiac: Voucher ideas from Feli (+1 Voucher/Booster slot, etc)
	
	[f] Painted: Selling/Destroying a Joker has a low chance to Increase Hand Size permanently
	
	[F] Anaglyph: All Skip Tags are Escort Tag
	
	[F] Plasma: Each chips and mutt are randomized between X1 X3 / Either unbalance or balance between 50-200%
	
	[F] Erratic: Ranks and Suits are randomized after playing a hand
	
	[X] Missing : Cycle Jokers (when?)
	]] --


BadDirector.MisprintedDecks.b_red = {
	calculate = function(self, back, context)
		if context.pre_discard and not context.hook then
			G.E_MANAGER:add_event(Event({
				func = function()
					if pseudorandom("bd_red_misprt", 1, 3) == 1 then
						play_sound('bd_inapmit')
						ease_discard(1, nil, true)
					end
					return true
				end
			}))
		end
	end
}

BadDirector.MisprintedDecks.b_blue = {

	calculate = function(self, back, context)
		if context.press_play then
			G.E_MANAGER:add_event(Event({
				func = function()
					if pseudorandom("bd_blue_misprt", 1, 7) == 1 then
						play_sound('bd_inapmit')
						G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
						ease_hands_played(1)
					end
					return true
				end
			}))
		end
	end

}
BadDirector.MisprintedDecks.b_painted = {

	calculate = function(self, back, context)
		if ((context.selling_card or context.joker_type_destroyed) and context.card.ability.set == "Joker") then
			G.E_MANAGER:add_event(Event({
				func = function()
					if pseudorandom("bd_blue_misprt", 1, 5) == 1 then
						play_sound('bd_inapmit')
						G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
						ease_hands_played(1)
					end
					return true
				end
			}))
		end
	end

}

BadDirector.MisprintedDecks.b_green = {

	calculate = function(self, back, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.interest_amount = (pseudorandom("bd_blue_misprt", 5, 30) / 10)
					return true
				end
			}))
			if G.GAME.last_blind and G.GAME.last_blind.boss then
				G.GAME.modifiers.money_per_hand = 2
				G.GAME.modifiers.money_per_discard = 1
			else
				G.GAME.modifiers.money_per_hand = 0
				G.GAME.modifiers.money_per_discard = 0
			end
		end
	end


}

BadDirector.MisprintedDecks.b_black = {
	calculate = function(self, back, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({
				func = function()
					for i, joker in ipairs(G.jokers.cards) do
						if (joker.edition and joker.edition.key ~= "e_negative") or joker.edition == nil then
							BadDirector.MisprintedDecks.b_black.config.count = BadDirector.MisprintedDecks.b_black
							.config.count + 1
						end
					end
					if BadDirector.MisprintedDecks.b_black.config.count > 0 then
						G.GAME.round_resets.hands = G.GAME.round_resets.hands -
						BadDirector.MisprintedDecks.b_black.config.count
						ease_hands_played(-BadDirector.MisprintedDecks.b_black.config.count)
						play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
					end

					return true
				end
			}))
		end
		if context.blind_defeated then
			G.E_MANAGER:add_event(Event({
				func = function()
					if BadDirector.MisprintedDecks.b_black.config.count > 0 then
						G.GAME.round_resets.hands = G.GAME.round_resets.hands +
						BadDirector.MisprintedDecks.b_black.config.count
						ease_hands_played(BadDirector.MisprintedDecks.b_black.config.count)
						play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
					end
					BadDirector.MisprintedDecks.b_black.config.count = 0
					return true
				end
			}))
		end
		if context.modify_shop_card and
			(context.card.ability.set == 'Joker') then -- is a playing card
			if pseudorandom('bd_black', 1, 9) <= 2 then
				context.card:set_edition("e_negative")
			end
		end
	end,
	config = {
		count = 0
	}
}

BadDirector.MisprintedDecks.b_yellow = {
	apply = function(self, back)
		local hermit = (pseudorandom("b_yellow_hermit", 1, 3) == 1) and "c_bd_herprint" or "c_hermit"
		local temperance = (pseudorandom("b_yellow_temperance", 1, 3) == 1) and "c_bd_temprint" or "c_temperance"
		local consumables = { hermit, temperance }
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
	calculate = function(self, back, context)
		if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
			local hermit = (pseudorandom("b_yellow_hermit", 1, 3) == 1) and "c_bd_herprint" or "c_hermit"
			local temperance = (pseudorandom("b_yellow_temperance", 1, 3) == 1) and "c_bd_temprint" or "c_temperance"
			local consumables = { hermit, temperance }
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

BadDirector.MisprintedDecks.b_anaglyph = {
	calculate = function(self, back, context)
		if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag({ key = 'tag_bd_escort' })
					play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
					play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
					return true
				end
			}))
		end
	end
}
BadDirector.MisprintedDecks.b_nebula = {
	calculate = function(self, back, context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({
				func = function()
					for i = 1, pseudorandom("bd_nebula", 1, 5) do
						SMODS.add_card({ set = "misplanet", edition = "e_negative" })
					end

					return true
				end
			}))
		end
	end
}

BadDirector.MisprintedDecks.b_magic = {
	apply = function(self, back)
		G.E_MANAGER:add_event(Event({ -- Adding back objects of any type from a deck MUST be done within an event
			func = function()
				G.GAME.used_vouchers["v_bd_counterfeitink"] = true
				G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
				Card.apply_to_run(nil, G.P_CENTERS["v_bd_counterfeitink"])
				return true
			end
		}))

		-- Apply the consumables
		delay(0.4)
		G.E_MANAGER:add_event(Event({
			func = function()
				SMODS.add_card({ key = "c_bd_foolprint" })
				SMODS.add_card({ key = "c_bd_foolprint" })
				return true
			end
		}))
	end,
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

BadDirector.MisprintedDecks.b_zodiac = {
	apply = function(self, back)
		for _, voucher_key in pairs(BadDirector.MisprintedDecks.b_zodiac.config.vouchers) do
			G.GAME.used_vouchers[voucher_key] = true
			G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
			G.E_MANAGER:add_event(Event({
				func = function()
					Card.apply_to_run(nil, G.P_CENTERS[voucher_key])
					return true
				end
			}))
		end
	end,
	config = { vouchers = { 'v_bd_gacha_addiction', 'v_bd_coupon_collector', 'v_overstock_norm' } },
}

BadDirector.MisprintedDecks.b_ghost = {
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.spectral_rate = 0.3
				G.GAME.mispectral_rate = 0.2
				SMODS.add_card({ set = "Joker", rarity = "Common" })
				SMODS.add_card({ key = "c_bd_wrathprint" })
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
				local roll = pseudorandom("b_abandoned_misprint", 1, 3)
				local even = pseudorandom("b_abandoned_misprint55", 0, 1)
				for _, playing_card in ipairs(G.playing_cards) do
					if roll == 1 then
						if playing_card:is_face() then
							SMODS.destroy_cards({ playing_card })
						end
					elseif roll == 2 then
						if playing_card.base.value == "Ace" then
							SMODS.destroy_cards({ playing_card })
						end
					else
						if not playing_card:is_face() and playing_card.base.nominal % 2 == even then
							SMODS.destroy_cards({ playing_card })
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

BadDirector.MisprintedDecks.b_bd_missingdeck = {
	calculate = function(self, back, context)
		if context.hand_drawn then
			local replace_table = {}
			for k, v in pairs(G.jokers.cards) do
				replace_table[#replace_table + 1] = v
				v:juice_up()
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					if #G.jokers.cards > 0 then
						BadDirector.replacecards(replace_table, nil, nil, true)
						play_sound('timpani')
					end
					return true
				end
			}))
		end
	end
}

BadDirector.MisprintedDecks.b_erratic = {
	calculate = function(self, back, context)
		if context.hand_drawn then
			G.E_MANAGER:add_event(Event({
				func = function()
					for k, v in pairs(G.playing_cards) do
						local suit = pseudorandom_element(SMODS.Suits, pseudoseed('suit'))
						local rank = pseudorandom_element(SMODS.Ranks, pseudoseed('rank'))
						SMODS.change_base(v, suit.key, rank.key)
						v:juice_up(0.25, 0.3)
					end
					play_sound("timpani", 1, 1)
					return true
				end
			}))
		end
	end
}
SMODS.Back:take_ownership("b_plasma") {
    pos = { x = 4, y = 2 },
    config = { ante_scaling = 2 },
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.ante_scaling } }
    end,
    calculate = function(self, back, context)
        if context.final_scoring_step then
            return {
                balance = true
            }
        end
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.starting_params.ante_scaling = self.config.ante_scaling
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize { type = 'name_text', set = 'Stake', key = 'stake_blue' },
                colours = { get_stake_col(5) }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 5
    end
}


BadDirector.MisprintedDecks.b_plasma = {
	config = { ante_scaling = 2 },
	apply = function(self, back)
		G.GAME.starting_params.ante_scaling = BadDirector.MisprintedDecks.b_plasma.config.ante_scaling
	end,
	calculate = function(self, back, context)
		if context.initial_scoring_step then
			BadDirector.MisprintedDecks.b_plasma.config = pseudorandom("coinflip", 1, 2)
			if BadDirector.MisprintedDecks.b_plasma.config == 1 then -- unbalance taken from toga
				local chipsmulttogether = (mult + hand_chips) * ((pseudorandom("unbalance", 15, 30) / 10) or 1)
				local rndperc = pseudorandom(pseudoseed('unbalance'), 1, 100) / 100
				local pchips, pmult = chipsmulttogether * rndperc, chipsmulttogether * (1 - rndperc)
				hand_chips = mod_chips(pchips)
				mult = mod_mult(pmult)
				update_hand_text({ delay = 0 }, { chips = hand_chips, mult = mult })
				G.E_MANAGER:add_event(Event({
					func = (function()
						play_sound('gong', 0.33 + math.random(-1, 1) / 10, 0.4)
						play_sound('gong', 0.66 + math.random(-1, 1) / 10, 0.3)
						play_sound('tarot1', 0.94)
						ease_colour(G.C.UI_CHIPS, { 0.8, 0.45, 0.85, 1 })
						ease_colour(G.C.UI_MULT, { 0.8, 0.45, 0.85, 1 })
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							blockable = false,
							blocking = false,
							delay = 0.8,
							func = (function()
								ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
								ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
								return true
							end)
						}))
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							blockable = false,
							blocking = false,
							no_delete = true,
							delay = 1.3,
							func = (function()
								G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1],
									G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
								G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2],
									G.C.RED[3], G.C.RED[4]
								return true
							end)
						}))
						return true
					end)
				}))
				delay(0.6)
			end
		end
		if context.final_scoring_step then
			if BadDirector.MisprintedDecks.b_plasma.config == 2 then
				return { balance = true }
			end
		end
	end
}
