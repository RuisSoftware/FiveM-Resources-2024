function OpenBagInventoryMenu(inventory, owner)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        if skin.bags_1 ~= 45 then
			hasBag = false
		else
			hasBag = true
        end
    end)
	if hasBag then
		ESX.TriggerServerCallback("DP_Inventory_bag:getInventory",function(inventory)
			TriggerEvent("DP_Inventory:openBagInventory", inventory)
			TriggerEvent('trew_hud_ui:toggleUit')
			if Config.CameraAnimationBag == true then
				if not IsPedSittingInAnyVehicle(PlayerPedId()) then
					DeleteSkinCam()
					loadCamera(0, 3)
				end
			end
		end, owner)
	else
		--print('You dont have a bag')
	end
end

-- 23 24 45
RegisterNetEvent('DP_Inventory_bag:toggleBag')
AddEventHandler('DP_Inventory_bag:toggleBag', function(id)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		if skin.bags_1 ~= 45 then
            TriggerEvent('skinchanger:change', "bags_1", 45)
            TriggerEvent('skinchanger:change', "bags_2", 0)
            TriggerEvent('skinchanger:getSkin', function(skin)
				TriggerServerEvent('esx_skin:save', skin)
				hasBag = true
			end)
		else
			OpenBagInventoryMenu('bag', PlayerData.identifier)
            -- TriggerEvent('skinchanger:change', "bags_1", 0)
            -- TriggerEvent('skinchanger:change', "bags_2", 0)
            -- TriggerEvent('skinchanger:getSkin', function(skin)
			-- 	TriggerServerEvent('esx_skin:save', skin)
			-- 	hasBag = false
			-- end)
        end
    end)
end)