local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local startPlayerScript
local animations: Folder

local maskInput: Enum.KeyCode = Enum.KeyCode.F
local squatinput: Enum.KeyCode = Enum.KeyCode.G

local debounce: boolean

local MODULE_NAME: string = "[Player Mechanics - LOCAL]"

local squatStatusName: string = "squatStatus"
local maskStatusName: string = "maskStatus"

local playerMachines = {}

function playerMachines.animationManager(character: Model, animationType: string): ()
    local function startAnimation(humanoid: Humanoid, animationName: string): ()
		assert(humanoid and animationType, `{MODULE_NAME} - Humanoid não foi enviado como parametro para a função addMask.`)
		local animation: Animation = animations[animationName]
        assert(animation, `{MODULE_NAME} - maskAdd not found`)
        local track: Animator = humanoid:WaitForChild("Animator"):LoadAnimation(animation)
        track:Play()
    end

    assert(character and animationType, `{MODULE_NAME} - Character or animationType sent by playerMachines.squatAnimation is nil.`)
    
    local humanoid: Humanoid = character:FindFirstChild("Humanoid")

    assert(humanoid, `{MODULE_NAME} - Error in locating Humanoid in character.`)

    if animationType == "Mask" then
        if character:GetAttribute(maskStatusName) == true then
            startAnimation(humanoid, "maskRemove")
            character:SetAttribute(maskStatusName, false)
            return false
        elseif character:GetAttribute(maskStatusName) == false then
            startAnimation(humanoid, "maskAdd")
            character:SetAttribute(maskStatusName, true)
            return true
        end
    end

    if animationType == "Squat" then
        if character:GetAttribute(maskStatusName) == true then
            startAnimation(humanoid, "raice")
            character:SetAttribute(squatStatusName, false)
            return false
        elseif character:GetAttribute(maskStatusName) == false then
            startAnimation(humanoid, "squat")
            character:SetAttribute(squatStatusName, true)
            return true
        else
            assert(animationType, `{MODULE_NAME} - Animation Type sent `)
        end
    end

end


function playerMachines.init(Player: Player): ()
	assert(Player, `{MODULE_NAME} = Player não foi enviando como parametro para a função init`)
	
    startPlayerScript = Player.PlayerScripts
    animations = startPlayerScript:WaitForChild("animations")

    local Character: Model = Player.Character or Player.CharacterAdded:Wait()

    if not Character:GetAttribute(maskStatusName) or not Character:GetAttribute("squatStatus") then
        if not Character:GetAttribute(maskStatusName) then
            Character:SetAttribute(maskStatusName, false)
        end

        if not not Character:GetAttribute(squatStatusName) then
            Character:SetAttribute(squatStatusName, false)
        end
        
    end

    local function processInput(animationType: string)
        assert(animationType, `{MODULE_NAME} - AnimationType`)
        if debounce == true then return end
        debounce = true
        local initAnimation: boolean = playerMachines.animationManager(Character, animationType)
        if initAnimation or not initAnimation then debounce = false end
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)

		if input.KeyCode == maskInput and not gameProcessedEvent then


        end

		if input.KeyCode == squatinput and not gameProcessedEvent then
            if debounce == true then return end
            debounce = true
            local initAnimation: boolean = playerMachines.animationManager(Character, "Squat")
            if initAnimation or not initAnimation then debounce = false end
        end
    end)

    Character:GetAttributeChangedSignal(maskStatusName):Connect(function()
        playerMachines.walkControler(Character:GetAttribute(maskStatusName))
    end)
end
--TODO: Localizar o atachmet da mão para setar a mascara na mão do player ao iniciar a animação
-- Usar o contectActionService

return playerMachines