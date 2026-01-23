--#region this fucking sucks, death to Talisman, CDATAMAN RULES GRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHH

to_big = to_big or function(n)
    return n
end

to_number = to_number or function(n)
    return n
end

--#endregion

--#region MISC STUFF

BadDirector = SMODS.current_mod

local upath = SMODS.current_mod.path .. 'utils/'
for _, v in pairs(NFS.getDirectoryItems(upath)) do
    assert(SMODS.load_file('utils/' .. v))()
end

BadDirector.optional_features = {
    cardareas = {},
    retrigger_joker = true,
    post_trigger = true
}

local jpath = SMODS.current_mod.path .. 'jokers/'
for _, v in pairs(NFS.getDirectoryItems(jpath)) do
    assert(SMODS.load_file('jokers/' .. v))()
end

local dpath = SMODS.current_mod.path .. 'decks/'
for _, v in pairs(NFS.getDirectoryItems(dpath)) do
    assert(SMODS.load_file('decks/' .. v))()
end

local cpath = SMODS.current_mod.path .. 'consumables/'
for _, v in pairs(NFS.getDirectoryItems(cpath)) do
    assert(SMODS.load_file('consumables/' .. v))()
end

SMODS.Atlas {
    key = "modicon",
    path = "modicon.png",
    px = 34,
    py = 34,
}

SMODS.Atlas {
    key = "modlogo",
    path = "modlogo.png",
    px = 258,
    py = 194,
}

SMODS.Atlas { -- ALL ARTS BELONG TO RATTLINGSNOW353 WITH PERMISSION
    key = "rattlingsnow",
    path = "rattling.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "nxkooselfinsert",
    path = "nxkoo.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "rubyselfinsert",
    path = "lordruby.png",
    px = 71,
    py = 95,
}

SMODS.Atlas {
    key = "nickselfinsert",
    path = "incognito.png",
    px = 71,
    py = 95,
}

SMODS.Joker {
    key = "nxkoojoker",
    rarity = 4,
    atlas = "nxkooselfinsert",
    pos = { x = 0, y = 0 },
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end
}

SMODS.Joker {
    key = "rubyjoker",
    rarity = 4,
    atlas = "rubyselfinsert",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end
}

SMODS.Joker {
    key = "nickjoker",
    rarity = 4,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 0, y = 1 },
    atlas = "nickselfinsert",
    cost = 666,
    no_collection = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    in_pool = function(self, args)
        return false
    end
}

local rotta_gradient = SMODS.Gradient({
    key = "rotta",
    colours = {
        HEX("ffe5b4"),
        HEX("dab772"),
        HEX("a58547"),
        HEX("4f6367"),
    },
    cycle = 2,
})

SMODS.ConsumableType({
    key = "mistarot",
    collection_rows = { 5, 6 },
    primary_colour = G.C.SECONDARY_SET.Tarot,
    secondary_colour = rotta_gradient,
    default = "c_bd_foolprint",
    cards = {},
    shop_rate = 4
})

local netpla_gradient = SMODS.Gradient({
    key = "netpla",
    colours = {
        HEX("dff5fc"),
        HEX("84c5d2"),
        HEX("5b9baa"),
        HEX("4f6367"),
    },
    cycle = 2,
})

SMODS.ConsumableType({
    key = "misplanet",
    collection_rows = { 6, 6 },
    primary_colour = G.C.SECONDARY_SET.Planet,
    secondary_colour = netpla_gradient,
    default = "c_bd_mercprint",
    cards = {},
    shop_rate = 4
})

local ralspect_gradient = SMODS.Gradient({
    key = "ralspect",
    colours = {
        HEX("638fe1"),
        HEX("5b7fc1"),
        HEX("4e5779"),
        HEX("5e7297"),
        HEX("96aacb"),
        HEX("bfc7d5"),
        HEX("e2ebf9"),
    },
    cycle = 2,
})

SMODS.ConsumableType({
    key = "mispectral",
    collection_rows = { 4, 5 },
    primary_colour = G.C.SECONDARY_SET.Spectral,
    secondary_colour = ralspect_gradient,
    default = "c_bd_familiarprint",
    cards = {},
})

--#endregion

--#region Mod Desc

function G.FUNCS.bad_director_wiki(e)
    love.system.openURL("The url of your wiki here")
end
function G.FUNCS.bad_director_other_link(e)
    love.system.openURL("https://nxkoo.straw.page/")
end

BadDirector.description_loc_vars = function()
    return {
        text_colour = G.C.WHITE,
        background_colour = G.C.CLEAR,
        scale = 1
    }
end

