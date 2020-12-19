RegisterNetEvent("DP_Inventory:openBagInventory")
AddEventHandler("DP_Inventory:openBagInventory", function(data)
	setPropertyBagData(data)
	openBagInventory()
end)

function refreshPropertyBagInventory()
	ESX.TriggerServerCallback("DP_Inventory_bag:getInventory", function(inventory)
		setPropertyBagData(inventory)
	end, ESX.GetPlayerData().identifier )
end

function setPropertyBagData(data)
	items = {}

	SendNUIMessage({
		action = "setInfoText",
		text = "<strong>" .. _("bagInventory") .. "</strong><br>" .. data.weight  .. " / " .. Config.MaxBagWeight
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

function openBagInventory()
	loadPlayerInventory()
	isInInventory = true
	SendNUIMessage({
		action = "display",
		type = "bag"
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoBag", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
		--print('test')
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		if data.item.type == "item_weapon" then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end
		if data.item.name == 'cash' then
			TriggerServerEvent("DP_Inventory_bag:putItem", ESX.GetPlayerData().identifier, 'item_account', 'money', count)
		else
			TriggerServerEvent("DP_Inventory_bag:putItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
		end
	end
	Wait(150)
	refreshPropertyBagInventory()
	Wait(150)
	loadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("TakeFromBag", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		TriggerServerEvent("DP_Inventory_bag:getItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
	end
	Wait(150)
	refreshPropertyBagInventory()
	Wait(150)
	loadPlayerInventory()
	cb("ok")
end)
