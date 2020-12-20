ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('DP_Motels:cancelRental')
AddEventHandler('DP_Motels:cancelRental', function(room)
    local src = source
    local pid = ESX.GetPlayerFromId(src)
    local playerIdent = pid.identifier

    MySQL.Sync.execute("DELETE FROM motels WHERE owner=@owner AND motel_id=@roomno", {['@owner'] = playerIdent, ['@roomno'] = room})
end)

RegisterServerEvent('DP_Motels:rentRoom')
AddEventHandler('DP_Motels:rentRoom', function(room)
    local src = source
    local pid = ESX.GetPlayerFromId(src)
    local playerIdent = pid.identifier
    MySQL.Sync.execute("INSERT INTO motels (owner, motel_id) VALUES (@owner, @roomno)", {['@owner'] = playerIdent, ['@roomno'] = room})
end)

ESX.RegisterServerCallback('DP_Motels:getMotelRoomID', function(source, cb, room)
    local src = source
    local pid = ESX.GetPlayerFromId(src)
    local playerIdent = pid.identifier

    MySQL.Async.fetchScalar("SELECT id FROM motels WHERE owner=@owner AND motel_id = @room", {['@owner'] = playerIdent, ['@room'] = room}, function(rentalID)
        if rentalID ~= nil then
            cb(rentalID)
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('DP_Motels:checkOwnership', function(source, cb)
    local src = source
    local pid = ESX.GetPlayerFromId(src)

    if pid ~= nil then
        local playerIdent = pid.identifier

        MySQL.Async.fetchScalar("SELECT motel_id FROM motels WHERE owner = @owner", {['@owner'] = playerIdent}, function(motelRoom)
            if motelRoom ~= nil then
            cb(motelRoom)
            else
            cb(false)
            end
        end)
    end
end)


RegisterServerEvent('DP_Motels:getItem')
AddEventHandler('DP_Motels:getItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('esx_addoninventory:getInventory', 'motels', xPlayerOwner.identifier, function(inventory)
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
	end
end)

RegisterServerEvent('DP_Motels:putItem')
AddEventHandler('DP_Motels:putItem', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getInventory', 'motels', xPlayerOwner.identifier, function(inventory)
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

			TriggerEvent('esx_addonaccount:getAccount', 'motels_' .. item, xPlayerOwner.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
		end

	end

end)

ESX.RegisterServerCallback('DP_Motels:getPropertyInventory', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local money = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addonaccount:getAccount', 'motels_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)
	TriggerEvent('esx_addonaccount:getAccount', 'motels_money', xPlayer.identifier, function(account2)
		money = account2.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'motels', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'motels', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		money = money,
		items      = items,
		weapons    = weapons
	})
end)

ESX.RegisterServerCallback('DP_Motels:getPlayerInventory', function(source, cb)
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


----------------------------------

RegisterServerEvent('DP_Motels:getItemBed')
AddEventHandler('DP_Motels:getItemBed', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local sourceItem = xPlayer.getInventoryItem(item)

		TriggerEvent('esx_addoninventory:getInventory', 'motels_bed', xPlayerOwner.identifier, function(inventory)
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
		TriggerEvent('esx_addonaccount:getAccount', 'motels_bed_' .. item, xPlayerOwner.identifier, function(account)
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

RegisterServerEvent('DP_Motels:putItemBed')
AddEventHandler('DP_Motels:putItemBed', function(owner, type, item, count)
	local _source      = source
	local xPlayer      = ESX.GetPlayerFromId(_source)
	local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

	if type == 'item_standard' then

		local playerItemCount = xPlayer.getInventoryItem(item).count

		if playerItemCount >= count and count > 0 then
			TriggerEvent('esx_addoninventory:getInventory', 'motels_bed', xPlayerOwner.identifier, function(inventory)
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

			TriggerEvent('esx_addonaccount:getAccount', 'motels_bed_' .. item, xPlayerOwner.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
		end
	end
end)

ESX.RegisterServerCallback('DP_Motels:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('DP_Motels:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)

RegisterServerEvent('DP_Motels:removeOutfit')
AddEventHandler('DP_Motels:removeOutfit', function(label)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing') or {}

		table.remove(dressing, label)
		store.set('dressing', dressing)
	end)
end)

ESX.RegisterServerCallback('DP_Motels:checkIsOwner', function(source, cb, room, owner)
    local xPlayer    = ESX.GetPlayerFromIdentifier(owner)

    MySQL.Async.fetchScalar("SELECT motel_id FROM motels WHERE motel_id = @room AND owner = @id", {
        ['@room'] = room,
        ['@id'] = xPlayer.identifier
     }, function(isOwner)

        if isOwner ~= nil then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('DP_Motels:SaveMotel')
AddEventHandler('DP_Motels:SaveMotel', function(motel, room)
	local xPlayer  = ESX.GetPlayerFromId(source)
	local motelname = motel
	local roomident = room

	MySQL.Sync.execute('UPDATE users SET last_motel = @motelname, last_motel_room = @lroom WHERE identifier = @identifier',
	{
		['@motelname']        = motelname,
		['@lroom'] 			  = roomident,
		['@identifier'] 	  = xPlayer.identifier
	})
end)

RegisterServerEvent('DP_Motels:DelMotel')
AddEventHandler('DP_Motels:DelMotel', function()
	local xPlayer  = ESX.GetPlayerFromId(source)
	MySQL.Sync.execute('UPDATE users SET last_motel = NULL, last_motel_room = NULL WHERE identifier = @identifier',
	{
		['@identifier'] 	  = xPlayer.identifier
	})
end)

ESX.RegisterServerCallback('DP_Motels:getLastMotel', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT last_motel, last_motel_room FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(users)
		cb(users[1].last_motel, users[1].last_motel_room)
	end)
end)

ESX.RegisterServerCallback('DP_Motels:getPropertyInventoryBed', function(source, cb, owner)
	local xPlayer    = ESX.GetPlayerFromIdentifier(owner)
	local blackMoney = 0
	local money = 0
	local items      = {}
	local weapons    = {}

	TriggerEvent('esx_addonaccount:getAccount', 'motels_bed_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('esx_addonaccount:getAccount', 'motels_bed_money', xPlayer.identifier, function(account2)
		money = account2.money
	end)

	TriggerEvent('esx_addoninventory:getInventory', 'motels_bed', xPlayer.identifier, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'motels_bed', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney 	= blackMoney,
		money 		= money,
		items      	= items,
		weapons    	= weapons
	})
end)

ESX.RegisterServerCallback('DP_Motels:getPlayerInventoryBed', function(source, cb)
	local xPlayer    	= ESX.GetPlayerFromId(source)
	local blackMoney 	= xPlayer.getAccount('black_money').money
	local money 		= xPlayer.getAccount('money').money
	local items      	= xPlayer.inventory

	cb({
		blackMoney 	= blackMoney,
		money 		= money,
		items      	= items,
		weapons    	= xPlayer.getLoadout()
	})
end)

function PayRent(d, h, m)
	MySQL.Async.fetchAll('SELECT * FROM motels', {}, function (result1)
		for i=1, #result1, 1 do
			local xPlayer = ESX.GetPlayerFromIdentifier(result1[i].owner)
			-- message player if connected
			if xPlayer then
				xPlayer.removeAccountMoney('bank', Config.PriceRental)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('paid_rent', ESX.Math.GroupDigits(Config.PriceRental))..' for motel room')
				print("[^1"..GetCurrentResourceName().."^7] Removed money to pay motels rent")
			else -- pay rent either way
				print("[^1"..GetCurrentResourceName().."^7] An error occured while paying motels rent money from "..result1[i].owner.." ("..tostring(Config.PriceRental).."$). The player is offline. Forcing removing money")
				MySQL.Async.fetchScalar('SELECT accounts FROM users WHERE identifier = @identifier', {
					['@identifier'] = result1[i].owner
				}, function(result2)
					if result2 then
						local foundAccounts = json.decode(result2)            
						foundAccounts.bank = foundAccounts.bank - Config.PriceRental
						MySQL.Async.execute('UPDATE users SET accounts = @accounts WHERE identifier = @identifier', {
							['@accounts'] = json.encode(foundAccounts),
							['@identifier'] = result1[i].owner
						}, function()
						end)
					end
				end)
			end
		end
	end)
end

TriggerEvent('cron:runAt', 22, 0, PayRent)