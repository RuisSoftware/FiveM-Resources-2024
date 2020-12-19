local trunkData = nil

RegisterNetEvent("DP_Inventory:openTrunkInventory")
AddEventHandler("DP_Inventory:openTrunkInventory", function(data, blackMoney, cashMoney, inventory, weapons)
	setTrunkInventoryData(data, blackMoney, cashMoney, inventory, weapons)
	openTrunkInventory()
end)

RegisterNetEvent("DP_Inventory:refreshTrunkInventory")
AddEventHandler("DP_Inventory:refreshTrunkInventory", function(data, blackMoney, cashMoney, inventory, weapons)
	setTrunkInventoryData(data, blackMoney, cashMoney, inventory, weapons)
end)

function setTrunkInventoryData(data, blackMoney, cashMoney, inventory, weapons)
	trunkData = data

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

function openTrunkInventory()
	loadPlayerInventory()
	isInInventory = true
	SendNUIMessage({
		action = "display",
		type = "trunk"
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoTrunk", function(data, cb)
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		if data.item.type == "item_weapon" then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end
		TriggerServerEvent("DP_Inventory_trunk:putItem", trunkData.plate, data.item.type, data.item.name, count, trunkData.max, trunkData.myVeh, data.item.label)
	end
	Wait(500)
	loadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("TakeFromTrunk", function(data, cb)
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		TriggerServerEvent("DP_Inventory_trunk:getItem", trunkData.plate, data.item.type, data.item.name, tonumber(data.number), trunkData.max, trunkData.myVeh)
	end
	Wait(500)
	loadPlayerInventory()
	cb("ok")
end)
