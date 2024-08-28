local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")

local Bridgnet2 = require(ReplicatedStorage.Packages.BridgeNet2)

local inventoryModule = {}

local MODULE_NAME: string = "[Inventory Module - Client]"

local GetPlayerInventory = Bridgnet2.ReferenceBridge("GET_INVENTORY")
local EquipItem = Bridgnet2.ReferenceBridge("EQUIP_ITEM")
local GetCurrentMask = Bridgnet2.ReferenceBridge("GET_CURRENT_MASK")
local GiftOpen = Bridgnet2.ReferenceBridge("GIFT_OPEN")

local ViewAnimation: TweenInfo = TweenInfo.new(.2, Enum.EasingStyle.Linear)
local GiftTweenInfo: TweenInfo = TweenInfo.new(.5, Enum.EasingStyle.Cubic)

local MaskFolder: Folder =  ReplicatedStorage.Masks
local GiftFolder: Folder = ReplicatedStorage.Gifts

local initScreen: string = "MASK"

local uncheckedColorButtontton: Color3 = Color3.fromHex("000000")
local selectColorButton: Color3 = Color3.fromHex("FFC37A")

local CurrentFrame: string
local Screen: string
local giftinView: string
local maskinView: string
local inView: boolean 
local Inventoryconection: RBXScriptSignal
local giftConnection: RBXScriptSignal

export type PossitionList = {
  ViewInventory: UDim2,
  OcultInventory: UDim2,
  ViewCloseButtom: UDim2,
  OcultCloseButtom :UDim2,
  ViewFrame :UDim2,
  OcultViewFrame :UDim2,
} 

local PossitionList = {
  ["ViewInventory"] = UDim2.fromScale(0.338, 0.5),
  ["OcultInventory"] = UDim2.fromScale(0.5, 0.5),
  ["ViewCloseButtom"] = UDim2.fromScale(0.64, 0.067),
  ["OcultCloseButtom"] = UDim2.fromScale(0.8, 0.067),
  ["ViewFrame"] = UDim2.fromScale(0.85, 0.5),
  ["OcultViewFrame"] = UDim2.fromScale(0.5, 0.5),
}

export type Rarity = {
  commun: Color3,
  icommun: Color3,
  rare: Color3,
  epic: Color3,
  legendary: Color3,
} 

local Rarity = {
  common = Color3.fromRGB(136, 103, 61),
  incomum = Color3.fromRGB(67, 136, 61),
  rare = Color3.fromRGB(103, 68, 143),
  epic = Color3.fromRGB(28, 19, 39),
  legendary = Color3.fromRGB(252, 217, 141),
}

export type GiftsModel = {
  COMMON: MeshPart,
  UNCOMMON: MeshPart,
  RARE: MeshPart,
  EPIC: MeshPart,
  LEGENDARY: MeshPart,
}

local GiftsModel = {
  ["COMMON"] = GiftFolder["Meshes/GIFT_BOX_COMMON"],
  ["UNCOMMON"] = GiftFolder["Meshes/GIFT_BOX_UNCOMMON"],
  ["RARE"] = GiftFolder["Meshes/GIFT_BOX_RARE"],
  ["EPIC"] = GiftFolder["Meshes/GIFT_BOX_EPIC"],
  ["LEGENDARY"] = GiftFolder["Meshes/GIFT_BOX_LEGENDARY"]
}

export type Masks = {
  BAGMASK: {ID: string, Name: string, Rarity: string, Model: Model},
  SPIDERMASK: {ID: string, Name: string, Rarity: string, Model: Model},
  HAIRMASK: {ID: string, Name: string, Rarity: string, Model: Model},
  CACTUSMASK: {ID: string, Name: string, Rarity: string, Model: Model},
} 

local Masks = {
  ["BAGMASK"]     = {ID = "BAGMASK",Name = "Bag mask", Rarity = "common", Model = MaskFolder.BAGMASK},
  ["SPIDERMASK"]  = {ID = "SPIDERMASK", Name = "Spider mask", Rarity = "uncommon", Model = MaskFolder.SPIDERMASK},
  ["HAIRMASK"]    = {ID = "HAIRMASK", Name = "Hair mask", Rarity = "rare", Model = MaskFolder.HAIRMASK},
  ["CACTUSMASK"]  = {ID = "CACTUSMASK", Name = "Cactus mask", Rarity = "legendary", Model = MaskFolder.CACTUSMASK}
}

