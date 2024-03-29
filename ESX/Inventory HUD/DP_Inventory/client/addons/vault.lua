RegisterNetEvent("DP_Inventory:openVaultInventory")
AddEventHandler("DP_Inventory:openVaultInventory", function(data)
	setVaultInventoryData(data)
	openVaultInventory()
end)

function refreshVaultInventory()
	data = getMonsterVaultLicense()
	ESX.TriggerServerCallback("DP_Inventory:getVaultInventory", function(inventory)
		setVaultInventoryData(inventory)
	end, data, true)
end

local vaultType

function setVaultInventoryData(inventory)
	items = {}
	if inventory.job == 'police' then
		kluisNaam = 'Politie'
	else
		kluisNaam = inventory.job
	end
	SendNUIMessage({
		action = "setInfoText",
		text = kluisNaam .. _U("vault")
	})

	local blackMoney = inventory.blackMoney
	local money = inventory.money
	local vaultItems = inventory.items
	local vaultWeapons = inventory.weapons
	vaultType = inventory.job

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

	for i = 1, #vaultItems, 1 do
		local item = vaultItems[i]
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

function openVaultInventory()
	LoadPlayerInventory()
	isInInventory = true
	SendNUIMessage({
		action = "display",
		type = "vault"
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoVault", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = 0
		if data.item.type == "item_weapon" then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
			TriggerServerEvent("DP_Inventory:putItem", --[[ESX.GetPlayerData().identifier,--]] vaultType, data.item.type, data.item.name, count)
		else
			if data.number > data.item.count or data.number == 0 then
				count = tonumber(data.item.count)
			else
				count = tonumber(data.number)
			end
			TriggerServerEvent("DP_Inventory:putItem", --[[ESX.GetPlayerData().identifier,--]] vaultType, data.item.type, data.item.name, count)
		end
	end
	Wait(0)
	refreshVaultInventory()
	Wait(0)
	LoadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("TakeFromVault", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = 0
		if data.number > data.item.count or data.number == 0 then
			count = tonumber(data.item.count)
		else
			count = tonumber(data.number)
		end
		TriggerServerEvent("DP_Inventory:getItem", --[[ESX.GetPlayerData().identifier,--]] vaultType, data.item.type, data.item.name, count)
	end
	Wait(0)
	refreshVaultInventory()
	Wait(0)
	LoadPlayerInventory()
	cb("ok")
end)
