ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('DP_Inventory:checkLocker', function(source, cb, lockerId)
	local pyrp = source
	local xPlayer = ESX.GetPlayerFromId(pyrp)
	MySQL.Async.fetchAll('SELECT * FROM inventory_lockers WHERE lockerName = @lockerId AND owner = @identifier', { ['@lockerId'] = lockerId, ['@identifier'] = xPlayer.identifier }, function(result) 
		if result[1] ~= nil then
			cb(true)
		else
			cb(false)
		end	
	end)
end)

RegisterServerEvent('DP_Inventory:startRentingLocker')
AddEventHandler('DP_Inventory:startRentingLocker', function(lockerId, lockerName) 
	local pyrp = source
	local xPlayer = ESX.GetPlayerFromId(pyrp)
	MySQL.Async.fetchAll('SELECT * FROM inventory_lockers WHERE owner = @identifier', { ['@identifier'] = xPlayer.identifier }, function(result)
		if result[1] == nil then
			if xPlayer.getMoney() >= Config.InitialLockerRentPrice then
				MySQL.Async.execute('INSERT INTO inventory_lockers (owner, lockerName) VALUES (@identifier, @lockerId)', {
					['@identifier'] = xPlayer.identifier,
					['@lockerId'] = lockerId
				})
				xPlayer.removeMoney(Config.InitialLockerRentPrice)
				TriggerClientEvent('mythic_notify:client:SendAlert', pyrp, { type = 'success', text = 'Je huurt nu kluis ' ..lockerName.. '. Dat kost dan €'..Config.DailyRentPrice..' dagelijks (IRL)', length = 5000 })
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', pyrp, { type = 'error', text = 'Je hebt niet genoeg contant geld om de initiële huurprijs te betalen.', length = 5000 })
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', pyrp, { type = 'error', text = 'Je hebt al een kluisje.', length = 5000 })
		end
	end)
end)

RegisterServerEvent('DP_Inventory:stopRentingLocker')
AddEventHandler('DP_Inventory:stopRentingLocker', function(lockerId, lockerName) 
	local pyrp = source
	local xPlayer = ESX.GetPlayerFromId(pyrp)
	MySQL.Async.fetchAll('SELECT * FROM inventory_lockers WHERE lockerName = @lockerId AND owner = @identifier', { ['@lockerId'] = lockerId, ['@identifier'] = xPlayer.identifier }, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('DELETE from inventory_lockers WHERE lockerName = @lockerId AND owner = @identifier', {
				['@lockerId'] = lockerId,
				['@identifier'] = xPlayer.identifier
			})
			TriggerClientEvent('mythic_notify:client:SendAlert', pyrp, { type = 'inform', text = 'Je hebt het huren van dit kluisje geannuleerd.', length = 5000 })
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', pyrp, { type = 'error', text = 'Je bezit deze locker-maat niet.', length = 5000 })
		end
	end)
end)

function PayLockerRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM inventory_lockers', {}, function(result)
		for i=1, #result, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].identifier)
			if xPlayer then
				xPlayer.removeAccountMoney('bank', Config.DailyLockerRentPrice)
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Je betaalde €'..Config.DailyLockerRentPrice..' voor de verhuur van kluisjes.', length = 8000 })
			else
				MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE owner = @identifier', { ['@bank'] = Config.DailyLockerRentPrice, ['@identifier'] = result[i].identifier })
			end
		end
	end)
end

TriggerEvent('cron:runAt', 5, 10, PayLockerRent)

RegisterServerEvent('DP_Inventory:getLockerItems')
AddEventHandler('DP_Inventory:getLockerItems', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('esx_addoninventory:getInventory', 'locker', xPlayerOwner.identifier, function(inventory)
			local inventoryItem = inventory.getItem(item)

			-- is there enough in the property?
			if count > 0 and inventoryItem.count >= count then
			
				-- can the player carry the said amount of x item?
				if not xPlayer.canCarryItem(sourceItem.name, sourceItem.count + count) then
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Je kunt niet meer van dit item vasthouden.', length = 5000 })
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Je pakte '..count..'x '..inventoryItem.label..'', length = 5000 })
				end
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Je hebt niet meer van dit item in de voorraad.', length = 5000 })
			end
		end)

	elseif type == 'item_account' then

		TriggerEvent('esx_addonaccount:getAccount', 'locker_cash', xPlayerOwner.identifier, function(account)
			local roomAccountMoney = account.money

			if roomAccountMoney >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(item, count)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Ongeldig aantal.', length = 5000 })
			end
		end)

	elseif type == 'item_weapon' then

		TriggerEvent('esx_datastore:getDataStore', 'locker', xPlayerOwner.identifier, function(store)
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

RegisterServerEvent('DP_Inventory:putLockerItems')
AddEventHandler('DP_Inventory:putLockerItems', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getInventory', 'locker', xPlayerOwner.identifier, function(inventory)
				xPlayer.removeInventoryItem(item, count)
				inventory.addItem(item, count)
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Je sloeg '..count..'x '..inventory.getItem(item).label..' op.', length = 5000 })
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Ongeldig aantal.', length = 5000 })
		end

	elseif type == 'item_account' then

		local playerAccountMoney = xPlayer.getAccount(item).money

		if playerAccountMoney >= count and count > 0 then
			xPlayer.removeAccountMoney(item, count)

			TriggerEvent('esx_addonaccount:getAccount', 'locker_cash', xPlayerOwner.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Ongeldig aantal.', length = 5000 })
		end

	elseif type == 'item_weapon' then

		TriggerEvent('esx_datastore:getDataStore', 'locker', xPlayerOwner.identifier, function(store)
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

ESX.RegisterServerCallback('DP_Inventory:getLockerInventory', function(source, cb, owner, lockerName)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local money = 0
	local items      = {}
	local weapons    = {}
	
	TriggerEvent('esx_addonaccount:getAccount', 'locker_cash', xPlayer.identifier, function(account2)
		money = account2.money
	end)

	TriggerEvent('esx_addonaccount:getAccount', 'locker_black', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'locker', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'locker', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		money = money,
		items      = items,
		weapons    = weapons,
		stash_name    = lockerName
	})
end)
