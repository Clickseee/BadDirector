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
    -- so i decided to just manually add them :sob:
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