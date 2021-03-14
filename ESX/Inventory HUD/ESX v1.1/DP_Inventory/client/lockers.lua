local ESX = nil

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()


    playerIdent = ESX.GetPlayerData().identifier
	
    CreateBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

function CreateBlips()
	local blip = AddBlipForCoord(Config.LockerExterior.x, Config.LockerExterior.y, Config.LockerExterior.z)
	SetBlipSprite(blip, Config.LockerRentBlipID)
	SetBlipDisplay(blip, 2)
	SetBlipScale(blip, Config.LockerRentBlipSize)
	SetBlipColour(blip, Config.LockerRentBlipColor)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentString(_U('locker_blip'))
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()

    while true do
		Citizen.Wait(0)
        local playerCoords = GetEntityCoords(GetPlayerPed(-1))
		local playerPed = PlayerPedId()
        local isClose = false
		
		for k, v in pairs (Config.Lockers) do
			local locker_name = v.locker_name
            local locker_loc = v.location
			local locker_dist = GetDistanceBetweenCoords(playerCoords, locker_loc.x, locker_loc.y, locker_loc.z, 1)
			
			if locker_dist <= 1.0 then
				isClose = true
                Draw3DText(locker_loc.x, locker_loc.y, locker_loc.z, '[E] '.. locker_name)
				if IsControlJustReleased(0, 38) then
					ESX.TriggerServerCallback('DP_Inventory:checkLocker', function(checkLocker)
						LockerMenu(k, checkLocker, locker_name)
					end, k)
				end
			end
			
		end
		
		local lockerExterior = GetDistanceBetweenCoords(playerCoords, Config.LockerExterior.x, Config.LockerExterior.y, Config.LockerExterior.z, 1)
		local lockerInterior = GetDistanceBetweenCoords(playerCoords, Config.LockerInterior.x, Config.LockerInterior.y, Config.LockerInterior.z, 1)
		
		if lockerExterior <= 4.0 then
			isClose = true
			Draw3DText(Config.LockerExterior.x, Config.LockerExterior.y, Config.LockerExterior.z, _U('enter_lockerroom'))
			if IsControlJustReleased(0, 38) then
				SetEntityCoords(playerPed, Config.LockerInterior.x, Config.LockerInterior.y, Config.LockerInterior.z)
				SetEntityHeading(playerPed, 90.0)
				DoScreenFadeIn(800)       
			end
		end
		
		if lockerInterior <= 1.0 then
			isClose = true
			Draw3DText(Config.LockerInterior.x, Config.LockerInterior.y, Config.LockerInterior.z, _U('exit_lockerroom'))
			if IsControlJustReleased(0, 38) then
				SetEntityCoords(playerPed, Config.LockerExterior.x, Config.LockerExterior.y, Config.LockerExterior.z)
				SetEntityHeading(playerPed, 185.0)
				DoScreenFadeIn(800)       
			end
		end
		
		if not isClose then
			Citizen.Wait(3000)
        end
		
	end
	
end)

function LockerMenu(k, hasLocker, lockerName)

	local elements = {}
	
	if hasLocker then
		table.insert(elements, {label = _U('open_locker'), value = 'open_locker'})
		table.insert(elements, {label = _U('cancel_lockerrent'), value = 'stop_renting'})
	end
	
	if not hasLocker then
		table.insert(elements, {label = "Huur | Gemiddelde kosten: <span style='color: green;'>€" .. ESX.Math.GroupDigits(Config.InitialLockerRentPrice) .. "</span> | Dagelijks - <span style='color: green;'>€" .. ESX.Math.GroupDigits(Config.DailyLockerRentPrice) .. "</span>", value = 'start_locker'})
	end
	
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'locker_menu', {
		title    = lockerName,
		align    = 'left',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'start_locker' then
			ConfirmLockerRent(k, lockerName)
			menu.close()
		elseif data.current.value == 'stop_renting' then
			StopLockerRent(k, lockerName)
			menu.close()
		elseif data.current.value == 'open_locker' then
			OpenStash(k, playerIdent, lockerName)
			menu.close()
		end

	end, function(data, menu)
		menu.close()
	end)

end

function ConfirmLockerRent(k, lockerName)

    local elements = {
        {label = _U('yes'), value = 'buy_yes'},
        {label = _U('no'), value = 'buy_no'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_rent_locker', {
        title    = 'Wil je ' .. lockerName .. 'huren?',
        align    = 'left',
        elements = elements
    }, function(data, menu)

        if data.current.value == 'buy_yes' then
            menu.close()
			TriggerServerEvent('DP_Inventory:startRentingLocker', k, lockerName)
        elseif data.current.value == 'buy_no' then
            menu.close()
        end

    end, function(data, menu)
        menu.close()
    end)  
end

function StopLockerRent(k, lockerName)

    local elements = {
        {label = _U('yes'), value = 'buy_yes'},
        {label = _U('no'), value = 'buy_no'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cancel_rent_locker', {
        title    = _U('cancel_locker') .. lockerName .. '?',
        align    = 'left',
        elements = elements
    }, function(data, menu)

        if data.current.value == 'buy_yes' then
            menu.close()
			TriggerServerEvent('DP_Inventory:stopRentingLocker', k, lockerName)
        elseif data.current.value == 'buy_no' then
            menu.close()
        end

    end, function(data, menu)
        menu.close()
    end)  
end

function OpenStash(lockerId, identifier, lockerName)
	ESX.TriggerServerCallback('DP_Inventory:getLockerInventory', function(inventory)
		TriggerEvent('DP_Inventory:openLockerInventory', inventory)
	end, identifier, lockerName)
end
