local ServerStorage = game:GetService("ServerStorage")
local players = game:GetService("Players")

local profiles = require(ServerStorage.Services.SubServices.Profiles)
local ProfileService = require(ServerStorage.ServerPackages.ProfileService)

local module = {}

export type ProfileType= {
	Coins:number,
	Level:number,
	Gems:number,
	XP:number,
	Inventory:{[string]:{}}
}

local profileTemplate:ProfileType = {
	Coins = 0,
	Level = 0,
	Gems = 0,
	XP = 0,
	Inventory = {},
	Config = {},
}	

local function TableClone(original)
	local copy = {}
	for k, v in pairs(original) do
		if type(v) == "table" then
			v = TableClone(v)
		end
		copy[k] = v
	end
	return copy
end

--game:GetService("DataStoreService"):GetDataStore("playerData")
local profileStore = ProfileService.GetProfileStore("TesteData", profileTemplate)

function onPlayerAdded(player)
	
	local profile = profileStore:LoadProfileAsync(`{player.UserId}`)
	
	profile:AddUserId(player.UserId)
	profile:Reconcile() -- Sincroniza a data do player com o template
	profile:ListenToRelease(function()
		profiles[player.UserId] = nil
		player:Kick()
	end)
	
	if player:IsDescendantOf(players) then
		profiles[player.UserId] = profile
	else
		profile:Release() -- Libera a data para poder carregar em outros servidores
	end
	
end

local function onPlayerRemoving(player)
	
	local profile = profiles[player.UserId]

	if profile then
		profile:Release() -- Libera a data para poder carregar em outros servidores
	end
	
end

function module:GetData(player): {any}
	
	local profile = profiles[player.UserId]
	
	while not profile and player:IsDescendantOf(players) do
		
		profile = profiles[player.UserId]
		
		if profile then break end
		
		task.wait(.4)
	end
	
	if profile then
		return profile.Data
	end
	
end

function module.Init()
	
	for index, player in players:GetPlayers() do
		task.spawn(onPlayerAdded, player)
	end
	
	players.PlayerAdded:Connect(onPlayerAdded)
	players.PlayerRemoving:Connect(onPlayerRemoving)
	
end

return module