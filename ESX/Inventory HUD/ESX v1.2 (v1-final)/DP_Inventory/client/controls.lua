RegisterCommand('+openinventory', function()
	if not IsPlayerDead(PlayerId()) then
		if IsInputDisabled(0) then
			openInventory()
		end
	end
end, false)
RegisterKeyMapping('+openinventory', 'Open Inventory', 'keyboard', 'f2')

RegisterCommand('+showhotbar', function()
	if not IsPlayerDead(PlayerId()) then
		HudForceWeaponWheel(false)
		showHotbar()
	end
end, false)
RegisterKeyMapping('+showhotbar', 'Show Inventory Hotbar', 'keyboard', 'tab')

RegisterCommand('+usehotbarone', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[1] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[1])
			TriggerEvent('DP_Inventory:notification', fastWeapons[1], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbarone', 'Use Inventory Hotbar Slot 1', 'keyboard', '1')

RegisterCommand('+usehotbartwo', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[2] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[2])
			TriggerEvent('DP_Inventory:notification', fastWeapons[2], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbartwo', 'Use Inventory Hotbar Slot 2', 'keyboard', '2')

RegisterCommand('+usehotbarthree', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[3] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[3])
			TriggerEvent('DP_Inventory:notification', fastWeapons[3], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbarthree', 'Use Inventory Hotbar Slot 3', 'keyboard', '3')

RegisterCommand('+usehotbarfour', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[4] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[4])
			TriggerEvent('DP_Inventory:notification', fastWeapons[4], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbarfour', 'Use Inventory Hotbar Slot 4', 'keyboard', '4')

RegisterCommand('+usehotbarfive', function()
	if not IsPlayerDead(PlayerId()) and canFire then
		if fastWeapons[5] ~= nil then
			TriggerServerEvent('esx:useItem', fastWeapons[5])
			TriggerEvent('DP_Inventory:notification', fastWeapons[5], _U('item_used'), 1, false)
		end
	end
end, false)
RegisterKeyMapping('+usehotbarfive', 'Use Inventory Hotbar Slot 5', 'keyboard', '5')

RegisterCommand('+openinventoryvault', function()
	local coords = GetEntityCoords(PlayerPedId())
	for k,v in pairs(Config.Vault) do
		local dist = GetDistanceBetweenCoords(coords, v.coords, true)
		if dist < 1.5 then
			OpenVaultInventoryMenu({job = k, needItemLicense = v.needItemLicense, InfiniteLicense = v.InfiniteLicense})
		end
	end
end, false)
RegisterKeyMapping('+openinventoryvault', 'Use Inventory Vault', 'keyboard', 'E')

RegisterCommand('+removeattachement', function()
	if not IsEntityDead(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), true) and not removingAttach then
		if currentWeapon ~= nil then
			removingAttach = true
			local playerPed = PlayerPedId()
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
RegisterKeyMapping('+removeattachement', 'Remove Attachement from Weapon', 'keyboard', 'BACKSLASH')

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
RegisterKeyMapping('+openshop', 'Open Shop', 'keyboard', 'E')