export type Itens = {
  XP:string,
  BROWM_BUTTON: string,
  GIFT: {[string]: string},
  MASK: {[string]: string},
} 

local Itens = {
  ["XP"]           = "rbxassetid://18193174919",
  ["BROWM_BUTTON"] = "rbxassetid://18206847829",
  ["GIFT"] = {
    ["COMMON"] = GiftFolder["Meshes/GIFT_BOX_COMMON"],
    ["Icommun Gift"] = GiftFolder["Meshes/GIFT_BOX_UNCOMMON"],
    ["Rare Gift"] = GiftFolder["Meshes/GIFT_BOX_RARE"],
    ["EPIC"] = GiftFolder["Meshes/GIFT_BOX_EPIC"],
    ["LEGENDARY"] = GiftFolder["Meshes/GIFT_BOX_LEGENDARY"]
  },
  ["MASK"] = {
    ["Hair Mask"] = MaskFolder.HAIRMASK,
    ["Spider Mask"] = MaskFolder.SPIDERMASK,
    ["Cactus Mask"] = MaskFolder.CACTUSMASK,
  },
}

local function apresentGifts(instanceList, list: {[number]: string})
  if not list or not instanceList then warn(`{MODULE_NAME} - Ajust list or Player is nil or not was not sent.`) return end
  
  local openGiftFrame: Frame = instanceList.inventoryScreem:FindFirstChild("OpenGiftFrame")

  if not openGiftFrame then warn(`{MODULE_NAME} - openGiftFrame is nil.`) return end

  local templatesItens: Folder = openGiftFrame.Templates
  local itensViewsFrame: Frame = openGiftFrame.ItensFrame

  itensViewsFrame.Visible = true

  local viewFrame: Frame

  for index: number, iten: {[string]: {string | Model}} in list do

    local temp = iten.VIEW
    
    if type(iten.VIEW) == "string" then
      viewFrame = templatesItens.img_Iten_Frame:clone()
      viewFrame.ItemName.Text = iten.ITEM_NAME
      viewFrame.Parent = itensViewsFrame
    elseif temp:IsA("MeshPart") or temp:IsA("Model") then
      viewFrame = templatesItens.view_Iten_Frame:clone()
      local Camera: Camera = Instance.new("Camera")
      local item: MeshPart | Model = temp:Clone()
      viewFrame.ItemName.Text = iten.ITEM_NAME
      viewFrame.Item.CurrentCamera = Camera
      Camera.CFrame = CFrame.new(0, 0, 2.5)
      Camera.Parent = viewFrame.Item
      viewFrame.Parent = itensViewsFrame
      item.Parent = viewFrame.Item
      item:PivotTo(CFrame.Angles(math.rad(25),0,0))
    end

    viewFrame.Visible = true
    local viewFrameSizeAnimation: Tween = TweenService:Create(viewFrame, TweenInfo.new(.5, Enum.EasingStyle.Bounce), {Size = UDim2.fromScale(1, 1)})
    TweenService:Create(viewFrame.SunRaid, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {Rotation = 360}):play()

    viewFrameSizeAnimation:Play()
    viewFrameSizeAnimation.Completed:Wait()

    task.wait(2)

    local viewFrameunSizeAnimation: Tween = TweenService:Create(viewFrame, TweenInfo.new(.8, Enum.EasingStyle.Linear), {Size = UDim2.fromScale(0, 0)})
    viewFrameunSizeAnimation:Play()
    viewFrameunSizeAnimation.Completed:Wait()

    viewFrame:Destroy()

  end

  return true
end

local function ajustGifts(list): {[number]: {string}}
  if not list then warn(`{MODULE_NAME} - Item list is nil.`) return end
  local ajustList: {} = {}

  for _, itenList in list do
    if not itenList.Type or not itenList.item then warn(`{MODULE_NAME} - Type in item list or item is nil or not exist`) return end
    if itenList.Type == "XP" or itenList.Type == "BROWM_BUTTON" then
      if not Itens[itenList.Type] then warn(`{MODULE_NAME} - Iten XP or Browm Button in list not find in itens or is nil in table.`) return end
      local content = {["ITEM_NAME"] = itenList.item, ["VIEW"] = Itens[itenList.Type]}
      table.insert(ajustList, content)
    
      elseif itenList.Type == "GIFT" or itenList.Type == "MASK" then
      
        if itenList.Type == "GIFT" then
          if not Itens[itenList.Type] then warn(`{MODULE_NAME} - Iten Gift in list not find in Itens or is nil in table.`) return end
          local content = {["ITEM_NAME"] = itenList.item, ["VIEW"] = Itens["GIFT"][itenList.item]}
          table.insert(ajustList, content)
        end
        if itenList.Type == "MASK" then
          if not Itens[itenList.Type] then warn(`{MODULE_NAME} - Iten Mask in list not find in Itens or is nil in table.`) return end
          local content = {["ITEM_NAME"] = itenList.item, ["VIEW"] = Itens["MASK"][itenList.item]}
          table.insert(ajustList, content)
        end
      end
    end

    return ajustList
