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