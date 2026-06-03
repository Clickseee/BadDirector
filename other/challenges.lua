-- im challenging it


-- this implementation is a tad scuffed but it still works ;w;
function BadDirector.banned_cards_heartless()
    local ret = {}
    local pool = SMODS.get_attribute_pool("hearts")
    for i=1, #pool do
        table.insert(ret, { id = pool[i] })
    end
    table.insert(ret, { id = 'j_bd_fakepromises' })
    table.insert(ret, { id = 'j_bd_heartbreak' })
    table.insert(ret, { id = 'j_bd_heartburn' })
    table.insert(ret, { id = 'j_bd_hopelessromantic' })
    table.insert(ret, { id = 'j_bd_lovebomb' })
    table.insert(ret, { id = 'j_bd_lovesick' })
    table.insert(ret, { id = 'j_bd_newlove' })
    table.insert(ret, { id = 'j_bd_propinquity' })
    table.insert(ret, { id = 'j_bd_redflag' })
    table.insert(ret, { id = 'j_bd_silenttreatment' })
    table.insert(ret, { id = 'j_bd_suicide' })
    table.insert(ret, { id = 'j_bd_traumabonding' })
    table.insert(ret, { id = 'c_sun' })
    table.insert(ret, { id = 'c_sigil' })
    -- for some godforsaken reason the challenges ui did not like me trying to apply the heart attribute BD jokers through this loop
    -- like here it just deadass doesn't work??????
    -- i tried a few methods but it Did Not Cooperate soooo
    -- i decided to just manually add them :sob:
    return ret
end

function BadDirector.banned_cards_oops()
    local ret = {}
    local pool = SMODS.get_attribute_pool("tarot")
    for i=1, #pool do
        table.insert(ret, { id = pool[i] })
    end
    local pool = SMODS.get_attribute_pool("planet")
    for i=1, #pool do
        table.insert(ret, { id = pool[i] })
    end
    local pool = SMODS.get_attribute_pool("spectral")
    for i=1, #pool do
        table.insert(ret, { id = pool[i] })
    end
    table.insert(ret, { id = 'j_bd_fakepromises' })
    table.insert(ret, { id = 'j_bd_propinquity' })
    local ret2 = {}
    for k, v in ipairs(G.P_CENTER_POOLS.Consumeables) do
        table.insert(ret2, v)
    end
    for i=1, #ret2 do
        if ret2[i].set == "Tarot" then
            table.insert(ret, { id = ret2[i].key })
        end
    end
    for i=1, #ret2 do
        if ret2[i].set == "Planet" then
            table.insert(ret, { id = ret2[i].key })
        end
    end
    table.insert(ret, { id = 'p_arcana_normal_1', ids = {
        'p_arcana_normal_1', 'p_arcana_normal_2', 'p_arcana_normal_3', 'p_arcana_normal_4', 'p_arcana_jumbo_1', 'p_arcana_jumbo_2', 'p_arcana_mega_1', 'p_arcana_mega_2',
    }})
    table.insert(ret, { id = 'p_celestial_normal_1', ids = {
        'p_celestial_normal_1', 'p_celestial_normal_2', 'p_celestial_normal_3', 'p_celestial_normal_4', 'p_celestial_jumbo_1', 'p_celestial_jumbo_2', 'p_celestial_mega_1', 'p_celestial_mega_2',
    }})
    table.insert(ret, { id = 'p_spectral_normal_1', ids = {
        'p_spectral_normal_1', 'p_spectral_normal_2', 'p_spectral_jumbo_1', 'p_spectral_mega_1',
    }})
    table.insert(ret, { id = 'v_planet_merchant' })
    table.insert(ret, { id = 'v_planet_tycoon' })
    table.insert(ret, { id = 'v_tarot_merchant' })
    table.insert(ret, { id = 'v_tarot_tycoon' })
    -- did the EXACT same thing with modded consumables???????? 
    return ret
end

SMODS.Challenge {
    key = "heartless",
    restrictions = {
        banned_cards = BadDirector.banned_cards_heartless(),
        banned_tags = {
            { id = 'tag_boss' }
        },
        banned_other = {
            { id = 'bl_head', type = 'blind'}
        }
    },
    deck = {
        type = 'Challenge Deck',
        no_suits = { H = true }
    }
}

SMODS.Challenge {
    key = "oops",
    restrictions = {
        banned_cards = BadDirector.banned_cards_oops(),
        banned_tags = {
            { id = 'tag_meteor' },
            { id = 'tag_charm' },
            { id = 'tag_ethereal' },
        },
    },
    deck = {
        type = 'Challenge Deck',
        edition = "bd_misprinted"
    },
    calculate = function(self, context)
        G.GAME.planet_rate = 0
        G.GAME.tarot_rate = 0
    end

}

-- i may have yoinked this from maximus, thanks astra
local skipHook = create_UIBox_blind_tag
create_UIBox_blind_tag = function(blind_choice, run_info)
    if not G.GAME.challenge and G.GAME.challenge == "c_bd_genocide" then
        return skipHook(blind_choice, run_info)
    end
end

SMODS.Challenge {
    key = "genocide",
    restrictions = {
        banned_other = {
            { id = 'bl_wall', type = 'blind'}
        }
    },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(-2)
                SMODS.change_booster_limit(-2)
                return true
            end
        }))
    end,
    calculate = function(self, context)
        G.GAME.blind.chips = 300
        --if G.shop_vouchers.cards then
            --G.shop_vouchers.cards:remove()
        --end
    end

}