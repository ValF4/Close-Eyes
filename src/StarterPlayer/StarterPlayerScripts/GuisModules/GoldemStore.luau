local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer.PlayerGui

local BuyGoldemGui: ScreenGui = PlayerGui:WaitForChild("BuyGoldemGui")

local MainFrame: Frame = BuyGoldemGui.MainFrame
local TemplateFolder: Folder = MainFrame.TemplateIten
local templateIten: ImageLabel = TemplateFolder.Template

local GoldemStore = {}

function GoldemStore.init()
    return
end

return GoldemStore