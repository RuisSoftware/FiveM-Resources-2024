RegisterNetEvent('DP_Inventory:openLockerInventory')
AddEventHandler('DP_Inventory:openLockerInventory', function(data)
	setPropertyLockerData(data)
	openLockerInventory()
end)

function refreshPropertyLockerInventory()
    ESX.TriggerServerCallback('DP_Inventory:getLockerInventory', function(inventory)
		setPropertyLockerData(inventory)
	end, ESX.GetPlayerData().identifier, currentLocker)
end

function setPropertyLockerData(data)

    items = {}
	currentLocker = data.stash_name
    SendNUIMessage(
                {
                    action = 'setInfoText',
                    text = data.stash_name ..' - Kluis'
                }
            )

    local money = data.money
    local blackMoney = data.blackMoney
    local propertyItems = data.items
    local propertyWeapons = data.weapons

	if money > 0 then
		accountData = {
			label = _U('cash'),
			count = money,
			type = 'item_money',
			name = 'cash',
			usable = false,
			rare = false,
			weight = 0,
			canRemove = false
		}
		table.insert(items, accountData)
	end

    if blackMoney > 0 then
        accountData = {
            label = _U('black_money'),
            count = blackMoney,
            type = 'item_account',
            name = 'black_money',
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = 'item_standard'
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= 'WEAPON_UNARMED' then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    limit = -1,
                    type = 'item_weapon',
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
            action = 'setSecondInventoryItems',
            itemList = items
        }
    )
end

function openLockerInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = 'display',
            type = 'locker'
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback('PutIntoLocker', function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	if type(data.number) == 'number' and math.floor(data.number) == data.number then
		local count = tonumber(data.number)

		if data.item.type == 'item_weapon' then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end

		TriggerServerEvent('DP_Inventory:putLockerItems', ESX.GetPlayerData().identifier, data.item.type, data.item.name, count, currentLocker)
	end

	Wait(150)
	refreshPropertyLockerInventory()
	Wait(150)
	loadPlayerInventory()

	cb('ok')
end)

RegisterNUICallback('TakeFromLocker',function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	if type(data.number) == 'number' and math.floor(data.number) == data.number then
		TriggerServerEvent('DP_Inventory:getLockerItems', ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number), currentLocker)
	end

	Wait(150)
	refreshPropertyLockerInventory()
	Wait(150)
	loadPlayerInventory()

	cb('ok')
end)
