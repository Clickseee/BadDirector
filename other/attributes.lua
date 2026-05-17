SMODS.Attribute {
    key = "debuff"
}

SMODS.ObjectType({
	key = "BadDirector_Jokers",
	default = "j_bd_fakepromises",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})