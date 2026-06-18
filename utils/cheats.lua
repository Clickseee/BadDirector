G.nxkoo_cheats = G.nxkoo_cheats or {
    buffer = "",
    controller_buffer = "",
    max_length = 64,

    image = nil,
    sound = nil,

    show_popup = false,
    popup_alpha = 0,
    popup_timer = 0,

    path = SMODS.current_mod.path,

    codes = {}
}

SMODS.Sound {
    key = "cheat",
    path = "cheatactivated.ogg"
}

do
    local full_path =
        G.nxkoo_cheats.path ..
        "assets/customimages/cheat.png"

    local file_data = assert(NFS.newFileData(full_path))
    local image_data = assert(love.image.newImageData(file_data))

    G.nxkoo_cheats.image =
        love.graphics.newImage(image_data)
end

local function trigger_cheat_popup()

    G.nxkoo_cheats.show_popup = true
    G.nxkoo_cheats.popup_alpha = 1
    G.nxkoo_cheats.popup_timer = 3

    play_sound("bd_cheat", 1, 1)

end

local function register_cheat(code, func)

    G.nxkoo_cheats.codes[string.upper(code)] = func

end

local function process_controller_cheat(token)

    G.nxkoo_cheats.controller_buffer =
        G.nxkoo_cheats.controller_buffer .. token

    for cheat, sequence in pairs(controller_cheats) do

        if string.find(
            G.nxkoo_cheats.controller_buffer,
            sequence,
            1,
            true
        ) then

            G.nxkoo_cheats.codes[cheat]()

            G.nxkoo_cheats.controller_buffer = ""

            break
        end
    end
end

local controller_cheats = {
    RICHGETRICHER = "uuddlrlrba",
    LETSGOGAMBLING = "abab",
    GREATESTOFALLTIME = "lb_rblb_rb",
}

local controller_button_press_update_ref =
    Controller.button_press_update

function Controller:button_press_update(button, dt)

    local map = {
        dpup = "u",
        dpdown = "d",
        dpleft = "l",
        dpright = "r",

        a = "a",
        b = "b",

        leftshoulder = "lb",
        rightshoulder = "rb",
    }

    if map[button] then
        process_controller_cheat(map[button])
    end

    return controller_button_press_update_ref(
        self,
        button,
        dt
    )
end



-- LIST OF THE CHEATS, FUCK YOU FOR READING THIS

register_cheat("RUBYCRIMSONFANG", function()

    local destroyed_cards = {}

    for _, card in ipairs(G.playing_cards) do
        if card:is_suit("Hearts") then
            destroyed_cards[#destroyed_cards+1] = card
        end
    end

    SMODS.destroy_cards(destroyed_cards)

    trigger_cheat_popup()

end)

register_cheat("FUCKTHISGAME", function()

    error("Yeah well, Fuck you too.")

    trigger_cheat_popup()

end)

register_cheat("RAISETHEEDITION", function()

    for _, joker in ipairs(G.jokers.cards) do

        if not joker.edition then
            joker:set_edition({
                foil = true
            }, true, true)

        elseif joker.edition.foil then
            joker:set_edition({
                holographic = true
            }, true, true)

        elseif joker.edition.holographic then
            joker:set_edition({
                polychrome = true
            }, true, true)
        end
    end

    trigger_cheat_popup()

end)

register_cheat("MIDASTOUCH", function()

    for _, card in ipairs(G.playing_cards) do
        card:set_ability(G.P_CENTERS.m_gold)
    end

    trigger_cheat_popup()

end)

register_cheat("OHNOOURTABLE", function()

    for _, card in ipairs(G.playing_cards) do
        card:set_ability(G.P_CENTERS.m_glass)
    end

    trigger_cheat_popup()

end)

register_cheat("GREATESTOFALLTIME", function()

    SMODS.add_card{
        set = "Joker",
        rarity = 4
    }

    trigger_cheat_popup()

end)

register_cheat("WORMHOLE", function()

    for k, _ in pairs(G.GAME.hands) do
        SMODS.smart_level_up_hand(nil, k, nil, 5)
    end

    trigger_cheat_popup()

end)

register_cheat("PRIDEMONTH", function()

    for _, card in ipairs(G.playing_cards) do
        card:set_edition({
            polychrome = true
        }, true, true)
    end

    trigger_cheat_popup()

end)

register_cheat("YOURESONEGATIVE", function()

    for _, joker in ipairs(G.jokers.cards) do

        joker:set_edition(
            {
                negative = true
            },
            true,
            true
        )

    end

    trigger_cheat_popup()

end)

register_cheat("RICHGETRICHER", function()

    ease_dollars(100)

    trigger_cheat_popup()

end)

register_cheat("LETSGOGAMBLING", function()

    SMODS.add_card {
        set = "Joker"
    }

    trigger_cheat_popup()

end)

local function process_cheat_key(key)

    key = string.upper(key)

    G.nxkoo_cheats.buffer =
        G.nxkoo_cheats.buffer .. key

    if #G.nxkoo_cheats.buffer >
       G.nxkoo_cheats.max_length then

        G.nxkoo_cheats.buffer =
            string.sub(
                G.nxkoo_cheats.buffer,
                -G.nxkoo_cheats.max_length
            )

    end

    for code, func in pairs(G.nxkoo_cheats.codes) do

        if string.find(
            G.nxkoo_cheats.buffer,
            code,
            1,
            true
        ) then

            func()

            G.nxkoo_cheats.buffer = ""

            break

        end
    end
end

for _, key in ipairs({
    "a","b","c","d","e","f","g",
    "h","i","j","k","l","m","n",
    "o","p","q","r","s","t","u",
    "v","w","x","y","z"
}) do

    SMODS.Keybind {
        key = "cheat_" .. key,
        key_pressed = key,

        action = function()

            process_cheat_key(key)

        end
    }

end

local updatehook = Game.update

function Game:update(dt)

    updatehook(self, dt)

    if G.nxkoo_cheats.show_popup then

        G.nxkoo_cheats.popup_timer =
            G.nxkoo_cheats.popup_timer - dt

        if G.nxkoo_cheats.popup_timer <= 0 then

            G.nxkoo_cheats.popup_alpha =
                G.nxkoo_cheats.popup_alpha - dt

            if G.nxkoo_cheats.popup_alpha <= 0 then

                G.nxkoo_cheats.popup_alpha = 0
                G.nxkoo_cheats.show_popup = false

            end
        end
    end
end

local drawhook = love.draw

function love.draw()

    drawhook()

    if not G.nxkoo_cheats.show_popup then
        return
    end

    local img = G.nxkoo_cheats.image

    if not img then
        return
    end

    local sw = love.graphics.getWidth()
local sh = love.graphics.getHeight()

local sx = sw / img:getWidth()
local sy = sh / img:getHeight()

love.graphics.setColor(
    1,
    1,
    1,
    G.nxkoo_cheats.popup_alpha
)

love.graphics.draw(
    img,
    0,
    0,
    0,
    sx,
    sy
)

love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setColor(
        1,
        1,
        1,
        1
    )
end