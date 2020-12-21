ESX.RegisterServerCallback('DP_Inventory:removeItem', function(source,cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = xPlayer.getInventoryItem(item).count
    if count >= 1 then
        xPlayer.removeInventoryItem(item,1)
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('DP_Inventory:giveWeapon', function(source, cb, targedId, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarged = ESX.GetPlayerFromId(targedId)
    local hash = GetHashKey(item)
    local targedCount = xTarged.getInventoryItem(item).count
    if targedCount == 0 then
        MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE owner = @owner and hash = @hash', {
            ['@owner'] = xPlayer.identifier,
            ['@hash'] = hash
        }, function(results)
            if #results ~= 0 then
                MySQL.Async.execute('UPDATE ammunition SET owner = @owner WHERE id = @id', {
                    ['@owner'] = xTarged.identifier,
                    ['@id'] = results[1].id
                }, function(results2)
                    if results2 ~= 0 then
                        cb(true)
                    else
                        cb(false)
                    end
                end)
            end
        end)
    else
        cb(false)
        TriggerClientEvent('esx:showNotification', source, _U('already_weapon'))
    end
end)

AddEventHandler('DP_Inventory:giveWeaponComponent', function(owner, component, weapon)
    local identity = owner.identifier
    local hash = GetHashKey(weapon)
    MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE hash = @hash AND owner = @owner', {
        ['@hash'] = hash,
        ['@owner'] =  identity
    },function(results)
        if #results ~= 0 then
            local attachments = json.decode(results[1].attach)
            if attachments ~= nil then
                table.insert(attachments, component)
            else
                attachments = {}
                table.insert(attachments, component)
            end
            MySQL.Async.execute('UPDATE ammunition SET attach = @attach WHERE `weapon_id` = @weapon_id', {
                ['@attach'] = json.encode(attachments),
                ['@weapon_id'] = results[1].weapon_id,
            }, function(results2)
                if results2 then
                else
                    print("[DP_Inventory] [^1ERROR^7] There was an error giving a weapon component")
                end
            end)
        end
    end)
end)

RegisterNetEvent('DP_Inventory:buyWeapon')
AddEventHandler('DP_Inventory:buyWeapon', function(owner, weapon, weapon_id, ammo)
    local hash = GetHashKey(weapon)
    local identity = owner.identifier
    local xPlayer = ESX.GetPlayerFromId(owner.source)
    MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE hash = @hash AND owner = @owner', {
        ['@hash'] = hash,
        ['@owner'] =  identity
    },function(results)
        if #results == 0 then
            MySQL.Async.execute('INSERT INTO ammunition (owner, hash, count, weapon_id, original_owner) VALUES (@owner, @hash, @count, @weapon_id, @original_owner) ON DUPLICATE KEY UPDATE owner = @owner, hash = @hash, count = @count, attach = @attach, weapon_id = @weapon_id, original_owner = @original_owner', {
                ['@owner'] = identity,
                ['@hash'] = hash,
                ['@original_owner'] = identity,
                ['@count'] = ammo,
                ['@weapon_id'] = weapon_id,
            })
            xPlayer.addInventoryItem(weapon,1)
        else
            TriggerClientEvent('esx:showNotification', owner.source, _U('already_weapon'))
        end
    end)
end)

ESX.RegisterServerCallback('DP_Inventory:getAttachments', function(source, cb, weaponHash)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hash = GetHashKey(weaponHash)
    MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE owner = @owner and hash = @hash', {
		['@owner'] = xPlayer.identifier,
		['@hash'] = hash
    }, function(results)
		if #results ~= 0 then
            cb(json.decode(results[1].attach))
		end
	end)
end)

AddEventHandler('DP_Inventory:changeWeaponOwner', function(originalOwner, ownerToGet, item)
    local hash = GetHashKey(item)
    MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE hash = @hash AND owner = @owner', {
        ['@hash'] = hash,
        ['@owner'] =  originalOwner
    },function(results)
        if #results ~= 0 then
            MySQL.Async.execute('UPDATE ammunition SET `owner` = @owner WHERE `weapon_id` = @weapon_id', {
                ['@owner'] = ownerToGet,
                ['@weapon_id'] = results[1].weapon_id,
            }, function(results2)
                if results2 then
                else
                    print("[DP_Inventory] [^1ERROR^7] There was an error taking a weapon from dead person")
                end
            end)
        end
    end)
