RegisterServerEvent('esx_inventoryhud:getItem')
AddEventHandler('esx_inventoryhud:getItem', function(--[[owner,--]] job, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(xPlayer.identifier)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		if xPlayer.job.name == job then
			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job, function(inventory)
				local inventoryItem = inventory.getItem(item)
				if count > 0 and inventoryItem.count >= count then
				--	if sourceItem.weight ~= -1 and (sourceItem.count + count) > sourceItem.weight then
					if not xPlayer.canCarryItem(item, count) then
						print('notify: player cannot hold')
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('player_cannot_hold'), length = 5500})
					else
						inventory.removeItem(item, count)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_withdrawn', count, inventoryItem.label), length = 7500})
					end
				else
					print('not enough in vault')
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('not_enough_in_vault'), length = 5500})
				end
			end)
		elseif job == 'vault' then
			TriggerEvent('esx_addoninventory:getInventory', 'vault', xPlayerOwner.identifier, function(inventory)
				local inventoryItem = inventory.getItem(item)
	
				
				if count > 0 and inventoryItem.count >= count then
				--	if sourceItem.weight ~= -1 and (sourceItem.count + count) > sourceItem.weight then
					if not xPlayer.canCarryItem(item, count) then
						TriggerClientEvent('mythic_notify:client:SendAlert', _source,  {type = 'error', text = _U('player_cannot_hold'), length = 5500})
					else
						inventory.removeItem(item, count)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_withdrawn', count, inventoryItem.label), length = 8500})
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('not_enough_in_vault'), length = 5500})
				end
			end)
		else
			print('notify: not permission for this job')
		end

	elseif type == 'item_account' then
		if xPlayer.job.name == job then
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
				local policeAccountMoney = account.money

				if policeAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
				end
			end)
		elseif xPlayer.job.name == job then
			TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
				local nachtclubAccountMoney = account.money

				if nachtclubAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
				end
			end)
		elseif job == 'vault' then
			TriggerEvent('esx_addonaccount:getAccount', 'vault_' .. item, xPlayerOwner.identifier, function(account)
				local roomAccountMoney = account.money
	
				if roomAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
				end
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = "You not have permission", length = 5500})
		end
	elseif type == 'item_weapon' then
		if xPlayer.job.name == job then
			TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..job, function(store)
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
		elseif job == 'vault' then
			TriggerEvent('esx_datastore:getDataStore', 'vault', xPlayerOwner.identifier, function(store)
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
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'You not have permission', length = 5500})
		end
	end

end)

RegisterServerEvent('esx_inventoryhud:putItem')
AddEventHandler('esx_inventoryhud:putItem', function(--[[owner,--]] job, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(xPlayer.identifier)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			if xPlayer.job.name == job then
				TriggerEvent('esx_addoninventory:getSharedInventory', 'society_'..job, function(inventory)
					xPlayer.removeInventoryItem(item, count)
					inventory.addItem(item, count)
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_deposited', count, inventory.getItem(item).label), length = 7500})
				end)
				-- print("esx_inventoryhud:putItem")
			elseif job == 'vault' then
				TriggerEvent('esx_addoninventory:getInventory', 'vault', xPlayerOwner.identifier, function(inventory)
					xPlayer.removeInventoryItem(item, count)
					inventory.addItem(item, count)
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'success', text = _U('have_deposited', count, inventory.getItem(item).label), length = 7500})
				end)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = "error", text = 'You not have permission for this job!', length = 5500})
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = "error", text = _U('invalid_quantity'), length = 5500})
		end

	elseif type == 'item_account' then

		local playerAccountMoney = xPlayer.getAccount(item).money

		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)
			if xPlayer.job.name == job and job == 'police' then
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
					account.addMoney(count)
				end)
			elseif xPlayer.job.name == job and job == 'nachtclub' then
				TriggerEvent('esx_addonaccount:getSharedAccount', 'society_'..job..'_'..item, function(account)
					account.addMoney(count)
				end)
			elseif job == 'vault' then
				TriggerEvent('esx_addonaccount:getAccount', 'vault_' .. item, xPlayerOwner.identifier, function(account)
					account.addMoney(count)
				end)
			else
				xPlayer.addAccountMoney(item, count)
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'This job not allow for black money', length = 5500})
			end
			
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = _U('amount_invalid'), length = 5500})
		end

	elseif type == 'item_weapon' then
		if xPlayer.job.name == job then
			TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..job, function(store)
				local storeWeapons = store.get('weapons') or {}
	
				table.insert(storeWeapons, {
					name = item,
					count = count
				})
	
				xPlayer.removeWeapon(item)
				store.set('weapons', storeWeapons)
				
			end)
		elseif job == 'vault' then
			TriggerEvent('esx_datastore:getDataStore', 'vault', xPlayerOwner.identifier, function(store)
				local storeWeapons = store.get('weapons') or {}
	
				table.insert(storeWeapons, {
					name = item,
					ammo = count
				})
	
				xPlayer.removeWeapon(item)
				store.set('weapons', storeWeapons)
				
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, {type = 'error', text = 'You not have permission', length = 5500})
		end
	end

