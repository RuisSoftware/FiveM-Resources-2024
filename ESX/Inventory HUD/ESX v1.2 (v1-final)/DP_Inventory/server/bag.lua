-- INSPIRED BY ORIGINAL SCRIPT FROM KRILLE https://github.com/KRILLE123
local arrayWeight = Config.localWeight
alleItems = nil

Citizen.CreateThread(function()
	while alleItems == nil do
		alleItems = MySQL.Sync.fetchAll("SELECT * FROM items")
		Citizen.Wait(2000)
	end
end)

ESX.RegisterUsableItem('bag', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    -- xPlayer.removeInventoryItem('bag', 1)
    
    TriggerClientEvent('DP_Inventory_bag:toggleBag', source)
end)

RegisterServerEvent('DP_Inventory_bag:getItem')
AddEventHandler('DP_Inventory_bag:getItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('esx_addoninventory:getInventory', 'bag', xPlayerOwner.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)
			
			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
			
				-- can the player carry the said amount of x item?
				--if sourceItem.limit ~= nil and (sourceItem.count + count) > sourceItem.limit then
				if xPlayer.canCarryItem(item, count) then
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
				else
					TriggerClientEvent('esx:showNotification', _source, _U('player_cannot_hold'))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('not_enough_in_bag'))
			end
		end)

	elseif type == 'item_account' then

		TriggerEvent('esx_addonaccount:getAccount', 'bag_' .. item, xPlayerOwner.identifier, function(account)
			local roomAccountMoney = account.money

			if roomAccountMoney >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
			end
		end)

	end

end)

function getItemWeight(item)
	local weight = 0
	local itemWeight = 0
	if item ~= nil then
		itemWeight = Config.DefaultWeight
		if arrayWeight[item] ~= nil then
			itemWeight = arrayWeight[item]
		end
	end
	return itemWeight
end

function getBagWeight(identifier)
	local bagWeight = 0
	TriggerEvent('esx_addoninventory:getInventory', 'bag', identifier, function(inventory)
		if #alleItems ~= 0 then
			for i=1, #alleItems, 1 do
				bagWeight = bagWeight + (getItemWeight(alleItems[i].name) * inventory.getItem(alleItems[i].name).count)
			end
			--print(bagWeight)
		end
	end)
	return bagWeight
end

RegisterServerEvent('DP_Inventory_bag:putItem')
AddEventHandler('DP_Inventory_bag:putItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)
	local weight = 0

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getInventory', 'bag', xPlayerOwner.identifier, function(inventory)
				Citizen.Wait(100)
				if #alleItems ~= 0 then
					for i=1, #alleItems, 1 do
						weight = weight + (getItemWeight(alleItems[i].name) * inventory.getItem(alleItems[i].name).count)
					end
					--print(weight)
				end
				if weight < Config.MaxBagWeight then
					xPlayer.removeInventoryItem(item, count)
					inventory.addItem(item, count)
					TriggerClientEvent('esx:showNotification', _source, _U('have_deposited', count, inventory.getItem(item).label))
				else
					TriggerClientEvent('esx:showNotification', _source, 'geen ruimte')
				end
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('invalid_quantity'))
		end

	elseif type == 'item_account' then

		local playerAccountMoney = xPlayer.getAccount(item).money

		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)
			TriggerEvent('esx_addonaccount:getAccount', 'bag_' .. item, xPlayerOwner.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
		end
	end
end)

ESX.RegisterServerCallback('DP_Inventory_bag:getInventory', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local money = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addonaccount:getAccount', 'bag_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)
	TriggerEvent('esx_addonaccount:getAccount', 'bag_money', xPlayer.identifier, function(account2)
		money = account2.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'bag', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'bag', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		money = money,
		items      = items,
		weapons    = weapons,
		weight = getBagWeight(xPlayer.identifier)
	})
end)

ESX.RegisterServerCallback('DP_Inventory_bag:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local blackMoney = xPlayer.getAccount('black_money').money
	local money = xPlayer.getAccount('money').money
	local items      = xPlayer.inventory

	cb({
		blackMoney = blackMoney,
		money = money,
		items      = items,
		weapons    = xPlayer.getLoadout()
	})
end)