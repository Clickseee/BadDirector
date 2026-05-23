--[[
Quick weighted pool pick.
Uhhh feli did you take this from your mod

Parameters:
  pool (table): required. A list of entries where each entry is either
    {key = value, weight = number} or {value, weight}.
    Example:
      {
        {key = 'j_foo', weight = 2},
        {'j_bar', 1},
      }

  roll (number|nil): optional. If provided, should be a [0,1) random float.
    You can pass either:
      pseudorandom(pseudoseed('myseed'))
    or a local variable storing that value.
    If omitted, it defaults to pseudorandom(pseudoseed('poolroll')).

Returns:
  selected key/value from pool based on weights.
]]--
BadDirector.quick_pool_pick = function(pool, roll)
	if type(pool) == "table" then
		roll = roll or pseudorandom(pseudoseed('uhhhh yeah i took this from my mod but shhhhh'))
		local total = 0
		
		for _, v in ipairs(pool) do
			local w = v.weight or v[2] or 1
			total = total + w
		end
		
		local _roll = roll * total
		local w_sum = 0
		
		for _, v in ipairs(pool) do
			local w = v.weight or v[2] or 1
			w_sum = w_sum + w
			if _roll <= w_sum then
				return v.key or v[1]
			end
		end
	elseif pool then
		error("pool is not a table ({key, weight}")
	else
		error("pool is nil")
	end
end


BadDirector.misprint_enhancements = {
	{key = "m_bd_misprintluckycard",    weight = 0.20},
    {key = "m_bd_misprintsteel",        weight = 0.20},
    {key = "m_bd_misprintglass",        weight = 0.20},
    {key = "m_bd_misprintgold",         weight = 0.20},
    {key = "m_bd_misprintstone",        weight = 0.20},
    {key = "m_bd_misprintwild",         weight = 0.20},
    {key = "m_bd_misprintmult",         weight = 0.20},
    {key = "m_bd_misprintbonus",        weight = 0.20},
}

BadDirector.misprint_seals = {
	{key = "bd_goldprint",          weight = 0.25},
    {key = "bd_bluesprint",         weight = 0.25},
    {key = "bd_purpleprint",        weight = 0.25},
    {key = "bd_redprint",           weight = 0.25},
}

BadDirector.misprint_modify = {
	{key = "enhanced",      weight = 7.5},
    {key = "sealed",        weight = 5},
    {key = "editioned",     weight = 5},
    {key = "enhsealed",     weight = 2.5},
    {key = "enhedi",        weight = 2.5},
    {key = "edisealed",     weight = 2.5},
    {key = "everything",    weight = 1.25}
}