end

local function scrollingItensDelete(Srolling: ScrollingFrame?): ()
  if #Srolling:GetChildren() == 0 then return end

  for _, Iten in Srolling:GetChildren() do
    if Iten:IsA("Frame") then Iten:Destroy() end
  end
end

local function resetGuiConfig(content: {Frame | ScreenGui}): ()

  if not content then return end

  local ExitBottom: ImageButton = content.Frame.ExitBottom
  local PreviewFrame: Frame = content.Frame.Preview
  local ViewFrame: Frame = PreviewFrame.View
  
  local InventoryFrame: Frame = content.Frame.Inventory

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

local function upgradeList(instanceListr): ()
  if not instanceListr then return end
  scrollingItensDelete(instanceListr.MainFrame.Inventory.ScrollingFrame)
  inventoryModule.GiftInventory()
end

local function openGiftView(Content: {string | number}, instanceList): ()
  print(instanceList)
   -- TODO: Arrumar o bug do content (tinha um content que passava uma numeração e um Item para esta função) -- Resolvido
   -- Passar o instanceList para todas as funções para redução de linhas de codigo -- Resolvido
   -- Reorganizar o module para ficar mais facil a manuteção futura -- Ressolvido
   -- Passar a lista de itens e raridades para outro modulo para redição de linha de codigo
   -- Arrumar o bug de desaparecer o presente no preview, ainda não foi localizado o bug
  if not Content or not instanceList then return end

  local conncetion

  local giftClick = false

  local GitfFrame: Frame = instanceList.InventoryScreem.OpenGiftFrame
  local ExitBottom: ImageButton = GitfFrame.ExitBottom
  
  local giftmodel: Model = GiftsModel[Content.ITEN]
  if not giftmodel then return end

  instanceList.Frame.Visible = false
  GitfFrame.Visible = true

  ExitBottom.MouseButton1Down:Connect(function(x, y): RBXScriptConnection
    SoundService:PlayLocalSound(SoundService.Guisounds.Press)
    conncetion:Disconnect() 
    GitfFrame.NoticeGift.TextTransparency = 1
    GitfFrame.Visible = false
    instanceList.Frame.Visible = true
    if #GitfFrame.ViewportFrame:GetChildren() > 1 then
      for _, iten: Model | MeshPart in GitfFrame.ViewportFrame:GetChildren() do
        iten:Destroy()
      end
    end
  end)

  local function createGiftView()
    local giftClone = giftmodel:Clone()
    local currentCamere: Camera = Instance.new("Camera")
    currentCamere.CFrame = CFrame.new(0 ,0 ,0)
    currentCamere.Parent = GitfFrame.ViewportFrame
    
    giftClone:PivotTo(CFrame.new(0,0,-90) * CFrame.fromOrientation(math.rad(50), 0, 0))
    giftClone.Parent = GitfFrame.ViewportFrame
    return giftClone
  end
  
  local giftClone = createGiftView()
  local transitionGift: Tween = TweenService:Create(giftClone, GiftTweenInfo, {CFrame = CFrame.new(0,0,-5)})
  transitionGift:Play()
  transitionGift.Completed:Wait()

  GitfFrame.OpenButton.Interactable = true
  
  local StartTime = tick()

  task.spawn(function()
    conncetion = RunService.Heartbeat:Connect(function()
      if giftClick == true then
        conncetion:Disconnect()
      end
      local CurrentTime = (tick() - StartTime)
      if CurrentTime >= 3 then
        TweenService:Create(GitfFrame.NoticeGift, TweenInfo.new(.5), {TextTransparency = 0}):Play()
        conncetion:Disconnect()
      end
    end)
  end)

  local function openGiftAnimation(giftClone)
    if not giftClone then return end

    local time: number = 0.1
    
    for _: number = 1, 10, 1 do
      local left: Tween = TweenService:Create(giftClone, TweenInfo.new(time), {CFrame = CFrame.new(0,0,-5) * CFrame.Angles(0, 0, math.rad(-25))})
      left:Play(); left.Completed:Wait()
      local center: Tween = TweenService:Create(giftClone, TweenInfo.new(time), {CFrame = CFrame.new(0,0,-5) * CFrame.Angles(0, 0, 0)})
      center:Play(); center.Completed:Wait()
      local rigth: Tween = TweenService:Create(giftClone, TweenInfo.new(time), {CFrame = CFrame.new(0,0,-5) * CFrame.Angles(0, 0, math.rad(25))})
      rigth:Play(); rigth.Completed:Wait()
      local returnCenter: Tween = TweenService:Create(giftClone, TweenInfo.new(time), {CFrame = CFrame.new(0,0,-5) * CFrame.Angles(0, 0, 0)})
      returnCenter:Play(); returnCenter.Completed:Wait()
      time -= 0.05
    end

    SoundService:PlayLocalSound(SoundService.Guisounds.OpenGift)

    local remove: Tween = TweenService:Create(giftClone, GiftTweenInfo, {CFrame = CFrame.new(0,0,-90)})
    remove:Play(); remove.Completed:Wait()

    giftClone:Destroy()
  end

  local ckickOpenGift
  ckickOpenGift = GitfFrame.OpenButton.MouseButton1Down:Connect(function()
    if giftClick then return end
    giftClick = true

    local getGift = GiftOpen:InvokeServerAsync(Content.ITEN)
    local ajustListGift = ajustGifts(getGift)
    
    if not getGift or not ajustListGift then warn(`{MODULE_NAME} - getGift or ajustListGift is nil.`) return end

    ExitBottom.Interactable = not ExitBottom.Interactable

    TweenService:Create(ExitBottom, TweenInfo.new(.5), {ImageTransparency = 1}):Play()
    TweenService:Create(GitfFrame.NoticeGift, TweenInfo.new(1), {TextTransparency = 1}):Play()

    openGiftAnimation(giftClone)

    local apresent: boolean = apresentGifts(instanceList, ajustListGift)
    
    if apresent then
      instanceList.Frame.Visible = true
      GitfFrame.Visible = false
    end
  end)

