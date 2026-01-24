return {
    descriptions = {
        Mod = {
            baddirector = {
					name = "Bad Director",
                    text = {
                        "{s:1.2}A {C:dark_edition}?allinaV{}-adjacent Balatro Mod",
                        "inspired by the idea of {C:attention}Misprint Joker{} and",
                        "a bunch of Big Vanilla-esque Mod.",
                        "Most of the Additions here are thematic, but some are non-thematic",
                        "that i come up with by myself.",
                        "Check out my other stuff such as: {C:attention}Tangents{}, and more!",
                    }
				}
        },
        Back = {
            b_bd_missingdeck = {
                name = "MissingDeck",
                text = {
                    "All Jokers are",
                    "rerolled after defeating",
                    "a {C:attention}Boss Blind",
                    '{s:0.8}(Respective to their rarities)'
                }
            }
        },
        Joker = {
            j_bd_polaroid = {
                name = "Polaroid",
                text = {
                    "First played and unscored",
                    "{C:attention}face{} card gives",
                    "{X:chips,C:white}X3.5{} Chips"
                }
            },
            j_bd_forgery = {
                name = "Forgery",
                text = {
                    "Played {C:attention}Steel{} card",
                    "now has {C:green}#1# in #2#{} chance",
                    "to increase it's rank by {C:attention}#3#{}"
                }
            },
            j_bd_contents = {
                name = "Contents [{s:0.7,C:blue}hide{}]",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult if all",
                    "{C:attention}poker hands{} mentioned are played,",
                    "{C:mult}+#2#{} Mult if it's half completed,",
                    "poker hand resets when {C:attention}Blind{} is selected",
                    "{C:inactive}(Currently {X:mult,C:white}X#3#{} {C:inactive}and {C:mult}+#4#{} {C:inactive}Mult)"
                }
            },
            j_bd_jello = {
                name = "Popsicle",
                text = {
                    {
                        "#"
                    },
                    {
                        "{C:green,E:bd_glitching}#1#{} {C:green}in{} {C:green,E:bd_glitching}#2#{} chance this is destroyed",
                        "at the end of the round"
                    }
                }
            },
            j_bd_lefty = {
                name = "Lefty",
                text = {
                    "If the leftmost scored card",
                    "is {C:attention}#2#{} of {V:1}#3#{}, gain {C:money}$#1#{}",
                    "{C:inactive,s:0.8}(Card changes every round){}"
                }
            },
            j_bd_pregnantchad = {
                name = "Pregnant Chad",
                text = {
                    "Retrigger {C:attention}first{} Joker's",
                    "trigger effect used in scoring",
                    "{C:attention}#1#{} additional times",
                }
            },
            j_bd_timeline = {
                name = "Timeline",
                text = {
                    "When an adjacent Joker triggers,",
                    "permanently gain {C:mult}+{E:bd_glitching,C:mult}N{}{C:mult}/{E:bd_glitching,C:mult}A{} Mult and {C:chips}+{E:bd_glitching,C:chips}N{}{C:chips}/{}{E:bd_glitching,C:chips}A{} chips",
                    "{C:inactive}(Currently {C:mult}+#1#{}{C:inactive} Mult and {C:chips}+#2#{} {C:inactive}Chips)",
                }
            },
            j_bd_counterfeitslab = {
                name = "Counterfeit Slab",
                text = {
                    "Jokers with {C:edition}Edition{} has",
                    "{C:green}#1# in #2#{} chance to duplicate",
                    "after beating a {C:attention}Showdown{} blind"
                }
            },
            j_bd_damocles = {
                name = "Sword of Damocles",
                text = {
                    {
                        "{C:money}Money{} is doubled at the end of every round,",
                        "triples all {C:attention}listed {C:green}probabilities,",
                        "other {C:attention}Jokers{} now retrigger {C:attention}#1#{} times,",
                        "every played {C:attention}card{} now retrigger {C:attention}#2#{} times"
                    },
                    {
                        "Set {C:blue}Hands{} to {C:attention}#3#{}"
                    }
                }
            },
            j_bd_cheapwine = {
                name = "Cheap Wine",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "{C:mult}-#2#{} Mult for every",
                    "{C:money}$5{} the player has",
                    "at end of every round"
                }
            },
            j_bd_p03 = {
                name = "Wicked Computer",
                text = {
                    {
                        "{X:mult,C:white}X1{} Mult for each",
                        "Browsers tabs used by {f:bd_p03font,C:dark_edition}P{E:bd_glitching,C:dark_edition}03{}",
                        "to upload his consciousness",
                        "{C:inactive}(Currently {X:mult,C:white}X#3#{}{C:inactive} Mult)"
                    },
                    {
                        "{C:green}1 in 2{} chance to be killed",
                        "at the end of the round",
                        "if it uses more than {C:attention}#4#{} Browsers tabs",
                    }
                }
            },
            j_bd_binded = {
                name = "Binded",
                text = {
                    "Retrigger each played {C:attention}enhanced{} cards,",
                    "{C:green}#2# in #3#{} chance to",
                    "remove card {C:attention}Enhancement"
                }
            },
            j_bd_longface = {
                name = "Long Face",
                text = {
                    "This Joker gains {C:mult}+{E:bd_glitching,C:mult}67{} Mult",
                    "if played hand has {C:attention}3{} or more",
                    "unscored {C:attention}face{} cards"
                }
            },
            j_bd_impulsebuyer = {
                name = "Impulse Buyer",
                text = {
                    "This Joker gains {X:mult,C:white}X#2#{} Mult",
                    "per bought cards in the shop,",
                    "resets when skipping a shop",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
                }
            },
        },
        mistarot = {
            c_bd_defaultprint = {
                name = "{E:bd_glitching,C:dark_edition}u{}nde{E:bd_glitching,C:dark_edition}f{}ined",
                text = {
                    "Creates up to",
                    "{C:attention}#1#{} of {E:bd_glitching,C:dark_edition}dick{}",
                    "{C:inactive}(Doesn't need room)"
                }
            },
            c_bd_foolprint = {
                name = "olThe Fo",
                text = {
                    "Creates a card",
                    "From the last",
                    "used consumable set",
                    "used during this run",
                    "{s:0.8,C:spectral}Spectrals{s:0.8} excluded",
                },
            },
            c_bd_highestprintess = {
                name = "h PriestessThe Hig",
                text = {
                    "Ra{E:bd_glitching,C:dark_edition}n{}d{E:bd_glitching,C:dark_edition}o{}{E:bd_glitching,C:dark_edition}miz{}es up to {C:attention}#1#{} to {C:attention}#2#",
                    "{C:dark_edition}negative{} random {C:planet}Planet{} cards",
                    "{C:inactive}(Doesn't need room)"
                }
            },
            c_bd_emprints = {
                name = "erorThe Emp",
                text = {
                    "Ra{E:bd_glitching,C:dark_edition}n{}d{E:bd_glitching,C:dark_edition}o{}{E:bd_glitching,C:dark_edition}miz{}es up to {C:attention}#1#{} to {C:attention}#2#",
                    "{C:dark_edition}negative{} random {C:tarot}Tarot{} cards",
                    "{C:inactive}(Doesn't need room)"
                }
            },
            c_bd_herprint = {
                name = "mitThe Her",
                text = {
                    "Ra{E:bd_glitching,C:dark_edition}n{}d{E:bd_glitching,C:dark_edition}o{}{E:bd_glitching,C:dark_edition}miz{}es money",
                    "{C:inactive}(Range of {X:money,C:white}X#1# - X#2#{}{C:inactive})"
                }
            },
            c_bd_temprint = {
                name = "eranceTemp",
                text = {
                    "Ra{E:bd_glitching,C:dark_edition}n{}d{E:bd_glitching,C:dark_edition}o{}{E:bd_glitching,C:dark_edition}miz{}es the sell values",
                    "of all current {C:attention}Jokers",
                    "{C:inactive}(Range of {X:money,C:white}X#1# - X#2#{}{C:inactive})"
                }
            },
            c_bd_starprint = {
                name = "rsThe Sta",
                text = {
                    "Gi{E:bd_glitching,C:dark_edition}v{}e{E:bd_glitching,C:dark_edition}t{}s up to",
                    "{C:attention}#1#{} selected {C:hearts}Hearts{}",
                    "and {C:diamonds}Diamonds{}",
                    "{X:mult,C:white}XMult{} equal to",
                    "{C:attention}10%{} of their {C:chips}Chips{}",
                }
            },
            c_bd_sunprint = {
                name = "unThe S",
                text = {
                    "Gi{E:bd_glitching,C:dark_edition}v{}e{E:bd_glitching,C:dark_edition}t{}s up to",
                    "{C:attention}#1#{} selected {C:hearts}Hearts{}",
                    "and {C:diamonds}Diamonds{}",
                    "{C:mult}+Mult{} equal to",
                    "{C:attention}half{} of their {C:chips}Chips{}",
                }
            },
            c_bd_moonprint = {
                name = "onThe Mo",
                text = {
                    "Gi{E:bd_glitching,C:dark_edition}v{}e{E:bd_glitching,C:dark_edition}t{}s up to",
                    "{C:attention}#1#{} selected {C:clubs}Clubs{}",
                    "and {C:spades}Spades{}",
                    "{X:chips,C:white}XChips{} equal to",
                    "all held {C:attention}Consumables{}",
                }
            },
            c_bd_worldprint = {
                name = "rldThe Wo",
                text = {
                    "Gi{E:bd_glitching,C:dark_edition}v{}e{E:bd_glitching,C:dark_edition}t{}s up to",
                    "{C:attention}#1#{} selected {C:clubs}Clubs{}",
                    "and {C:spades}Spades{}",
                    "{C:chips}Chips{} equal to",
                    "all {C:attention}Jokers{} sell value",
                }
            },
            c_bd_judgeprint = {
                name = "ementJudg",
                text = {
                    "Destroy a selected {C:attention}Joker{} and",
                    "Ra{E:bd_glitching,C:dark_edition}n{}d{E:bd_glitching,C:dark_edition}o{}{E:bd_glitching,C:dark_edition}miz{}es up to {C:attention}2{}",
                    "{C:attention}Misprinted{} consumables"
                }
            },
            c_bd_wheelofprint = {
                name = "el of FortuneThe Whe",
                text = {
                    "{C:green}#1# in #2#{} chance to ra{E:bd_glitching,C:dark_edition}n{}d{E:bd_glitching,C:dark_edition}o{}{E:bd_glitching,C:dark_edition}miz{}es",
                    "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or",
                    "{C:dark_edition}Polychrome{} edition",
                    "to a random {C:attention}Joker{}",
                    "or cards {C:attention}held in hand{}",
                    "{s:0.8}(Can affect up to {C:attention,s:0.8}5{} {s:0.8}cards)"
                }
            },
            c_bd_strenghtprints = {
                name = "ngthStre",
                text = {
                    "Ranks of up to {C:attention}#1#{} selected cards",
                    "are shu{E:bd_glitching,C:dark_edition}f{}fl{E:bd_glitching,C:dark_edition}e{}d between each other"
                }
            },
            c_bd_hangedprint = {
                name = "nged ManThe Ha",
                text = {
                    "Debu{E:bd_glitching,C:dark_edition}f{}fs up to {C:attention}#1#{} selected cards,",
                    "{C:green}#2# in #3#{} chance to permanently add",
                    "{C:attention}1{} retrigger to selected cards"
                }
            },
            c_bd_deathprint = {
                name = "athDe",
                text = {
                    "{C:green}#1# in #2#{} chance to {E:bd_glitching,C:dark_edition}bruhbruhbruh{}",
                    "all cards {C:attention}held in hand{} then",
                    "forcibly select all cards {C:attention}held in hand{}"
                }
            },
        },
        mispectral = {
            c_bd_soulprint = {
                name = "ulSo",
                text = {
                    "{E:bd_glitching,C:green}1{}{C:green} in {E:bd_glitching,C:green}1{}{C:green}6{} to",
                    "{E:bd_glitching,C:dark_edition,s:1.5}ki{}{E:bd_glitching,C:red,s:1.5}lls{} {E:bd_glitching,C:legendary,s:1.5}yo{}{E:bd_glitching,C:edition,s:1.5}u.{}",
                    "{E:bd_glitching,C:chips,s:1.5}ki{}{E:bd_glitching,C:red,s:1.5}also ki{} {E:bd_glitching,C:planet,s:1.5}yours{}{E:bd_glitching,C:tarot,s:1.5}self{}"
                },
            }
        },
        Edition = {
            e_bd_thermal = {
                name = "Thermal",
                text = {
                    "{X:attention,C:white}X2{} Values",
                    "{C:red}Cannot{} be retriggered"
                }
            },
            e_bd_xray = {
                name = "X-Ray",
                text = {
                    "{C:dark_edition}Misprint{} {C:attention}2{} random",
                    "cards when triggered"
                }
            },
        }
    },
    misc = {
        dictionary = {
            k_specialthanks = "{C:edition,E:1,s:2}Special Thanks to:",
            b_bad_director_wiki = "Wiki",
            b_bad_director_other = "My Other Mods",
            k_mistarot = 'rotTa',
            b_mistarot_cards = "ot CardsTar",
            k_misplanet = 'netPla',
            b_misplanet_cards = "net CardsPla",
            k_mispectral = 'ralSpect',
            b_mispectral_cards = "tral CardsSpec",
            k_what = '...?'
        },
        labels = {
            bd_thermal = "Thermal",
            bd_xray = "X-Ray",
        }
    }
}
