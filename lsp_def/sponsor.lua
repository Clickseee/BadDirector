---@meta


---@overload fun(self: BadDirector.Sponsor): BadDirector.Sponsor
BadDirector.Sponsor = setmetatable({}, {
	__call = function(self)
		return self
	end
})