end)

ESX.RegisterServerCallback('DP_Inventory:doesWeaponHas', function(source,cb,hash)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE hash = @hash AND owner = @owner', {
        ['@hash'] = hash,
        ['@owner'] =  xPlayer.identifier
    },function(results)
        if #results ~= 0 then
            if results[1].weapon_id then
                cb(results[1].weapon_id)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

AddEventHandler('DP_Inventory:weaponID', function(weaponID, identifier)
    MySQL.Async.execute('UPDATE ammunition SET `owner` = @owner WHERE `weapon_id` = @weapon_id', {
        ['@owner'] = identifier,
        ['@weapon_id'] = weaponID,
    }, function(results2)
        if results2 then
        else
            print("[DP_Inventory] [^1ERROR^7] There was an error picing a weapon from the ground")
        end
    end)
end)

MySQL.ready(function()
    MySQL.Async.fetchAll('SELECT * FROM ammunition', {
    },function(results)
        if #results ~= 0 then
            for i=1, #results, 1 do
                if results[i].owner == nil then
                    MySQL.Sync.execute("DELETE FROM ammunition WHERE `id` = @id", {
                        ['@id'] = results[i].id ,
                    })
                end
            end
        end
    end)
end)

Citizen.CreateThread(function()
	for i = 1, #Config.Attachments do
		ESX.RegisterUsableItem(Config.Attachments[i], function(source)
			TriggerClientEvent("DP_Inventory:useAttach", source, Config.Attachments[i])
		end)
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(10)
	MySQL.Async.fetchAll('SELECT * FROM items WHERE LCASE(name) LIKE \'%weapon_%\'', {}, function(results)
		for k, v in pairs(results) do
			ESX.RegisterUsableItem(v.name, function(source)
				TriggerClientEvent('DP_Inventory:itemPopUp', source, v.name)
			end)
		end
	end)
end)

RegisterServerEvent('DP_Inventory:updateAmmoCount')
AddEventHandler('DP_Inventory:updateAmmoCount', function(hash, wepInfo)
	local player = ESX.GetPlayerFromId(source)
	for i=1, #wepInfo.attach do
		if wepInfo.attach[i] ~= nil then
			if wepInfo.attach[i] == 'skin' then
				table.remove(wepInfo.attach,i)
            end
            if wepInfo.attach[i] == wepInfo.attach[i+1] then
                table.remove(wepInfo.attach,i)
            end
		end
	end
	MySQL.Async.execute('UPDATE ammunition SET count = @count, attach = @attach WHERE hash = @hash AND owner = @owner and weapon_id = @weapon_id', {
		['@owner'] = player.identifier,
		['@hash'] = hash,
		['@count'] = wepInfo.count,
		['@weapon_id'] = wepInfo.weapon_id,
		['@attach'] = json.encode(wepInfo.attach)
	}, function(results)
		if results == 0 then
			MySQL.Async.execute('INSERT INTO ammunition (owner, hash, count, attach, weapon_id, original_owner) VALUES (@owner, @hash, @count, @attach, @weapon_id, @original_owner) ON DUPLICATE KEY UPDATE owner = @owner, hash = @hash, count = @count, attach = @attach, weapon_id = @weapon_id, original_owner = @original_owner', {
				['@owner'] = player.identifier,
				['@hash'] = hash,
				['@original_owner'] = player.identifier,
				['@count'] = wepInfo.count,
				['@weapon_id'] = wepInfo.weapon_id,
				['@attach'] = json.encode(wepInfo.attach)
			})
		end
	end)
end)

ESX.RegisterServerCallback('DP_Inventory:isWeaponNumberTaken', function(source, cb, weapon)
	MySQL.Async.fetchAll('SELECT 1 FROM ammunition WHERE weapon_id = @weapon_id', {
		['@weapon_id'] = weapon
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('DP_Inventory:getAmmoCount', function(source, cb, hash)
	local player = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE owner = @owner and hash = @hash', {
		['@owner'] = player.identifier,
		['@hash'] = hash
	}, function(results)
		if #results == 0 then
			local cbResult = {
				ammoCount = nil,
				attachments = {}
			}
			cb(cbResult)
		else
			local cbResult = {
				ammoCount = results[1].count,
				attachments = json.decode(results[1].attach)
			}
			cb(cbResult)
		end
	end)
end)
