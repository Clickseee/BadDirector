-- commented out cuz yeah but just reuse this code for spons ors

-- code by foo54, nxkoo, and squeax09

--[[
BadDirector.Sponsor{
	key = "template",
    atlas = "sponsors",
    artist = {"squeax09"},
    pos = { x = 0, y = 0 },
	redeem = function (self, voucher)
		if not G.GAME.used_sponsors then G.GAME.used_sponsors = {} end
		G.GAME.used_sponsors.spon_bd_template = true
		G.GAME.used_sponsors.last_used = "spon_bd_template"
	end
}

do
    local full_path = SMODS.current_mod.path .. "assets/customimages/sponsortest.png" -- currently using the stake logo as an exmaple/test lmao
    local file_data = assert(NFS.newFileData(full_path))
    local image_data = assert(love.image.newImageData(file_data))
    G.sponsor_images.spon_bd_template.image = love.graphics.newImage(image_data)
end

local drawhook = love.draw
function love.draw()
    drawhook()
    if G.GAME.used_sponsors and G.GAME.used_sponsors.spon_bd_template then
        local w, h = love.graphics.getWidth(), love.graphics.getHeight()
        local img = G.sponsor_images.spon_bd_template.image
        local _xscale = w / img:getWidth()
        local _yscale = h / img:getHeight()
		if G.GAME.used_sponsors.last_used == "spon_bd_template" then
        	love.graphics.setColor(1, 1, 1, 1)
		else
			love.graphics.setColor(1, 1, 1, 0.2)
		end
        love.graphics.draw(img, 0, 0, 0, _xscale, _yscale)
    end
end
]]