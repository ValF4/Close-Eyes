local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local GetPlayerInventory = Bridgnet2.ReferenceBridge("GET_INVENTORY")
local EquipItem = Bridgnet2.ReferenceBridge("EQUIP_ITEM")
local GetCurrentMask = Bridgnet2.ReferenceBridge("GET_CURRENT_MASK")

local ViewAnimation: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear)

local PossitionList = {
  ["ViewInventory"] = UDim2.fromScale(0.338, 0.5),
  ["OcultInventory"] = UDim2.fromScale(0.5, 0.5),
  ["ViewCloseButtom"] = UDim2.fromScale(0.64, 0.067),
  ["OcultCloseButtom"] = UDim2.fromScale(0.8, 0.067),
  ["ViewFrame"] = UDim2.fromScale(0.85, 0.5),
  ["OcultViewFrame"] = UDim2.fromScale(0.5, 0.5),
}
local inventoryModule = {}
local MaskFolder: Folder =  ReplicatedStorage.Masks

local CurrentFrame: string
local inView: boolean
local Inventoryconection: RBXScriptSignal

local Rarity = {
  commun = Color3.fromRGB(136, 103, 61),
  uncommon = Color3.fromRGB(67, 136, 61),
  rare = Color3.fromRGB(103, 68, 143),
  legendary = Color3.fromRGB(252, 217, 141),
}

local Masks = {
  ["BAGMASK"]     = {ID = "BAGMASK", Name = "Bag mask", Rarity = "commun", ImageID = ""},
  ["SPIDERMASK"]  = {ID = "SPIDERMASK", Name = "Spider mask", Rarity = "uncommon", ImageID = ""},
  ["HAIRMASK"]    = {ID = "HAIRMASK", Name = "Hair mask", Rarity = "rare", ImageID = ""},
  ["CACTUSMASK"]  = {ID = "CACTUSMASK", Name = "Cactus mask", Rarity = "legendary", ImageID = ""}
}

function ViewControler(Player: Player, Item: string)
  if CurrentFrame == Item then return end
  
  local PlayerGui: PlayerGui = Player.PlayerGui
  local GuiFolders: Folder = PlayerGui.GAME_GUIS
  local InventoryScreem: ScreenGui = GuiFolders.InventoryGui
  local Frame: Frame = InventoryScreem.MainFrame

  local InventoryFrame: Frame = Frame.Inventory
  local ExitBottom: ImageButton = Frame.ExitBottom
  
  local PreviewFrame: Frame = Frame.Preview
  local Viewframe: Frame = PreviewFrame.View
  local EquipBottom: ImageButton = PreviewFrame.Equip
  local MaskNameLabel: TextLabel = PreviewFrame.MaskName
  local RarityLabel: TextLabel = PreviewFrame.Rarity

  if CurrentFrame ~= Item and CurrentFrame then
    for i: number, Item in Viewframe:GetChildren() do
      if Item:IsA("ViewportFrame") then Item:Destroy() end
    end
  end

  CurrentFrame = Item
  
  local CurrentMask = GetCurrentMask:InvokeServerAsync(Player)

  if not inView then
    TweenService:Create(InventoryFrame, ViewAnimation, {Position = PossitionList.ViewInventory}):Play()
    TweenService:Create(ExitBottom, ViewAnimation, {Position = PossitionList.ViewCloseButtom}):Play()
    PreviewFrame.Visible = true
    local FinishViewAnimation: TweenService = TweenService:Create(PreviewFrame, ViewAnimation, {Position = PossitionList.ViewFrame})
    FinishViewAnimation:Play()
    FinishViewAnimation.Completed:Wait()
    PreviewFrame.ZIndex = 2
    inView = true
  end

  if CurrentMask ~= CurrentFrame then
    local Exit
    MaskNameLabel.Text = Masks[Item].Name
    RarityLabel.Text = Masks[Item].Rarity
    EquipBottom.Text = "Equip"
  
    local connectEquibottom = EquipBottom.MouseButton1Click:Connect(function()
      local equipStatus = EquipItem:InvokeServerAsync(Player, Item)
      if equipStatus then
          EquipBottom.Text = "Equipped item"
          task.wait(.5)
          EquipBottom.Text = "Equip"
      end
    end)
  
    Exit = ExitBottom.MouseButton1Down:Connect(function() connectEquibottom:Disconnect() Exit:Disconnect() end)
  else
    local Exit
    MaskNameLabel.Text = Masks[Item].Name
    RarityLabel.Text = Masks[Item].Rarity
    EquipBottom.Text = "Equipped"
  
    Exit = ExitBottom.MouseButton1Down:Connect(function() Exit:Disconnect() end)
  end


end

