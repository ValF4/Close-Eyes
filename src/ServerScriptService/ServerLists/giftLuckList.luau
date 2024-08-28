export type giftlucklist = {
	COMMON: {
		{Name: string, possibility: number, Total: number ,Type: string}
	},

	UNCOMMON: {
		{Name: string, possibility: number, Total: number, Type: string}
	},

	RARE: {
		{Name: string, possibility: number, Total: number, Type: string}
	},

	EPIC: {
		{Name: string, possibility: number, Total: number, Type: string}
	},

	LEGENDARY: {
		{Name: string, possibility: number, Total: number, Type: string}
	},
}

local giftlucklist = {
	COMMON = {
		{Name = "+100 XP",           possibility = 0.55,     Total = 100,  Type = "XP"}, -- 55% de chance
		{Name = "+250 XP",           possibility = 0.4,      Total = 250,  Type = "XP"}, -- 40% de chance
		{Name = "+350 XP",           possibility = 0.355,    Total = 350,  Type = "XP"}, -- 35.5% de chance
		{Name = "+500 XP",           possibility = 0.3,      Total = 500,  Type = "XP"}, -- 30% de chance
		{Name = "+75 Browm Button",  possibility = 0.2,      Total = 75,   Type = "BROWM_BUTTON"}, -- 20% de chance
		{Name = "+50 Browm Button",  possibility = 0.17,     Total = 50,   Type = "BROWM_BUTTON"}, -- 17% de chance 
		{Name = "+150 Browm Button", possibility = 0.155,    Total = 150,  Type = "BROWM_BUTTON"}, -- 15.5% de chance 
		{Name = "+250 Browm Button", possibility = 0.15,     Total = 250,  Type = "BROWM_BUTTON"}, -- 15% de chance
		{Name = "Icommun Gift",      possibility = 0.024,    Total = 1,    Type = "GIFT"}, -- 2.4% de chance
		{Name = "Rare Gift",         possibility = 0.02,     Total = 1,    Type = "GIFT"}, -- 2% de chance
		{Name = "Spider Mask",       possibility = 0.01,     Total = 1,    Type = "MASK"}, -- 1% de chance
	},

	INCOMUN = {
		{Name = "+300 XP",            possibility = 0.55,    Total = 300,  Type = "XP"}, -- 55% de chance
		{Name = "+375 XP",            possibility = 0.4,     Total = 375,  Type = "XP"}, -- 40% de chance
		{Name = "+550 XP",            possibility = 0.355,   Total = 550,  Type = "XP"}, -- 35.5% de chance
		{Name = "+600 XP",            possibility = 0.30,    Total = 600,  Type = "XP"}, -- 30% de chance
		{Name = "+80 Browm Button",   possibility = 0.2,     Total = 80,   Type = "BROWM_BUTTON"}, -- 20% de chance
		{Name = "+120 Browm Button",  possibility = 0.17,    Total = 120,  Type = "BROWM_BUTTON"}, -- 17% de chance
		{Name = "+300 Browm Button",  possibility = 0.155,   Total = 300,  Type = "BROWM_BUTTON"}, -- 15.5% de chance
		{Name = "+500 Browm Button",  possibility = 0.15,    Total = 500,  Type = "BROWM_BUTTON"}, -- 15% de chance
		{Name = "Icommun Gift",       possibility = 0.024,   Total = 1,    Type = "GIFT"}, -- 2.4% de chance
		{Name = "Rare Gift",          possibility = 0.02,    Total = 1,    Type = "GIFT"}, -- 2% de chance
		{Name = "Hair Mask",          possibility = 0.01,    Total = 1,    Type = "MASK"}, -- 1% de chance
	},

	RARE = {
		{Name = "+350 XP",            possibility = 0.55,    Total = 350,  Type = "XP"}, -- 55% de chance
		{Name = "+400 XP",            possibility = 0.4,     Total = 400,  Type = "XP"}, -- 40% de chance
		{Name = "+650 XP",            possibility = 0.355,   Total = 650,  Type = "XP"}, -- 35.5% de chance
		{Name = "+750 XP",            possibility = 0.30,    Total = 750,  Type = "XP"}, -- 30% de chance
		{Name = "+100 Browm Button",  possibility = 0.2,     Total = 100,  Type = "BROWM_BUTTON"}, -- 20% de chance
		{Name = "+300 Browm Button",  possibility = 0.17,    Total = 300,  Type = "BROWM_BUTTON"}, -- 17% de chance
		{Name = "+400 Browm Button",  possibility = 0.155,   Total = 400,  Type = "BROWM_BUTTON"}, -- 15.5% de chance
		{Name = "+680 Browm Button",  possibility = 0.15,    Total = 680,  Type = "BROWM_BUTTON"}, -- 15% de chance
		{Name = "Icommun Gift",       possibility = 0.024,   Total = 1,    Type = "GIFT"}, -- 2.4% de chance
		{Name = "Epic Gift",          possibility = 0.02,    Total = 1,    Type = "GIFT"}, -- 2% de chance
		{Name = "Hair Mask",          possibility = 0.01,    Total = 1,    Type = "MASK"}, -- 1% de chance
	},

	EPIC = {
		{Name = "+375 XP",            possibility = 0.55,    Total = 375,  Type = "XP"}, -- 55% de chance
		{Name = "+450 XP",            possibility = 0.4,     Total = 450,  Type = "XP"}, -- 40% de chance
		{Name = "+675 XP",            possibility = 0.355,   Total = 675,  Type = "XP"}, -- 35.5% de chance
		{Name = "+825 XP",            possibility = 0.30,    Total = 825,  Type = "XP"}, -- 30% de chance
		{Name = "+175 Browm Button",  possibility = 0.2,     Total = 175,  Type = "BROWM_BUTTON"}, -- 20% de chance
		{Name = "+480 Browm Button",  possibility = 0.17,    Total = 480,  Type = "BROWM_BUTTON"}, -- 17% de chance
		{Name = "+520 Browm Button",  possibility = 0.155,   Total = 520,  Type = "BROWM_BUTTON"}, -- 15.5% de chance
		{Name = "+750 Browm Button",  possibility = 0.15,    Total = 750,  Type = "BROWM_BUTTON"}, -- 15% de chance
		{Name = "Rare Gift",          possibility = 0.024,   Total = 1,    Type = "GIFT"}, -- 2.4% de chance
		{Name = "Legendary Gift",     possibility = 0.02,    Total = 1,    Type = "GIFT"}, -- 2% de chance
		{Name = "Cactus Mask",        possibility = 0.01,    Total = 1,    Type = "MASK"}, -- 1% de chance
	},

	LEGENDARY = {
		{Name = "+2500 XP",           possibility = 0.55,     Total = 2500,  Type = "XP"}, -- de 55% chance
		{Name = "+4000 XP",           possibility = 0.4,      Total = 4000,  Type = "XP"}, -- de 40% chance
		{Name = "+1500 Browm Button", possibility = 0.355,    Total = 1500,  Type = "BROWM_BUTTON"}, -- de 35,5% chance
		{Name = "+2000 Browm Button", possibility = 0.30,     Total = 2000,  Type = "BROWM_BUTTON"}, -- de 30% chance
		{Name = "Rare Gift",          possibility = 0.2,      Total = 1,     Type = "GIFT"}, -- de 20% chance
		{Name = "Cactus Mask",        possibility = 0.17,     Total = 1,     Type = "MASK"}, -- de 17% chance
	},
}

return giftlucklist