end)

ESX.RegisterServerCallback('esx_inventoryhud:getVaultInventory', function(source, cb, item, refresh)
	-- local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem
	if item.needItemLicense ~= '' or item.needItemLicense ~= nil then
		xItem = xPlayer.getInventoryItem(item.needItemLicense)
	else
		xItem = nil
	end
	local refresh = refresh or false

	local blackMoney = 0
	local money = 0
	local items      = {}
	local weapons    = {}

	if not refresh and (item.needItemLicense ~= '' or item.needItemLicense ~= nil) and xItem ~= nil and xItem.count < 1 then
		-- if xItem.count < 1 then
		cb(false)
		-- end
		-- return
	elseif not item.InfiniteLicense and not refresh and xItem ~= nil and xItem.count > 0 then
		-- if not item.InfiniteLicense then
			xPlayer.removeInventoryItem(item.needItemLicense, 1)
		-- end
	end

	-- if item.job == xPlayer.job.name then
	-- 	print('u job: '..xPlayer.job.name)
	-- end

	local typeVault = ''
	local society = false
	if string.find(item.job, "vault") then
		typeVault = item.job
	else
		typeVault = "society_"..item.job
		society = true
	end
	print("Vault: "..typeVault)

	if society then
		if item.job == 'police' or item.job == 'nachtclub' then
			TriggerEvent('esx_addonaccount:getSharedAccount', typeVault..'_black_money', function(account)
				blackMoney = account.money
			end)
		else
			blackMoney = 0
		end
		if item.job == 'police' or item.job == 'nachtclub' then
			TriggerEvent('esx_addonaccount:getSharedAccount', typeVault..'_money', function(account)
				money = account.money
			end)
		else
			money = 0
		end
		TriggerEvent('esx_addoninventory:getSharedInventory', typeVault, function(inventory)
			items = inventory.items
		end)
		TriggerEvent('esx_datastore:getSharedDataStore', typeVault, function(store)
			weapons = store.get('weapons') or {}
		end)
		cb({
			blackMoney = blackMoney,
			items      = items,
			weapons    = weapons,
			money = money,
			job = item.job
		})
	else
		TriggerEvent('esx_addonaccount:getAccount', typeVault..'_black_money', xPlayer.identifier, function(account)
			blackMoney = account.money
		end)
		TriggerEvent('esx_addonaccount:getAccount', typeVault..'_money', xPlayer.identifier, function(account)
			money = account.money
		end)

		TriggerEvent('esx_addoninventory:getInventory', typeVault, xPlayer.identifier, function(inventory)
			items = inventory.items
		end)

		TriggerEvent('esx_datastore:getDataStore', typeVault, xPlayer.identifier, function(store)
			weapons = store.get('weapons') or {}
		end)

		cb({
			blackMoney = blackMoney,
			items      = items,
			weapons    = weapons,
			money  = money,
			job = item.job
		})
	end
end)
