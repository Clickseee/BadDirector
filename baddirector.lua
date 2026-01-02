--#region this fucking sucks, death to Talisman, CDATAMAN RULES GRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHH

to_big = to_big or function(n)
  return n
end

to_number = to_number or function(n)
  return n
end

--#endregion

--#region MISC STUFF

BadDirector = SMODS.current_mod

local upath = SMODS.current_mod.path .. 'utils/'
for _, v in pairs(NFS.getDirectoryItems(upath)) do
    assert(SMODS.load_file('utils/' .. v))()
end

BadDirector.optional_features = {
  cardareas = {},
  retrigger_joker = true,
  post_trigger = true
}

local jpath = SMODS.current_mod.path .. 'jokers/'
for _, v in pairs(NFS.getDirectoryItems(jpath)) do
    assert(SMODS.load_file('jokers/' .. v))()
end

local dpath = SMODS.current_mod.path .. 'decks/'
for _, v in pairs(NFS.getDirectoryItems(dpath)) do
    assert(SMODS.load_file('decks/' .. v))()
end

local cpath = SMODS.current_mod.path .. 'consumables/'
for _, v in pairs(NFS.getDirectoryItems(cpath)) do
    assert(SMODS.load_file('consumables/' .. v))()
end

SMODS.Atlas { -- ALL ARTS BELONG TO RATTLINGSNOW353 WITH PERMISSION
    key = "rattlingsnow",
    path = "rattling.png",
    px = 71,
    py = 95,
}

local rotta_gradient = SMODS.Gradient({
	key = "rotta",
	colours = {
		HEX("ffe5b4"),
		HEX("dab772"),
		HEX("a58547"),
		HEX("4f6367"),
	},
	cycle = 2,
})

SMODS.ConsumableType({
    key = "mistarot",
    collection_rows = {5,6},
    primary_colour = G.C.SECONDARY_SET.Tarot,
    secondary_colour = rotta_gradient,
    default = "c_bd_foolprint",
    cards = {},
    shop_rate = 4
})

local netpla_gradient = SMODS.Gradient({
	key = "netpla",
	colours = {
		HEX("dff5fc"),
		HEX("84c5d2"),
		HEX("5b9baa"),
		HEX("4f6367"),
	},
	cycle = 2,
})

SMODS.ConsumableType({
    key = "misplanet",
    collection_rows = {6,6},
    primary_colour = G.C.SECONDARY_SET.Planet,
    secondary_colour = netpla_gradient,
    default = "c_bd_mercprint",
    cards = {},
    shop_rate = 4
})

local ralspect_gradient = SMODS.Gradient({
	key = "ralspect",
	colours = {
		HEX("638fe1"),
		HEX("5b7fc1"),
		HEX("4e5779"),
		HEX("5e7297"),
        HEX("96aacb"),
        HEX("bfc7d5"),
        HEX("e2ebf9"),
	},
	cycle = 2,
})

SMODS.ConsumableType({
    key = "mispectral",
    collection_rows = {4,5},
    primary_colour = G.C.SECONDARY_SET.Spectral,
    secondary_colour = ralspect_gradient,
    default = "c_bd_familiarprint",
    cards = {},
})

--#endregion

--#region SHADER

SMODS.Shader {
    key = "thermal",
    path = "thermals.fs"
}

SMODS.Shader {
    key = "colorsplash",
    path = "colorsplashes.fs"
}

SMODS.Shader {
    key = "xrays",
    path = "xray.fs"
}

SMODS.Shader {
    key = "blueprints",
    path = "blueprint.fs"
}


SMODS.Edition {
    key = "heat",
    order = 1,
    loc_txt = {
        name = "Thermal",
        label = "Thermal",
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
	shader = "thermal",
	in_shop = true,
	extra_cost = 3,
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Edition {
    key = "disco",
    order = 2,
    loc_txt = {
        name = "Colorsplash",
        label = "Colorsplash",
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
	shader = "colorsplash",
	in_shop = true,
	extra_cost = 3,
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Edition {
    key = "spooky",
    order = 3,
    loc_txt = {
        name = "X-Ray",
        label = "X-Ray",
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
	shader = "xrays",
	in_shop = true,
	extra_cost = 3,
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Edition {
    key = "copier",
    order = 3,
    loc_txt = {
        name = '"Blueprint"?',
        label = '"Blueprint"?',
        text = {
            "Ascension Power now",
            "deals X2 more"
        }
    },
    weight = 21,
	shader = "blueprints",
	in_shop = true,
	extra_cost = 3,
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue)
    end,
    calculate = function(self, card, context)
    end
}