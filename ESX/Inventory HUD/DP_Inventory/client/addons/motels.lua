RegisterNetEvent("DP_Inventory:openMotelsInventory")
AddEventHandler("DP_Inventory:openMotelsInventory", function(data)
	setPropertyMotelData(data)
	openMotelInventory()
end)

function refreshPropertyMotelInventory()
	ESX.TriggerServerCallback("DP_Motels:getPropertyInventory", function(inventory)
		setPropertyMotelData(inventory)
	end, ESX.GetPlayerData().identifier )
end

function setPropertyMotelData(data)
	items = {}

	SendNUIMessage({
		action = "setInfoText",
		text = _("motels")
	})

	local blackMoney = data.blackMoney
	local money = data.money
	local propertyItems = data.items
	local propertyWeapons = data.weapons

	if blackMoney > 0 then
		accountData = {
			label = _U("black_money"),
			count = blackMoney,
			type = "item_account",
			name = "black_money",
			usable = false,
			rare = false,
			weight = -1,
			canRemove = false
		}
		table.insert(items, accountData)
	end

	if money > 0 then
		accountData = {
			label = _U("money"),
			count = money,
			type = "item_account",
			name = "money",
			usable = false,
			rare = false,
			weight = -1,
			canRemove = false
		}
		table.insert(items, accountData)
	end

	for i = 1, #propertyItems, 1 do
		local item = propertyItems[i]

		if item.count > 0 then
			item.type = "item_standard"
			item.usable = false
			item.rare = false
			item.weight = -1
			item.canRemove = false
			table.insert(items, item)
		end
	end

	SendNUIMessage({
		action = "setSecondInventoryItems",
		itemList = items
	})
end

function openMotelInventory()
	LoadPlayerInventory()
	isInInventory = true
	SendNUIMessage({
		action = "display",
		type = "motels"
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoMotel", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		if data.item.type == "item_weapon" then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end
		if data.item.name == 'cash' then
			TriggerServerEvent("DP_Motels:putItem", ESX.GetPlayerData().identifier, 'item_account', 'money', count)
		else
			TriggerServerEvent("DP_Motels:putItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
		end
	end
	Wait(0)
	refreshPropertyMotelInventory()
	Wait(0)
	LoadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("TakeFromMotel", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		TriggerServerEvent("DP_Motels:getItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
	end
	Wait(0)
	refreshPropertyMotelInventory()
	Wait(0)
	LoadPlayerInventory()
	cb("ok")
end)
