ESX = nil
local PlayerData = {}
local kosten = 100
local vehicles1 = {}
local vehicles3 = {}
local prijzenBekend = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

local garages = {
	{vector3(-234.82, 6198.65, 30.94), vector3(-230.08, 6190.24, 30.49), 140.24},
	{vector3(-1872.77,-616.1,10.71), vector3(-1855.85,-611.57,11.71), 309.77}
}

local enableField = false

function AddCar(plate, label, price)
	if label == "CARNOTFOUND" then
		label = "ONBEKEND"
	end
    SendNUIMessage({
        action = 'add',
        plate = plate,
		label = label,
		price = price
    }) 
end

function toggleField(enable)
    SetNuiFocus(enable, enable)
    enableField = enable

    if enable then
        SendNUIMessage({
            action = 'open'
        }) 
    else
        SendNUIMessage({
            action = 'close'
        }) 
    end
end



AddEventHandler('onResourceStart', function(name)
    if GetCurrentResourceName() ~= name then
        return
    end

    toggleField(false)
end)

RegisterNUICallback('escape', function(data, cb)
    toggleField(false)
    SetNuiFocus(false, false)

    cb('ok')
end)

RegisterNUICallback('enable-parkout', function(data, cb)
    
    ESX.TriggerServerCallback('DP_Impound:loadVehicles', function(vehicles)
        for key, value in pairs(vehicles) do
			local props = json.decode(value.vehicle)
			for k, v in pairs(vehicles1) do
				if props.model == GetHashKey(v.model) then
					price = v.price*0.01
					break
				else
					price = 250
					break
					--[[for k2, v2 in pairs(vehicles3) do
						if props.model == GetHashKey(v2.model) then
							price = v.price*0.01
							break
						else
							price = 250
							break
						end
					end]]
				end
			end
			AddCar(value.plate, GetDisplayNameFromVehicleModel(props.model), price)
        end
    end)
	
    
    cb('ok')
end) 

RegisterNUICallback('enable-parking', function(data, cb)
    
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        ESX.TriggerServerCallback('DP_Impound:isOwned', function(owned)

            if owned then
                AddCar(GetVehicleNumberPlateText(value))
            end
    
        end, GetVehicleNumberPlateText(value))
    end
    
    cb('ok')
end) 

local usedGarage

RegisterNUICallback('park-out', function(data, cb)
    
    ESX.TriggerServerCallback('DP_Impound:loadVehicle', function(vehicle)
        local x,y,z = table.unpack(garages[usedGarage][2])
        local props = json.decode(vehicle[1].vehicle)

		local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

		for key, value in pairs(vehicles) do
			if GetVehicleNumberPlateText(value) == data.plate then
				ESX.Game.DeleteVehicle(value)
			end
		end
		ESX.TriggerServerCallback('DP_Impound:laadPrijs1', function(prijs1)
			if prijs1 == true then
				ESX.Game.SpawnVehicle(props.model, {
					x = x,
					y = y,
					z = z + 1
				}, garages[usedGarage][3], function(callback_vehicle)
					ESX.Game.SetVehicleProperties(callback_vehicle, props)
					SetVehRadioStation(callback_vehicle, "OFF")
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
					TriggerServerEvent('DP_Impound:changeState', data.plate, 1)
				end)
			else
				ESX.ShowNotification(prijs1)
				--[[ESX.TriggerServerCallback('DP_Impound:laadPrijs3', function(prijs3)
					if prijs3 == true then
						ESX.Game.SpawnVehicle(props.model, {
							x = x,
							y = y,
							z = z + 1
						}, garages[usedGarage][3], function(callback_vehicle)
							ESX.Game.SetVehicleProperties(callback_vehicle, props)
							SetVehRadioStation(callback_vehicle, "OFF")
							TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
							TriggerServerEvent('DP_Impound:changeState', data.plate, 1)
						end)
					else
						ESX.ShowNotification(prijs3)
					end
				end, GetDisplayNameFromVehicleModel(props.model))]]
			end
		end, GetDisplayNameFromVehicleModel(props.model))

    end, data.plate)
    
    cb('ok')
end)

RegisterNUICallback('park-in', function(data, cb)
    
    local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        if GetVehicleNumberPlateText(value) == data.plate then
            TriggerServerEvent('DP_Impound:saveProps', data.plate, ESX.Game.GetVehicleProperties(value))
            TriggerServerEvent('DP_Impound:changeState', data.plate, 1)
            ESX.Game.DeleteVehicle(value)
        end
    end

    cb('ok')
end)

RegisterKey("keyboard","E",
	function()
	end,
	function()
		if timer == 0 then
			for key, value in pairs(garages) do
				local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), value[1])

				if dist <= 2.0 then
					if not prijzenBekend then
						ESX.TriggerServerCallback('DP_Impound:laadPrijzen1', function(data)
							--for k, v in pairs(data) do
								vehicles1 = data
							--end
						end)
						--[[ESX.TriggerServerCallback('DP_Impound:laadPrijzen3', function(data)
							--for k, v in pairs(data) do
								vehicles3 = data
							--end
						end)]]
						prijzenBekend = true
						toggleField(true)
						usedGarage = key
						timertje() -- timer so they cannot spam server requests
					else
						toggleField(true)
						usedGarage = key
						timertje()
					end
				end
			end
		else
			print("Wait")
        end
	end
)

timer = 0
function timertje()
	timer = 100
	while timer > 0 do
		Citizen.Wait(0)
		timer = timer - 1
	end
end

local coordinate = {
    {-234.82, 6198.65, 31.94, nil, 140.24, nil, -1176698112}, 
    {-1872.77,-616.1,11.71, nil, 247.83, nil, 68070371}                    
}

Citizen.CreateThread(function()

    for _, v in pairs(coordinate) do
        RequestModel(v[7])
        while not HasModelLoaded(v[7]) do
            Wait(1)
        end

        ped = CreatePed(4, v[7], v[1], v[2], v[3] - 1, 3374176, false, true)
        SetEntityHeading(ped, v[5])
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
		TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_CLIPBOARD',-1872.77,-616.1,11.71, 0, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end

end)

Citizen.CreateThread(function()
    for _, coords in pairs(garages) do
        local blip = AddBlipForCoord(coords[1])

        SetBlipSprite(blip, 67)
        SetBlipScale(blip, 0.9)
        SetBlipColour(blip, 0)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("ANWB - In beslag name")
        EndTextCommandSetBlipName(blip)
    end
end)