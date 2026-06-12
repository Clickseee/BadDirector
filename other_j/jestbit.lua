G.lolbit_event = G.lolbit_event or {
    enabled = false,
    active = false,
    owner = nil,
    progress = "",
    sequence = "jk",
    next_spawn = 0,
    image = nil,
    sound = nil,
    path = SMODS.current_mod.path
}

--[[
SMODS.Sound {
    key = "lolbit_spawn",
    path = "lolbitspawn.ogg"
}
]]

do
    local full_path = G.lolbit_event.path .. "assets/customimages/lolbit.png"
    local file_data = assert(NFS.newFileData(full_path))
    local image_data = assert(love.image.newImageData(file_data))

    G.lolbit_event.image = love.graphics.newImage(image_data)
    --[[
    G.lolbit_event.sound = love.audio.newSource(
        G.lolbit_event.path .. "assets/sounds/lolbitloop.ogg",
        "stream"
    )

    G.lolbit_event.sound:setLooping(true)
    ]]
end

local function schedule_next_lolbit()
    G.lolbit_event.next_spawn =
        G.TIMERS.REAL + pseudorandom("lolbit_spawn", 15, 45)
end

local updatehook = Game.update
local lolbit_check_timer = 0

function Game:update(dt)
    updatehook(self, dt)

    if not G.lolbit_event.enabled then
        return
    end

    lolbit_check_timer = lolbit_check_timer + dt

    if lolbit_check_timer >= 1 then
        lolbit_check_timer = 0

        if not G.lolbit_event.active
        and G.TIMERS.REAL >= G.lolbit_event.next_spawn then

            G.lolbit_event.active = true
            G.lolbit_event.progress = ""

            play_sound("lolbit_spawn", 1, 1)

            if G.lolbit_event.sound then
                G.lolbit_event.sound:stop()
                G.lolbit_event.sound:play()
            end
        end
    end
end

SMODS.Keybind {
    key = "lolbit_j",
    key_pressed = "j",

    action = function(self)
        if not G.lolbit_event.active then
            return
        end

        if G.lolbit_event.progress == "" then
            G.lolbit_event.progress = "j"
        else
            G.lolbit_event.progress = ""
        end
    end
}

SMODS.Keybind {
    key = "lolbit_k",
    key_pressed = "k",

    action = function(self)
        if not G.lolbit_event.active then
            return
        end

        if G.lolbit_event.progress ~= "j" then
            G.lolbit_event.progress = ""
            return
        end

        local owner = G.lolbit_event.owner

        if owner
        and owner.ability
        and owner.ability.extra then

            owner.ability.extra.xmult =
                owner.ability.extra.xmult +
                owner.ability.extra.gain

            card_eval_status_text(
                owner,
                "extra",
                nil,
                nil,
                nil,
                {
                    message = "X+" ..
                        tostring(owner.ability.extra.gain),
                    colour = G.C.MULT
                }
            )
        end

        G.lolbit_event.active = false
        G.lolbit_event.progress = ""

        if G.lolbit_event.sound then
            G.lolbit_event.sound:stop()
        end

        schedule_next_lolbit()
    end
}

local drawhook = love.draw

function love.draw()
    drawhook()

    if not G.lolbit_event.active then
        return
    end

    local img = G.lolbit_event.image

    if not img then
        return
    end

    local w, h =
        love.graphics.getWidth(),
        love.graphics.getHeight()

    local sx = w / img:getWidth()
    local sy = h / img:getHeight()

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(img, 0, 0, 0, sx, sy)
end

SMODS.Joker {
    key = "jestbit",

    config = {
        extra = {
            xmult = 1,
            gain = 0.5
        }
    },

    rarity = 2,
    cost = 5,

    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    atlas = "misprintenhanced",
    coder = { "Nxkoo" },
    pos = { x = 1, y = 0 },
    pools = {["BadDirector_Jokers"] = true, ["FNAF"] = true, },
    attributes = {
        'xmult',
        'joker',
        'scaling'
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {
            key = 'bd_jestbit_info',
            set = 'Other'
        }
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.gain
            }
        }
    end,

    remove_from_deck = function(self, card, from_debuff)
        if G.lolbit_event.owner == card then

            G.lolbit_event.enabled = false
            G.lolbit_event.active = false
            G.lolbit_event.owner = nil
            G.lolbit_event.progress = ""

            if G.lolbit_event.sound then
                G.lolbit_event.sound:stop()
            end
        end
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}