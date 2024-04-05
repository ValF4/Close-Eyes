local codeGui = {}

function codeGui:init(Player: Player): ()

    local PlayerGui: PlayerGui = Player.PlayerGui

    local folderGuis: Folder = PlayerGui:FindFirstChild("GAME_GUIS")
    local codeScreem: ScreenGui = folderGuis:FindFirstChild("CodeGui")
    local mainCodeFrame: Frame = codeScreem:FindFirstChild("MainFrame")
    local codeFrame: Frame = mainCodeFrame:FindFirstChild("Code")
    local itensFrame: Frame = codeFrame:FindFirstChild("Frame")

    local input: TextBox = itensFrame:FindFirstChild("input")
    local redeemBottom: TextButton = itensFrame:FindFirstChild("redeem")

    --for index: number, item: UICorner | TextButton | TextLabel | ImageLabel in itensFrame:GetChildren() do
    --    if item ~= item:IsA("ImageLabel") then return end
    --    print(item)
    --end
end

return codeGui