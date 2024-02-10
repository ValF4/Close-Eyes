local EffectControler = {} 

EffectControler.GuiEvent = function() return end 

local TweenService = game:GetService("TweenService")

local BlurEffect: BlurEffect = game:GetService("Lighting"):WaitForChild("Blur") 

local DefaltBlurAnimation: TweenInfo = TweenInfo.new(.1, Enum.EasingStyle.Linear)

local CreateBlurAnimation: Tween = TweenService:Create(BlurEffect, DefaltBlurAnimation, {Size = 24}) -- funciona
local RemoveBlur: Tween = TweenService:Create(BlurEffect, DefaltBlurAnimation, {Size = 0})

local db: {} = {}

function EffectControler:Init(Event)
	self.GuiEvent = Event 
end

local function ChekingGuiInScreem(Player: Player, InGui: string)

	if InGui == nil or InGui == "" then return true end

	local PlayerGui: PlayerGui = Player.PlayerGui or Player:WaitForChild("PlayerGui")
	local gameGuis: Folder = PlayerGui:WaitForChild("GAME_GUIS") 

	for _, ScreemName in gameGuis:GetChildren() do
		if tostring(ScreemName) == InGui then
			return EffectControler.GuiEvent(ScreemName)
		end 
	end 

end

function EffectControler.BlueControler(Player: Player, InGui: String, State: boolean)
	if db[Player.UserId] and tick() - db[Player.UserId] < .4 then return end db[Player.UserId] = tick()

	local ResponseCheskingGui = ChekingGuiInScreem(Player, InGui)

	if not State and not ResponseCheskingGui then
		RemoveBlur:Play()
	else
		CreateBlurAnimation:Play()	
	end
end 

return EffectControler
