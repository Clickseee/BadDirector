BadDirector = BadDirector or {}
BadDirector.power_fuse_active = false

SMODS.Sound {
    key = "bd_powerout",
    path = "fnaf_poweroutage.ogg",
    volume = 1
} 

SMODS.ScreenShader {
    key = "flashlight",

    path = "flashlight.fs",

    should_apply = function(self)
        return BadDirector.power_fuse_active
    end,

    send_vars = function(self)
        return {
            center_pos = {love.mouse.getX(), love.mouse.getY()},
            dist = 225
        }
    end
}

local function remakeSign(power_off)
    if G.SHOP_SIGN then
        G.SHOP_SIGN:remove()
    end

    local atlas = power_off
        and G.ASSET_ATLAS['bd_shopsign']
        or G.ANIMATION_ATLAS['shop_sign']

    local shop_sign = AnimatedSprite(0, 0, 4.4, 2.2, atlas)

    shop_sign:define_draw_steps({
        {shader = 'dissolve', shadow_height = 0.05},
        {shader = 'dissolve'}
    })

    G.SHOP_SIGN = UIBox{
        definition = {
            n = G.UIT.ROOT,
            config = {
                colour = G.C.DYN_UI.MAIN,
                emboss = 0.05,
                align = 'cm',
                r = 0.1,
                padding = 0.1
            },
            nodes = {
                {
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        padding = 0.1,
                        minw = 4.72,
                        minh = 3.1,
                        colour = G.C.DYN_UI.DARK,
                        r = 0.1
                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = {align = "cm"},
                            nodes = {
                                {n = G.UIT.O, config = {object = shop_sign}}
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = {align = "cm"},
                            nodes = {
                                {
                                    n = G.UIT.O,
                                    config = {
                                        object = DynaText({
                                            string = {localize('ph_improve_run')},
                                            colours = {lighten(G.C.GOLD, 0.3)},
                                            shadow = true,
                                            rotate = true,
                                            float = true,
                                            bump = true,
                                            scale = 0.5,
                                            spacing = 1,
                                            pop_in = 1.5,
                                            maxw = 4.3
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        config = {
            align = "cm",
            offset = {x = 0, y = -15},
            major = G.HUD:get_UIE_by_ID('row_blind'),
            bond = 'Weak'
        }
    }

    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            G.SHOP_SIGN.alignment.offset.y = 0
            return true
        end
    }))
end

SMODS.Joker {
    key = "powerfuse",
    rarity = 1,
    atlas = "fuses",
    coder = { "Nxkoo" },
    artist = {"Le Ginger"},
    pos = { x = 0, y = 0 },
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {
        "xmult",
        "passive",
        "scaling"
    },

    config = {
        extra = {
            xmult = 4,
            awareness = 0
        },
        power = {
            is_active = false,
        },
    },

    update = function(self,card,dt)
        if BadDirector.power_fuse_active == true then
            Blind:change_colour(HEX('000000')) -- Blind box
	        ease_background_colour{new_colour = HEX('000000')}
            G.jokers.config.highlighted_limit = 99999
        end
    end,
    load = function(self, card, card_table, other_card)
        G.E_MANAGER:add_event(Event({
			func = function() 
                if card.ability.power.is_active == true then
                    BadDirector.power_fuse_active = true
                    play_sound('bd_powerout', 1, 1)
					if (G.SHOP_SIGN) then
						G.E_MANAGER:add_event(Event({
							func = function() 
								remakeSign(true)
								return true 
							end
						}))
					end
                end
			    return true 
			end
		}))
        
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.awareness
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.power.is_active = true
        BadDirector.power_fuse_active = true
        if (G.SHOP_SIGN) then
			G.E_MANAGER:add_event(Event({
				func = function() 
					remakeSign(true)
					return true 
				end
			}))
		end
        play_sound('bd_powerout', 1, 1)
    end,

    remove_from_deck = function(self, card, from_debuff)
        BadDirector.power_fuse_active = false
        play_sound("bd_poweron",1,1)
        if (G.SHOP_SIGN) then
			G.E_MANAGER:add_event(Event({
				func = function() 
					remakeSign(false)
					return true 
				end
			}))
		end
        local function getState()
            for name, id in pairs(G.STATES) do
                if id == G.STATE then
                    return G.STATES[name]
                end
            end
        end


	    ease_background_colour_blind{getState()}
    end,

    calculate = function(self, card, context)

        if (context.starting_shop 
        or context.buying_self) 
        and (BadDirector.power_fuse_active == true or card.ability.power.is_active == true) then
			G.E_MANAGER:add_event(Event({
				func = function() 
					remakeSign(true)
					return true 
				end
			}))
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.end_of_round
        and not context.individual
        and not context.repetition then

            card.ability.extra.awareness =
                card.ability.extra.awareness + 1

            return {
                message = "+1",
                colour = G.C.DARK_EDITION
            }
        end
    end,
    in_pool = function(self, args)
        return args and (args.source == "buf" or args.source == "bd_buf")
    end
}
