local ReplicatedStore = game:GetService("ReplicatedStorage")

local EffectControler = require(script.GuiEffects)

local InGui: string = "ShopGui"

local GuiControl: {} = {}

local HudBottons = {
	["InventoryBottom"]	=	function(Player) EffectControler.BlueControler(Player, InGui, true) InventoryHud(Player) end,
	["ConfigBottom"] 	=	function(Player) EffectControler.BlueControler(Player, InGui, true) ConfigHud(Player) end,
	["CreditBottom"] 	=	function(Player) EffectControler.BlueControler(Player, InGui, true) CreditHud(Player) end,
	["CodeBottom"] 	=	function(Player) EffectControler.BlueControler(Player, InGui, true) CodeHud(Player) end,
	["ShopBottom"] 	=	function(Player) EffectControler.BlueControler(Player, InGui, true) Shop(Player) end,
}

function ConfigHud(Player: Player) 
	
	InGui = "ConfigGui"
	print("Agora sou a: ConfigGui" )

	return
end

function CreditHud(Player: Player)
	return
end

function CodeHud(Player: Player)
	return
end

function InventoryHud(Player: Player)
	return
end	

function Shop(Player: Player)
	
	return print("Entrei aqui")
end

function GuiControl.RemoveGuiInScreem (ScreemName: ScreenGui?): ()
	if not ScreemName or ScreemName == "" then 
		
		print("Irei remover a GUI: " ..tostring(InGui).. " da sua tela.")
		InGui = "" or nil
		
		return true
		
		else
		
		print("Irei remover a GUI: " ..tostring(ScreemName).. " da sua tela.")
		InGui = "" or nil

		return true
	end

end

function GuiControl.OpenShopinMark(Player: Player)
	if InGui == "ShopGui" then return end
	InGui = "ShopGui"
	print("Teste")
	EffectControler.BlueControler(Player, InGui, true)
	Shop(Player)
end

function GuiControl:Init(Player: Player): ()
	EffectControler:Init(self.RemoveGuiInScreem)
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
