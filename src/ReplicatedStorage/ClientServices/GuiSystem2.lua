-- Create script for HeroGames
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer: Player = Players.LocalPlayer

local RemoveGuiAnimation: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear, Enum.EasingDirection.In, false)

local Module = {}
local ScreenGuis = {}
local GuiMetodos = {}

local templateGuiInfo = {
	instance = nil	:: ScreenGui,
	state = false :: boolean
}

GuiMetodos.__index = GuiMetodos

function GuiMetodos:CloseGui()
	local CreteRemoveAnimation: Tween = TweenService:Create()
	self.instance.Enabled = false
	self.state = false
	TweenService:Create(self.instance.canvasgroup,RemoveGuiAnimation,{GroupTranparency = 1}):Play()
end

function GuiMetodos:OpenGui()
	local CreteRemoveAnimation: Tween = TweenService:Create()
	self.instance.Enabled = true
	self.state = true
end


function Module:NewGui(screengui:ScreenGui)
	templateGuiInfo.instance = screengui
	templateGuiInfo.state = screengui.Enabled
	
	return setmetatable(templateGuiInfo,GuiMetodos)
end
function Module:Init()
	for _,Screengui: ScreenGui in LocalPlayer.PlayerGui:GetChildren() do
		ScreenGuis[Screengui.Name] = self:NewGui(Screengui)
	end
end

function Module:GetScreenList()
	return ScreenGuis
end

function Module:GetScrenGui(name:string)
	return ScreenGuis[name]
end

function Module:CheckScreenOpened()
	for name,proprieties in ScreenGuis do
		if proprieties.state == true then return name end
	end
end

function Module:ChangeGui(Name)
	for name,proprieties in ScreenGuis do
		if proprieties.state == true then
			proprieties.state.Enabled = false
		elseif	name == name then
			proprieties.state.Enabled = true
		end
		
	end	
end

return Module