end

local function ViewControler(Item: {[string]: string | number} | string, instanceList): ()

  if not Item or not instanceList then return end

  if type(Item) == "table" then
    if CurrentFrame == Item.ITEN then return end
    CurrentFrame = Item.ITEN
  elseif type(Item) == "string" then
      if CurrentFrame == Item then return end
      CurrentFrame = Item
  end 

  local Player: Player = Players.LocalPlayer

  local InventoryFrame: Frame = instanceList.Frame.Inventory
  local ExitBottom: ImageButton = instanceList.Frame.ExitBottom
  
  local PreviewFrame: Frame = instanceList.Frame.Preview
  local EquipBottom: ImageButton = PreviewFrame.Equip
  local MaskNameLabel: TextLabel = PreviewFrame.MaskName
  local RarityLabel: TextLabel = PreviewFrame.Rarity

  local function openViewFrame(): ()
    TweenService:Create(InventoryFrame, ViewAnimation, {Position = PossitionList.ViewInventory}):Play()
    TweenService:Create(ExitBottom, ViewAnimation, {Position = PossitionList.ViewCloseButtom}):Play()
    PreviewFrame.Visible = true
    local FinishViewAnimation: TweenService = TweenService:Create(PreviewFrame, ViewAnimation, {Position = PossitionList.ViewFrame})
    FinishViewAnimation:Play()
    FinishViewAnimation.Completed:Wait()
    PreviewFrame.ZIndex = 2
    inView = true
  end

  local function configTexts(typeItem: string, status: string)
    if not typeItem or not status then return end
    
    if typeItem == "MASK" then
      MaskNameLabel.Text = Masks[Item].Name
      RarityLabel.Text = Masks[Item].Rarity
      EquipBottom.Text = status
    elseif typeItem == "GIFT" then
      MaskNameLabel.Text = "Gift"
      RarityLabel.Text = string.lower(Item.ITEN)
      EquipBottom.Text = status
    end
  end

  if Screen == "MASK" then
    local CurrentMask = GetCurrentMask:InvokeServerAsync(Player)
    if not CurrentMask then error(`{MODULE_NAME} - Current mask return nil or error`, 1) end

    if not inView then
      openViewFrame()
    end

    if CurrentMask ~= CurrentFrame then
      local Exit
      configTexts("MASK", "Equip")
      local connectEquibottom = EquipBottom.MouseButton1Click:Connect(function()
        local equipStatus = EquipItem:InvokeServerAsync(Player, Item)
        if equipStatus then
            EquipBottom.Text = "Equipped item"
            task.wait(.5)
            EquipBottom.Text = "Equip"
        end
      end)
    
      Exit = ExitBottom.MouseButton1Down:Connect(function() SoundService:PlayLocalSound(SoundService.Guisounds.Press) connectEquibottom:Disconnect() Exit:Disconnect() end)
    else
      local Exit
      configTexts("MASK", "Equipped")
      Exit = ExitBottom.MouseButton1Down:Connect(function() SoundService:PlayLocalSound(SoundService.Guisounds.Press) Exit:Disconnect() end)
    end
  end

  if Screen == "GIFT" then

    if not inView then
      openViewFrame()
    end

    local Exit
    configTexts("GIFT", "Open")
  
    local connectEquibottom = EquipBottom.MouseButton1Click:Connect(function(): ()
      SoundService:PlayLocalSound(SoundService.Guisounds.Press)
      openGiftView(Item, instanceList)
    end)

    Exit = ExitBottom.MouseButton1Down:Connect(function() SoundService:PlayLocalSound(SoundService.Guisounds.Press) connectEquibottom:Disconnect() Exit:Disconnect() end)
  end
