local isPlayerSafe = false

RegisterNetEvent("esx_inventoryhud:openPropertyInventory")
AddEventHandler("esx_inventoryhud:openPropertyInventory", function(data, playerSafe)
    if playerSafe then isPlayerSafe = playerSafe; else isPlayerSafe = false; end
    setPropertyInventoryData(data)
    openPropertyInventory()
end)

function refreshPropertyInventory()
    if isPlayerSafe then
        ESX.TriggerServerCallback('MF_PlayerSafes:GetSafeInventory', function(inventory) 
            setPropertyInventoryData(inventory); 
        end,isPlayerSafe.safeid)
    else
        ESX.TriggerServerCallback("esx_property:getPropertyInventory",function(inventory)
            setPropertyInventoryData(inventory)
        end,ESX.GetPlayerData().identifier)
    end
end

function setPropertyInventoryData(data)
    items = {}

    local blackMoney = data.blackMoney
    local money = data.money
    local propertyItems = data.items
    local propertyWeapons = data.weapons

    if money > 0 then
        accountData = {
            label = _U("cash"),
            count = money,
            type = "item_money",
            name = "cash",
            usable = false,
            rare = false,
            weight = 0,
            canRemove = false
        }
        table.insert(items, accountData)
    end
	
    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            weight = 0,
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
            item.weight = 0
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
                    weight = 0,
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

function openPropertyInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "property"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoProperty", function(data, cb) 
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	print(data)
	for k,v in pairs(data) do print(k,v); end

	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		local isWeapon = false
		if data.item.type == "item_weapon" then
			isWeapon = true
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end

		if isPlayerSafe then       
			print("DOPUTSAFE")     
			TriggerServerEvent("MF_PlayerSafes:PutItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count, isPlayerSafe.safeid, isWeapon)
		else
			if data.item.name == 'cash' then
				TriggerServerEvent("esx_property:putItem", ESX.GetPlayerData().identifier, 'item_account', 'money', count)
			else
				TriggerServerEvent("esx_property:putItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
			end
		end
	end

	Wait(150)
	refreshPropertyInventory()
	Wait(150)
	loadPlayerInventory()

	cb("ok")
end)

RegisterNUICallback("TakeFromProperty", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	if type(data.number) == "number" and math.floor(data.number) == data.number then
		if isPlayerSafe then
			TriggerServerEvent("MF_PlayerSafes:GetItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number), isPlayerSafe.safeid)
		else
			if data.item.name == 'cash' then
				TriggerServerEvent("esx_property:getItem", ESX.GetPlayerData().identifier, 'item_account', 'money', tonumber(data.number))
			else
				TriggerServerEvent("esx_property:getItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
			end
		end
	end

	Wait(150)
	refreshPropertyInventory()
	Wait(150)
	loadPlayerInventory()

	cb("ok")
end)
