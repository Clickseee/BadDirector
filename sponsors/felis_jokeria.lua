BadDirector.Sponsor{
	key = "felisjokeria",
    atlas = "sponsors",
    coder = { "Foo54", "squeax09" },
    artist = {"LasagnaFelidae"},
    pos = { x = 1, y = 0 },
    config = { extra = { hands = 1, xblind = 1.2 }},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.extra.hands,
                self.config.extra.xblind,
            }
        }
    end,
	redeem = function (self, voucher)
		if not G.GAME.used_sponsors then G.GAME.used_sponsors = {} end
		G.GAME.used_sponsors.spon_bd_felisjokeria = true
		G.GAME.used_sponsors.last_used = "spon_bd_felisjokeria"

        G.GAME.round_resets.hands = G.GAME.round_resets.hands + voucher.ability.extra.hands
        ease_hands_played(voucher.ability.extra.hands)
        G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * voucher.ability.extra.xblind
	end
}

do
    local full_path = SMODS.current_mod.path .. "assets/customimages/spon_fj.png" 
    local file_data = assert(NFS.newFileData(full_path))
    local image_data = assert(love.image.newImageData(file_data))
    G.sponsor_images.spon_bd_felisjokeria.image = love.graphics.newImage(image_data)
end

local drawhook = love.draw
function love.draw()
    drawhook()
    if G.GAME.used_sponsors and G.GAME.used_sponsors.spon_bd_felisjokeria then
        local w, h = love.graphics.getWidth(), love.graphics.getHeight()
        local img = G.sponsor_images.spon_bd_felisjokeria.image
        local _xscale = w / img:getWidth()
        local _yscale = h / img:getHeight()
		if G.GAME.used_sponsors.last_used == "spon_bd_felisjokeria" then
        	love.graphics.setColor(1, 1, 1, 1)
		else
			love.graphics.setColor(1, 1, 1, 0.2)
		end
        love.graphics.draw(img, 0, 0, 0, _xscale, _yscale)
    end
end