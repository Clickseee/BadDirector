--[[
Copy a card table into a new card object.

Parameters:
  card (table): required original card to copy.
  new_card (table|nil): optional existing card object to fill; if provided, preserves deck membership if required.
  area (table|nil): optional area to place card into if not already in deck/area; defaults to new_card.area or card.area or G.jokers.

Returns:
  copy (table): the newly copied card. Returns nil if card is nil.
]]--

BadDirector.copy_card = function(card, new_card, area) -- credit somethingcom515
    if not card then return nil end
    local area = area or (new_card and new_card.area) or card.area or G.jokers
    local cardwasindeck = new_card and new_card.added_to_deck or nil
    local copy = copy_card(card, new_card)
    if new_card and cardwasindeck then copy:remove_from_deck() end
    if card.playing_card then
        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
        copy.playing_card = G.playing_card
        G.deck.config.card_limit = G.deck.config.card_limit + 1
        table.insert(G.playing_cards, copy)
    end
    if (new_card and cardwasindeck) or not new_card then copy:add_to_deck() end
    if not new_card then area:emplace(copy) end
    return copy
end