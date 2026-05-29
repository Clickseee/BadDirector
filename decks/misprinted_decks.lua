---@diagnostic disable: undefined-field
BadDirector.MisprintedDecks = {}

local back_apply_to_run_ref = Back.apply_to_run
function Back:apply_to_run()
	local self_in_use = self
	if BadDirector.do_misprint_deck then
		local key = self.effect.center.key
		if BadDirector.MisprintedDecks[key] then
			self_in_use = {effect = {
				center = {apply = self.effect.center.apply},
				config = self.effect.config
			}}
			if not BadDirector.MisprintedDecks[key].keep_apply then
				self_in_use.effect.center.apply = BadDirector.MisprintedDecks[key].apply
			end
			if not BadDirector.MisprintedDecks[key].keep_config then
				self_in_use.effect.config = BadDirector.MisprintedDecks[key].config or {}
			end
		end
	end
	return back_apply_to_run_ref(self_in_use)
end

--[[

Assign an effect to a deck by doing
function BadDirector.MisprintedDecks.deck_key = {
	apply? = function(self), -- new apply function
	keep_apply? = boolean, -- don't overwrite the old apply
	config? = table, -- new config table,
	keep_config? = boolean -- don't overwrite the old config
}
both apply and config are the same as making a normal deck

]]
