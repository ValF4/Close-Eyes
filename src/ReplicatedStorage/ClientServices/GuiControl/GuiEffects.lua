local EffectControler = {}

local TweenService = game:GetService("TweenService")

local BlurEffect: BlurEffect = game:GetService("Lighting"):WaitForChild("Blur")
local PlayerCamera: Camera = workspace.CurrentCamera

local DefaltTweenAnimation: TweenInfo = TweenInfo.new(.1, Enum.EasingStyle.Linear)

local CreateBlurAnimation: Tween = TweenService:Create(BlurEffect, DefaltTweenAnimation, {Size = 24}) -- funciona
local RemoveBlur: Tween = TweenService:Create(BlurEffect, DefaltTweenAnimation, {Size = 0})

local AddFog: Tween = TweenService:Create(PlayerCamera, DefaltTweenAnimation, {FieldOfView = 85})
local RemoveFog: Tween = TweenService:Create(PlayerCamera, DefaltTweenAnimation, {FieldOfView = 70})

local db: {} = {}

local function BLurControler(State: boolean): ()
	if not State then
		RemoveBlur:Play()
	else
		CreateBlurAnimation:Play()
	end
end

local function FogControler(State: boolean): ()
	if not State then
		RemoveFog:Play()
	else
		AddFog:Play()
	end
end

function EffectControler.Controler(Player: Player?, State: boolean): ()
	if db[Player.UserId] and tick() - db[Player.UserId] < .4 then return end db[Player.UserId] = tick()

	if not State then
		BLurControler(false)
		FogControler(false)
	else
		BLurControler(true)
		FogControler(true)
	end
end

return EffectControler
