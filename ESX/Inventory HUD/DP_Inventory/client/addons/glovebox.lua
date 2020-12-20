local gloveboxData = nil

RegisterNetEvent("DP_Inventory:openGloveboxInventory")
AddEventHandler("DP_Inventory:openGloveboxInventory", function(data, blackMoney, cashMoney, inventory, weapons)
	setGloveboxInventoryData(data, blackMoney, cashMoney, inventory, weapons)
	openGloveboxInventory()
end)

RegisterNetEvent("DP_Inventory:refreshGloveboxInventory")
AddEventHandler("DP_Inventory:refreshGloveboxInventory", function(data, blackMoney, cashMoney, inventory, weapons)
	setGloveboxInventoryData(data, blackMoney, cashMoney, inventory, weapons)
end)

function setGloveboxInventoryData(data, blackMoney, cashMoney, inventory, weapons)
	gloveboxData = data

	SendNUIMessage({
		action = "setInfoText",
		text = data.text
	})

	items = {}

	if blackMoney > 0 then
		accountData = {
			label = _U("black_money"),
			count = blackMoney,
			type = "item_account",
			name = "black_money",
			usable = false,
			rare = false,
			weight = 0,
			canRemove = false
		}
		table.insert(items, accountData)
	end

	if cashMoney > 0 then
		accountData = {
			label = _U("cash"),
			count = cashMoney,
			type = "item_money",
			name = "cash",
			usable = false,
			rare = false,
			weight = 0,
			canRemove = false
		}
		table.insert(items, accountData)
	end

	if inventory ~= nil then
		for key, value in pairs(inventory) do
			if inventory[key].count <= 0 then
				inventory[key] = nil
			else
				inventory[key].type = "item_standard"
				inventory[key].usable = false
				inventory[key].rare = false
				inventory[key].weight = -1
				inventory[key].canRemove = false
				table.insert(items, inventory[key])
			end
		end
	end

	SendNUIMessage({
		action = "setSecondInventoryItems",
		itemList = items
	})
end

function openGloveboxInventory()
	loadPlayerInventory()
	isInInventory = true
	SendNUIMessage({
		action = "display",
		type = "glovebox"
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoGlovebox", function(data, cb)
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		if data.item.type == "item_weapon" then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end
		TriggerServerEvent("DP_Inventory_glovebox:putItem", gloveboxData.plate, data.item.type, data.item.name, count, gloveboxData.max, gloveboxData.myVeh, data.item.label)
	end
	Wait(500)
	loadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("TakeFromGlovebox", function(data, cb)
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		TriggerServerEvent("DP_Inventory_glovebox:getItem", gloveboxData.plate, data.item.type, data.item.name, tonumber(data.number), gloveboxData.max, gloveboxData.myVeh)
	end
	Wait(500)
	loadPlayerInventory()
	cb("ok")
end)
