ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('DP_Inventory:checkLocker', function(source, cb, lockerId)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
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
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM inventory_lockers WHERE owner = @identifier', { ['@identifier'] = xPlayer.identifier }, function(result)
		if result[1] == nil then
			if xPlayer.getMoney() >= Config.InitialLockerRentPrice then
				MySQL.Async.execute('INSERT INTO inventory_lockers (owner, lockerName) VALUES (@identifier, @lockerId)', {
					['@identifier'] = xPlayer.identifier,
					['@lockerId'] = lockerId
				})
				xPlayer.removeMoney(Config.InitialLockerRentPrice)
				TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
					style  =  'success',
					duration  =  5500,
					message = 'Je huurt nu kluis ' ..lockerName.. '. Dat kost dan €'..Config.DailyRentPrice..' dagelijks (IRL)',
					sound  =  true
				})
			else
				TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
					style  =  'error',
					duration  =  5500,
					message = _U('no_money_locker'),
					sound  =  true
				})
			end
		else
			TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
				style  =  'error',
				duration  =  5500,
				message = _U('already_locker'),
				sound  =  true
			})
		end
	end)
end)

RegisterServerEvent('DP_Inventory:stopRentingLocker')
AddEventHandler('DP_Inventory:stopRentingLocker', function(lockerId, lockerName) 
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM inventory_lockers WHERE lockerName = @lockerId AND owner = @identifier', { ['@lockerId'] = lockerId, ['@identifier'] = xPlayer.identifier }, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('DELETE from inventory_lockers WHERE lockerName = @lockerId AND owner = @identifier', {
				['@lockerId'] = lockerId,
				['@identifier'] = xPlayer.identifier
			})
			TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
				style  =  'succes',
				duration  =  5500,
				message = _U('canceled_locker'),
				sound  =  true
			})
		else
			TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
				style  =  'error',
				duration  =  5500,
				message = _U('dont_own_locker'),
				sound  =  true
			})
		end
	end)
end)

function PayLockerRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM inventory_lockers', {}, function(result)
		for i=1, #result, 1 do
			owner = result[i].owner
			local xPlayer = ESX.GetPlayerFromIdentifier(result[i].owner)
			if xPlayer then
				xPlayer.removeAccountMoney('bank', Config.DailyLockerRentPrice)
				TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Je betaalde €'..Config.DailyLockerRentPrice..' voor de verhuur van kluisjes.', length = 8000 })
			else
				if oldESX then
					MySQL.Sync.execute('UPDATE users SET bank = bank - @bank WHERE owner = @identifier', { ['@bank'] = Config.DailyLockerRentPrice, ['@identifier'] = owner })
				else
					print("[^1"..GetCurrentResourceName().."^7] An error occured while removing money from "..owner.." ("..tostring(Config.DailyLockerRentPrice).."$). The player is offline. Forcing removing money")
					MySQL.Async.fetchScalar('SELECT accounts FROM users WHERE identifier = @identifier', {
						['@identifier'] = owner
					}, function(result)
						if result then
							local foundAccounts = json.decode(result)            
							foundAccounts.bank = foundAccounts.bank - Config.DailyLockerRentPrice
							MySQL.Async.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier', {
								['@accounts'] = json.encode(foundAccounts),
								['@identifier'] = owner
							}, function()
							end)
						end
					end)
				end
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
					TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
						style  =  'error',
						duration  =  5500,
						message = _U('insufficient_space'),
						sound  =  true
					})
				else
					inventory.removeItem(item, count)
					xPlayer.addInventoryItem(item, count)
					TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
						style  =  'error',
						duration  =  5500,
						message = _U('you_took') ..count..'x '..inventoryItem.label..'',
						sound  =  true
					})
				end
			else
				TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
					style  =  'error',
					duration  =  5500,
					message = _U('not_in_locker'),
					sound  =  true
				})
			end
		end)

	elseif type == 'item_account' then
		if item == 'black_money' then
			TriggerEvent('esx_addonaccount:getAccount', 'locker_black', xPlayerOwner.identifier, function(account)
				local roomAccountMoney = account.money

				if roomAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)
				else
					TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
						style  =  'error',
						duration  =  5500,
						message = _U('invalid_quantity'),
						sound  =  true
					})
				end
			end)
		else
			TriggerEvent('esx_addonaccount:getAccount', 'locker_cash', xPlayerOwner.identifier, function(account)
				local roomAccountMoney = account.money

				if roomAccountMoney >= count then
					account.removeMoney(count)
					xPlayer.addAccountMoney(item, count)
				else
					TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
						style  =  'error',
						duration  =  5500,
						message = _U('invalid_quantity'),
						sound  =  true
					})
				end
			end)
		end
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
				TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
					style  =  'inform',
					duration  =  5500,
					message = _U('you_put')..count..'x '..inventory.getItem(item).label..'',
					sound  =  true
				})
			end)
		else
			TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
				style  =  'error',
				duration  =  5500,
				message = _U('invalid_quantity'),
				sound  =  true
			})
		end

	elseif type == 'item_account' or type == 'item_money' then
		if item == 'black_money' then
			local playerAccountMoney = xPlayer.getAccount(item).money

			if playerAccountMoney >= count and count > 0 then
				xPlayer.removeAccountMoney(item, count)

				TriggerEvent('esx_addonaccount:getAccount', 'locker_black', xPlayerOwner.identifier, function(account)
					account.addMoney(count)
				end)
			else
				TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
					style  =  'error',
					duration  =  5500,
					message = _U('invalid_quantity'),
					sound  =  true
				})
			end
		else
			local playerAccountMoney = xPlayer.getAccount('money').money

			if playerAccountMoney >= count and count > 0 then
				xPlayer.removeAccountMoney(item, count)

				TriggerEvent('esx_addonaccount:getAccount', 'locker_cash', xPlayerOwner.identifier, function(account)
					account.addMoney(count)
				end)
			else
				TriggerClientEvent('tnotify:client:SendTextAlert', _source, {
					style  =  'error',
					duration  =  5500,
					message = _U('invalid_quantity'),
					sound  =  true
				})
			end
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
	
	TriggerEvent('esx_addonaccount:getAccount', 'locker_cash', xPlayer.identifier, function(account)
		money = account.money
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
