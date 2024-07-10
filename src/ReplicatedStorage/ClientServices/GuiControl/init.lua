local ReplicatedFirst = game:GetService("ReplicatedFirst")
local StarterPlayer = game:GetService("StarterPlayer")
local TweenService = game:GetService("TweenService")

local timeInitAnimation: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
local InifinitTimeAnimation: TweenInfo = TweenInfo.new(60, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 1, true)

local BottomMouseAnimation: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
local TextHudTransparency: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

local EffectControler = require(script.GuiEffects)
local MissionsModule = require(StarterPlayer.StarterPlayerScripts.GuisModules.MissionModule)
local GoldemStoreModule = require(StarterPlayer.StarterPlayerScripts.GuisModules.GoldemStore)
local InventoryModule = require(StarterPlayer.StarterPlayerScripts.GuisModules.InventoryModule)

local OriginalBottomSize: UDim2 = UDim2.fromScale(0.26, 0.205)
local UppcaseBottomSize: UDim2 = UDim2.fromScale(0.33, 0.295)

local InGui: string = nil

local GuiControl: {} = {}

local TextBottons = {
	MissionBottom 		= {OriginalBottomSize = UDim2.fromScale(0.26, 0.205),UppcaseBottomSize = UDim2.fromScale(0.33, 0.295), Name = "Missions",},
	InventoryBottom 	= {OriginalBottomSize = UDim2.fromScale(0.26, 0.205),UppcaseBottomSize = UDim2.fromScale(0.33, 0.295), Name = "Inventory",},
	ShopBottom 			= {OriginalBottomSize = UDim2.fromScale(0.26, 0.205),UppcaseBottomSize = UDim2.fromScale(0.33, 0.295), Name = "Shop",},
	ConfigBottom		= {OriginalBottomSize = UDim2.fromScale(0.26, 0.535),UppcaseBottomSize = UDim2.fromScale(0.33, 0.650), Name = "Config",},
}

local function ResetSizeIcons(Player: Player): ()
	local PlayerGui: PlayerGui = Player.PlayerGui
	local Hud: ScreenGui = PlayerGui.Hud

	local HudFrames = {
		["ConfigFrame"] = Hud.Config_Frame,
		["Players Tools Frame"] = Hud.Players_Tools_Frame
	}

	for _, Frame: Frame in HudFrames do
		for _, Iten in Frame:GetChildren() do
			if Iten:IsA("ImageButton") then
				Iten.Size = OriginalBottomSize
			elseif Iten:IsA("TextLabel") then
				Iten.TextTransparency = 1
			else
				continue
			end
		end
	end
end

local function OpenGui(Player: Player, Gui: string, CodePosition: UDim2): ()
	if not Player or not Gui then return end

	local PlayerGui: PlayerGui = Player.PlayerGui
	local Game_Guis: Folder = PlayerGui:FindFirstChild("GAME_GUIS")
	local GuiManager: ScreenGui = Game_Guis:FindFirstChild(Gui)

	if not GuiManager then return end

	local GetBackgroundEffect: ImageLabel = GuiManager:FindFirstChild("Opacitybackground")
	local GetMainFrame: Frame = GuiManager:FindFirstChild("MainFrame")
	if not GetBackgroundEffect or not GetMainFrame then return end

	local OpenFrameAnimation: Tween = TweenService:Create(GetMainFrame, timeInitAnimation, {Position = UDim2.new(CodePosition.X, CodePosition.Y)}) -- {0.173, 0},{-5, 0}
	local InitBackgroundAnimation: Tween = TweenService:Create(GetBackgroundEffect, timeInitAnimation, {BackgroundTransparency = 0.5})

	GuiManager.Enabled = true

	OpenFrameAnimation:Play()
	InitBackgroundAnimation:Play()

end

function GuiControl.HudControler(Player: Player, State: boolean): ()
	if not Player or State == nil then return end

	local PlayerGui: PlayerGui = Player.PlayerGui
	local Hud: ScreenGui = PlayerGui:FindFirstChild("Hud") or PlayerGui.Hud

	if State then
		Hud.Enabled = false
	else
		Hud.Enabled = true
	end
end

