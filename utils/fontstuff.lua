SMODS.Font {
    key = "isaac",
    path = "upheavtt.ttf",
    render_scale = 128,
    TEXT_HEIGHT_SCALE = 1,
    TEXT_OFFSET = { x = 0, y = 0 },
    FONTSCALE = 0.23,
    squish = 1,
    DESCSCALE = 1
}

SMODS.Font {
    key = "p03font",
    path = "DAGGERSQUARE.ttf",
    render_scale = 95,
    TEXT_HEIGHT_SCALE = 1,
    TEXT_OFFSET = { x = 0, y = 0 },
    FONTSCALE = 0.17,
    squish = 1,
    DESCSCALE = 1
}

local dyslexia_cache = {}

local function mutate_word(word)
    if #word <= 3 then
        return word
    end

    local chars = {}

    for i = 1, #word do
        chars[i] = word:sub(i, i)
    end

    local mode = pseudorandom("dyslexia_mode", 1, 4)

    if mode == 1 then
        local i = pseudorandom("swap", 2, #chars - 2)
        chars[i], chars[i + 1] = chars[i + 1], chars[i]
    elseif mode == 2 then
        local i = pseudorandom("duplicate", 2, #chars - 1)
        table.insert(chars, i, chars[i])
    elseif mode == 3 then
        local i = pseudorandom("remove", 2, #chars - 1)
        table.remove(chars, i)
    elseif mode == 4 then
        local i = pseudorandom("drift", 2, #chars - 2)
        chars[i], chars[i + 2] = chars[i + 2], chars[i]
    end

    return table.concat(chars)
end

local function dyslexia_text(text)
    local result = {}

    for word, spaces in text:gmatch("(%S+)(%s*)") do
        if pseudorandom("mutate_word", 1, 100) <= 35 then
            word = mutate_word(word)
        end

        result[#result + 1] = word .. spaces
    end

    return table.concat(result)
end

SMODS.DynaTextEffect {
    key = "dyslexia",

    func = function(dynatext, index, letter)
        if not dynatext.dyslexia_data then
            dynatext.dyslexia_data = {
                timer = 0,
                original = dynatext.string,
                current = dynatext.string
            }
        end

        local data = dynatext.dyslexia_data

        data.timer = data.timer + G.real_dt

        if data.timer > 0.8 then
            data.timer = 0
            data.current = dyslexia_text(data.original)
        end

        local char = data.current:sub(index, index)

        if char == "" then
            char = " "
        end

        letter.letter = love.graphics.newText(
            dynatext.font.FONT,
            char
        )
    end
}

local funny_str = "!\"#$%&'()+-*,./\\:;<=>?[]^_~"
local font_cache = {}
SMODS.DynaTextEffect { -- Haya stuff, fuck them (jk) but i like this code
    key = "glitching",
    func = function(dynatext, index, letter)
        if not letter.normal_letter then
            letter.normal_letter = letter.letter
        end
        local st = pseudorandom('skip_' .. index, 1, #funny_str)
        local rnd = string.sub(funny_str, st, st + 1)
        font_cache[dynatext.font.key or dynatext.font.file] = font_cache[dynatext.font.key or dynatext.font.file] or {}
        font_cache[dynatext.font.key or dynatext.font.file][rnd] = font_cache[dynatext.font.key or dynatext.font.file]
            [rnd] or love.graphics.newText(dynatext.font.FONT, rnd)
        --print(rnd)
        letter.letter = font_cache[dynatext.font.key or dynatext.font.file][rnd]
    end
}
