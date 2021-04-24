DP = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while DP == nil do
        TriggerEvent('dp:getSharedObject', function(obj) DP = obj end)
        Citizen.Wait(0)
    end

    while DP.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = DP.GetPlayerData()
end)

local garages = {
	{vector3(-234.82, 6198.65, 30.94), vector3(-230.08, 6190.24, 30.49), 140.24},
	{vector3(-1872.77,-616.1,10.71), vector3(-1855.85,-611.57,11.71), 309.77}
}


local enableField = false

function AddCar(plate, label)
	if label == "CARNOTFOUND" then
		label = "ONBEKEND" -- translatable
	end
    SendNUIMessage({
        action = 'add',
        plate = plate,
		label = label
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
    
    DP.TriggerServerCallback('DP_Impound:loadVehicles', function(vehicles)
        for key, value in pairs(vehicles) do
			local props = json.decode(value.vehicle)
            AddCar(value.plate, GetDisplayNameFromVehicleModel(props.model))
			
        end
    end)
    
    cb('ok')
end) 

RegisterNUICallback('enable-parking', function(data, cb)
    
    local vehicles = DP.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        DP.TriggerServerCallback('DP_Impound:isOwned', function(owned)

            if owned then
                AddCar(GetVehicleNumberPlateText(value))
            end
    
        end, GetVehicleNumberPlateText(value))
    end
    
    cb('ok')
end) 

local usedGarage

RegisterNUICallback('park-out', function(data, cb)
    
    DP.TriggerServerCallback('DP_Impound:loadVehicle', function(vehicle)
        local x,y,z = table.unpack(garages[usedGarage][2])
        local props = json.decode(vehicle[1].vehicle)

    local vehicles = DP.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        if GetVehicleNumberPlateText(value) == data.plate then
            DP.Game.DeleteVehicle(value)
        end
    end
        DP.Game.SpawnVehicle(props.model, {
            x = x,
            y = y,
            z = z + 1
        }, garages[usedGarage][3], function(callback_vehicle)
            DP.Game.SetVehicleProperties(callback_vehicle, props)
            SetVehRadioStation(callback_vehicle, "OFF")
            TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
        end)

    end, data.plate)

    TriggerServerEvent('DP_Impound:changeState', data.plate, 1)
    
    cb('ok')
end)

RegisterNUICallback('park-in', function(data, cb)
    
    local vehicles = DP.Game.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(-1)), 25.0)

    for key, value in pairs(vehicles) do
        if GetVehicleNumberPlateText(value) == data.plate then
            TriggerServerEvent('DP_Impound:saveProps', data.plate, DP.Game.GetVehicleProperties(value))
            TriggerServerEvent('DP_Impound:changeState', data.plate, 1)
            DP.Game.DeleteVehicle(value)
        end
    end

    cb('ok')
end)

RegisterKey("keyboard","E",
	function()
	end,
	function()
        for key, value in pairs(garages) do
            local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), value[1])

            if dist <= 2.0 then
				toggleField(true)
				usedGarage = key
            end
        end
	end
)

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
        AddTextComponentString("Garage - Abschlepphof")
        EndTextCommandSetBlipName(blip)
    end
end)