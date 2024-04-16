local codeGui = {}

local DEFALT_MENSAGER: string = "Type here"
local ERROR_MENSAGER: string = "Invalid or incorrect code"
local SUCESS_MENSAGER: string = "Valid code, reward redeemed"

local DEFALT_COLOR: Color3 = Color3.fromRGB(178, 178, 178)
local ERROR_COLOR: Color3 = Color3.fromRGB(255,0,0)
local SUCESS_COLOR: Color3 = Color3.fromRGB(0,255,0)

local function AlertCode(input: TextBox, alertType: string)
    if not input or not alertType then return end
    if alertType == "SUCESS" then
        input.PlaceholderText = SUCESS_MENSAGER input.PlaceholderColor3 = SUCESS_COLOR
        task.wait(2)
        input.PlaceholderText = DEFALT_MENSAGER input.PlaceholderColor3 = DEFALT_COLOR
    else
        input.PlaceholderText = ERROR_MENSAGER input.PlaceholderColor3 = ERROR_COLOR
        task.wait(2)
        input.PlaceholderText = DEFALT_MENSAGER input.PlaceholderColor3 = DEFALT_COLOR
    end
    return
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

    redeemBottom.MouseButton1Click:Connect(function()
        local getTextInInput: string | number = input.Text
        if not getTextInInput or getTextInInput == "" then AlertCode(input, "ERROR") return end
        print(getTextInInput)

    end)
end

return codeGui