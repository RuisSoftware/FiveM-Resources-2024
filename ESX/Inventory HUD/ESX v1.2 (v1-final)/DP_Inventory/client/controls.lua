RegisterCommand('+openinventory', function()
	if not isPlayerDead then
		if (vehicleInFront == 0 or vehicleInFront == nil) and isPedOnFoot then
			OpenInventory()
			return
		end
		if (vehicleInFront ~= nil and vehicleInFront ~= 0) and isPedOnFoot then
			OpenTrunk()
			return
		end
		OpenGlovebox()
	end
end, false)
RegisterKeyMapping('+openinventory', 'Open Inventory', 'keyboard', Config.OpenControl)

RegisterCommand('+showhotbar', function()
	if not isPlayerDead then
		HudForceWeaponWheel(false)
		ShowHotbar()
	end
end, false)
RegisterKeyMapping('+showhotbar', 'Show Inventory Hotbar', 'keyboard', Config.ShowHotbar)

RegisterCommand('+usehotbarone', function()
	if not isPlayerDead and canFire then
		if fastWeapons[1] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[1])
			TriggerEvent('DP_Inventory:notification', fastWeapons[1], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbarone', 'Use Inventory Hotbar Slot 1', 'keyboard', '1')

RegisterCommand('+usehotbartwo', function()
	if not isPlayerDead and canFire then
		if fastWeapons[2] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[2])
			TriggerEvent('DP_Inventory:notification', fastWeapons[2], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbartwo', 'Use Inventory Hotbar Slot 2', 'keyboard', '2')

RegisterCommand('+usehotbarthree', function()
	if not isPlayerDead and canFire then
		if fastWeapons[3] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[3])
			TriggerEvent('DP_Inventory:notification', fastWeapons[3], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbarthree', 'Use Inventory Hotbar Slot 3', 'keyboard', '3')

RegisterCommand('+usehotbarfour', function()
	if not isPlayerDead and canFire then
		if fastWeapons[4] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[4])
			TriggerEvent('DP_Inventory:notification', fastWeapons[4], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbarfour', 'Use Inventory Hotbar Slot 4', 'keyboard', '4')

RegisterCommand('+usehotbarfive', function()
	if not isPlayerDead and canFire then
		if fastWeapons[5] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[5])
			TriggerEvent('DP_Inventory:notification', fastWeapons[5], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbarfive', 'Use Inventory Hotbar Slot 5', 'keyboard', '5')

RegisterCommand('+openinventoryvault', function()
	local coords = playerCoords
	for k,v in pairs(Config.Vault) do
		local dist = GetDistanceBetweenCoords(coords, v.coords, true)
		if dist < 1.5 then
			OpenVaultInventoryMenu({job = k, needItemLicense = v.needItemLicense, InfiniteLicense = v.InfiniteLicense})
		end
	end
end, false)
RegisterKeyMapping('+openinventoryvault', 'Open Vault Inventory', 'keyboard', Config.GeneralInteraction)

RegisterCommand('+removeattachement', function()
	if not isPlayerDead and not isPedInAnyVehicle and not removingAttach then
		if currentWeapon ~= nil then
			removingAttach = true
			local playerPed = playerPedId
			local hash = GetHashKey(currentWeapon)
			for i = 1, #currentWepAttachs do
				if currentWepAttachs[i] ~= nil then
					if string.find(currentWepAttachs[i], 'skin') == nil then
						TriggerEvent("mythic_progbar:client:progress", {
							name = "washing_gsr",
							duration = 1500,
							label = _U('waiting_remove'),
							useWhileDead = false,
							canCancel = false,
							controlDisables = {
								disableMovement = false,
								disableCarMovement = false,
								disableMouse = false,
								disableCombat = false,
							},
						}, function(status)
							if not status then
								RemoveWeaponComponentFromPed(playerPed, hash, weapons[tostring(hash)][currentWepAttachs[i]])
								DP.TriggerServerCallback('DP_Inventaris:addPlayerItem', function(cb)end, currentWepAttachs[i], 1)
								table.remove(currentWepAttachs, i)
								removingAttach = false
							end
						end)
					end
				end
			end
		else
			exports['t-notify']:Alert({
				style  	=  'error',
				message =  _U("no_gun_in_hand"),
				length 	= 5500
			})
		end
	end
end, false)
RegisterKeyMapping('+removeattachement', 'Remove Attachement from Weapon', 'keyboard', Config.RemoveAttachementKey)

RegisterCommand('+openshop', function()
	player = PlayerPedId()
	coords = GetEntityCoords(player)
	if not IsPlayerDead(player) then
		if IsInRegularShopZone(coords) or IsInRobsLiquorZone(coords) or IsInDrugShopZone(coords) or IsInIlegalShopZone(coords) or IsInYouToolZone(coords) or IsInPrisonShopZone(coords) or IsInWeaponShopZone(coords) or IsInBlackMarketZone(coords) or IsInShopNightclubZone(coords) or IsInPoliceShopZone(coords) or IsInGroothandelSupermarktZone(coords) then
			if IsInRegularShopZone(coords) then
				OpenShopInv('regular')
			end
			
			if IsInIlegalShopZone(coords) then
				if Config.IllegalshopOpen == true then
					OpenShopInv('ilegal')
				else
					if ESX.GetPlayerData().job.name == Config.InventoryJob.Police then
						OpenShopInv('ilegal')
					else
						exports['t-notify']:Alert({
							style  	=  'error',
							message =  _U('no_acces'),
							length 	= 5500
						})
					end
				end
			end
			
			if Config.useAdvancedShop == true then
				if IsInGroothandelSupermarktZone(coords) then
					ESX.TriggerServerCallback('DP_Inventory:heeftSupermarkt', function(ja)
						if ja then
							OpenShopInv('groothandel_supermarkt')
						else
							exports['t-notify']:Alert({
								style  	=  'error',
								message =  _U('no_acces'),
								length 	= 5500
							})
						end
					end, GetPlayerServerId(PlayerId()))
				end
			end
			
			if IsInRobsLiquorZone(coords) then
				OpenShopInv('robsliquor')
			end
			
			if IsInYouToolZone(coords) then
				OpenShopInv('youtool')
			end
			
			if IsInPrisonShopZone(coords) then
				if ESX.GetPlayerData().job.name == Config.InventoryJob.Police then
					OpenShopInv('prison')
				end
			end
			
			if IsInDrugShopZone(coords) then
				OpenShopInv('drugs')
			end
			
			if IsInWeaponShopZone(coords) then
				if Config.UseLicense == true then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
						if hasWeaponLicense then
							OpenShopInv('weaponshop')
						else
							exports['t-notify']:Alert({
								style  	=  'error',
								message =  _U('license_check_fail'),
								length 	= 5500
							})
						end
					end, GetPlayerServerId(PlayerId()), Config.License.Weapon)
				else
					OpenShopInv('weaponshop')
				end
			end
			
			if IsInPoliceShopZone(coords) then
				if ESX.GetPlayerData().job.name == Config.InventoryJob.Police and ESX.GetPlayerData().job.grade >= Config.ShopMinimumGradePolice then
					OpenShopInv('policeshop')
				end
			end
			
			if IsInShopNightclubZone(coords) then
				if ESX.GetPlayerData().job.name == Config.InventoryJob.Nightclub and ESX.GetPlayerData().job.grade >= Config.ShopMinimumGradeNightclub then
					OpenShopInv('nightclubshop')
				end
			end
			
			if IsInBlackMarketZone(coords) then
				if ESX.GetPlayerData().job.name == Config.InventoryJob.Mafia and ESX.GetPlayerData().job.grade >= Config.ShopMinimumGradeMafia then
					OpenShopInv('blackmarket')
				end
			end
			
		end
	end
end, false)
RegisterKeyMapping('+openshop', 'Open Regular Shop', 'keyboard', 'E')

if Config.UseLicense then
	RegisterCommand('+openlicensemenu', function()
		if not isPlayerDead then
			LicenseShop = Config.Shops.LicenseShop.Locations
			player = PlayerPedId()
			coords = GetEntityCoords(player)
			for i = 1, #LicenseShop, 1 do
				if GetDistanceBetweenCoords(coords, LicenseShop[i].x, LicenseShop[i].y, LicenseShop[i].z, true) < 2.0 then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
						if hasWeaponLicense then
							exports['t-notify']:Alert({
								style  	=  'error',
								message =  _U('license_shop_check'),
								length 	= 5500
							})
						else
							OpenBuyLicenseMenu()
							Citizen.Wait(2000)
						end
					end, GetPlayerServerId(PlayerId()), Config.License.Weapon)
				end
			end
		end
	end, false)
	RegisterKeyMapping('+openlicensemenu', 'Open License Shop', 'keyboard', Config.RobKeyPrimary)
end

local holdRobKey = false
RegisterCommand('+robsomeone1', function()
	if not isPlayerDead then
		holdRobKey = true
	end
end, false)
RegisterKeyMapping('+robsomeone1', 'Primary Key to Rob Someone', 'keyboard', Config.RobKeyPrimary)

RegisterCommand('-robsomeone1', function()
	holdRobKey = false
end, false)
RegisterKeyMapping('-robsomeone1', 'Primary Key to Rob Someone', 'keyboard', Config.RobKeyPrimary)

RegisterCommand('+robsomeone2', function()
	if not isPlayerDead then
        if holdRobKey then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
				if not Config.EverybodyCanRob then
					if (Config.AllowPolice and PlayerData.job.name == Config.InventoryJob.Police) or (Config.AllowNightclub and PlayerData.job.name == Config.InventoryJob.Nightclub) or (Config.AllowMafia and PlayerData.job.name == Config.InventoryJob.Mafia) or (Config.AllowMafia and PlayerData.job.name == Config.InventoryJob.Ambulance) then
						local searchPlayerPed = GetPlayerPed(closestPlayer)
						if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityPlayingAnim(searchPlayerPed, 'missminuteman_1ig_2', 'handsup_base', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 or IsEntityPlayingAnim(searchPlayerPed, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(searchPlayerPed, "mp_arrest_paired", "crook_p2_back_right", 3) then
							exports['mythic_progbar']:Progress({
								name = "OpenGlovebox",
								duration = 3500,
								label = _U('robbing'),
								useWhileDead = false,
								canCancel = true,
								controlDisables = {},
								animation = {},
								prop = {},
							}, function(status)
								if not status then
									TriggerEvent("DP_Inventory:openPlayerInventory", GetPlayerServerId(closestPlayer), GetPlayerName(closestPlayer))
								end
							end)
						else
							exports['t-notify']:Alert({
								style  	=  'info',
								message =  _U('player_not_dead'),
								length 	= 5500
							})
						end
					else
						exports['t-notify']:Alert({
							style  	=  'info',
							message =  _U('no_permissions'),
							length 	= 5500
						})
					end
				else
					local searchPlayerPed = GetPlayerPed(closestPlayer)
					if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityPlayingAnim(searchPlayerPed, 'missminuteman_1ig_2', 'handsup_base', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 or IsEntityPlayingAnim(searchPlayerPed, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(searchPlayerPed, "mp_arrest_paired", "crook_p2_back_right", 3) then
						exports['mythic_progbar']:Progress({
							name = "OpenGlovebox",
							duration = 3500,
							label = _U('robbing'),
							useWhileDead = false,
							canCancel = true,
							controlDisables = {},
							animation = {},
							prop = {},
						}, function(status)
							if not status then
								TriggerEvent("DP_Inventory:openPlayerInventory", GetPlayerServerId(closestPlayer), GetPlayerName(closestPlayer))
							end
						end)  
					else
						exports['t-notify']:Alert({
							style  	=  'info',
							message =  _U('player_not_dead'),
							length 	= 5500
						})
					end
				end
            end
        end
	end
end, false)
RegisterKeyMapping('+robsomeone2', 'Secondary key to rob someone', 'keyboard', Config.RobKeyPrimary)

RegisterCommand('+showbaginventory', function()
	if not IsPedInAnyVehicle(PlayerPedId(), true) and not IsEntityInAir(PlayerPedId()) and hasBag then
		OpenBagInventoryMenu('bag', PlayerData.identifier)
	end
end, false)
RegisterKeyMapping('+showbaginventory', 'Show Bag Inventory', 'keyboard', Config.BagControl)

RegisterCommand('+showlockerinventory', function()
	if not IsPedInAnyVehicle(PlayerPedId(), true) and not IsEntityInAir(PlayerPedId()) and hasBag then
        local playerCoords = playerCoords
		local playerPed = PlayerPedId()
        local isClose = false
		
		for k, v in pairs (Config.Lockers) do
			local locker_name = v.locker_name
            local locker_loc = v.location
			local locker_dist = GetDistanceBetweenCoords(playerCoords, locker_loc.x, locker_loc.y, locker_loc.z, 1)
			
			if locker_dist <= 1.0 then
				isClose = true
				ESX.TriggerServerCallback('DP_Inventory:checkLocker', function(checkLocker)
					LockerMenu(k, checkLocker, locker_name)
					return
				end, k)
			end
		end
		
		local lockerExterior = GetDistanceBetweenCoords(playerCoords, Config.LockerExterior.x, Config.LockerExterior.y, Config.LockerExterior.z, 1)
		if lockerExterior <= 4.0 then
			isClose = true
			SetEntityCoords(playerPed, Config.LockerInterior.x, Config.LockerInterior.y, Config.LockerInterior.z)
			SetEntityHeading(playerPed, 90.0)
			DoScreenFadeIn(800)
			return
		end
		
		local lockerInterior = GetDistanceBetweenCoords(playerCoords, Config.LockerInterior.x, Config.LockerInterior.y, Config.LockerInterior.z, 1)
		if lockerInterior <= 1.0 then
			isClose = true
			SetEntityCoords(playerPed, Config.LockerExterior.x, Config.LockerExterior.y, Config.LockerExterior.z)
			SetEntityHeading(playerPed, 185.0)
			DoScreenFadeIn(800)
			return
		end
	end
end, false)
RegisterKeyMapping('+showlockerinventory', 'Show Locker Inventory', 'keyboard', Config.GeneralInteraction)