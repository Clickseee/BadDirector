SMODS.Consumable {
    key = 'spectralprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 9, y = 6 },
}

SMODS.Consumable {
    key = 'familiarprint',  
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 0, y = 5 },
    misprint_original = "c_familiar"
}

SMODS.Consumable {
    key = 'grimprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 1, y = 5 },
    misprint_original = "c_grim"
}

SMODS.Consumable {
    key = 'incantaprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 2, y = 5 },
    misprint_original = "c_incantation"
}

SMODS.Consumable {
    key = 'talisprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 3, y = 5 },
    misprint_original = "c_talisman"
}

SMODS.Consumable {
    key = 'auraprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 4, y = 5 },
    misprint_original = "c_aura"
}

SMODS.Consumable {
    key = 'wrathprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 5, y = 5 },
    misprint_original = "c_wrath"
}

SMODS.Consumable {
    key = 'sigilprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 6, y = 5 },
    misprint_original = "c_sigil"
}

SMODS.Consumable {
    key = 'ouijaprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 7, y = 5 },
    misprint_original = "c_ouija"
}

SMODS.Consumable {
    key = 'ectoprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 8, y = 5 },
    misprint_original = "c_ectoplasm"
}

SMODS.Consumable {
    key = 'immoprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 9, y = 5 },
    misprint_original = "c_immolate"
}

SMODS.Consumable {
    key = 'ankhprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 0, y = 6 },
    misprint_original = "c_ankh"
}

SMODS.Consumable {
    key = 'dejaprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 1, y = 6 },
    misprint_original = "c_deja_vu"
}

SMODS.Consumable {
    key = 'hexprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 2, y = 6 },
    misprint_original = "c_hex"
}

SMODS.Consumable {
    key = 'tranceprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 3, y = 6 },
    misprint_original = "c_trance"
}

SMODS.Consumable {
    key = 'mediumprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 4, y = 6 },
    misprint_original = "c_medium"
}

SMODS.Consumable {
    key = 'cryptidprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 5, y = 6 },
    misprint_original = "c_cryptid"
}

SMODS.Consumable {
    atlas = "consumisprints",
    key = 'soulprint',
    set = 'mispectral',
    pos = { x = 2, y = 2 },
    soul_pos = {
        x = 3, y = 2,
        draw = function(card, scale_mod, rotate_mod)
            local t = G.TIMERS.REAL
            local frac = t - math.floor(t)

            local jitter = (math.random() - 0.5) * 0.02
            local bitflip = (math.sin(t * 37) > 0.95) and 0.05 or 0

            local _scale_mod =
                0.06
                + 0.04 * math.sin(8.3 * t)
                + 0.02 * math.sin(53 * frac)
                + jitter
                + bitflip

            local _rotate_mod =
                0.25 * math.sin(1.7 * t)
                + 0.05 * math.sin(t * 113)
                + jitter * 2
                + (math.sin(t * 19) > 0.85 and 0.12 or 0)

            card.children.floating_sprite.role.draw_major = card

            card.children.floating_sprite:draw_shader(
                'dissolve',
                0,
                nil,
                nil,
                card.children.center,
                _scale_mod,
                _rotate_mod,
                nil,
                0.15 + 0.05 * math.sin(14.2 * t),
                nil,
                0.7
            )

            card.children.floating_sprite:draw_shader(
                'dissolve',
                nil,
                nil,
                nil,
                card.children.center,
                _scale_mod,
                _rotate_mod
            )
            if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
                card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
            end
        end,
    },
    hidden = true,
    misprint_original = "c_soul"
}