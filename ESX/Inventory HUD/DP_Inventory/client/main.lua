isInInventory = false
maxWeight = nil
ESX = nil
GUI = {}
GUI.Time = 0
arrayWeight = Config.localWeight
fastWeapons = {[1] = nil, [2] = nil, [3] = nil, [4] = nil, [5] = nil}
hasBag = false
canFire = true

local canPlayAnim = true
local fastItemsHotbar = {}
local itemslist ={}
local isHotbar = false

CreateThread(function()
	while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Citizen.Wait(0) end
	while ESX.GetPlayerData().job == nil do Citizen.Wait(10) end
	PlayerData = ESX.GetPlayerData()
	
	Citizen.Wait(3000)
	
    CreateLockerBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent("DP_Inventory_trunk:getOwnedVehicle")
	TriggerServerEvent("DP_Inventory_glovebox:getOwnedVehicle")
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin.bags_1 ~= 45 then
			hasBag = false
		else
			hasBag = true
        end
    end)
	lastChecked = GetGameTimer()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
	PlayerData = ESX.GetPlayerData()
	while PlayerData == nil do
		Citizen.Wait(10)
	end
	PlayerData.job = job
end)

AddEventHandler("onResourceStart", function()
	TriggerServerEvent("DP_Inventory_trunk:getOwnedVehicle")
	TriggerServerEvent("DP_Inventory_glovebox:getOwnedVehicle")
	lastChecked = GetGameTimer()
end)

CreateThread(function()
	while true do
		Citizen.Wait(0)
		HudForceWeaponWheel(false)
		HudWeaponWheelIgnoreSelection()
		DisableControlAction(1, 37, true)
		DisableControlAction(1, 157, true)
		DisableControlAction(1, 158, true)
		DisableControlAction(1, 160, true)
		DisableControlAction(1, 164, true)
		DisableControlAction(1, 165, true)
		DisableControlAction(2, 157, true)-- disable changing weapon
		DisableControlAction(2, 158, true)-- disable changing weapon
		DisableControlAction(2, 159, true)-- disable changing weapon
		DisableControlAction(2, 160, true)-- disable changing weapon
		DisableControlAction(2, 161, true)-- disable changing weapon
		DisableControlAction(2, 162, true)-- disable changing weapon
		DisableControlAction(2, 163, true)-- disable changing weapon
		DisableControlAction(2, 164, true)-- disable changing weapon
		DisableControlAction(2, 165, true)-- disable changing weapon
	end
end)

