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

local funny_str = "!\"#$%&'()+-*,./\\:;<=>?[]^_~"
local font_cache = {}
SMODS.DynaTextEffect { -- Haya stuff, fuck them (jk) but i like this code
	key = "glitching",
	func = function(dynatext, index, letter)
		if not letter.normal_letter then
			letter.normal_letter = letter.letter
		end
		local st = pseudorandom('skip_'..index, 1, #funny_str)
		local rnd = string.sub(funny_str, st, st+1)
		font_cache[dynatext.font.key or dynatext.font.file] = font_cache[dynatext.font.key or dynatext.font.file] or {}
		font_cache[dynatext.font.key or dynatext.font.file][rnd] = font_cache[dynatext.font.key or dynatext.font.file][rnd] or love.graphics.newText(dynatext.font.FONT, rnd)
		--print(rnd)
		letter.letter = font_cache[dynatext.font.key or dynatext.font.file][rnd]
  end
}