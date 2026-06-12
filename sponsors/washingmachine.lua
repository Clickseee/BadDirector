BadDirector.Sponsor{
	key = "john",
	redeem = function (self, voucher)
		if not G.GAME.used_sponsors then G.GAME.used_sponsors = {} end
		G.GAME.used_sponsors.spon_bd_john = true
		G.GAME.used_sponsors.last_used = "spon_bd_john"
	end
}

do
    local full_path = SMODS.current_mod.path .. "assets/customimages/spon_johnmockup.png"
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