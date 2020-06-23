isInInventory = false
ESX = nil
local canOpenInventory = true
local targetInventory = nil

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, Config.CloseControl) then
			if isInInventory then
                closeInventory()
				end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
                openInventory()
            end
        end
    end
)

function openInventory()
    ESX.UI.Menu.CloseAll()-- this also closes any esx menus to prevent from society inventory duping
    if canOpenInventory then -- checks if inventory is being searched (can be opened)
        loadPlayerInventory()
        isInInventory = true
        SendNUIMessage(
            {
                action = "display",
                type = "normal"
            }
        )
        SetNuiFocus(true, true)
    else
        -- add any notification that lets person know that he can't open inventory
        exports['b1g_notify']:Notify('false', 'Inventory is disabled')
    end
end

-- sets the id of target
RegisterNetEvent("esx_invnetoryhud:setOpenedPlayerId")
AddEventHandler("esx_invnetoryhud:setOpenedPlayerId", function(target)
    --print(target)
    targetInventory = target
end)

-- disables inventory opening if someone is searching the source
RegisterNetEvent("esx_inventoryhud:disableOpen")
AddEventHandler('esx_inventoryhud:disableOpen', function()
    ESX.UI.Menu.CloseAll() -- this also closes any esx menus to prevent duping using society inventory
    closeInventory()
    canOpenInventory = false
end)

-- enables opening after search is finished
RegisterNetEvent("esx_inventoryhud:enableOpen")
AddEventHandler("esx_inventoryhud:enableOpen", function()
    canOpenInventory = true
end)

RegisterNetEvent("esx_inventoryhud:doClose")
AddEventHandler("esx_inventoryhud:doClose", function()
    closeInventory()
end)

RegisterCommand('closeinv', function(source, args, raw)
    closeInventory()
end)

function closeInventory()
    if targetInventory ~= nil then -- checks if search inventory was open and target's inventory needs to be enabled
        print(targetInventory)
        TriggerServerEvent("esx_inventoryhud:enableTargetInv", targetInventory)
        targetInventory = nil
    end
    isInInventory = false
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
end

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInventory()
    end
)

RegisterNUICallback(
    "GetNearPlayers",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true

                table.insert(
                    elements,
                    {
                        label = GetPlayerName(players[i]),
                        player = GetPlayerServerId(players[i])
                    }
                )
            end
        end

        if not foundPlayers then
        
            exports['b1g_notify']:Notify('false', _U("players_nearby"))
        else
            SendNUIMessage(
                {
                    action = "nearPlayers",
                    foundAny = foundPlayers,
                    players = elements,
                    item = data.item
                }
            )
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        TriggerServerEvent("esx:useItem", data.item.name)

        if shouldCloseInventory(data.item.name) then
            closeInventory()
        else
            Citizen.Wait(250)
            loadPlayerInventory()
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "DropItem",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
			if data.item.type == "item_money" then
				TriggerServerEvent("esx:removeInventoryItem", "item_account", "money", data.number)
			else
				TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
			end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "GiveItem",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == data.player then
                    foundPlayer = true
                end
            end
        end

        if foundPlayer then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            if data.item.type == "item_money" then
				TriggerServerEvent("esx:giveInventoryItem", data.player, "item_account", "money", count)
			else
				TriggerServerEvent("esx:giveInventoryItem", data.player, data.item.type, data.item.name, count)
			end
            Wait(250)
            loadPlayerInventory()
        else
        
            exports['b1g_notify']:Notify('false', _U("player_nearby"))
        end
        cb("ok")
    end
)

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function loadPlayerInventory()
    ESX.TriggerServerCallback(
        "esx_inventoryhud:getPlayerInventory",
        function(data)
            items = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons
            weight = data.weight
            maxWeight = data.maxWeight

            SendNUIMessage(
                {
                    action = "setWeight",
                    text = "<p>" .._U("player_inventory_weight").. "</p><div class=\"control\"><p>" ..weight.. " / " ..maxWeight.. "</p></div>"
                }
            )
            if Config.IncludeCash and money ~= nil and money > 0 then
                moneyData = {
                    label = _U("cash"),
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    weight = -1,
                    canRemove = true
                }

                table.insert(items, moneyData)
            end

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                weight = -1,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end

            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        inventory[key].type = "item_standard"
                        table.insert(items, inventory[key])
                    end
                end
            end

            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if weapons[key].name ~= "WEAPON_UNARMED" then
                        local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                        table.insert(
                            items,
                            {
                                label = weapons[key].label,
                                count = ammo,
                                weight = -1,
                                type = "item_weapon",
                                name = weapons[key].name,
                                usable = false,
                                rare = false,
                                canRemove = true
                            }
                        )
                    end
                end
            end

            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items
                }
            )
        end,
        GetPlayerServerId(PlayerId())
    )
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            if isInInventory then
                local playerPed = PlayerPedId()
                DisableAllControlActions(0)
                EnableControlAction(0, 47, true)
                EnableControlAction(0, 245, true)
                EnableControlAction(0, 38, true)
            end
            
            if not canOpenInventory then -- if inventory is being searched (can not be opened) - disable open control
                local playerPed = PlayerPedId()
                DisableControlAction(0, Config.OpenControl, true)
            else
                Citizen.Wait(2000)
            end
        end
    end
)
