local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local AnchoredPlayerEvent = Bridgnet2.ReferenceBridge("AnchoredPlayer")

local GameControler = {}

function GameControler.CheckingAtributes(LocalPlayer: Player): ()
	local InitThread: thread = task.spawn(function()
        while task.wait() do

            local GetLoadingAtribute: boolean? = ReplicatedFirst:GetAttribute("IN_LOADING")

            if not GetLoadingAtribute then

                local Content = {
                    HumanoitRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart"),
                    State = true
                }
                
                AnchoredPlayerEvent:Fire(Content)
                break
            end
        end
    end)
end

return GameControler