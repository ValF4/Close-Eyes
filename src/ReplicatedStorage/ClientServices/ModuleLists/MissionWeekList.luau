
local XP_IMG = "rbxassetid://18193174919"
local RANDOM_GIFT_IMG = "rbxassetid://18193169632"
local BROWM_BOTTOM_IMG = "rbxassetid://18206847829"

local MissionWeekList = {
    ["MISSION_1"] = { -- Buy Goldem Bottons
        Total_Mission = "3000",
        Name = "Boss day",
        Description = "Buy 3000 golden buttons from the button shop.",
        Recompenses = { { IMG = `{XP_IMG}`, RECOMPENSE_NAME = "50 XP",}, { IMG = `{RANDOM_GIFT_IMG}`, RECOMPENSE_NAME = "Random Gift"}, },
    },

    ["MISSION_2"] = { -- Game Win in Radom Tent
        Total_Mission = "5",
        Name = "The King of the house",
        Description = "Win 5 epic prizes at the games tent.",
        Recompenses = { { IMG = `{XP_IMG}`, RECOMPENSE_NAME = "150 XP" }, },
    },

    ["MISSION_3"] = { -- Collet Ballons in the map
        Total_Mission = "10",
        Name = "House of balloons",
        Description = "Acquire 10 balloons spread across the map",
        Recompenses = { { IMG = `{BROWM_BOTTOM_IMG}`, RECOMPENSE_NAME = "150 Browm bottom"}, { IMG = `{XP_IMG}`, RECOMPENSE_NAME = "+150 XP"}, },
    },

    ["MISSION_4"] = { -- Run in the Monster in the map
        Total_Mission = "200",
        Name = "Run if you can",
        Description = "Run around the map avoiding some monster",
        Recompenses = { { IMG = `{RANDOM_GIFT_IMG}` , RECOMPENSE_NAME = "Random Gift"}, },
    },

    ["MISSION_5"] = { -- Sequence Wins in the game
        Total_Mission = "5",
        Name = "Your death reflects your life",
        Description = "Survive the game 5 times in a row",
        Recompenses = { { IMG = `{RANDOM_GIFT_IMG}`, RECOMPENSE_NAME = "Random gift"}, { IMG = `{XP_IMG}`, RECOMPENSE_NAME = "+100 XP"}},
    },

    ["MISSION_6"] = { -- Find SterEggs in the lobby
        Total_Mission = "10",
        Name = ".- / ...- . .-. -.. .- -.. .",
        Description = "Find secrets in the lobby",
        Recompenses = { { IMG = `{XP_IMG}`, RECOMPENSE_NAME = "+150 XP"}, { IMG = `{BROWM_BOTTOM_IMG}`, RECOMPENSE_NAME = "+200 Browm Bottom"}},
    },

    ["MISSION_7"] = { -- Collet Browm bottons in the map
        Total_Mission = "50",
        Name = "We've been waiting for you for years",
        Description = "Collect buttons around the map",
        Recompenses = { { IMG = `{RANDOM_GIFT_IMG}`, RECOMPENSE_NAME = "Radom Gift"}, },
    },
}

return MissionWeekList