SMODS.current_mod.custom_ui = function(nodes)
    local logo = {

        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = { 0, 0, 0, 0 },
            r = 0.3,
            padding = 0.25
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = SMODS.create_sprite(
                                0, 0,
                                6.5, 4.5,
                                'bd_modlogo',
                                { x = 0, y = 0 }
                            )
                        }
                    }
                }
            }
        }
    }

    table.insert(nodes, 2, logo)

        nodes[#nodes + 1] = {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.05 },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    UIBox_button({
                        button = "bad_director_wiki",
                        label = { localize("b_bad_director_wiki") },
                        minw = 4.75,
                        colour = G.C.RED
                    }),
                },
            },
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    UIBox_button({
                        button = "bad_director_other_link",
                        label = { localize("b_bad_director_other") },
                        minw = 4.75,
                        colour = G.C.RED
                    }),
                },
            },
        },
    }

    return nodes
end

BadDirector.extra_tabs = function()
    return {
        {
            label = "Credits",
            tab_definition_function = function()
                local jokers = {
                    { key = "j_bd_nxkoojoker",        text = "Nxkoo" },
                    { key = "j_bd_nickjoker", text = "IncognitoN71" },
                    { key = "j_bd_rubyjoker",  text = "lord.ruby" },
                }

                local columns = {}

                for _, v in ipairs(jokers) do
                    local area = CardArea(
                        G.ROOM.T.x, G.ROOM.T.y,
                        G.CARD_W,
                        G.CARD_H,
                        { card_limit = 1, type = 'title', highlight_limit = 0, collection = true }
                    )

                    local card = Card(
                        area.T.x, area.T.y,
                        G.CARD_W, G.CARD_H,
                        G.P_CARDS.empty,
                        G.P_CENTERS[v.key]
                    )

                    card.no_ui = true

                    area:emplace(card)

                    columns[#columns + 1] = {
                        n = G.UIT.C,
                        config = { align = "cm", padding = 0.1 },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0.02 },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = {
                                            text = "{C:edition,E:1,s:2}Special Thanks to:",
                                            scale = 0.35,
                                            colour = G.C.UI.TEXT_LIGHT,
                                            shadow = true
                                        }
                                    }
                                }
                            }
                        },
                        n = G.UIT.C,
                        config = { align = "cm", padding = 0.1 },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0.05 },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = {
                                            text = v.text,
                                            scale = 0.45,
                                            colour = G.C.UI.TEXT_LIGHT,
                                            shadow = true
                                        }
                                    }
                                }
                            },
                            {
                                n = G.UIT.R,
                                config = { align = "cm" },
                                nodes = {
                                    { n = G.UIT.O, config = { object = area } }
                                }
                            }
                        }
                    }
                end

                return {
                    n = G.UIT.ROOT,
                    config = { align = "cm", padding = 0.2 },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = {
                                align = "cm",
                                colour = G.C.L_BLACK,
                                r = 0.2,
                                padding = 0.2
                            },
                            nodes = columns
                        }
                    }
                }
            end
        }
    }
end

SMODS.current_mod.ui_config = {
    author_colour = ralspect_gradient,
    tab_button_colour = G.C.BLACK,
    back_colour = G.C.BLACK,
    bg_colour = adjust_alpha(G.C.BLACK, 0.95),
    colour = darken(G.C.BLACK, .2),
    outline_colour = lighten(G.C.BLACK, .2),
}


--#endregion

--#region SHADER

SMODS.Shader {
    key = "thermal",
    path = "thermals.fs"
}

SMODS.Shader {
    key = "colorsplash",
    path = "colorsplashes.fs"
}

SMODS.Shader {
    key = "xrays",
    path = "xray.fs"
}

SMODS.Shader {
    key = "blueprints",
    path = "blueprint.fs"
}


SMODS.Edition {
    key = "heat",
    order = 1,
    loc_txt = {
        name = "Thermal",
        label = "Thermal",
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
    shader = "thermal",
    in_shop = true,
    extra_cost = 3,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Edition {
    key = "disco",
    order = 2,
    loc_txt = {
        name = "Colorsplash",
        label = "Colorsplash",
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
    shader = "colorsplash",
    in_shop = true,
    extra_cost = 3,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Edition {
    key = "spooky",
    order = 3,
    loc_txt = {
        name = "X-Ray",
        label = "X-Ray",
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
    shader = "xrays",
    in_shop = true,
    extra_cost = 3,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Edition {
    key = "copier",
    order = 3,
    loc_txt = {
        name = '"Blueprint"?',
        label = '"Blueprint"?',
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
    shader = "blueprints",
    in_shop = true,
    extra_cost = 3,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}
