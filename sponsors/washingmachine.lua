BadDirector.Sponsor{
	key = "john",
    atlas = "sponsors",
    coder = { "Foo54", "squeax09" },
    artist = {"squeax09"},
    pos = { x = 2, y = 0 },
    config = { extra = { kromer = 3 }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.extra.kromer
            }
        }
    end,
	redeem = function (self, voucher)
		if not G.GAME.used_sponsors then G.GAME.used_sponsors = {} end
		G.GAME.used_sponsors.spon_bd_john = true
		G.GAME.used_sponsors.last_used = "spon_bd_john"
        local cards = 0
        for i=1, #G.playing_cards do
            if not SMODS.has_enhancement(G.playing_cards[i], 'c_base') then
                G.playing_cards[i]:set_ability('c_base', nil, true)
                cards = cards + 1
            end
        end
        ease_dollars(voucher.ability.extra.kromer * cards)
	end
}

do
    local full_path = SMODS.current_mod.path .. "assets/customimages/spon_john.png"
    local file_data = assert(NFS.newFileData(full_path))
    local image_data = assert(love.image.newImageData(file_data))
    G.sponsor_images.spon_bd_john.image = love.graphics.newImage(image_data)
end

local drawhook = love.draw
function love.draw()
    drawhook()
    if G.GAME.used_sponsors and G.GAME.used_sponsors.spon_bd_john then
        local w, h = love.graphics.getWidth(), love.graphics.getHeight()
        local img = G.sponsor_images.spon_bd_john.image
        local _xscale = w / img:getWidth()
        local _yscale = h / img:getHeight()
		if G.GAME.used_sponsors.last_used == "spon_bd_john" then
        	love.graphics.setColor(1, 1, 1, 1)
		else
			love.graphics.setColor(1, 1, 1, 0.2)
		end
        love.graphics.draw(img, 0, 0, 0, _xscale, _yscale)
    end
end