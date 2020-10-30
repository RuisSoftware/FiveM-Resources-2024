-- ORIGINAL SCRIPT FROM KRILLE https://github.com/KRILLE123

ESX.RegisterUsableItem('bag', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    --xPlayer.removeInventoryItem('bag', 1)
    
    TriggerClientEvent('esx_bag:toggleBag', source)
end)

RegisterServerEvent('esx_bag:getItem')
AddEventHandler('esx_bag:getItem', function(owner, type, item, count)
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
				TriggerClientEvent('esx:showNotification', _source, _U('not_enough_in_property'))
			end
		end)

	elseif type == 'item_account' then

		TriggerEvent('esx_addonaccount:getAccount', 'motels_' .. item, xPlayerOwner.identifier, function(account)
			local roomAccountMoney = account.money

			if roomAccountMoney >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
			end
		end)

	elseif type == 'item_weapon' then

		TriggerEvent('esx_datastore:getDataStore', 'bag', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}
			local weaponName   = nil
			local ammo         = nil

			for i=1, #storeWeapons, 1 do
				if storeWeapons[i].name == item then
					weaponName = storeWeapons[i].name
					ammo       = storeWeapons[i].ammo

					table.remove(storeWeapons, i)
					break
				end
			end

			store.set('weapons', storeWeapons)
			xPlayer.addWeapon(weaponName, ammo)
		end)

	end

end)

RegisterServerEvent('esx_bag:putItem')
AddEventHandler('esx_bag:putItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getInventory', 'bag', xPlayerOwner.identifier, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				TriggerClientEvent('esx:showNotification', _source, _U('have_deposited', count, inventory.getItem(item).label))
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

	elseif type == 'item_weapon' then

		TriggerEvent('esx_datastore:getDataStore', 'bag', xPlayerOwner.identifier, function(store)
			local storeWeapons = store.get('weapons') or {}

			table.insert(storeWeapons, {
				name = item,
				ammo = count
			})

			store.set('weapons', storeWeapons)
			xPlayer.removeWeapon(item)
		end)

	end

end)

ESX.RegisterServerCallback('esx_bag:getPropertyInventory', function(source, cb, owner)
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
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('esx_bag:getPlayerInventory', function(source, cb)
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