local function LockInventory()
	CreateThread(function()
		while isInInventory do
			Citizen.Wait(3)
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

local function GetPlayerWeight()
	CreateThread(function()
		if maxWeight == nil then
			ESX.TriggerServerCallback("DP_Inventory:getMaxInventoryWeight", function(cb)
				maxWeight = cb
			end)
		end
		ESX.TriggerServerCallback("DP_Inventory:getPlayerInventoryWeight", function(cb)
			local playerweight = cb
			SendNUIMessage({
				action = "setWeightText",
				text =  "<strong>         "..tostring(playerweight).."/"..tostring(maxWeight).."KG<strong>"
			})
			weight = playerweight
			if weight >= maxWeight then
				weight = 100
			end
			WeightLoaded = true
		end)
	end)
end

local function LoadItems()
	CreateThread(function()
		ESX.TriggerServerCallback("DP_Inventory:getPlayerInventory", function(data)
			items = {}
			fastItems = {}
			slotes = data.slotes
			if slotes ~= nil then
				if slotes ~= false then
					for index=1, #slotes do
						fastWeapons[slotes[index].slot] = slotes[index].item
					end
				end
			end
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
					if not ShouldSkipAccount(accounts[key].name) then
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
								table.insert(fastItems, {
									label = inventory[key].label,
									count = inventory[key].count,
									weight = 0,
									type = "item_standard",
									name = inventory[key].name,
									usable = inventory[key].usable,
									rare = inventory[key].rare,
									canRemove = true,
									slot = slot
								})
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

			if weapons ~= nil then
				for key, value in pairs(weapons) do
					local weaponHash = GetHashKey(weapons[key].name)
					local playerPed = PlayerPedId()
					if weapons[key].name ~= "WEAPON_UNARMED" then
						local found = false
						for slot, weapon in pairs(fastWeapons) do
							if weapon == weapons[key].name then
								local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
								table.insert(fastItems, {
									label = weapons[key].label,
									count = ammo,
									limit = -1,
									type = "item_weapon",
									name = weapons[key].name,
									usable = false,
									rare = false,
									canRemove = true,
									slot = slot
								})
								found = true
								break
							end
						end
						if found == false then
							local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
							table.insert(items, {
								label = weapons[key].label,
								count = ammo,
								weight = 0,
								type = "item_weapon",
								name = weapons[key].name,
								usable = false,
								rare = false,
								canRemove = true
							})
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

function OpenInventory()
	if Config.CameraAnimationPocket == true then
		if not IsPedSittingInAnyVehicle(PlayerPedId()) then
			DeleteSkinCam()
			loadCamera(0, 3)
		end
	end
	isInInventory = true
	LockInventory()
	LoadPlayerInventory()
	SendNUIMessage({
		action = "display",
		type = "normal",
		weight = weight
	})
	TransitionToBlurred(1000)
	SetNuiFocus(true, true)
end

function CloseInventory()
	DeleteSkinCam()
	isInInventory = false
	ClearPedSecondaryTask(PlayerPedId())
	SendNUIMessage({
		action = "hide"
	})
	TransitionFromBlurred(1000)
	SetNuiFocus(false, false)
end

local function ShouldCloseInventory(itemName)
	for index, value in ipairs(Config.CloseUiItems) do
		if value == itemName then
			return true
		end
	end
	return false
end

function ShouldSkipAccount(accountName)
	for index, value in ipairs(Config.ExcludeAccountsList) do
		if value == accountName then
			return true
		end
	end
	return false
end

function LoadPlayerInventory()
	WeightLoaded = false
	GetPlayerWeight()
	ItemsLoaded = false
	LoadItems()
	while not ItemsLoaded or not WeightLoaded do
		Citizen.Wait(100)
	end
end

function ShowHotbar()
	if not isHotbar then
		isHotbar = true
		SendNUIMessage({
			action = "ShowHotbar",
			fastItems = fastItemsHotbar,
			itemList = itemslist
		})
		Citizen.Wait(1500)
		isHotbar = false
	end
end

RegisterNUICallback("NUIFocusOff", function()
	if isInInventory then
		CloseInventory()
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
					table.insert(elements, {
						label = playerss,
						player = GetPlayerServerId(players[i])
					})

					SendNUIMessage({
						action = "nearPlayers",
						foundAny = foundPlayers,
						players = elements,
						item = data.item
					})
			end, GetPlayerServerId(players[i]))
		end
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
			if data.item.name == 'bag' then
				TriggerEvent('skinchanger:change', "bags_1", 0)
				TriggerEvent('skinchanger:change', "bags_2", 0)
				TriggerEvent('skinchanger:getSkin', function(skin)
					TriggerServerEvent('esx_skin:save', skin)
					hasBag = false
				end)
			end
			if data.item.name == 'idcard' then
				local coords = playerCoords
				local forward = GetEntityForwardVector(PlayerPedId())
				coords = coords + forward*1.0
				TriggerServerEvent('license_menu:idCardLocation', coords)
			end
			TriggerServerEvent("esx:removeInventoryItem", data.item.type, data.item.name, data.number)
		end
	end
			Wait(100)
	LoadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("UseItem", function(data, cb)
print("used item")
	TriggerServerEvent("esx:useItem", data.item.name)
    TriggerEvent('DP_Inventory:notification', data.item.name, _U("item_used"), 1, false)
	if ShouldCloseInventory(data.item.name) then
		CloseInventory()
	else
		Wait(100)
		LoadPlayerInventory()
	end
	cb("ok")
end)

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
		elseif data.item.name == 'WEAPON_PISTOL' or data.item.name == 'WEAPON_FLASHLIGHT' or data.item.name == 'WEAPON_STUNGUN' or data.item.name == 'WEAPON_KNIFE'
		or data.item.name == 'WEAPON_BAT' or data.item.name == 'WEAPON_ADVANCEDRIFLE' or data.item.name == 'WEAPON_APPISTOL' or data.item.name == 'WEAPON_ASSAULTRIFLE'
		or data.item.name == 'WEAPON_ASSAULTSHOTGUN' or data.item.name == 'WEAPON_ASSAULTSMG' or data.item.name == 'WEAPON_AUTOSHOTGUN' or data.item.name == 'WEAPON_CARBINERIFLE'
		or data.item.name == 'WEAPON_COMBATPISTOL' or data.item.name == 'WEAPON_PUMPSHOTGUN' or data.item.name == 'WEAPON_SMG' then
			ESX.TriggerServerCallback('DP_Inventory:giveWeapon', function(callback)
				if callback then
					TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), data.item.type, data.item.name, count)
				end
			end,GetPlayerServerId(closestPlayer), data.item.name)
		else
			if data.item.name == 'idcard' then
				TriggerServerEvent('license_menu:idCardGiven', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
			end
			TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), data.item.type, data.item.name, count)
		end
			Wait(100)
		LoadPlayerInventory()
	end
	cb("ok")
