BadDirector = BadDirector or {}
BadDirector.CREDITS = {}

BadDirector.CREDITS.roles = {
    artist   = "Art by",
    coder    = "Code by",
    partner = "Married with",
}

--[[
EXAMPLE = {
    name = "Chud",
    artist = {"Soy"},
    coder = {"Fish"},
}
]]

function BadDirector.CREDITS.make_row(title, names, role)

    if type(names) ~= "table" or #names == 0 then return end

    local text_row = {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {}
    }

    table.insert(text_row.nodes, {
        n = G.UIT.T,
        config = {
            text = title .. " ",
            scale = 0.27,
            colour = G.C.UI.TEXT_LIGHT,
            shadow = true
        }
    })

    for i, name in ipairs(names) do

        table.insert(text_row.nodes, {
            n = G.UIT.O,
            config = {
                object = DynaText({
                    string = tostring(name),
                    colours = { G.C.UI.TEXT_LIGHT },
                    scale = 0.27,
                    silent = true,
                    shadow = true,
                    y_offset = -0.6
                })
            }
        })

        if i < #names then

            local sep = (i == #names - 1) and " and " or ", "

            table.insert(text_row.nodes, {
                n = G.UIT.T,
                config = {
                    text = sep,
                    scale = 0.27,
                    colour = G.C.UI.TEXT_LIGHT,
                    shadow = true
                }
            })
        end
    end


    local panel_colour = G.C.UI.BACKGROUND_INACTIVE

    if role == "artist" then
        panel_colour = G.C.PEAK
    elseif role == "coder" then
        panel_colour = G.C.BLUE
    elseif role == "designer" then
        panel_colour = G.C.GREEN
    elseif role == "music" then
        panel_colour = G.C.PURPLE
    end


    return {
        n = G.UIT.C,
        config = {
            align = "cm",
            colour = panel_colour,
            padding = 0.06,
            r = 0.12
        },
        nodes = {
            text_row
        }
    }
end



function BadDirector.CREDITS.build(center)
    if not center then return end

    local block = {
        n = G.UIT.R,
        config = { align = "tm" },
        nodes = {}
    }

    for field, title in pairs(BadDirector.CREDITS.roles) do

        local data = center[field]

        if type(data) == "string" then
            data = { data }
        end

        if type(data) == "table" then

            local row = BadDirector.CREDITS.make_row(title, data)

            if row then
                table.insert(block.nodes, row)
            end
        end
    end

    if #block.nodes == 0 then
        return
    end

    return block
end


local BD_old_card_popup = G.UIDEF.card_h_popup

function G.UIDEF.card_h_popup(card)

    local ret = BD_old_card_popup(card)

    local center = card and card.config and card.config.center

    if not center then
        return ret
    end

    local target = ret.nodes
        and ret.nodes[1]
        and ret.nodes[1].nodes
        and ret.nodes[1].nodes[1]
        and ret.nodes[1].nodes[1].nodes

    if not target then
        return ret
    end

    local credits = BadDirector.CREDITS.build(center)

    if credits then
        table.insert(target, credits)
    end

    return ret
end
