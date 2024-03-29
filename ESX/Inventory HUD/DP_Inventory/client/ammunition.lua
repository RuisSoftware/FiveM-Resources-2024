CreateThread(function()
	while true do
		Citizen.Wait(0)
		local currentWeapon = GetSelectedPedWeapon(PlayerPedId())
		DisplayAmmoThisFrame(currentWeapon)
	end
end)

RegisterNetEvent('ammunition:useAmmoItem')
AddEventHandler('ammunition:useAmmoItem', function(ammo)
	local playerPed = PlayerPedId()
	local weapon
	local found, currentWeapon = GetCurrentPedWeapon(playerPed, true)
	if found then
		for _, v in pairs(ammo.weapons) do
			local weaponHash = GetHashKey(v)
			if currentWeapon == weaponHash then
				weapon = v
				break
			end
		end
		if weapon ~= nil then
			local pedAmmo = GetAmmoInPedWeapon(playerPed, weapon)
			local newAmmo = pedAmmo + ammo.count
			ClearPedTasks(playerPed)
			local found, maxAmmo = GetMaxAmmo(playerPed, weapon)
			--print(weapon)
			if newAmmo < maxAmmo then
				local hash = GetHashKey(weapon)
				--print(hash)
				ESX.TriggerServerCallback('DP_Inventory:getAmmoCount', function(gunInfo)
					currentWepAttachs = gunInfo.attachments
				end, hash)
				ESX.TriggerServerCallback('DP_Inventory:doesWeaponHas', function(hasWeaponId)
					if hasWeaponId then
						weaponKey = hasWeaponId
						--print(weaponKey)
					else
						weaponKey = GenerateWeapon()
						--print(weaponKey)
					end
				end, hash)
				while weaponKey == nil do
				Wait(0)
				end
				local wepInfo = { 
					count = newAmmo,
					attach = currentWepAttachs or '{}',
					weapon_id = weaponKey
				}
				--print(wepInfo.count)
				--print(wepInfo.attach)
				--print(wepInfo.weapon_id)
				TriggerServerEvent('DP_Inventory:updateAmmoCount', hash, wepInfo)
				SetPedAmmo(playerPed, weapon, newAmmo)
				TriggerServerEvent('ammunition:removeAmmoItem', ammo)
				TaskReloadWeapon(playerPed)
				exports['t-notify']:Alert({
					style  	=  'info',
					message =  _U('reloaded'),
					length 	= 5500
				})
			else
				exports['t-notify']:Alert({
					style  	=  'error',
					message =  _U('max_ammo'),
					length 	= 5500
				})
			end
		end
	end
end)

