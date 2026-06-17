SMODS.Achievement {
    key = "parkedlikeadickhead",
    hidden_name = false,
    hidden_text = true,
    bypass_all_unlocked = false,

    unlock_condition = function(self, args)
        if args.type == 'modify_jokers' and G.jokers then
            return next(SMODS.find_card('j_bd_belovedprince'))
        end
    end
}