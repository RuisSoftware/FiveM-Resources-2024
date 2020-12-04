ESX.RegisterServerCallback('dp_inventory:removeItem', function(source,cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = xPlayer.getInventoryItem(item).count
    if count >= 1 then
        xPlayer.removeInventoryItem(item,1)
        cb(true)
    else
        cb(false)
    end
end)


ESX.RegisterServerCallback('dp_inventory:giveWeapon', function(source, cb, targedId, item)
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


RegisterNetEvent('dp_inventory:weaponLocation')
AddEventHandler('dp_inventory:weaponLocation', function(coords, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hash = GetHashKey(item)
    local location = {x = ESX.Math.Round(coords.x,1), y = ESX.Math.Round(coords.y,1), z = ESX.Math.Round(coords.z,1)}
    MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE owner = @owner and hash = @hash', {
        ['@owner'] = xPlayer.identifier,
        ['@hash'] = hash
    }, function(results)
        if #results ~= 0 then
            MySQL.Async.execute('UPDATE ammunition SET location = @location, owner = @owner WHERE id = @id and hash = @hash', {
                ['@location'] = json.encode(location),
                ['@id'] = results[1].id,
                ['@owner'] = nil,
                ['@hash'] = hash
            }, function(results2)
            end)
        end
    end)
end)

RegisterNetEvent('dp_inventory:weaponLocationCheck')
AddEventHandler('dp_inventory:weaponLocationCheck', function(coords, item)
    local _source = source
    local hash = GetHashKey(item)
    MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE hash = @hash', {
        ['@hash'] = hash,
    },function(results)
        if #results ~= 0 then
            for i=1, #results, 1 do
                 if results[i].location ~= nil then
                    local DBcoords = json.decode(results[i].location)
                    TriggerClientEvent('dp_inventory:getdistance', _source, DBcoords, coords, hash, results[i].id)
                end
            end
        end
    end)
end)

RegisterNetEvent('dp_inventory:updateOwner')
AddEventHandler('dp_inventory:updateOwner', function(hash, id)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('UPDATE ammunition SET owner = @owner, location = @location WHERE id = @id and hash = @hash', {
        ['@location'] = nil,
        ['@id'] = id,
        ['@owner'] = xPlayer.identifier,
        ['@hash'] = hash
    }, function(results2)
    end)
end)
