RegisterNetEvent("esx_inventoryhud:openMotelsInventory")
AddEventHandler(
    "esx_inventoryhud:openMotelsInventory",
    function(data)
        setPropertyMotelData(data)
        openMotelInventory()
    end
)

function refreshPropertyMotelInventory()
    ESX.TriggerServerCallback(
        "lsrp-motels:getPropertyInventory",
        function(inventory)
            setPropertyMotelData(inventory)
        end,
        ESX.GetPlayerData().identifier
    )
end

function setPropertyMotelData(data)
    items = {}

    SendNUIMessage(
                {
                    action = "setInfoText",
                    text = "Motel Inventory"
                }
            )

    local blackMoney = data.blackMoney
	local money = data.money
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            weight = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    if money > 0 then
        accountData = {
            label = _U("money"),
            count = money,
            type = "item_account",
            name = "money",
            usable = false,
            rare = false,
            weight = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end
	
    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.weight = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    weight = -1,
                    type = "item_weapon",
                    name = weapon.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openMotelInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "motels"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoMotel",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("lsrp-motels:putItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
        end

        Wait(150)
        refreshPropertyMotelInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromMotel",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("lsrp-motels:getItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
        end

        Wait(150)
        refreshPropertyMotelInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)
