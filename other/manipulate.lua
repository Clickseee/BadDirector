if Cryptid then 
	return
end

BadDirector.base_values = {}

BadDirector.misprintize_value_blacklist = {
	perish_tally = false,
	id = false,
	suit_nominal = false,
	base_nominal = false,
	face_nominal = false,
	qty = false,
	h_x_chips = false,
	d_size = false,
	h_size = false,
	selected_d6_face = false,
	cry_hook_id = false,
	colour = false,
	suit_nominal_original = false,
	times_played = false,
	extra_slots_used = false,
	card_limit = false,
	-- TARGET: Misprintize Value Blacklist (format: key = false, )
}
BadDirector.misprintize_bignum_blacklist = {
	odds = false,
	cry_prob = false,
	perma_repetitions = false,
	repetitions = false,
	nominal = false, --no clue why this was commented, it causes a crash if not
}
BadDirector.misprintize_value_cap = { --yeahh.. this is mostly just for retriggers, but i might as well make it fully functional
	perma_repetitions = 40,
	repetitions = 40,
}

function BadDirector.log_random(seed, min, max)
	math.randomseed(seed)
	local lmin = math.log(min, 2.718281828459045)
	local lmax = math.log(max, 2.718281828459045)
	local poll = math.random() * (lmax - lmin) + lmin
	return math.exp(poll)
end
function cry_format(number, str)
	if math.abs(to_big(number)) >= to_big(1e300) then
		return number
	end
	return tonumber(str:format((Big and to_number(to_big(number)) or number)))
end
--use ID to work with glitched/misprint
function Card:get_nominal(mod)
	local mult = 1
	local rank_mult = 1
	if mod == "suit" then
		mult = 1000000
	end
	if self.ability.effect == "Stone Card" or (self.config.center.no_suit and self.config.center.no_rank) then
		mult = -10000
	elseif self.config.center.no_suit then
		mult = 0
	elseif self.config.center.no_rank then
		rank_mult = 0
	end
	return 10 * (self.base.id or 0.1) * rank_mult
		+ self.base.suit_nominal * mult
		+ (self.base.suit_nominal_original or 0) * 0.0001 * mult
		+ 10 * self.base.face_nominal * rank_mult
		+ 0.000001 * self.unique_val
end

function BadDirector.manipulate(card, args)
	if not card or not card.config or not card.config.center then return end
	if not Card.no(card, "immutable", true) or (args and args.bypass_checks) then
		if not args then
			return BadDirector.manipulate(card, {
				min = (G.GAME.modifiers.cry_misprint_min or 1),
				max = (G.GAME.modifiers.cry_misprint_max or 1),
				type = "X",
				dont_stack = true,
				no_deck_effects = true,
			})
		else
			local func = function(card)
				if not args.type then
					args.type = "X"
				end
				--hardcoded whatever
				if card.config.center.set == "Booster" then
					args.big = false
				end
				local caps = card.config.center.misprintize_caps or {}
				if card.infinifusion then
					if card.config.center == card.infinifusion_center or card.config.center.key == "j_infus_fused" then
						calculate_infinifusion(card, nil, function(i)
							BadDirector.manipulate(card, args)
						end)
					end
				end
				BadDirector.manipulate_table(card, card, "ability", args)
				if card.base then
					BadDirector.manipulate_table(card, card, "base", args)
				end
				if G.GAME.modifiers.cry_misprint_min then
					card.misprint_cost_fac = 1
						/ BadDirector.log_random(
							pseudoseed("bd_misprint" .. G.GAME.round_resets.ante),
							override and override.min,
							override and override.max
						)
					card:set_cost()
				end
				if caps then
					for i, v in pairs(caps) do
						if BadDirector.is_big(v) then
							for i2, v2 in pairs(v) do
								if to_big(card.ability[i][i2]) > to_big(v2) then
									card.ability[i][i2] = BadDirector.sanity_check(v2, BadDirector.is_card_big(card))
								end
							end
						elseif BadDirector.is_number(v) then
							if to_big(card.ability[i]) > to_big(v) then
								card.ability[i] = BadDirector.sanity_check(v, BadDirector.is_card_big(card))
							end
						end
					end
				end
			end
			local config = copy_table(card.config.center.config)
			if not BadDirector.base_values[card.config.center.key] then
				BadDirector.base_values[card.config.center.key] = {}
				for i, v in pairs(config) do
					if BadDirector.is_number(v) and to_big(v) ~= to_big(0) then
						BadDirector.base_values[card.config.center.key][i .. "ability"] = v
					elseif type(v) == "table" then
						for i2, v2 in pairs(v) do
							BadDirector.base_values[card.config.center.key][i2 .. i] = v2
						end
					end
				end
			end
			if not args.bypass_checks and not args.no_deck_effects then
				BadDirector.with_deck_effects(card, func)
			else
				func(card)
			end
			if card.ability.consumeable then
				for k, v in pairs(card.ability.consumeable) do
					card.ability.consumeable[k] = BadDirector.deep_copy(card.ability[k])
				end
			end
			--ew ew ew ew
			G.P_CENTERS[card.config.center.key].config = config
		end
		return true
	end
end

