local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

local codeGui = {}

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local CodeSystemEvent = Bridgnet2.ReferenceBridge("CodeSystem")

local DEFALT_MENSAGER: string = "Type here"
local ERROR_MENSAGER: string = "Invalid or incorrect code"
local SUCESS_MENSAGER: string = "Valid code, reward redeemed"

local DEFALT_COLOR: Color3 = Color3.fromRGB(178, 178, 178)
local ERROR_COLOR: Color3 = Color3.fromRGB(255,0,0)
local SUCESS_COLOR: Color3 = Color3.fromRGB(0,255,0)

local function AlertCode(input: TextBox, alertType: string)
    if not input or not alertType then return end

    if alertType == "SUCESS" then
        input.Text = SUCESS_MENSAGER
        input.TextColor3 = SUCESS_COLOR
        task.wait(2)
        input.Text = DEFALT_MENSAGER
        input.TextColor3 = DEFALT_COLOR
    elseif alertType == "ERROR" then
        input.Text = ERROR_MENSAGER
        input.TextColor3 = ERROR_COLOR
        task.wait(2)
        input.Text = DEFALT_MENSAGER
        input.TextColor3 = DEFALT_COLOR
    end
end

function codeGui:init(Player: Player): ()

    local PlayerGui: PlayerGui = Player.PlayerGui

    local folderGuis: Folder = PlayerGui:FindFirstChild("GAME_GUIS")
    local codeScreem: ScreenGui = folderGuis:FindFirstChild("CodeGui")
    local mainCodeFrame: Frame = codeScreem:FindFirstChild("MainFrame")
    local codeFrame: Frame = mainCodeFrame:FindFirstChild("Code")
    local itensFrame: Frame = codeFrame:FindFirstChild("Frame")

    local input: TextBox = itensFrame:FindFirstChild("input")
    local redeemBottom: TextButton = itensFrame:FindFirstChild("redeem")

    input.Focused:Connect(function()
        input.ClearTextOnFocus = true
    end)

    redeemBottom.MouseButton1Click:Connect(function()
        local getTextInInput: string | number = input.Text
        if not getTextInInput or getTextInInput == "" then AlertCode(input, "ERROR") return end
        
        local ckekingCode = CodeSystemEvent:InvokeServerAsync(getTextInInput)

        if ckekingCode then
            AlertCode(input, "SUCESS")
        elseif not ckekingCode then
            AlertCode(input, "ERROR")
        end
    end)
end

return codeGui