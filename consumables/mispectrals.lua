local function BadDirector_reset_crt_smooth()
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        blocking = false,
        func = function()
            BadDirector_crt_glitch = math.max(0, BadDirector_crt_glitch - 0.1)
            BadDirector_crt_noise = math.max(0, BadDirector_crt_noise - 0.1)
            BadDirector_crt_intensity = math.max(0, BadDirector_crt_intensity - 0.1)

            if BadDirector_crt_glitch > 0 then
                return false
            end

            return true
        end
    }))
end


SMODS.Consumable {
    key = 'spectralprint',
    atlas = "consumisprints",
    set = 'mispectral',
    pos = { x = 9, y = 6 },
    can_use = function(self, card)
        return #G.jokers.cards > 0
    end,

    use = function(self, card, area, copier)
        BadDirector_set_crt_vals('glitch', 2)
        BadDirector_set_crt_vals('noise', 1.0)
        BadDirector_set_crt_vals('intensity', 1.5)
        for i = 1, #G.jokers.cards do
            local joker = G.jokers.cards[i]

            if joker and joker.config then
                BadDirector.manipulate(joker, {
                    min = 0.5,
                    max = 3,
                    type = "X",
                    dont_stack = true,
                    no_deck_effects = true,
                    seed = "fuckme5sides" .. G.GAME.round
                })

                joker:juice_up(0.4, 0.4)
                play_sound('bd_inapmit')
                BadDirector_reset_crt_smooth()
            end
        end
    end
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
    misprint_original = "c_talisman",
    config = { extra = { seal = 'Gold' }, odds = 6 }, -- can be adjusted as need be ofc
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { G.GAME.probabilities.normal, card.ability.odds } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        play_sound('bd_inapmit') -- was unsure if it should play every time a seal is applied lol
        for i=1, #G.hand.cards do
            local woah = G.hand.cards[i]
            if pseudorandom('blud is golden') < G.GAME.probabilities.normal / card.ability.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        woah:set_seal(card.ability.extra.seal, nil, true)
                        return true
                    end
                }))
                delay(0.5)
            else -- we probably dont HAVE to have the Nope! here so i can remove if need be i just thought it might help visually
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.6,
                    func = function()
                        attention_text({
                            text = localize('k_nope_ex'),
                            scale = 1,
                            hold = 1,
                            major = woah,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = 'cm',
                            offset = { x = 0 + ((G.hand.cards[(math.floor(#G.hand.cards / 2))].T.x - woah.T.x) / -50), y = -2 },
                            silent = true,
                        })
                        play_sound('generic1')
                        woah:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
        end
    end
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
