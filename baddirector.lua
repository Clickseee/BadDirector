--#region this fucking sucks, death to Talisman, CDATAMAN RULES GRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHH

to_big = to_big or function(n)
    return n
end

to_number = to_number or function(n)
    return n
end

BadDirector = SMODS.current_mod

local function _load_folder(folder)
    folder = folder .. "/"
    local upath = SMODS.current_mod.path .. folder
    for _, v in pairs(NFS.getDirectoryItems(upath)) do
        assert(SMODS.load_file(folder .. v))()
    end
end
_load_folder("other")
_load_folder("utils")
_load_folder("decks")
_load_folder("consumables")
_load_folder("vouchers")
_load_folder("enhancements")
_load_folder("jokers")
_load_folder("other_j")
_load_folder("sponsors")

BadDirector.optional_features = {
    cardareas = {},
    retrigger_joker = true,
    post_trigger = true
}
