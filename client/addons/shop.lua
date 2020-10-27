local shopData = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        player = PlayerPedId()
        coords = GetEntityCoords(player)
        if IsInRegularShopZone(coords) or IsInRobsLiquorZone(coords) or IsInDrugShopZone(coords) or IsInIlegalShopZone(coords) or IsInYouToolZone(coords) or IsInPrisonShopZone(coords) or IsInWeaponShopZone(coords) or IsInBlackMarketZone(coords) or IsInShopNightclubZone(coords) or IsInPoliceShopZone(coords) then
            if IsInRegularShopZone(coords) then
                if IsControlJustReleased(0, 38) then
                    OpenShopInv("regular")
                    Citizen.Wait(2000)
                end
            end
            if IsInIlegalShopZone(coords) then
                if IsControlJustReleased(0, 38) then
					if Config.IllegalshopOpen == true then
						OpenShopInv("ilegal")
						Citizen.Wait(2000)
					else
						if ESX.GetPlayerData().job.name == Config.InventoryJob.Police then
							OpenShopInv("ilegal")
							Citizen.Wait(2000)
						else
							exports['mythic_notify']:DoHudText('error', _U('no_acces'))
						end
					end
                end
            end
            if IsInRobsLiquorZone(coords) then
                if IsControlJustReleased(0, 38) then
                    OpenShopInv("robsliquor")
                    Citizen.Wait(2000)
                end
            end
            if IsInYouToolZone(coords) then
                if IsControlJustReleased(0, 38) then
                    OpenShopInv("youtool")
                    Citizen.Wait(2000)
                end
            end
            if IsInPrisonShopZone(coords) then
                if ESX.GetPlayerData().job.name == Config.InventoryJob.Police then
                    if IsControlJustReleased(0, 38) then
                        OpenShopInv("prison")
                       Citizen.Wait(2000)
                    end
                end
            end
            if IsInDrugShopZone(coords) then
				if IsControlJustReleased(0, 38) then
					OpenShopInv("drugs")
					Citizen.Wait(2000)
				end
            end
            if IsInWeaponShopZone(coords) then
                if IsControlJustReleased(0, 38) then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
						if hasWeaponLicense then
							OpenShopInv("weaponshop")
							Citizen.Wait(2000)
						else
							exports['mythic_notify']:DoHudText('error', _U('license_check_fail'))
						end
					end, GetPlayerServerId(PlayerId()), Config.License.Weapon)
                end
            end
            if IsInPoliceShopZone(coords) then
                if IsControlJustReleased(0, 38) then
                    if ESX.GetPlayerData().job.name == Config.InventoryJob.Police and ESX.GetPlayerData().job.grade >= 8 then
						--ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
							--if hasWeaponLicense then
								OpenShopInv("policeshop")
								Citizen.Wait(2000)
							--else
							--	exports['mythic_notify']:DoHudText('error', _U('license_check_fail'))
							--end
						--end, GetPlayerServerId(PlayerId()), Config.License.Police)
					end
                end
            end
            if IsInShopNightclubZone(coords) then
                if IsControlJustReleased(0, 38) then
                    if ESX.GetPlayerData().job.name == Config.InventoryJob.Nightclub then
                        OpenShopInv("nightclubshop")
                        Citizen.Wait(2000)
                    end
                end
            end
            if IsInBlackMarketZone(coords) then
                if IsControlJustReleased(0, 38) then
                    if ESX.GetPlayerData().job.name == Config.InventoryJob.Mafia then
						OpenShopInv("blackmarket")
						Citizen.Wait(2000)
                    end
                end
            end
        else
            Citizen.Wait(1500)
        end
    end
end)

function OpenShopInv(shoptype)
    text = _("store")
    data = {text = text}
    inventory = {}
    ESX.TriggerServerCallback("suku:getShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
            
        end
        TriggerEvent("esx_inventoryhud:openShopInventory", data, inventory)
    end, shoptype)
end

RegisterNetEvent("suku:OpenCustomShopInventory")
AddEventHandler("suku:OpenCustomShopInventory", function(type, shopinventory)
    text = _("store")
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getCustomShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
        TriggerEvent("esx_inventoryhud:openShopInventory", data, inventory)
    end, type, shopinventory)
end)

RegisterNetEvent("esx_inventoryhud:openShopInventory")
AddEventHandler("esx_inventoryhud:openShopInventory", function(data, inventory)
    setShopInventoryData(data, inventory, weapons)
    openShopInventory()
end)

