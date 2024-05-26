local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local playerGui: PlayerGui = Players.LocalPlayer.PlayerGui

local displayScroling: UDim2 = UDim2.fromScale(0.872, 0.224)
local recallScroling: UDim2 = UDim2.fromScale(2 ,0.224)

local Bridgnet2         = require(ReplicatedStorage.Packages.BridgeNet2)
local getInformations   = Bridgnet2.ClientBridge("getInformations")

local leaderBordControl = {}

local scrollTablePlayer: ScrollingFrame
local FrameTemplate: Frame

function leaderBordControl.upgradeList()
    
    for i: number, playerFrames: Frame | UIListLayout in scrollTablePlayer:GetChildren() do
        if playerFrames:IsA("Frame") and playerFrames.Name ~= "1" then playerFrames:Destroy() end
    end

    for i: number, player: Player in Players:GetPlayers() do
        local playerImg = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
        local templateClone: Frame = FrameTemplate:Clone()
        templateClone.Name = player.Name

        templateClone.DisplayName.Text = player.DisplayName
        templateClone.RealName.Text = "@" ..player.Name
        templateClone.playerphoto.Image = playerImg

        local getInfo = getInformations:InvokeServerAsync(player)

        if not getInfo then repeat task.wait() until getInfo end

        templateClone.BrowmBottom.Text = getInfo.BrowmBottom
        templateClone.GoldemBottom.Text = getInfo.GoldemBottom

		templateClone.Parent = scrollTablePlayer
        templateClone.Visible = true
    end
end

function leaderBordControl.init()
    repeat task.wait() until not ReplicatedFirst:GetAttribute("LOADING_RESOURCES")

    local LeaderbordGui: ScreenGui = playerGui:WaitForChild("Leaderboard")
    local TemplateFolder: Folder = LeaderbordGui:FindFirstChild("TemplatePlayer")

    scrollTablePlayer = LeaderbordGui:FindFirstChild("PlayerScroller")
    FrameTemplate = TemplateFolder:FindFirstChild("FrameTemplate")

    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if input.KeyCode == Enum.KeyCode.Tab then
            if scrollTablePlayer.Position == UDim2.fromScale(0.872, 0.224) then
                scrollTablePlayer:TweenPosition(recallScroling, "Out", "Quad", 0.1)
            else
                scrollTablePlayer:TweenPosition(displayScroling, "Out", "Quad", 0.1)
            end
        end
    end)

    leaderBordControl.upgradeList()

    Players.PlayerAdded:Connect(leaderBordControl.upgradeList)
    Players.PlayerRemoving:Connect(leaderBordControl.upgradeList)
end

return leaderBordControl