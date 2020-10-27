isInInventory = false
ESX = nil
local fastWeapons = {
	[1] = nil,
	[2] = nil,
	[3] = nil,
    [4] = nil,
    [5] = nil
}
local canPlayAnim = true
local fastItemsHotbar = {}
local itemslist ={}
local isHotbar = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	Citizen.Wait(3000)
	toghud = true
end)


RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
    PlayerData = xPlayer
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicle")
    TriggerServerEvent("esx_glovebox_inventory:getOwnedVehicle")
    lastChecked = GetGameTimer()
end)

AddEventHandler("onResourceStart", function()
    PlayerData = xPlayer
    TriggerServerEvent("esx_trunk_inventory:getOwnedVehicle")
    TriggerServerEvent("esx_glovebox_inventory:getOwnedVehicle")
    lastChecked = GetGameTimer()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	local PlayerData = ESX.GetPlayerData()
	
	if PlayerData == nil then
		print ('Kofferbak kan beroep niet synchroniseren. Dit is niet erg.')  -- Cannot sync job, not bad
	else
		print (PlayerData.job.name) -- Can sync job
		PlayerData.job = job
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		HudForceWeaponWheel(false)
		HudWeaponWheelIgnoreSelection()
        DisableControlAction(0, 37, true)
	end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)
    end
    while true do
        Citizen.Wait(7)
        if not IsPlayerDead(PlayerId()) then
            DisableControlAction(0, 37, true)
            if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
                    openInventory()
            elseif IsControlJustReleased(0, Config.CloseControl) and IsInputDisabled(0) then
                    closeInventory()
            elseif  IsDisabledControlJustReleased(1, 157) and canFire then
                if fastWeapons[1] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[1])
                end
            elseif IsDisabledControlJustReleased(1, 158) and canFire then
                if fastWeapons[2] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[2])
                end
            elseif IsDisabledControlJustReleased(1, 160) and canFire then
                if fastWeapons[3] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[3])
                end
            elseif IsDisabledControlJustReleased(1, 164) and canFire then
                if fastWeapons[4] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[4])
                end
            elseif IsDisabledControlJustReleased(1, 165) and canFire then
                if fastWeapons[5] ~= nil then
                    TriggerServerEvent("esx:useItem", fastWeapons[5])
                end
            elseif IsDisabledControlJustReleased(1, 37) then
				HudForceWeaponWheel(false)
                showHotbar()
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

function lockinv()
    Citizen.CreateThread(function()
        while isInInventory do
            Citizen.Wait(10)
            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 32, true) -- W
            DisableControlAction(0, 34, true) -- A
            DisableControlAction(0, 31, true) -- S (fault in Keys table!)
            DisableControlAction(0, 30, true) -- D (fault in Keys table!)

            DisableControlAction(0, 45, true) -- Reload
            DisableControlAction(0, 22, true) -- Jump
            DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 23, true) -- Also 'enter'?

            DisableControlAction(0, 288, true) -- Disable phone
            DisableControlAction(0, 289, true) -- Inventory
            DisableControlAction(0, 170, true) -- Animations
            DisableControlAction(0, 166, true) -- Job

            DisableControlAction(0, 0, true) -- Disable changing view
            DisableControlAction(0, 26, true) -- Disable looking behind
            DisableControlAction(0, 73, true) -- Disable clearing animation
            DisableControlAction(2,199, true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, 36, true) -- Disable going stealth

            DisableControlAction(0, 47, true) -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable 
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)
end

function getPlayerWeight()
    Citizen.CreateThread(function()
        ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventoryWeight", function(cb)
            local playerweight = cb
            SendNUIMessage({
                action = "setWeightText",
                text =  "<strong>         "..tostring(playerweight).."/"..tostring(Config.MaxWeight).."KG<strong>"
            })
            weight = playerweight
            if weight >= Config.MaxWeight then
                weight = 100
            end
            WeightLoaded = true
        end)
    end)
end

