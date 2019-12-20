local gloveboxData = nil

RegisterNetEvent("esx_inventoryhud:openGloveboxInventory")
AddEventHandler(
    "esx_inventoryhud:openGloveboxInventory",
    function(data, blackMoney, inventory, weapons)
        setGloveboxInventoryData(data, blackMoney, inventory, weapons)
        openGloveboxInventory()
    end
)

RegisterNetEvent("esx_inventoryhud:refreshGloveboxInventory")
AddEventHandler(
    "esx_inventoryhud:refreshGloveboxInventory",
    function(data, blackMoney, inventory, weapons)
        setGloveboxInventoryData(data, blackMoney, inventory, weapons)
    end
)

function setGloveboxInventoryData(data, blackMoney, inventory, weapons)
    gloveboxData = data

    SendNUIMessage(
        {
            action = "setInfoText",
            text = data.text
        }
    )

    items = {}

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                inventory[key].type = "item_standard"
                inventory[key].usable = false
                inventory[key].rare = false
                inventory[key].limit = -1
                inventory[key].canRemove = false
                table.insert(items, inventory[key])
            end
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
                        label = weapons[key].label,
                        count = weapons[key].ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openGloveboxInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "glovebox"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoGlovebox",
    function(data, cb)
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("esx_glovebox:putItem", gloveboxData.plate, data.item.type, data.item.name, count, gloveboxData.max, gloveboxData.myVeh, data.item.label)
        end

        Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromGlovebox",
    function(data, cb)
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx_glovebox:getItem", gloveboxData.plate, data.item.type, data.item.name, tonumber(data.number), gloveboxData.max, gloveboxData.myVeh)
        end

        Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)