local function RemoveGui(Player: Player ,FindGui: ScreenGui): ()
	local PlayerGui: PlayerGui = Player.PlayerGui
	local GameGuiFolder: Folder = PlayerGui:FindFirstChild("GAME_GUIS")
	local GetScreemGui: ScreenGui = GameGuiFolder:FindFirstChild(FindGui)
	
	if not GetScreemGui then return end
	
	local GetFrameInGui: Frame = GetScreemGui:FindFirstChild("MainFrame")
	local GetClosedBottom: ImageButton = GetFrameInGui:FindFirstChild("ExitBottom")

	local function ClosedFrame(): ()
		local ClosedGuiAnimation: Tween = TweenService:Create(GetFrameInGui, timeInitAnimation, {Position = UDim2.fromScale(0.5, -2)})
		ClosedGuiAnimation:Play()
		ClosedGuiAnimation.Completed:Wait()
		EffectControler.Controler(Player, false)
		GuiControl.HudControler(Player, false)
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		GetScreemGui.Enabled = false
		InGui = nil
		return
	end

	GetClosedBottom.MouseButton1Down:Connect(ClosedFrame)
end

local function InitGui(Player: Player, CallGui: string, Position: UDim2): boolean
	if not CallGui and ReplicatedFirst:GetAttribute("UpgradeGui") then return end

	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	EffectControler.Controler(Player, true)
	RemoveGui(Player, CallGui)
	GuiControl.HudControler(Player, true)
	ResetSizeIcons(Player)
	OpenGui(Player, CallGui, Position)

	InGui = CallGui
	return true
end

local HudBottons = {
	["InventoryBottom"]	= function(Player: Player)
		local InitScreem = InitGui(Player, "InventoryGui", UDim2.fromScale(0.5, 0.5))
		if not InitScreem then return end
		InventoryModule.init(Player)
	end,

	["ConfigBottom"] =function(Player)
		print("ConfigBottom")
		 --InitGui(Player, "ConfigGui", UDim2.fromScale(0.5, 0.5))
		 -- TODO Respective function Gui 
	end,

	["MissionBottom"] =	function(Player: Player)
		local InitScreem = InitGui(Player, "MissionsGui", UDim2.fromScale(0.5, 0.5))
		if not InitScreem then return end
		MissionsModule.init(Player)
	end,

	["ShopBottom"] 	= function(Player)
		print("ShopBottom")
		--InitGui(Player, "ShopGui", UDim2.fromScale(0.5, 0.5))

	end,

	["BuyGoldemBottom"] = function(Player)
		local InitScreem = InitGui(Player, "BuyGoldemGui", UDim2.fromScale(0.5, 0.5))
		if not InitScreem then return end
		GoldemStoreModule.init(Player)
	end,
}

function GuiControl:init(Player: Player): ()
	local PlayerGui: PlayerGui = Player.PlayerGui
	local hud: ScreenGui = PlayerGui:WaitForChild("Hud", 5) or PlayerGui.Hud

	local FrameButtons: Frame = hud:GetChildren()

	local function directionGui(Name: string): ()
		if not Name then return end
		local GetFunction = HudBottons[Name]
		if not GetFunction then warn("Function in HudButtons not find.") end
		GetFunction(Player)
	end

	for _, iten: Frame | ImageButton in FrameButtons do
		if iten:IsA("Frame") then
			for _, Bottom in iten:GetChildren() do

				if not Bottom:IsA("ImageButton") then continue end

				Bottom.MouseEnter:Connect(function(): ()
					if Bottom.Name == "BuyGoldemBottom" then return end
					local GetText: TextLabel = Bottom.Parent:FindFirstChild(TextBottons[Bottom.Name].Name)
					TweenService:Create(Bottom, BottomMouseAnimation, {Size = TextBottons[Bottom.Name].UppcaseBottomSize}):Play()
					TweenService:Create(GetText, TextHudTransparency, {TextTransparency = 0}):Play()
				end)

				Bottom.MouseLeave:Connect(function(): ()
					if Bottom.Name == "BuyGoldemBottom" then return end
					local GetText: TextLabel = Bottom.Parent:FindFirstChild(TextBottons[Bottom.Name].Name)
					TweenService:Create(Bottom, BottomMouseAnimation, {Size = TextBottons[Bottom.Name].OriginalBottomSize}):Play()
					TweenService:Create(GetText, TextHudTransparency, {TextTransparency = 1}):Play()
				end)

				Bottom.MouseButton1Up:Connect(function()
					directionGui(Bottom.Name)
				end)

			end
		end
	end
end

return GuiControl
