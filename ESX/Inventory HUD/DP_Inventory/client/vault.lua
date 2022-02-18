local vaultType = {}

CreateThread(function()
	while ESX == nil or PlayerData == nil or PlayerData.job == nil do
		Citizen.Wait(1)
	end
	for k,v in pairs(Config.Vault) do
		if v.show == true then
			ESX.Game.SpawnLocalObject(Config.VaultBox, v.coords, function(obj)
				SetEntityHeading(obj, v.heading)
				PlaceObjectOnGroundProperly(obj)
				FreezeEntityPosition(obj, true)
			end)
		else
		end
	end
end)

--[[RegisterNetEvent('esx:setClub')
AddEventHandler('esx:setClub', function(club)
	--print('setclub', a,b)
	PlayerData.club = club
end)]]

function OpenVaultInventoryMenu(data)
	--if (data.job == PlayerData.job.name and PlayerData.job.grade > 1) or data.job == 'vault' or (data.job == PlayerData.club.name and PlayerData.club.grade == '3') or (data.job == PlayerData.club.name and PlayerData.club.grade == '4') then
	if (data.job == PlayerData.job.name and PlayerData.job.grade > 1) or data.job == 'vault' then
		--print(data.needItemLicense)
		vaultType = data
		ESX.TriggerServerCallback("DP_Inventory:getVaultInventory", function(inventory)
			if not inventory then
				exports['t-notify']:Alert({
					style  	=  'error',
					message =  _U('not_found'),
					length 	= 5500
				})
			else
				TriggerEvent("DP_Inventory:openVaultInventory", inventory)
			end
		end,
		data)
	else
		exports['t-notify']:Alert({
			style  	=  'error',
			message =  _U('no_key'),
			length 	= 5500
		})
		Citizen.Wait(0)
	end
end

function getMonsterVaultLicense()
	return vaultType
end