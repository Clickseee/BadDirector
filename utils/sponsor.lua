--- @class BadDirector.Sponsor: SMODS.Voucher
BadDirector.Sponsor = SMODS.Voucher:extend {
	unlocked = true,
	discovered = false,
	pos = { x = 0, y = 0 },
	atlas = "Voucher",
	cost = 8,
	set = 'bd_Sponsor',
	config = {},
	class_prefix = 'spon',
	required_params = {
		'key',
	},
	in_pool = function (self, args)
		return true, {allow_duplicates = true}
	end,
	set_card_type_badge = function(self, card, badges)
		badges[#badges + 1] = create_badge(localize("k_bd_sponsor"), G.C.BLACK, G.C.WHITE, 1.2)
	end,
	inject = function(self)
		-- call the parent function to ensure all pools are set
		-- don't call the voucher one though, we are just using voucher for its redeem code and shader
		G.P_CENTER_POOLS.bd_Sponsor = G.P_CENTER_POOLS.bd_Sponsor or {}
		SMODS.Center.inject(self)
	end,
}
G.C.SET.bd_Sponsor = G.C.BLACK
G.C.SECONDARY_SET.bd_Sponsor = G.C.BLACK

local cfbshook = G.FUNCS.check_for_buy_space
---@diagnostic disable-next-line: duplicate-set-field
function G.FUNCS.check_for_buy_space(card)
	if card.ability.set == 'bd_Sponsor' then
		return true
	end
	return cfbshook(card)
end

local card_redeem_ref = Card.redeem
---@diagnostic disable-next-line: duplicate-set-field
function Card:redeem()
    if self.ability.set == "bd_Sponsor" then
        stop_use()
        if not self.config.center.discovered then
            discover_card(self.config.center)
        end
        G.STATE = G.STATES.SMODS_REDEEM_VOUCHER
				--- @type Card
				local _copy = copy_card(self)
				_copy.states.visible = false -- hide card while its moving
				G.bd_sponsor_area:emplace(_copy)
				G.E_MANAGER:add_event(Event{func = function() _copy.states.visible = true; return true end})

        self.states.hover.can = false
        local top_dynatext = nil
        local bot_dynatext = nil
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                top_dynatext = DynaText({string = localize{type = 'name_text', set = self.config.center.set, key = self.config.center.key}, colours = {G.C.WHITE}, rotate = 1,shadow = true, bump = true,float=true, scale = 0.9, pop_in = 0.6/G.SPEEDFACTOR, pop_in_rate = 1.5*G.SPEEDFACTOR})
                bot_dynatext = DynaText({string = localize('k_bd_signed_ex'), colours = {G.C.WHITE}, rotate = 2,shadow = true, bump = true,float=true, scale = 0.9, pop_in = 1.4/G.SPEEDFACTOR, pop_in_rate = 1.5*G.SPEEDFACTOR, pitch_shift = 0.25})
                self:juice_up(0.3, 0.5)
                play_sound('card1')
                play_sound('coin1')
                self.children.top_disp = UIBox{
                    definition =    {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
                                        {n=G.UIT.O, config={object = top_dynatext}}
                                    }},
                    config = {align="tm", offset = {x=0,y=0},parent = self}
                }
                self.children.bot_disp = UIBox{
                        definition =    {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
                                            {n=G.UIT.O, config={object = bot_dynatext}}
                                        }},
                        config = {align="bm", offset = {x=0,y=0},parent = self}
                    }
            return true end }))
        if self.cost ~= 0 then
            ease_dollars(-self.cost)
            inc_career_stat('c_shop_dollars_spent', self.cost)
        end
        set_voucher_usage(self)
        self.config.center.redeem(self, self)
        delay(0.6)
        SMODS.calculate_context({buying_card = true, card = self})
        if G.GAME.modifiers.inflation then 
            G.GAME.inflation = G.GAME.inflation + 1
            G.E_MANAGER:add_event(Event({func = function()
              for k, v in pairs(G.I.CARD) do
                  if v.set_cost then v:set_cost() end
              end
              return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 2.6, func = function()
---@diagnostic disable-next-line: need-check-nil, need-check-nil, undefined-field
            top_dynatext:pop_out(4)
---@diagnostic disable-next-line: need-check-nil, need-check-nil, undefined-field
            bot_dynatext:pop_out(4)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
            self.children.top_disp:remove()
            self.children.top_disp = nil
            self.children.bot_disp:remove()
            self.children.bot_disp = nil
        return true end }))
		else
			return card_redeem_ref(self)
		end
end

function BadDirector.custom_card_areas(game)
	game.bd_sponsor_area = CardArea(
		G.ROOM.T.w + 5, G.ROOM.T.y,
		game.CARD_W, game.CARD_H,
		{
			card_limit = 10,
			type = "vouchers",
			card_count = false,
		}
	)
end
--[[
SMODS.UndiscoveredSprite {
	key = 'bd_Sponsor',
	--atlas = 'sponsors',
	pos = { x = 0, y = 0 },
}
SMODS.UndiscoveredCompat.bd_Sponsor = true
]]

function BadDirector.custom_collection_tabs()
	local tally = 0
	for _, v in pairs(G.P_CENTER_POOLS.bd_Sponsor) do
		tally = tally + (v.discovered and 1 or 0)
	end
	return { UIBox_button {
		button = "bd_your_collection_sponsors",
		label = { localize("b_bd_sponsors") },
		count = { tally = tally, of = #G.P_CENTER_POOLS.bd_Sponsor },
		minw = 5,
		id = "bd_your_collection_sponsors"
	} }
end

function G.UIDEF.bd_create_UIBox_your_collection_sponsors()
	local pool = {}
	for k, v in pairs(G.P_CENTER_POOLS.bd_Sponsor) do
		if not v.no_collection then pool[#pool + 1] = v end
	end
	return SMODS.card_collection_UIBox(pool, { 5, 5, 5 }, {
		no_materialize = true,
		h_mod = 0.95,
	})
end

function G.FUNCS.bd_your_collection_sponsors(e)
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu {
		definition = G.UIDEF.bd_create_UIBox_your_collection_sponsors(),
	}
end