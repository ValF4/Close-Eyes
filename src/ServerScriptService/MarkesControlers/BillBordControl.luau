local TeleportService = game:GetService("TeleportService")

local BillboardControl = {}

local BreakConter: boolean

local MaxPlayers: number = 8
local MaxTemp: number = 60
local MinTemp: number = 10

local function TeleportGroup(): ()
	
end

local function timer(label: TextLabel, playersInGroup: {Player}): ()
	
	if not label or not playersInGroup then return end
	if label:GetAttribute("timerHolding") then return end
	
	label:SetAttribute("timerHolding", true)
	
	local function StopHolding()
		label.Text = `Aguardando jogadores...`
		label:SetAttribute("timerHolding")
	end
	
	if #playersInGroup == 0 then
		StopHolding()
	elseif #playersInGroup == MaxPlayers then
		for remainTime = 10, 0, -1 do
			task.wait(1)
			label.Text = `Iniciando em {remainTime} segundos!`
			if #playersInGroup ~= MaxPlayers then return StopHolding() end
		end
		TeleportGroup(playersInGroup)
	else
		for remainTime = MaxTemp, 0, -1 do
			label.Text = `Iniciando em {remainTime} segundos!`
			if #playersInGroup == 0 then return StopHolding() end
		end
		TeleportGroup(playersInGroup)
	end
	
end

function BillboardControl.ViewPortControler(MarkParent: Model, playersInGroup: number): ()
	
	if not playersInGroup then
		local markersTable = workspace:WaitForChild("InitGameMarks"):GetChildren()

		for index, marker: Model in markersTable do
			local billboard = marker.ViewPort.BillboardGui

			local timerLabel: TextLabel = billboard.Frame.Timer
			local playersLabel: TextLabel = billboard.Frame.TotalPlayer

			playersLabel.Text = `0/{MaxPlayers}`
			timer(timerLabel, playersInGroup)
		end
		
	else
		local billboard: BillboardGui = MarkParent.ViewPort.BillboardGui
		if not billboard then return warn("ERROR - Not find Viewport or BillboarGui") end

		local timerLabel: TextLabel = billboard.Frame.Timer
		local playersLabel: TextLabel = billboard.Frame.TotalPlayer
		
		playersLabel.Text = `{#playersInGroup}/{MaxPlayers}`
		timer(timerLabel, playersInGroup)
	end
	
end

return BillboardControl