local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local startPlayerScript
local animations: Folder

local maskInput: Enum.KeyCode = Enum.KeyCode.F
local squatinput: Enum.KeyCode = Enum.KeyCode.G

local debounce: boolean = false

local MODULE_NAME: string = "[Player Mechanics - LOCAL]"

local playerMachines = {}
local mask: boolean = false

function playerMachines.maskAnimationManager(character: Model): ()
    if not character then warn(`{MODULE_NAME} - Character sent by playerMachines.squatAnimation is nil.`) return end
    
    local function addMask(humanoid: Humanoid): ()
        local maskAddAnimation: Animation = animations.maskAdd
        if not maskAddAnimation then warn(`{MODULE_NAME} - maskAdd not found`) return end
        local track: Animator = humanoid:WaitForChild("Animator"):LoadAnimation(maskAddAnimation)
        print(track)
    end

    local function removeMask(humanoid: Humanoid): ()
        local maskRemoveAnimation: Animation = animations.maskRemove
        if not maskRemoveAnimation then warn(`{MODULE_NAME} - maskRemove not found`) return end
        local track: Animator = humanoid:WaitForChild("Animator"):LoadAnimation(maskRemoveAnimation)
        print(track)
    end
    
    local humanoid: Humanoid = character:FindFirstChild("Humanoid")

    if not humanoid then warn(`{MODULE_NAME} - Error in locating Humanoid in character.`) return end

    if mask == true then
        removeMask()
        mask = false
        return false
    elseif not mask or mask == false then
        addMask()
        mask = false
        return true
    end

end

function playerMachines.squatAnimation(character: Model): ()
    return
end

function playerMachines.init(Player: Player): ()
    if not Player then return end

    startPlayerScript = Player.PlayerScripts
    animations = startPlayerScript:WaitForChild("animations")

    local Character: Model = Player.Character or Player.CharacterAdded:Wait()

    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if not gameProcessedEvent then return end

        if input.KeyCode == maskInput then
            if debounce == false then return end
            debounce = true
            local initAnimation: boolean = playerMachines.maskAnimationManager(Character)
            if initAnimation == true then
                debounce = false
            end
        end

        if input.KeyCode == squatinput then
            if debounce == false then return end
            debounce = true
            local initAnimation: boolean = playerMachines.squatAnimation(Character)
            if initAnimation == true then
                debounce = false
            end
        end
    end)
end
--TODO: Localizar o atachmet da mão para setar a mascara na mão do player ao iniciar a animação
-- Usar o contectActionService

return playerMachines