local ReplicatedFirst = game:GetService("ReplicatedFirst")
local StarterPlayer = game:GetService("StarterPlayer")
local TweenService = game:GetService("TweenService")

local timeInitAnimation: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
local InifinitTimeAnimation: TweenInfo = TweenInfo.new(60, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 1, true)

local BottomMouseAnimation: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)
local TextHudTransparency: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

local EffectControler = require(script.GuiEffects)
local CodeModule = require(StarterPlayer.StarterPlayerScripts.GuisModules.CodeModule)

local InGui: string = nil

local GuiControl: {} = {}

local TextBottons = {
	CalendarBottom 		= "Daily Rewards",
	MissionBottom 		= "Missions",
	InventoryBottom 	= "Inventory",
	ShopBottom 			= "Shop",
	ConfigBottom		= "Config"
}

local function OpenGui(Player: Player, Gui: string, CodePosition: UDim2): ()
	if not Player or not Gui then return end

	local PlayerGui: PlayerGui = Player.PlayerGui
	local Game_Guis: Folder = PlayerGui:FindFirstChild("GAME_GUIS")
	local GuiManager: ScreenGui = Game_Guis:FindFirstChild(Gui)

	if not GuiManager then return end

	local GetBackgroundEffect: ImageLabel = GuiManager:FindFirstChild("Texture")
	local GetMainFrame: Frame = GuiManager:FindFirstChild("MainFrame")
	if not GetBackgroundEffect or not GetMainFrame then return end

	local OpenFrameAnimation: Tween = TweenService:Create(GetMainFrame, timeInitAnimation, {Position = UDim2.new(CodePosition.X, CodePosition.Y)}) -- {0.173, 0},{-5, 0}
	local InitBackgroundAnimation: Tween = TweenService:Create(GetBackgroundEffect, timeInitAnimation, {ImageTransparency = 0.6})
	local infinitAnimationBackground: Tween = TweenService:Create(GetBackgroundEffect, InifinitTimeAnimation, {Position = UDim2.fromScale(1.0, 0.5)})

	GuiManager.Enabled = true

	OpenFrameAnimation:Play()
	infinitAnimationBackground:Play()
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
		local ClosedGuiAnimation: Tween = TweenService:Create(GetFrameInGui, timeInitAnimation, {Position = UDim2.fromScale(0.5, -0.5)})
		ClosedGuiAnimation:Play()
		ClosedGuiAnimation.Completed:Wait()
		EffectControler.Controler(Player, false)
		GuiControl.HudControler(Player, false)
		GetScreemGui.Enabled = false
		InGui = nil
		return
	end

	GetClosedBottom.MouseButton1Down:Connect(ClosedFrame)
end

local function InitGui(Player: Player, CallGui: string, Position: UDim2): ()
	if not CallGui then return end

	if ReplicatedFirst:GetAttribute("UpgradeGui") then return end

	EffectControler.Controler(Player, true)
	--OpenGui(Player, CallGui, Position)
	--GuiControl.HudControler(Player, true)
	--RemoveGui(Player, CallGui)
	--InGui = CallGui
end

local HudBottons = {
	["InventoryBottom"]	= function(Player: Player)
		print("InventoryBottom")
		--InitGui(Player, "InventoryGui", UDim2.fromScale(0.5, 0.5))
		-- TODO Respective function Gui 
	end,

	["ConfigBottom"] =function(Player)
		print("ConfigBottom")
		 --InitGui(Player, "ConfigGui", UDim2.fromScale(0.5, 0.5))
		 -- TODO Respective function Gui 
	end,

	["CalendarBottom"] = function(Player)
		print("CalendarBottom")
		 --InitGui(Player, "CreditGui", UDim2.fromScale(0.5, 0.5))
	end,

	["MissionBottom"] =	function(Player: Player)
		print("MissionBottom")
		--InitGui(Player, "CodeGui", UDim2.fromScale(0.5, 0.5))
		--CodeModule:init(Player)
	end,

	["ShopBottom"] 	= function(Player)
		print("ShopBottom")
		--InitGui(Player, "ShopGui", UDim2.fromScale(0.5, 0.5))
		-- TODO Respective function Gui
	end,

	["BuyGoldemBottom"] = function(Player)
		print("BuyGoldemBottom")
		--InitGui(Player, "ShopGui", UDim2.fromScale(0.5, 0.5))
		-- TODO Respective function Gui
	end,
}

function GuiControl:init(Player: Player): ()
	local PlayerGui: PlayerGui = Player.PlayerGui
	local hud: ScreenGui = PlayerGui:WaitForChild("Hud", 5) or PlayerGui.Hud

	local FrameButtons: Frame = hud:GetChildren()

	local Db: boolean
	local OcultHud: boolean

	local function directionGui(Name: string): ()
		if not Name then return end
		local GetFunction = HudBottons[Name]
		if not GetFunction then warn("Function in HudButtons not find.") end
		GetFunction(Player)
	end

	for _, iten: Frame | ImageButton in FrameButtons do
		if iten:IsA("ImageButton") then
			iten.MouseButton1Up:Connect(function()
				directionGui(iten.Name)
			end)
		else
			if iten.Name == "Coins_Frame" then continue end
			for _, Bottom: ImageButton in iten:GetChildren() do
				if not Bottom:IsA("ImageButton") then continue end

				Bottom.MouseEnter:Connect(function(x, y)
					local GetText: TextLabel = Bottom.Parent:FindFirstChild(TextBottons[Bottom.Name])
					TweenService:Create(Bottom, BottomMouseAnimation, {Size = UDim2.fromScale(0.35, 0.45)}):Play()
					TweenService:Create(GetText, TextHudTransparency, {TextTransparency = 0}):Play()
				end)

				Bottom.MouseLeave:Connect(function(x, y)
					local GetText: TextLabel = Bottom.Parent:FindFirstChild(TextBottons[Bottom.Name])
					TweenService:Create(Bottom, BottomMouseAnimation, {Size = UDim2.fromScale(0.3, 0.4)}):Play()
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
