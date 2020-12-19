local vaultType = {}

Citizen.CreateThread(function()
	while ESX == nil or PlayerData == nil or PlayerData.job == nil do
		Citizen.Wait(1)
	end
	for k,v in pairs(Config.Vault) do
		ESX.Game.SpawnLocalObject(Config.VaultBox, v.coords, function(obj)
			SetEntityHeading(obj, v.heading)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)
		end)
	end
end)

function OpenVaultInventoryMenu(data)
	if data.job == PlayerData.job.name or data.job == 'vault' then
		--print(data.needItemLicense)
		vaultType = data
		ESX.TriggerServerCallback("DP_Inventory:getVaultInventory", function(inventory)
			if not inventory then
				exports['mythic_notify']:SendAlert('error', 'Niets gevonden')
			else
				TriggerEvent("DP_Inventory:openVaultInventory", inventory)
			end
		end,
		data)
	else
		exports['mythic_notify']:SendAlert('error', "Je hebt geen kluissleutel", 5500)
		Citizen.Wait(8000)
	end
end

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Vault) do
			local dist = GetDistanceBetweenCoords(coords, v.coords, true)
			if dist < 1.5 then
				ESX.ShowHelpNotification("Druk op E om de kluis van de "..k.. " te openen")
				if IsControlJustReleased(0, 38) then
					OpenVaultInventoryMenu({job = k, needItemLicense = v.needItemLicense, InfiniteLicense = v.InfiniteLicense})
				else
					break
				end
			end
		end
	end
end)

function getMonsterVaultLicense()
	return vaultType
end