end)

RegisterNUICallback("PutIntoFast", function(data, cb)
	if data.item.slot ~= nil then
		fastWeapons[data.item.slot] = nil
	end
	TriggerServerEvent('DP_Inventory:putInToSlot', data.item.name, data.slot)
	fastWeapons[data.slot] = data.item.name
	Wait(100)
	LoadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
	TriggerServerEvent('DP_Inventory:removeFromSlot',data.item.name, data.item.slot)
	fastWeapons[data.item.slot] = nil
	if string.find(data.item.name, "WEAPON_", 1) ~= nil and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(data.item.name) then
		TriggerEvent('DP_Inventory:closeinventory', source)
		RemoveWeapon(data.item.name)
	end
	Wait(100)
	LoadPlayerInventory()
	cb("ok")
end)

RegisterNetEvent('DP_Inventory:disablenumbers')
AddEventHandler('DP_Inventory:disablenumbers', function(disabled)
	canFire = disabled
end)

RegisterNetEvent('DP_Inventory:notification')
AddEventHandler('DP_Inventory:notification', function(sourceitemname, sourceitemlabel, sourceitemcount, sourceitemremove)
	SendNUIMessage({
		action = "notification",
		itemname = sourceitemname,
		itemlabel = sourceitemlabel,
		itemcount = sourceitemcount,
		itemremove = sourceitemremove
	})
end)

RegisterNetEvent('DP_Inventory:closeinventory')
AddEventHandler('DP_Inventory:closeinventory', function()
	CloseInventory()
end)

RegisterNetEvent('DP_Inventory:clearfastitems')
AddEventHandler('DP_Inventory:clearfastitems', function()
	fastWeapons = {[1] = nil, [2] = nil, [3] = nil, [4] = nil, [5] = nil}
	RemoveAllPedWeapons(PlayerPedId(), true)
end)

RegisterNetEvent('DP_Inventory:doClose')
AddEventHandler('DP_Inventory:doClose', function(...)
	CloseInventory(...);
end)

CreateThread(function()
    while true do
		Wait((1000 * 60) * 10)
		local _currentGarabge = math.floor(collectgarbage("count")+0.5)
        if _currentGarabge > 5000 then 
			collectgarbage("collect")
			local _newGarbage = math.floor(collectgarbage("count")+0.5)
			local _foundGarbage = math.floor(_currentGarabge - _newGarbage+0.5)
			print("^Garbage Collection: ^1" .. _foundGarbage .. "Kb ^7Garbage found. Old Memory Usage: ^3" .. _currentGarabge .. "Kb^7. New Memory Usage: ^2" .. _newGarbage .. "Kb^7. Around ^5" ..math.floor(_currentGarabge/_newGarbage+0.5) .. "%^7 Collectend and Removed.")
		end
    end 
end)