function setShopInventoryData(data, inventory)
    shopData = data

    SendNUIMessage(
            {
                action = "setInfoText",
                text = data.text
            }
    )

    items = {}

    SendNUIMessage(
            {
                action = "setShopInventoryItems",
                itemList = inventory
            }
    )
end

function openShopInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
            {
                action = "display",
                type = "shop"
            }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("TakeFromShop", function(data, cb)
    if IsPedSittingInAnyVehicle(playerPed) then
        return
    end

    if type(data.number) == "number" and math.floor(data.number) == data.number then
        TriggerServerEvent("suku:SellItemToPlayer", GetPlayerServerId(PlayerId()), data.item.type, data.item.name, tonumber(data.number))
    end

    Wait(150)
    loadPlayerInventory()

    cb("ok")
end)

RegisterNetEvent("suku:AddAmmoToWeapon")
AddEventHandler("suku:AddAmmoToWeapon", function(hash, amount)
    AddAmmoToPed(PlayerPedId(), hash, amount)
end)

function IsInRegularShopZone(coords)
    RegularShop = Config.Shops.RegularShop.Locations
    for i = 1, #RegularShop, 1 do
        if GetDistanceBetweenCoords(coords, RegularShop[i].x, RegularShop[i].y, RegularShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInIlegalShopZone(coords)
    IlegalShop = Config.Shops.IlegalShop.Locations
    for i = 1, #IlegalShop, 1 do
        if GetDistanceBetweenCoords(coords, IlegalShop[i].x, IlegalShop[i].y, IlegalShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInDrugShopZone(coords)
    DrugShop = Config.Shops.DrugShop.Locations
    for i = 1, #DrugShop, 1 do
        if GetDistanceBetweenCoords(coords, DrugShop[i].x, DrugShop[i].y, DrugShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInRobsLiquorZone(coords)
    RobsLiquor = Config.Shops.RobsLiquor.Locations
    for i = 1, #RobsLiquor, 1 do
        if GetDistanceBetweenCoords(coords, RobsLiquor[i].x, RobsLiquor[i].y, RobsLiquor[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInYouToolZone(coords)
    YouTool = Config.Shops.YouTool.Locations
    for i = 1, #YouTool, 1 do
        if GetDistanceBetweenCoords(coords, YouTool[i].x, YouTool[i].y, YouTool[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInPrisonShopZone(coords)
    PrisonShop = Config.Shops.PrisonShop.Locations
    for i = 1, #PrisonShop, 1 do
        if GetDistanceBetweenCoords(coords, PrisonShop[i].x, PrisonShop[i].y, PrisonShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInWeaponShopZone(coords)
    WeaponShop = Config.Shops.WeaponShop.Locations
    for i = 1, #WeaponShop, 1 do
        if GetDistanceBetweenCoords(coords, WeaponShop[i].x, WeaponShop[i].y, WeaponShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end


function IsInPoliceShopZone(coords)
    PoliceShop = Config.Shops.PoliceShop.Locations
    for i = 1, #PoliceShop, 1 do
        if GetDistanceBetweenCoords(coords, PoliceShop[i].x, PoliceShop[i].y, PoliceShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInBlackMarketZone(coords)
    BlackMarket = Config.Shops.BlackMarket.Locations
    for i = 1, #BlackMarket, 1 do
        if GetDistanceBetweenCoords(coords, BlackMarket[i].x, BlackMarket[i].y, BlackMarket[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInShopNightclubZone(coords)
    ShopNightclub = Config.Shops.ShopNightclub.Locations
    for i = 1, #ShopNightclub, 1 do
        if GetDistanceBetweenCoords(coords, ShopNightclub[i].x, ShopNightclub[i].y, ShopNightclub[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInShopNightclubZone(coords)
    ShopNightclub = Config.Shops.ShopNightclub.Locations
    for i = 1, #ShopNightclub, 1 do
        if GetDistanceBetweenCoords(coords, ShopNightclub[i].x, ShopNightclub[i].y, ShopNightclub[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    player = PlayerPedId()
    coords = GetEntityCoords(player)
	if Config.ShowRegularShopBlip then
		for k, v in pairs(Config.Shops.RegularShop.Locations) do
			CreateBlip(vector3(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z ), _U('regular_shop_name'), 3.0, Config.Color, Config.ShopBlipID)
		end
	end

	if Config.ShowRobsLiquorBlip then
		for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
			CreateBlip(vector3(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z ), _U('robs_liquor_name'), 3.0, Config.Color, Config.LiquorBlipID)
		end
	end

	if Config.ShowYouToolBlip then
		for k, v in pairs(Config.Shops.YouTool.Locations) do
			CreateBlip(vector3(Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z ), _U('you_tool_name'), 3.0, Config.Color, Config.YouToolBlipID)
		end
	end

	if Config.ShowPrisonShopBlip then
		for k, v in pairs(Config.Shops.PrisonShop.Locations) do
			CreateBlip(vector3(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z), _U('prison_shop_name'), 3.0, Config.Color, Config.PrisonShopBlipID)
		end
	end

	if Config.ShowWeaponShopBlip then
		for k, v in pairs(Config.Shops.WeaponShop.Locations) do
			CreateBlip(vector3(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z), _U('weapon_shop_name'), 3.0, Config.WeaponColor, Config.WeaponShopBlipID)
		end
	end

	if Config.ShowPoliceShopBlip then
		for k, v in pairs(Config.Shops.PoliceShop.Locations) do
			CreateBlip(vector3(Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z), _U('police_shop_name'), 3.0, Config.WeaponColor, Config.PoliceShopBlipID)
		end
	end

	if Config.ShowNightclubShopBlip then
		for k, v in pairs(Config.Shops.ShopNightclub.Locations) do
			CreateBlip(vector3(Config.Shops.ShopNightclub.Locations[k].x, Config.Shops.ShopNightclub.Locations[k].y, Config.Shops.ShopNightclub.Locations[k].z), _U('nightclub_shop_name'), 3.0, Config.WeaponColor, Config.NightclubShopBlipID)
		end
	end

	if Config.ShowBlackMarketBlip then
		for k, v in pairs(Config.Shops.BlackMarket.Locations) do
			CreateBlip(vector3(Config.Shops.BlackMarket.Locations[k].x, Config.Shops.BlackMarket.Locations[k].y, Config.Shops.BlackMarket.Locations[k].z), _U('blackmarket_shop_name'), 3.0, Config.WeaponColor, Config.BlackMarketBlipID)
		end
	end

	if Config.ShowDrugMarketBlip then
		for k, v in pairs(Config.Shops.DrugShop.Locations) do
			CreateBlip(vector3(Config.Shops.DrugShop.Locations[k].x, Config.Shops.DrugShop.Locations[k].y, Config.Shops.DrugShop.Locations[k].z), _U('drug_shop_name'), 3.0, Config.WeaponColor, Config.DrugShopBlipID)
		end
	end

	if Config.ShowIllegalShopBlip then
		for k, v in pairs(Config.Shops.IlegalShop.Locations) do
			CreateBlip(vector3(Config.Shops.IlegalShop.Locations[k].x, Config.Shops.IlegalShop.Locations[k].y, Config.Shops.IlegalShop.Locations[k].z), _U('blackmarket_shop_name'), 3.0, Config.WeaponColor, Config.IllegalShopBlipID)
		end
	end
    CreateBlip(vector3(-755.79, 5596.07, 41.67), "www.theheadquarters.eu", 3.0, 4, 36) -- The original esx_inventoryhud is from Trsak. It is officially maintained by the Headquarters.
end)

Citizen.CreateThread(function()
    local sleep = 7
    while true do
        Citizen.Wait(sleep)
        player = PlayerPedId()
        coords = GetEntityCoords(player)
        if IsPedOnFoot(player) then
            for k, v in pairs(Config.Shops.RegularShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.IlegalShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.IlegalShop.Locations[k].x, Config.Shops.IlegalShop.Locations[k].y, Config.Shops.IlegalShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.IlegalShop.Locations[k].x, Config.Shops.IlegalShop.Locations[k].y, Config.Shops.IlegalShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.IlegalShop.Locations[k].x, Config.Shops.IlegalShop.Locations[k].y, Config.Shops.IlegalShop.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.YouTool.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.PrisonShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.WeaponShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.PoliceShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.PoliceShop.Locations[k].x, Config.Shops.PoliceShop.Locations[k].y, Config.Shops.PoliceShop.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.ShopNightclub.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.ShopNightclub.Locations[k].x, Config.Shops.ShopNightclub.Locations[k].y, Config.Shops.ShopNightclub.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.ShopNightclub.Locations[k].x, Config.Shops.ShopNightclub.Locations[k].y, Config.Shops.ShopNightclub.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.ShopNightclub.Locations[k].x, Config.Shops.ShopNightclub.Locations[k].y, Config.Shops.ShopNightclub.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.BlackMarket.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.BlackMarket.Locations[k].x, Config.Shops.BlackMarket.Locations[k].y, Config.Shops.BlackMarket.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.BlackMarket.Locations[k].x, Config.Shops.BlackMarket.Locations[k].y, Config.Shops.BlackMarket.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.BlackMarket.Locations[k].x, Config.Shops.BlackMarket.Locations[k].y, Config.Shops.BlackMarket.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            for k, v in pairs(Config.Shops.DrugShop.Locations) do
                local distance = GetDistanceBetweenCoords(coords, Config.Shops.DrugShop.Locations[k].x, Config.Shops.DrugShop.Locations[k].y, Config.Shops.DrugShop.Locations[k].z, true)
                if distance < 10 then
                    DrawMarker(27, Config.Shops.DrugShop.Locations[k].x, Config.Shops.DrugShop.Locations[k].y, Config.Shops.DrugShop.Locations[k].z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, false, false, 2, false, false, false, false)
                    if distance < 3.0 then 
                        DrawText3Ds(Config.Shops.DrugShop.Locations[k].x, Config.Shops.DrugShop.Locations[k].y, Config.Shops.DrugShop.Locations[k].z + 1, _U("open_shop"))
                        near = true
                        break
                    end
                    near = true
                end
            end
            if not near then 
                sleep = 1500
            else
                sleep = 7
            end
            near = false
        else
            Citizen.Wait(1500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        LicenseShop = Config.Shops.LicenseShop.Locations
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)
		for i = 1, #LicenseShop, 1 do
			if GetDistanceBetweenCoords(coords, LicenseShop[i].x, LicenseShop[i].y, LicenseShop[i].z, true) < 8.0 then
				DrawMarker(25, LicenseShop[i].x, LicenseShop[i].y, LicenseShop[i].z - 0.99, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
					if currentAction then
						ESX.ShowHelpNotification(_U('license_shop_help'))
						if IsControlJustReleased(0, 38) then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
							if hasWeaponLicense then
								exports['mythic_notify']:DoHudText('error', _U('license_shop_check'))
							else
								OpenBuyLicenseMenu()
								Citizen.Wait(2000)
							end
						end, GetPlayerServerId(PlayerId()), Config.License.Weapon)
					end
				end
			end
		end
    end
end)

Citizen.CreateThread(function()
    while true do
        Player = nil
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local isInMarker, letSleep, currentZone = false, false
        for k,v in pairs(Config.Shops) do
            for i = 1, #v.Locations, 1 do
                local distance = GetDistanceBetweenCoords(playerCoords, v.Locations[i].x, v.Locations[i].y, v.Locations[i].z, true)
                if distance <  1.5 then
                    letSleep = false
                    if distance < Config.MarkerSize.x then
                        isInMarker  = true
                        currentZone = k
                        lastZone    = k
                    end
                end
            end
        end
        if isInMarker and not hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = true
            TriggerEvent('suku:hasEnteredMarker', currentZone)
        end
        if not isInMarker and hasAlreadyEnteredMarker then
            hasAlreadyEnteredMarker = false
            TriggerEvent('suku:hasExitedMarker', lastZone)
        end
        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

AddEventHandler('suku:hasEnteredMarker', function(zone)
    currentAction     = 'shop_menu'
    currentActionMsg  = _U('shop_press_menu')
    currentActionData = {zone = zone}
end)

function OpenBuyLicenseMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license',{
	title = _U('license_shop_title'), 
		elements = {
			{ label = _U('yes') ..' (€' .. Config.LicensePrice ..')', value = 'yes' }, 
			{ label = _U('no'), value = 'no' },
		}
	},
      function (data, menu)		
		if data.current.value == 'yes' then
            ESX.TriggerServerCallback('suku:buyLicense', function(bought)
                if bought then
                    menu.close()
                end
            end)
        end
    end,
    function (data, menu)
        menu.close()
    end)
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local scale = 0.3

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function CreateBlip(coords, text, radius, color, sprite)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end