local function CreatMaskView(Player: Player, Item: string)
  local PlayerGui: PlayerGui = Player.PlayerGui
  local GuiFolders: Folder = PlayerGui.GAME_GUIS
  local InventoryScreem: ScreenGui = GuiFolders.InventoryGui
  local Frame: Frame = InventoryScreem.MainFrame
  
  local PreviewFrame: Frame = Frame.Preview
  local ViewFrame: Frame = PreviewFrame.View

  local View: ViewportFrame = Instance.new("ViewportFrame")
  local Camera: Camera = Instance.new("Camera")
  local Mask: Model = MaskFolder:FindFirstChild(Item):Clone()
  
  View.AnchorPoint = Vector2.new(0.5, 0.5)
  View.Position = UDim2.fromScale(0.5, 0.5)
  View.BackgroundTransparency = 1
  View.BorderSizePixel = 0
  View.Parent = ViewFrame
  View.CurrentCamera = Camera
  Camera.CFrame = CFrame.new(0, 0, 2.5)
  View.Size = UDim2.fromScale(0.85, 0.85)
  Camera.Parent = View
  Mask.Parent = View
  Mask:PivotTo(CFrame.fromOrientation(math.pi / 2, math.pi, 0))
  
  
end

local function resetGuiConfig(Player: Player): ()
  local PlayerGui: PlayerGui = Player.PlayerGui

  local GuiFolders: Folder = PlayerGui.GAME_GUIS
  local InventoryScreem: ScreenGui = GuiFolders.InventoryGui
  local Frame: Frame = InventoryScreem.MainFrame

  local ExitBottom: ImageButton = Frame.ExitBottom
  local PreviewFrame: Frame = Frame.Preview
  local ViewFrame: Frame = PreviewFrame.View
  
  local InventoryFrame: Frame = Frame.Inventory

  for _, Item in ViewFrame:GetChildren() do
    if Item:IsA("ViewportFrame") then Item:Destroy() end
  end

  InventoryFrame.Position = PossitionList.OcultInventory
  ExitBottom.Position = PossitionList.OcultCloseButtom
  PreviewFrame.Position = PossitionList.OcultViewFrame
  PreviewFrame.ZIndex = 1
  PreviewFrame.Visible = false
  inView = nil
  CurrentFrame = nil
end

function inventoryModule.init(Player: Player): ()
    local PlayerGui: PlayerGui = Player.PlayerGui

    local GuiFolders: Folder = PlayerGui.GAME_GUIS
    local InventoryScreem: ScreenGui = GuiFolders.InventoryGui
    local Frame: Frame = InventoryScreem.MainFrame

    local ItentemplateFolder: Folder = Frame.ItemTemplate
    local ExitBottom: ImageButton = Frame.ExitBottom
    
    local InventoryFrame: Frame = Frame.Inventory
    local SrollingInventory: ScrollingFrame = InventoryFrame.ScrollingFrame

    local PlayerInventory = GetPlayerInventory:InvokeServerAsync(Player)
    
    if not PlayerInventory then return end

    for index:number, Item: string in PlayerInventory do
      local clone = ItentemplateFolder.ItemFrame:Clone()
      local CloneMask: Model = MaskFolder:FindFirstChild(Item):Clone()
      local Camera: Camera = Instance.new("Camera")
      Camera.CFrame = CFrame.new(0, 0, 2.5)
      clone.ViewportFrame.CurrentCamera = Camera
      clone.UIStroke.Color = Rarity[Masks[Item].Rarity]
      clone.ItemName.Text = Masks[Item].Name
      clone.Name = Item
      clone.Visible = true
      Camera.Parent = clone.ViewportFrame
      CloneMask.Parent = clone.ViewportFrame
      clone.Parent = SrollingInventory
      CloneMask:PivotTo(CFrame.fromOrientation(math.pi / 2, 0, 0))
      
      Inventoryconection = RunService.Heartbeat:Connect(function(DeltaTime: number): RBXScriptSignal
        CloneMask:PivotTo(CloneMask:GetPivot() * CFrame.fromOrientation(0, 0, math.rad(90 * DeltaTime)))
      end)

      clone.Button.MouseButton1Down:Connect(function()
        CreatMaskView(Player, Item)
        ViewControler(Player, Item)
      end)

    end

    local CloseGui
    CloseGui= ExitBottom.MouseButton1Down:Connect(function()

      resetGuiConfig(Player)
      Inventoryconection:Disconnect()
      CloseGui:Disconnect()

      for index, Iten in SrollingInventory:GetChildren() do
        if Iten:IsA("Frame") then Iten:Destroy() end
      end
    end)
end

return inventoryModule

--[[{
  Name: String,
  Rarity: String,
}
  
--]]