function BadDirector.manipulate_table(card, ref_table, ref_value, args, tblkey)
	if ref_value == "consumeable" then
		return
	end
	for i, v in pairs(ref_table[ref_value]) do
		if
			BadDirector.is_number(v)
			and BadDirector.misprintize_value_blacklist[i] ~= false
		then
			local num = v
			if args.dont_stack then
				if
					BadDirector.base_values[card.config.center.key]
					and (
						BadDirector.base_values[card.config.center.key][i .. ref_value]
						or (ref_value == "ability" and BadDirector.base_values[card.config.center.key][i .. "consumeable"])
					)
				then
					num = BadDirector.base_values[card.config.center.key][i .. ref_value]
						or BadDirector.base_values[card.config.center.key][i .. "consumeable"]
				end
			end
			if args.big ~= nil then
				ref_table[ref_value][i] = BadDirector.manipulate_value(num, args, args.big, i)
			else
				ref_table[ref_value][i] = BadDirector.manipulate_value(num, args, BadDirector.is_card_big(card), i)
			end
		elseif i ~= "immutable" and type(v) == "table" and BadDirector.misprintize_value_blacklist[i] ~= false then
			BadDirector.manipulate_table(card, ref_table[ref_value], i, args)
		end
	end
end

function BadDirector.manipulate_value(num, args, is_big, name)
	if not BadDirector.is_number(num) then return end
	if args.func then
		num = args.func(num, args, is_big, name)
	else
		if args.min and args.max then
			local new_args = args
			local big_min = to_big(args.min)
			local big_max = to_big(args.max)
			local new_value = BadDirector.log_random(
				pseudoseed(args.seed or ("cry_misprint" .. G.GAME.round_resets.ante)),
				big_min,
				big_max
			)
			if args.type == "+" then
				if to_big(num) ~= to_big(0) and to_big(num) ~= to_big(1) then
					num = num + new_value
				end
			elseif args.type == "X" then
				if
					to_big(num) ~= to_big(0) and (to_big(num) ~= to_big(1) or (name ~= "x_chips" and name ~= "x_mult"))
				then
					num = num * new_value
				end
			elseif args.type == "^" then
				num = to_big(num) ^ new_value
			elseif args.type == "hyper" and SMODS.Mods.Talisman and SMODS.Mods.Talisman.can_load then
				if to_big(num) ~= to_big(0) and to_big(num) ~= to_big(1) then
					num = to_big(num):arrow(args.value.arrows, to_big(new_value))
				end
			end
		elseif args.value then
			if args.type == "+" then
				if to_big(num) ~= to_big(0) and to_big(num) ~= to_big(1) then
					num = num + to_big(args.value)
				end
			elseif args.type == "X" then
				if
					to_big(num) ~= to_big(0) and (to_big(num) ~= to_big(1) or (name ~= "x_chips" and name ~= "x_mult"))
				then
					num = num * args.value
				end
			elseif args.type == "^" then
				num = to_big(num) ^ args.value
			elseif args.type == "hyper" and SMODS.Mods.Talisman and SMODS.Mods.Talisman.can_load then
				num = to_big(num):arrow(args.value.arrows, to_big(args.value.height))
			end
		end
	end
	if BadDirector.misprintize_value_cap[name] then
		num = math.min(num, BadDirector.misprintize_value_cap[name])
	end
	if BadDirector.misprintize_bignum_blacklist[name] == false then
		num = to_number(num)
		return to_number(BadDirector.sanity_check(num, false))
	end
	local val = BadDirector.sanity_check(num, is_big)
	if to_big(val) > to_big(-1e100) and to_big(val) < to_big(1e100) then
		return to_number(val)
	end
	return val
end

local get_nominalref = Card.get_nominal
function Card:get_nominal(...)
	return to_number(get_nominalref(self, ...))
end

local gsr = Game.start_run
function Game:start_run(args)
	gsr(self, args)
	BadDirector.base_values = {}
end

function BadDirector.sanity_check(val, is_big)
	if not Talisman then return val end
	if is_big then
		if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
			val = 1e300
		end
		if BadDirector.is_big(val) then
			return val
		end
		if val > 1e100 or val < -1e100 then
			return to_big(val)
		end
	end
	if not val or type(val) == "number" and (val ~= val or val > 1e300 or val < -1e300) then
		return 1e300
	end
	if BadDirector.is_big(val) then
		if val > to_big(1e300) then
			return 1e300
		end
		if val < to_big(-1e300) then
			return -1e300
		end
		return to_number(val)
	end
	return val
end

-- Check G.GAME as well as joker info for banned keys
function Card:no(m, no_no)
	if no_no then
		-- Infinifusion Compat
		if self.infinifusion then
			for i = 1, #self.infinifusion do
				if
					G.P_CENTERS[self.infinifusion[i].key][m]
					or (G.GAME and G.GAME[m] and G.GAME[m][self.infinifusion[i].key])
				then
					return true
				end
			end
			return false
		end
		if not self.config then
			--assume this is from one component of infinifusion
			return G.P_CENTERS[self.key][m] or (G.GAME and G.GAME[m] and G.GAME[m][self.key])
		end

		return self.config.center[m] or (G.GAME and G.GAME[m] and G.GAME[m][self.config.center_key]) or false
	end
	return Card.no(self, "no_" .. m, true)
end

function BadDirector.no(center, m, key, no_no)
	if no_no then
		return center[m] or (G.GAME and G.GAME[m] and G.GAME[m][key]) or false
	end
	return BadDirector.no(center, "no_" .. m, key, true)
end