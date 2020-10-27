Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local currentWeapon = GetSelectedPedWeapon(GetPlayerPed(-1))
        DisplayAmmoThisFrame(currentWeapon)
    end
end)

RegisterNetEvent('ammunition:useAmmoItem')
AddEventHandler('ammunition:useAmmoItem', function(ammo)
    local playerPed = GetPlayerPed(-1)
    local weapon

    local found, currentWeapon = GetCurrentPedWeapon(playerPed, true)
    if found then
        for _, v in pairs(ammo.weapons) do
            if currentWeapon == v then
                weapon = v
                break
            end
        end
        if weapon ~= nil then
            local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon)
            local newAmmo = pedAmmo + ammo.count
            ClearPedTasks(playerPed)
            local found, maxAmmo = GetMaxAmmo(playerPed, weapon)
            if newAmmo < maxAmmo then
                TaskReloadWeapon(playerPed)
                if Config.EnableInventoryHUD then
                    TriggerServerEvent('disc-inventoryhud:updateAmmoCount', weapon, newAmmo)
                end
                SetPedAmmo(playerPed, weapon, newAmmo)
                TriggerServerEvent('ammunition:removeAmmoItem', ammo)
                exports['mythic_notify']:SendAlert('success', _U('reloaded'))
            else
                exports['mythic_notify']:SendAlert('error', _U('max_ammo'))
            end
        end
    end
end)
