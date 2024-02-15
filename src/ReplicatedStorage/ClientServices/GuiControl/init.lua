local ReplicatedStore = game:GetService("ReplicatedStorage")

local EffectControler = require(script.GuiEffects)

local InGui: string = nil

local GuiControl = {}

local function ChargedGui(): ()
	return
end

local function HudControler(Player: Player, State: boolean): ()
	local PlayerGui: PlayerGui = Player.PlayerGui or Player:WaitForChild("PlayerGui")
	local Hud: ScreenGui = PlayerGui:WaitForChild("Hud",3) or PlayerGui.Hud

	if State then
		Hud.Enabled = false
	else
		Hud.Enabled = true
	end
end

local function RemoveGui(): ()
	InGui = nil
	return
end

local function InitGui(Player: Player, CallGui: string): ()
	if not CallGui then return end

	if InGui and InGui ~= CallGui then ChargedGui() end

	if InGui == CallGui then EffectControler.Controler(Player, false) RemoveGui() return end

	--HudControler(Player, true)
	EffectControler.Controler(Player, true)
	InGui = CallGui
end

local HudBottons = {
	["InventoryBottom"]	= function(Player: Player)
		InitGui(Player, "InventoryGui")
	end,

	["ConfigBottom"] 	=	function(Player)
		 InitGui(Player, "ConfigGui")
	end,

	["CreditBottom"] 	=	function(Player)
		 InitGui(Player, "CreditGui")
	end,

	["CodeBottom"] 		=	function(Player)
		InitGui(Player, "CodeGui")
	end,

	["ShopBottom"] 		=	function(Player)
		InitGui(Player, "ShopGui")
	end
}

function GuiControl:Init(Player: Player): ()
	local PlayerGui: PlayerGui = Player.PlayerGui or Player:WaitForChild("PlayerGui")
	local hud: ScreenGui = PlayerGui:WaitForChild("Hud",3) or PlayerGui.Hud

	local Bottons: Frame = hud.Bottons

	local function directionGui(Name: string): ()
		for index: string?, func in HudBottons do
			if Name == index then func(Player) end
		end
	end

	for index, bottom: TextButton in Bottons:GetChildren() do
		if not bottom:IsA("TextButton") then return end
		bottom.MouseButton1Up:Connect(function()
			directionGui(bottom.Name)
		end)
	end
end

return GuiControl
