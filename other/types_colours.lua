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
    collection_rows = { 5, 6 },
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
    collection_rows = { 6, 6 },
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
    collection_rows = { 4, 5 },
    primary_colour = G.C.SECONDARY_SET.Spectral,
    secondary_colour = ralspect_gradient,
    default = "c_bd_familiarprint",
    cards = {},
})