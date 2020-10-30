hasBag = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin.bags_1 ~= 45 then
			hasBag = false
		else
			hasBag = true
        end
    end)
end)

function OpenBagInventoryMenu(inventory, owner)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin.bags_1 ~= 45 then
			hasBag = false
		else
			hasBag = true
        end
    end)
	if hasBag then
		ESX.TriggerServerCallback("esx_bag:getPropertyInventory",function(inventory)
			TriggerEvent("esx_inventoryhud:openBagInventory", inventory)
		end, owner)
	else
		print('You dont have a bag')
	end
end

RegisterNetEvent('esx_bag:toggleBag')
AddEventHandler('esx_bag:toggleBag', function(id)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin.bags_1 ~= 45 then
            TriggerEvent('skinchanger:change', "bags_1", 45)
            TriggerEvent('skinchanger:change', "bags_2", 0)
            TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerServerEvent('esx_skin:save', skin)
				hasBag = true
			end)
		else
            TriggerEvent('skinchanger:change', "bags_1", 0)
            TriggerEvent('skinchanger:change', "bags_2", 0)
            TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerServerEvent('esx_skin:save', skin)
				hasBag = false
			end)
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Wait(5)
		owner = ESX.GetPlayerData().identifier
		--owner = PlayerData.identifier
        if IsControlJustReleased(0, Config.BagControl) and not IsPedInAnyVehicle(GetPlayerPed(-1), true) and not IsEntityInAir(PlayerPedId()) then
			OpenBagInventoryMenu('bag', owner)
        end
    end
end)
