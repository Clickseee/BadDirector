BadDirector.STATE = BadDirector.STATE or {}
BadDirector.credit_page = BadDirector.credit_page or 1

function G.FUNCS.bad_director_wiki(e)
    love.system.openURL("The url of your wiki here")
end

function G.FUNCS.bad_director_other_link(e)
    love.system.openURL("https://nxkoo.straw.page/")
end

G.FUNCS.open_bad_director = function()
    if G.bad_director then return end

    G.bad_director = UIBox {
        definition = BadDirector:create_UIBox(),
        config = {
            align = "cm",
            major = G.ROOM_ATTACH
        }
    }

    G.bad_director:align_to_major()
end


G.FUNCS.reload_bad_director = function()
    if G.bad_director then
        G.bad_director:remove()
        G.bad_director = nil
        G.FUNCS.open_bad_director()
    end
end

G.FUNCS.bd_switch_tab = function(e)
    local i = e.config.tab_index
    if not i then return end

    BadDirector.active_tab = i

    G.FUNCS.reload_bad_director()
end

G.FUNCS.bd_prev_credit_page = function(e)
    BadDirector.credit_page =
        math.max(1, (BadDirector.credit_page or 1) - 1)

    G.FUNCS.reload_bad_director()
    local element = G.OVERLAY_MENU:get_UIE_by_ID("tab_but_Credits")
	G.FUNCS.change_tab(element)
end

BadDirector.contributors = {
    { key = "j_bd_nxkoojoker", text = "Nxkoo" },
    { key = "j_bd_nickjoker",  text = "IncognitoN71" },
    { key = "j_bd_rubyjoker",  text = "lord.ruby" },
    { key = "j_bd_nhjoker",  text = "Nh6574" },
    { key = "j_bd_thunderjoker",  text = "ThunderEdge" },
}
BadDirector.PER_PAGE = 3

G.FUNCS.bd_next_credit_page = function(e)
    local max_page = math.max(1,
        math.ceil(#BadDirector.contributors / BadDirector.PER_PAGE)
    )
    BadDirector.credit_page =
        math.min(max_page, (BadDirector.credit_page or 1) + 1)
    G.FUNCS.reload_bad_director()
    local element = G.OVERLAY_MENU:get_UIE_by_ID("tab_but_Credits")
	G.FUNCS.change_tab(element)
end



function BadDirector:create_UIBox()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm" },
        nodes = {
            {
                n = G.UIT.R,
                nodes = {
                    { n = G.UIT.T, config = { text = "Credits" } }
                }
            }
        }
    }
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
end

SMODS.Sound {
    key = "woof1",
    path = "woof1.ogg",
    volume = 1.5
}
SMODS.Sound {
    key = "woof2",
    path = "woof2.ogg",
    volume = 1.5
}
SMODS.Sound {
    key = "woof3",
    path = "woof3.ogg",
    volume = 1.5
}

local card_click_ref = Card.click
function Card:click(...)
    if self.config.center.key == "j_bd_rubyjoker" and G.SETTINGS.paused then
        play_sound(pseudorandom_element({
            "bd_woof1",
            "bd_woof2",
            "bd_woof3",
        }, pseudoseed("bd_ruby_woof")))
    else
        if self.config.center.key == "j_bd_nhjoker" and G.SETTINGS.paused then
            love.system.openURL("https://github.com/nh6574/JoyousSpring")
        else
            return card_click_ref(self, ...)
        end
    end
end

BadDirector.extra_tabs = function()
    return {
        {
            label = "Credits",
            tab_definition_function = function()
                local PER_PAGE = BadDirector.PER_PAGE
                local contributors = BadDirector.contributors

                local max_page = math.max(1, math.ceil(#contributors / PER_PAGE))

                BadDirector.credit_page = math.min(max_page, math.max(1, BadDirector.credit_page))

                BadDirector.credit_page = BadDirector.credit_page or 1

                local function get_page(list, page, per_page)
                    per_page = per_page or 1

                    local t = {}

                    local start = (page - 1) * per_page + 1
                    local stop = math.min(#list, start + per_page - 1)

                    for i = start, stop do
                        t[#t + 1] = list[i]
                    end

                    return t
                end




                local columns = {}

                local page_data = get_page(contributors, BadDirector.credit_page, PER_PAGE)

                for _, v in ipairs(page_data) do
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
                    config = { align = "cm", padding = 0.2, r = 0.1, colour = G.C.BLACK },
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
                        },


                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.15 },
                            nodes = {
                                {
                                    n = G.UIT.C,
                                    config = {
                                        align = "cm",
                                        minw = 1,
                                        button = "bd_prev_credit_page",
                                        colour = G.C.L_BLACK,
                                        r = 0.1,
                                        padding = 0.1,
                                        emboss = 0.05,
                                        hover = true,
                                        shadow = true,
                                    },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "< Prev",
                                                scale = 0.4,
                                                colour = G.C.UI.TEXT_LIGHT,
                                                padding = 0.1
                                            }
                                        },
                                    }
                                },
                                {
                                    n = G.UIT.C,
                                    config = {
                                        align = "cm",
                                        minw = 1,
                                        button = "bd_next_credit_page",
                                        colour = G.C.L_BLACK,
                                        r = 0.1,
                                        padding = 0.1,
                                        emboss = 0.05,
                                        hover = true,
                                        shadow = true,
                                    },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = BadDirector.credit_page .. " / " .. max_page,
                                                scale = 0.4,
                                                colour = G.C.UI.TEXT_LIGHT,
                                                padding = 0.1
                                            }
                                        },
                                    }
                                },
                                {
                                    n = G.UIT.C,
                                    config = {
                                        align = "cm",
                                        minw = 1,
                                        button = "bd_next_credit_page",
                                        colour = G.C.L_BLACK,
                                        r = 0.1,
                                        padding = 0.1,
                                        emboss = 0.05,
                                        hover = true,
                                        shadow = true,
                                    },
                                    nodes = {
                                        {
                                            n = G.UIT.T,
                                            config = {
                                                text = "Next >",
                                                scale = 0.4,
                                                colour = G.C.UI.TEXT_LIGHT,
                                                padding = 0.1
                                            }
                                        },
                                    }
                                },
                            }
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
