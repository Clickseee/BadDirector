--#region MISC STUFF

--opens balatro
--wins round
--❤❤ W SPEED ❤❤


BadDirector = SMODS.current_mod

local path = SMODS.current_mod.path .. 'jokers/'
for _, v in pairs(NFS.getDirectoryItems(path)) do
    assert(SMODS.load_file('jokers/' .. v))()
end

--#endregion
