local oldcardgetid = Card.get_id
function Card:get_id()
    local g = oldcardgetid(self)
    if next(SMODS.find_card('j_bd_genderdysphoria')) and (g == 12 or g == 13) then
        return 11
    end
    return g
end


SMODS.Joker {
    key = "genderdysphoria",
    rarity = 2,
    atlas = "<3",
    artist = {"IncognitoN71"},
    pos = { x = 2, y = 0 },
    cost = 4,
    pools = {
        ["BadDirector_Jokers"] = true,
    },
    attributes = {"king","queen","jack"},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    calculate = function(self, card, context)
        if context.before then
            for _, played_card in ipairs(context.full_hand) do
                local id = played_card:get_id()

                if id == 12 or id == 13 then
                    SMODS.change_base(played_card, nil, "Jack")
                end
            end
        end
    end
}
