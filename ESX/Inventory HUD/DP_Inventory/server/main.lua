ESX = nil
ServerItems = {}
itemShopList = {}

TriggerEvent("esx:getSharedObject", function(obj) 
	ESX = obj 
end)

RegisterCommand("closeinventory", function(source)
	local _source = source
	TriggerClientEvent('DP_Inventory:closeinventory', _source)
end)

RegisterCommand("openinventory", function(source, args, rawCommand) -- ADMIN WATCH
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local group = xPlayer.getGroup()
	if group == 'admin' or (Config.AllowModerators and group == 'mod') then
		local target = tonumber(args[1])
		local targetXPlayer = ESX.GetPlayerFromId(target)
		if targetXPlayer ~= nil then
			TriggerClientEvent("DP_Inventory:openPlayerInventory", source, target, targetXPlayer.name)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('no_player') })
		end
	else
		if Config.JobOnlyInventory then
			if (Config.AllowPolice and xPlayer.job.name == Config.InventoryJob.Police) or (Config.AllowNightclub and xPlayer.job.name == Config.InventoryJob.Nightclub) or (Config.AllowMafia and xPlayer.job.name == Config.InventoryJob.Mafia) or (Config.AllowMafia and xPlayer.job.name == Config.InventoryJob.Ambulance) then
				TriggerClientEvent("DP_Inventory:openPlayerInventory", source, target, targetXPlayer.name)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('no_permissions') })
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('no_permissions') })
		end
	end
end)

ESX.RegisterServerCallback("DP_Inventory:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local itemSlotes = {}
	if targetXPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM inventory_hotbar WHERE owner = @owner', {
			['@owner'] =  targetXPlayer.identifier
		},function(data)
			if #data ~= 0 then
				for i=1, #data do
					table.insert(itemSlotes, {
						slot = data[i].slot,
						item = data[i].item
					})
				end
			else
				itemSlotes = false
			end
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout, slotes = itemSlotes})
		end)
	else
		cb(nil)
	end
end)

ESX.RegisterServerCallback("DP_Inventory:getPlayerInventoryWeight", function(source,cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerweight = xPlayer.getWeight()
	cb(playerweight)
end)

ESX.RegisterServerCallback("DP_Inventory:getMaxInventoryWeight", function(source,cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local maxWeight = xPlayer.getMaxWeight()
	cb(maxWeight)
end)

RegisterNetEvent("DP_Inventory:clearweapons")
AddEventHandler("DP_Inventory:clearweapons", function(target)
	TriggerClientEvent('DP_Inventory:clearfastitems',target)
end)

ESX.RegisterServerCallback('DP_Inventory:takePlayerItem', function(source, cb, item, count)
	local player = ESX.GetPlayerFromId(source)
	local invItem = player.getInventoryItem(item)
	if invItem.count - count < 0 then
		cb(false)
	else
		player.removeInventoryItem(item, count)
		cb(true)
	end
end)

ESX.RegisterServerCallback('DP_Inventory:addPlayerItem', function(source, cb, item, count)
	local player = ESX.GetPlayerFromId(source)
	if player.canCarryItem(item, count) then
		player.addInventoryItem(item, count)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent("DP_Inventory:tradePlayerItem")
AddEventHandler("DP_Inventory:tradePlayerItem", function(from, target, type, itemName, itemCount)
	local _source = from
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local item = sourceXPlayer.getInventoryItem(itemName)

	if type == "item_standard" then
		if itemCount > 0 and item.count >= itemCount then
			if  targetXPlayer.canCarryItem(itemName, itemCount) then
				if itemName == 'WEAPON_PISTOL' or itemName == 'WEAPON_FLASHLIGHT' or itemName == 'WEAPON_STUNGUN' or itemName == 'WEAPON_KNIFE' or itemName == 'WEAPON_ASSAULTSMG'
				or itemName == 'WEAPON_BAT' or itemName == 'WEAPON_ADVANCEDRIFLE' or itemName == 'WEAPON_APPISTOL' or itemName == 'WEAPON_ASSAULTRIFLE' or itemName == 'WEAPON_ASSAULTSHOTGUN'
				or itemName == 'WEAPON_AUTOSHOTGUN' or itemName == 'WEAPON_CARBINERIFLE' or itemName == 'WEAPON_COMBATPISTOL' or itemName == 'WEAPON_PUMPSHOTGUN' or itemName == 'WEAPON_SMG' then
					TriggerEvent('DP_Inventory:changeWeaponOwner', sourceXPlayer.identifier, targetXPlayer.identifier, itemName)
				end
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem(itemName, itemCount)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source , { type = 'error', text = _U('player_inv_no_space') })
			end
		end
	elseif type == "item_money" then
		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney(itemCount)
		end
	elseif type == "item_account" then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney(itemName, itemCount)
		end
	end
end)

ESX.RegisterServerCallback('GetCharacterNameServer', function(source, cb, target)
	local xTarget = ESX.GetPlayerFromId(target)
	cb(xTarget.getName())
end)
