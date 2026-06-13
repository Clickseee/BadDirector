G.sponsor_images = G.sponsor_images or {}

G.sponsor_images.spon_bd_elchip = {
    image = nil,
    next_ad = 0,
    active = false,
    ads_seen = 0,
    path = SMODS.current_mod.path
}

SMODS.Sound({
    key = "elchip_ad_music",
    path = "elchip_ad_music.ogg",
    pitch = 1,
    volume = 1,

    select_music_track = function()
        return G.GAME
            and G.GAME.used_sponsors
            and G.GAME.used_sponsors.spon_bd_elchip_active
    end
})

BadDirector.Sponsor{
    key = "elchip",

    redeem = function(self, voucher)
        if not G.GAME.used_sponsors then
            G.GAME.used_sponsors = {}
        end

        G.GAME.used_sponsors.spon_bd_elchip = true
        G.GAME.used_sponsors.last_used = "spon_bd_elchip"

        G.GAME.used_sponsors.spon_bd_elchip_redemptions =
            (G.GAME.used_sponsors.spon_bd_elchip_redemptions or 0) + 1

        G.GAME.used_sponsors.spon_bd_elchip_active = false

        -- honest to god idk
        G.GAME.interest_cap = (G.GAME.interest_cap or 5)
            + 1

        if G.sponsor_images.spon_bd_elchip.next_ad == 0 then
            G.sponsor_images.spon_bd_elchip.next_ad =
                G.TIMERS.REAL + pseudorandom("elchip_first") * 60 + 30
        end
    end
}

do
    local full_path =
        SMODS.current_mod.path ..
        "assets/customimages/spon_elchip.png"

    local file_data = assert(NFS.newFileData(full_path))
    local image_data = assert(love.image.newImageData(file_data))

    G.sponsor_images.spon_bd_elchip.image =
        love.graphics.newImage(image_data)

    --[[

    Example multi-ad support:

    G.sponsor_images.spon_bd_elchip.ads = {}

    for i = 1, 5 do
        local full_path =
            SMODS.current_mod.path ..
            "assets/customimages/elchip_ad_" .. i .. ".png"

        local file_data = assert(NFS.newFileData(full_path))
        local image_data = assert(love.image.newImageData(file_data))

        G.sponsor_images.spon_bd_elchip.ads[i] =
            love.graphics.newImage(image_data)
    end

    When spawning:

    G.sponsor_images.spon_bd_elchip.image =
        pseudorandom_element(
            G.sponsor_images.spon_bd_elchip.ads,
            pseudoseed('elchip_ad')
        )

    ]]
end

local updatehook = Game.update

function Game:update(dt)
    updatehook(self, dt)

    if not G.GAME
    or not G.GAME.used_sponsors
    or not G.GAME.used_sponsors.spon_bd_elchip then
        return
    end

    if not G.GAME.used_sponsors.spon_bd_elchip_active
    and G.TIMERS.REAL >= G.sponsor_images.spon_bd_elchip.next_ad then

        G.GAME.used_sponsors.spon_bd_elchip_active = true

        G.sponsor_images.spon_bd_elchip.ads_seen =
            G.sponsor_images.spon_bd_elchip.ads_seen + 1

        local redemptions =
            G.GAME.used_sponsors.spon_bd_elchip_redemptions or 1

        -- More redemptions = more frequent ads
        local min_time = math.max(5, 30 - redemptions * 5)
        local max_time = math.max(15, 90 - redemptions * 10)

        G.sponsor_images.spon_bd_elchip.next_ad =
            G.TIMERS.REAL +
            pseudorandom("elchip_next") * (max_time - min_time) +
            min_time
    end
end

SMODS.Keybind{
    key = "elchip_dismiss",
    key_pressed = "return",

    action = function(self)

        if not G.GAME
        or not G.GAME.used_sponsors
        or not G.GAME.used_sponsors.spon_bd_elchip_active then
            return
        end

        G.GAME.used_sponsors.spon_bd_elchip_active = false

        play_sound("tarot1", 1, 1)
    end
}

local drawhook = love.draw

function love.draw()
    drawhook()

    if not G.GAME
    or not G.GAME.used_sponsors
    or not G.GAME.used_sponsors.spon_bd_elchip_active then
        return
    end

    local img = G.sponsor_images.spon_bd_elchip.image

    if not img then
        return
    end

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    local sx = w / img:getWidth()
    local sy = h / img:getHeight()

    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(
        img,
        0,
        0,
        0,
        sx,
        sy
    )

    -- PRESS ENTER TO SKIP
    local pulse = 0.75 + math.sin(G.TIMERS.REAL * 6) * 0.25

    love.graphics.setColor(1, 1, 1, pulse)

    love.graphics.printf(
        "PRESS ENTER TO SKIP",
        0,
        h - 80,
        w,
        "center"
    )

    love.graphics.setColor(1, 1, 1, 1)
end