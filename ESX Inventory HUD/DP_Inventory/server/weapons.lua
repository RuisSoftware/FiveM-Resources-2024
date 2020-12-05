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
AddEventHandler('dp_inventory:weaponLocation', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hash = GetHashKey(item)
    MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE owner = @owner and hash = @hash', {
        ['@owner'] = xPlayer.identifier,
        ['@hash'] = hash
    }, function(results)
        if #results ~= 0 then
            MySQL.Async.execute('UPDATE ammunition SET owner = @owner WHERE id = @id and hash = @hash and weapon_id = @weapon_id', {
                ['@id'] = results[1].id,
                ['@owner'] = nil,
                ['@weapon_id'] = results[1].weapon_id,
                ['@hash'] = hash
            }, function(results2)
            end)
        end
    end)
end)

ESX.RegisterServerCallback('dp_inventory:doesWeaponHas', function(source,cb,hash)
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

AddEventHandler('dp_inventory:weaponID', function(weaponID, identifier)
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
