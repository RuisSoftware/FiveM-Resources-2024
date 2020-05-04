local shopData = nil
local currentAction, currentActionMsg, currentActionData = nil, nil, {}

Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)
        if IsInRegularShopZone(coords) or IsInRobsLiquorZone(coords) or IsInYouToolZone(coords) or IsInPrisonShopZone(coords) or IsInWeaponShopZone(coords) then
            if IsInRegularShopZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenShopInv("regular")
                        Citizen.Wait(2000)
                    end
                end
            end
            if IsInRobsLiquorZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenShopInv("robsliquor")
                        Citizen.Wait(2000)
                    end
                end
            end
            if IsInYouToolZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenShopInv("youtool")
                        Citizen.Wait(2000)
                    end
                end
            end
            if IsInPrisonShopZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
                        OpenShopInv("prison")
                        Citizen.Wait(2000)
                    end
                end
            end
            if IsInWeaponShopZone(coords) then
                if currentAction then
                    ESX.ShowHelpNotification(currentActionMsg)
                    if IsControlJustReleased(0, Keys["E"]) then
                        ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
                            if hasWeaponLicense then
                                OpenShopInv("weaponshop")
                                Citizen.Wait(2000)
                            else
                                exports['mythic_notify']:DoHudText('error', _U('license_check_fail'))
                            end
                        end, GetPlayerServerId(PlayerId()), 'weapon')
                    end
                end
            end
        end
    end
end)

function OpenShopInv(shoptype)
    text = "shop"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
    end, shoptype)

    Citizen.Wait(500)
    TriggerEvent("esx_inventoryhud:openShopInventory", data, inventory)
end

RegisterNetEvent("suku:OpenCustomShopInventory")
AddEventHandler("suku:OpenCustomShopInventory", function(type, shopinventory)
    text = "shop"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getCustomShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
    end, type, shopinventory)
    Citizen.Wait(500)

    TriggerEvent("esx_inventoryhud:openShopInventory", data, inventory)
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
    AddAmmoToPed(GetPlayerPed(-1), hash, amount)
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
						if IsControlJustReleased(0, Keys["E"]) then
							ESX.TriggerServerCallback('esx_license:checkLicense', function(hasWeaponLicense)
							if hasWeaponLicense then
								exports['mythic_notify']:DoHudText('error', _U('license_shop_check'))
							else
								OpenBuyLicenseMenu()
								Citizen.Wait(2000)
							end
						end, GetPlayerServerId(PlayerId()), 'weapon')
					end
				end
			end
		end
    end
end)

function OpenBuyLicenseMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license',{
        title = _U('license_shop_title'), --Register a License
        elements = {
          { label = 'yes' ..' ($' .. Config.LicensePrice ..')', value = 'yes' }, --yes
          { label = 'no', value = 'no' },
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

Citizen.CreateThread(function()
    player = GetPlayerPed(-1)
    coords = GetEntityCoords(player)
    for k, v in pairs(Config.Shops.RegularShop.Locations) do
        CreateBlip(vector3(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z ), _U('regular_shop_name'), 3.0, Config.Color, Config.ShopBlipID)
    end

    for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
        CreateBlip(vector3(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z ), _U('robs_liquor_name'), 3.0, Config.Color, Config.LiquorBlipID)
    end

    for k, v in pairs(Config.Shops.YouTool.Locations) do
        CreateBlip(vector3(Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z ), _U('you_tool_name'), 3.0, Config.Color, Config.YouToolBlipID)
    end

    for k, v in pairs(Config.Shops.YouTool.Locations) do
        CreateBlip(vector3(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z), _U('prison_shop_name'), 3.0, Config.Color, Config.PrisonShopBlipID)
    end

    for k, v in pairs(Config.Shops.WeaponShop.Locations) do
        CreateBlip(vector3(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z), _U('weapon_shop_name'), 3.0, Config.WeaponColor, Config.WeaponShopBlipID)
    end

    CreateBlip(vector3(-755.79, 5596.07, 41.67), "Cablecart", 3.0, 4, 36)
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

AddEventHandler('suku:hasExitedMarker', function(zone)
    SendNUIMessage({
        display = false,
        clear = true
    })
    currentAction = false
    SetNuiFocus(false, false)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)

        for k, v in pairs(Config.Shops.RegularShop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z, true) < 12.0 then
                DrawMarker(25, Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z + 0.01, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end

        for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end

        for k, v in pairs(Config.Shops.YouTool.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end

        for k, v in pairs(Config.Shops.PrisonShop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end

        for k, v in pairs(Config.Shops.WeaponShop.Locations) do
            if GetDistanceBetweenCoords(coords, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z + 0.01, true) < 12.0 then
                DrawMarker(25, Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)
            end
        end
    end
end)

function CreateBlip(coords, text, radius, color, sprite)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, 0.8)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end