end

local function deletView(item: Frame): ()
  if not item then return end
  for _, content in item:GetChildren() do
    if content:IsA("ViewportFrame") then content:Destroy() continue end
  end
end

local function CreatMaskView(Item: string, content): ()

  if not content then return end
  
  local PreviewFrame: Frame = content.Frame.Preview
  local ViewFrame: Frame = PreviewFrame.View

  if maskinView == Item then return end

  if not maskinView or maskinView ~= Item then
   -- deletView(ViewFrame)
    maskinView = Item

    local View: ViewportFrame = Instance.new("ViewportFrame")
    local Camera: Camera = Instance.new("Camera")
    local Mask: Model = Masks[Item].Model:Clone()
    
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
end

local function CreatGiftView(Item: string, content): ()

  if not content then return end

  local PreviewFrame: Frame = content.Frame.Preview
  local ViewFrame: Frame = PreviewFrame.View

  if giftinView == Item then return end

  if not giftinView or giftinView ~= Item then
--    deletView(ViewFrame)
    giftinView = Item

    local View: ViewportFrame = Instance.new("ViewportFrame")
    local Camera: Camera = Instance.new("Camera")
    local Gift: Model = GiftsModel[Item]:Clone()
    
    View.AnchorPoint = Vector2.new(0.5, 0.5)
    View.Position = UDim2.fromScale(0.5, 0.5)
    View.BackgroundTransparency = 1
    View.BorderSizePixel = 0
    View.Parent = ViewFrame
    View.CurrentCamera = Camera
    Camera.CFrame = CFrame.new(0, 0, 3)
    View.Size = UDim2.fromScale(0.85, 0.85)
    Camera.Parent = View
    Gift.Parent = View
    Gift:PivotTo(CFrame.Angles(math.rad(25),0,0))
  end
end

function inventoryModule.GiftInventory(Player: Player, content): ()
  if not content then return end
  local ItentemplateFolder: Folder = content.Frame.ItemTemplate

  local InventoryFrame: Frame = content.Frame.Inventory
  local SrollingInventory: ScrollingFrame = InventoryFrame.ScrollingFrame

  local PlayerGiftInventory = GetPlayerInventory:InvokeServerAsync("GIFT")
    
  if not PlayerGiftInventory then return end
  
  for index, Item: string in PlayerGiftInventory do
    local clone = ItentemplateFolder.ItemFrame:Clone()
    local CloneMask: Model = GiftsModel[Item]:Clone()
    local Camera: Camera = Instance.new("Camera")
    Camera.CFrame = CFrame.new(0, 0, 2.7)
    clone.ViewportFrame.CurrentCamera = Camera
    clone.UIStroke.Color = Rarity[string.lower(Item)]
    clone.ItemName.Text = string.lower(Item)
    clone.Name = index
    clone.Visible = true
    Camera.Parent = clone.ViewportFrame
    CloneMask.Parent = clone.ViewportFrame
    clone.Parent = SrollingInventory
    CloneMask:PivotTo(CFrame.fromOrientation(0, math.pi / 2, 0))
    
    giftConnection = RunService.Heartbeat:Connect(function(DeltaTime: number): RBXScriptSignal
      CloneMask:PivotTo(CloneMask:GetPivot() * CFrame.fromOrientation(0, math.rad(90 * DeltaTime), 0))
    end)

    clone.Button.MouseButton1Down:Connect(function()
      SoundService:PlayLocalSound(SoundService.Guisounds.Press)
      CreatGiftView(Item, content)
      ViewControler({["ITEN"] = Item, ["INDEX"] = index}, content)
    end)
    end
