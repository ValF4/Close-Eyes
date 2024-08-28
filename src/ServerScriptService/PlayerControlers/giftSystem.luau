local giftSystem = {}

local ServerScriptService = game:GetService("ServerScriptService")

local lists = ServerScriptService:WaitForChild("ServerLists")

local ItemInformation = require(lists.giftLuckList)

local playerLuck: number = 1

local moduleName: string = "[Gift System]"

local function SelectItems(luckAdjusted: {})
	--Chance base
	local totalBaseChance = 0
	
	for _, values in luckAdjusted do
		totalBaseChance = totalBaseChance + values.itemPossibility
	end
	
	--número aleatório
	local random = math.random() * totalBaseChance
	
	--Pegar o item aleatório até zera o número aleatório
	for _, values in luckAdjusted do
		if random <= values.itemPossibility then
			return {item = values.itemName, Type = values.itemType}
		else
			random = random - values.itemPossibility
		end
	end
	
end

local function AdjustItems(luck: number, gift: string)
	--Peso
	local weight = 0
	
	local itemTypeInfo = ItemInformation[string.upper(gift)]
	if not itemTypeInfo then return warn(`{moduleName} Name item not find.`) end
	
	--Ajustar o peso
	for index, info in itemTypeInfo do
		weight = weight + info.possibility
	end
	
	local adjustedItems = {}
	
	--Ajustar a sorte dos itens
	for index, item in itemTypeInfo do
		local itemChance = 0

		if item.possibility <= weight / luck then
			itemChance = item.possibility * luck
		else
			itemChance = item.possibility / luck
		end


		
		table.insert(adjustedItems, {itemName = item.Name, itemPossibility = itemChance, itemType = item.Type})
	end

	return adjustedItems
end

function giftSystem.init(playerLuck: number, gift: string)
	if not playerLuck or not gift then warn(`{moduleName} Player luck or gift name is nil or not exist.`) end
    local itens: {} = {}
	local totalGift: number = math.random(3, 6)
	
	for i = 1, totalGift, 1 do
		if #itens >= totalGift then break end
		local ajust = AdjustItems(playerLuck, gift)
		local item: string = SelectItems(ajust)
		table.insert(itens, item)
	end
	
    return itens
end

return giftSystem