function loadItems()
    Citizen.CreateThread(function()
        ESX.TriggerServerCallback("esx_inventoryhud:getPlayerInventory", function(data)
            items = {}
            fastItems = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons

            if Config.IncludeCash and money ~= nil and money > 0 then
                moneyData = {
                    label = _U("cash"),
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    weight = 0,
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
                                weight = 0,
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
                        local founditem = false
                        for slot, item in pairs(fastWeapons) do
                            if item == inventory[key].name then
                                table.insert(
                                        fastItems,
                                        {
                                            label = inventory[key].label,
                                            count = inventory[key].count,
                                            weight = 0,
                                            type = "item_standard",
                                            name = inventory[key].name,
                                            usable = inventory[key].usable,
                                            rare = inventory[key].rare,
                                            canRemove = true,
                                            slot = slot
                                        }
                                )
                                founditem = true
                                break
                            end
                            end
                            if founditem == false then
                             table.insert(items, inventory[key])

                        end
                    end
                end
            end

            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if weapons[key].name ~= "WEAPON_UNARMED" then
                        local found = false
			for slot, weapon in pairs(fastWeapons) do
                            if weapon == weapons[key].name then
                                local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                                table.insert(
                                    fastItems,
                                    {
                                        label = weapons[key].label,
                                        count = ammo,
                                        limit = -1,
                                        type = "item_weapon",
                                        name = weapons[key].name,
                                        usable = false,
                                        rare = false,
                                        canRemove = true,
                                        slot = slot
                                    }
                                )
                                found = true
                                break
                            end
                        end
                        if found == false then
				local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
				table.insert(
					items,
					{
						label = weapons[key].label,
						count = ammo,
						weight = 0,
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
            end
            fastItemsHotbar =  fastItems
			SendNUIMessage({
				action = "setItems",
				itemList = items,
				fastItems = fastItems,
				weight = weight
			})
            ItemsLoaded = true
        end, GetPlayerServerId(PlayerId()))
    end)
end

function openInventory()
    isInInventory = true
    lockinv()
    SetNuiFocus(true, true)  
    loadPlayerInventory()
    SendNUIMessage(
        {
            action = "display",
            type = "normal",
            weight = weight
        }
    )
end

function closeInventory()
    isInInventory = false
    ClearPedSecondaryTask(PlayerPedId())
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
end

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
    WeightLoaded = false
    getPlayerWeight()
    ItemsLoaded = false
    loadItems()
    while not ItemsLoaded or not WeightLoaded do
        Citizen.Wait(100)
    end
end

function showHotbar()
    if not isHotbar then
        isHotbar = true
        SendNUIMessage({
            action = "showhotbar",
            fastItems = fastItemsHotbar,
            itemList = itemslist
        })
        Citizen.Wait(1500)
        isHotbar = false
    end
end

RegisterNUICallback("NUIFocusOff", function()
    if isInInventory then
        closeInventory()
    end
end)

RegisterNUICallback("GetNearPlayers", function(data, cb)
	local playerPed = PlayerPedId()
	local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 10.0)
	local foundPlayers = false
	local elements = {}

	for i = 1, #players, 1 do
		if players[i] ~= PlayerId() then
			foundPlayers = true
			ESX.TriggerServerCallback('GetCharacterNameServer', function(playerss)
				foundPlayers = true
					table.insert(
						elements,
						{
							label = playerss,
							player = GetPlayerServerId(players[i])
						}
					)

					SendNUIMessage(
						{
							action = "nearPlayers",
							foundAny = foundPlayers,
							players = elements,
							item = data.item
						}
					)
			end, GetPlayerServerId(players[i]))
		end
	end

	cb("ok")
end)

RegisterNUICallback("UseItem", function(data, cb)
	TriggerServerEvent("esx:useItem", data.item.name)

	if shouldCloseInventory(data.item.name) then
		closeInventory()
	else
		Citizen.Wait(0)
		loadPlayerInventory()
	end

	cb("ok")
end)

RegisterNUICallback("DropItem",function(data, cb)
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

	Wait(0)
	loadPlayerInventory()

	cb("ok")
end
)

RegisterNUICallback("GiveItem", function(data, cb)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance < 3.0 then
        local count = tonumber(data.number)
        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        canPlayAnim = false
        ClearPedSecondaryTask(PlayerPedId())
        RequestAnimDict("mp_common")
        while (not HasAnimDictLoaded("mp_common")) do 
            Citizen.Wait(10) 
        end
        TaskPlayAnim(PlayerPedId(),"mp_common","givetake1_a",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
        SetCurrentPedWeapon(PlayerPedId(), 0xA2719263) 
        if (Config.PropList[data.item.name] ~= nil) then 
            attachModel = GetHashKey(Config.PropList[data.item.name].model)
            local bone = GetPedBoneIndex(PlayerPedId(), Config.PropList[data.item.name].bone)
            RequestModel(attachModel)
            while not HasModelLoaded(attachModel) do
                Citizen.Wait(10)
            end
            closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
            AttachEntityToEntity(closestEntity, PlayerPedId(), bone, Config.PropList[data.item.name].x, Config.PropList[data.item.name].y, Config.PropList[data.item.name].z,
            Config.PropList[data.item.name].xR, Config.PropList[data.item.name].yR, Config.PropList[data.item.name].zR, 1, 1, 0, true, 2, 1)
            Citizen.Wait(1500)
            if DoesEntityExist(closestEntity) then
                DeleteEntity(closestEntity)
            end
        end
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
        canPlayAnim = true
		if data.item.type == "item_money" then
				TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_account", "money", count)
			else
        TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), data.item.type, data.item.name, count)
		end
        Wait(0)
        loadPlayerInventory()
    end
    cb("ok")
end
)

RegisterNUICallback("PutIntoFast", function(data, cb)
		if data.item.slot ~= nil then
			fastWeapons[data.item.slot] = nil
		end
		fastWeapons[data.slot] = data.item.name
		loadPlayerInventory()
		cb("ok")
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
    fastWeapons[data.item.slot] = nil
    if string.find(data.item.name, "WEAPON_", 1) ~= nil and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(data.item.name) then
        TriggerEvent('esx_inventoryhud:closeinventory', source)
        RemoveWeapon(data.item.name)
    end
    loadPlayerInventory()
    cb("ok")
end)

RegisterNetEvent('esx_inventoryhud:disablenumbers')
AddEventHandler('esx_inventoryhud:disablenumbers', function(disabled)
    canFire = disabled
end)

RegisterNetEvent('esx_inventoryhud:steal')
AddEventHandler('esx_inventoryhud:steal', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        local searchPlayerPed = GetPlayerPed(closestPlayer)
        if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 or IsEntityPlayingAnim(searchPlayerPed, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(searchPlayerPed, "mp_arrest_paired", "crook_p2_back_right", 3) then
            exports['mythic_progbar']:Progress({
                name = "rob",
                duration = 3000,
                label = _U('stealing'),
                useWhileDead = false,
                canCancel = true,
                controlDisables = {},
                animation = {},
                prop = {},
              }, function(status)
                if not status then
                    TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(closestPlayer))
                end
            end)
        end
    else
        exports['mythic_notify']:SendAlert('error', _U('players_nearby'))
    end
end)

RegisterNetEvent('esx_inventoryhud:notification')
AddEventHandler('esx_inventoryhud:notification', function(sourceitemname, sourceitemlabel, sourceitemcount, sourceitemremove)
	SendNUIMessage({
		action = "notification",
		itemname = sourceitemname,
		itemlabel = sourceitemlabel,
		itemcount = sourceitemcount,
		itemremove = sourceitemremove
	})
end)

RegisterNetEvent('esx_inventoryhud:closeinventory')
AddEventHandler('esx_inventoryhud:closeinventory', function()
    closeInventory()
end)

RegisterNetEvent('esx_inventoryhud:clearfastitems')
AddEventHandler('esx_inventoryhud:clearfastitems', function()
    fastWeapons = {
        [1] = nil,
        [2] = nil,
        [3] = nil,
        [4] = nil,
        [5] = nil
    }
    RemoveAllPedWeapons(PlayerPedId(), true)
end)

RegisterNetEvent('esx_inventoryhud:doClose')
AddEventHandler('esx_inventoryhud:doClose', function(...) 
    closeInventory(...); 
end)

