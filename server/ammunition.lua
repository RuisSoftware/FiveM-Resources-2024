Citizen.CreateThread(function()
    Citizen.Wait(0)
    for k, v in pairs(Config.Ammo) do
        ESX.RegisterUsableItem(v.name, function(source)
            TriggerClientEvent('inventoryo:useAmmoItem', source, v)
        end)
    end
end)

RegisterServerEvent('inventoryo:removeAmmoItem')
AddEventHandler('inventoryo:removeAmmoItem', function(ammo)
    local player = ESX.GetPlayerFromId(source)
    player.removeInventoryItem(ammo.name, 1)
end)