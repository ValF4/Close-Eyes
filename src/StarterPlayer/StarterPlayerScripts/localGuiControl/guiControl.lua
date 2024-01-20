local ReplicatedStore = game:GetService("ReplicatedStorage")

local PlayerFramework = require(ReplicatedStore.FrameWorks.playerWork) 

local GuiControl = {}

function GuiControl.Hud()

	local hud: ScreenGui = PlayerFramework.PlayerGui:WaitForChild("Hud")
	
	print(hud)

end

--local function

return GuiControl