end

function inventoryModule.MaskInventory(content): ()
  if not content then return end

  local ItentemplateFolder: Folder = content.Frame.ItemTemplate

  local InventoryFrame: Frame = content.Frame.Inventory
  local SrollingInventory: ScrollingFrame = InventoryFrame.ScrollingFrame

  local PlayerMaskInventory = GetPlayerInventory:InvokeServerAsync("MASK")
    
  if not PlayerMaskInventory then return end

  for _, Item: string in PlayerMaskInventory do
    local clone = ItentemplateFolder.ItemFrame:Clone()
    local CloneMask: Model = Masks[Item].Model:Clone()
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
      SoundService:PlayLocalSound(SoundService.Guisounds.Press)
      CreatMaskView(Item, content)
      ViewControler(Item, content)
    end)

  end
end

local function exchangeGuide(Player: Player, content, View: string): ()
  if not Player or not content then return end

  local InventoryFrame: Frame = content.Frame.Inventory
  
  local GiftButton: TextButton = InventoryFrame.Gifts
  local MaskButton: TextButton = InventoryFrame.Masks
  
  if View == "GIFT" then
    MaskButton.UIStroke.Color = uncheckedColorButtontton
    GiftButton.UIStroke.Color = selectColorButton
    Screen = "GIFT"
  elseif View == "MASK" then
    GiftButton.UIStroke.Color = uncheckedColorButtontton
    MaskButton.UIStroke.Color = selectColorButton
    Screen = "MASK"
  end
end

function inventoryModule.init(Player: Player): ()
    local PlayerGui: PlayerGui = Player.PlayerGui

    local GuiFolders: Folder = PlayerGui.GAME_GUIS
    local InventoryScreem: ScreenGui = GuiFolders.InventoryGui
    local Frame: Frame = InventoryScreem.MainFrame

    local ExitBottom: ImageButton = Frame.ExitBottom
    
    local InventoryFrame: Frame = Frame.Inventory
    local SrollingInventory: ScrollingFrame = InventoryFrame.ScrollingFrame
    local GiftButton: TextButton = InventoryFrame.Gifts
    local MaskButton: TextButton = InventoryFrame.Masks

    local contents = { PlayerGui = PlayerGui, GuiFolders = GuiFolders, InventoryScreem = InventoryScreem, Frame = Frame}

    exchangeGuide(Player, contents, initScreen)
    inventoryModule.MaskInventory(contents)

    MaskButton.MouseButton1Down:Connect(function(): ()
      SoundService:PlayLocalSound(SoundService.Guisounds.Press)
      if Screen == "MASK" then return end
      resetGuiConfig(contents)
      scrollingItensDelete(SrollingInventory)
      exchangeGuide(Player, contents, "MASK")
      inventoryModule.MaskInventory(contents)
    end)

    GiftButton.MouseButton1Down:Connect(function(): ()
      SoundService:PlayLocalSound(SoundService.Guisounds.Press)
      if Screen == "GIFT" then return end
      resetGuiConfig(contents)
      scrollingItensDelete(SrollingInventory)
      exchangeGuide(Player, contents, "GIFT")
      inventoryModule.GiftInventory(Player, contents)
    end)

    local CloseGui
    CloseGui = ExitBottom.MouseButton1Down:Connect(function(): ()
      SoundService:PlayLocalSound(SoundService.Guisounds.Press)
      resetGuiConfig(contents)
      scrollingItensDelete(SrollingInventory)

      local sucess: boolean, _: string = pcall(function()
        Inventoryconection:Disconnect()
        giftConnection:Disconnect()
      end)
  
      CloseGui:Disconnect()
    end)
end

return inventoryModule