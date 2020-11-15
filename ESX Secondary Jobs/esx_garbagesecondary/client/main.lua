local Keys = {
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

ESX                             = nil
local PlayerData                = {}
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local onDuty                    = false
local BlipCloakRoom             = nil
local BlipVehicle               = nil
local BlipVehicleDeleter		= nil
local Blips                     = {}
local OnJob                     = false
local Done 						= false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
	onDuty = false
    CreateBlip()
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    PlayerData.job2 = job2
	onDuty = false
    CreateBlip()
end)

-- NPC MISSIONS

function SelectPoubelle()
    local index = GetRandomIntInRange(1,  #Config.Poubelle)

    for k,v in pairs(Config.Zones) do
      if v.Pos.x == Config.Poubelle[index].x and v.Pos.y == Config.Poubelle[index].y and v.Pos.z == Config.Poubelle[index].z then
        return k
      end
    end
end

function StartNPCJob()
    NPCTargetPoubelle     = SelectPoubelle()
    local zone            = Config.Zones[NPCTargetPoubelle]
  
    Blips['NPCTargetPoubelle'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
    SetBlipRoute(Blips['NPCTargetPoubelle'], true)
    ESX.ShowNotification(_U('GPS_info'))
    Done = true
end

function StopNPCJob(cancel)
  
    if Blips['NPCTargetPoubelle'] ~= nil then
      RemoveBlip(Blips['NPCTargetPoubelle'])
      Blips['NPCTargetPoubelle'] = nil
	end
	
	OnJob = false
  
    if cancel then
	  ESX.ShowNotification(_U('cancel_mission'))
	else
		TriggerServerEvent('esx_garbagesecondary:GiveItem')
		StartNPCJob()
		Done = true
	end   
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if NPCTargetPoubelle ~= nil then

            local coords = GetEntityCoords(GetPlayerPed(-1))
            local zone   = Config.Zones[NPCTargetPoubelle]

           	if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < 3 then

                HelpPromt(_U('pickup'))
  
                if IsControlJustReleased(1, Keys["E"]) and PlayerData.job2 ~= nil then
                    StopNPCJob()
                    Wait(300)
                    Done = false
                end
            end
        end
    end
end)

-- Prise de service 
function CloakRoomMenu()

	local elements = {}
	
	if onDuty then
		table.insert(elements, {label = _U('end_service'), value = 'citizen_wear'})
	else
		table.insert(elements, {label = _U('take_service'), value = 'job_wear'})
	end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'cloakroom',
        {
            css      = 'vestiaire',
			img = 'menu_vestiaire',
			align    = 'top',
            elements = elements
        },
        function(data, menu)

            if data.current.value == 'citizen_wear' then
				onDuty = false
				CreateBlip()
				menu.close()
                ESX.ShowNotification(_U('end_service_notif'))
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin2', function(skin, jobSkin)
				  local model = nil

				  if skin.sex == 0 then
					model = GetHashKey("mp_m_freemode_01")
				  else
					model = GetHashKey("mp_f_freemode_01")
				  end

				  RequestModel(model)
				  while not HasModelLoaded(model) do
					RequestModel(model)
					Citizen.Wait(1)
				  end

				  SetPlayerModel(PlayerId(), model)
				  SetModelAsNoLongerNeeded(model)

				  TriggerEvent('esx_skin:loadSkin', skin)
				  TriggerEvent('esx:restoreLoadout')
				  
				  local playerPed = GetPlayerPed(-1)
				  -- SetPedArmour(playerPed, 0)
				  ClearPedBloodDamage(playerPed)
				  ResetPedVisibleDamage(playerPed)
				  ClearPedLastWeaponDamage(playerPed)
				end)
            end

            if data.current.value == 'job_wear' then
				onDuty = true
				CreateBlip()
                menu.close()
				ESX.ShowNotification(_U('take_service_notif'))
				ESX.ShowNotification(_U('start_job'))
				local playerPed = GetPlayerPed(-1)
				setUniform(data.current.value, playerPed)
				
				-- SetPedArmour(playerPed, 0)
				ClearPedBloodDamage(playerPed)
				ResetPedVisibleDamage(playerPed)
				ClearPedLastWeaponDamage(playerPed)
            end
			
            CurrentAction     = 'cloakroom_menu'
            CurrentActionMsg  = Config.Zones.Cloakroom.hint
            CurrentActionData = {}
        end,
        function(data, menu)

            menu.close()

			CurrentAction     = 'cloakroom_menu'
			CurrentActionMsg  = Config.Zones.Cloakroom.hint
            CurrentActionData = {}        
        end    
    )

end

-- Prise du véhicule
function VehicleMenu()

    local elements = {
        {label = Config.Vehicles.Truck.Label, value = Config.Vehicles.Truck}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'spawn_vehicle',
        {
            css      = 'vehicle',
			title    = _U('Vehicle_Menu_Title'),
            elements = elements
        },
        function(data, menu)
            for i=1, #elements, 1 do
				menu.close()
				local playerPed = GetPlayerPed(-1)
				local coords    = Config.Zones.VehicleSpawnPoint.Pos
				local Heading    = Config.Zones.VehicleSpawnPoint.Heading
				local platenum = math.random(1000, 9999)
				local platePrefix = Config.platePrefix
				ESX.Game.SpawnVehicle(data.current.value.Hash, coords, Heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					SetVehicleNumberPlateText(vehicle, platePrefix .. platenum)
					plate = GetVehicleNumberPlateText(vehicle)
					plate = string.gsub(plate, " ", "")
					name = 'Véhicule de '..platePrefix
					TriggerServerEvent('esx_vehiclelock:registerkeyjob', name, plate, 'no')
				end)
				break
            end
            menu.close()

    end,
function(data, menu)
    menu.close()
    CurrentAction     = 'vehiclespawn_menu'
    CurrentActionMsg  = Config.Zones.VehicleSpawner.hint
    CurrentActionData = {}
end
)
end

-- Quand le joueur entre dans la zone
AddEventHandler('esx_garbagesecondary:hasEnteredMarker', function(zone)

    if zone == 'Cloakroom' then
        CurrentAction        = 'cloakroom_menu'
        CurrentActionMsg     = Config.Zones.Cloakroom.hint
        CurrentActionData    = {}
    end

    if zone == 'VehicleSpawner' then
        CurrentAction        = 'vehiclespawn_menu'
        CurrentActionMsg     = Config.Zones.VehicleSpawner.hint
        CurrentActionData    = {}      
    end

    if zone == 'VehicleDeleter' then
        local playerPed = GetPlayerPed(-1)
        if IsPedInAnyVehicle(playerPed,  false) then
          CurrentAction        = 'delete_vehicle'
          CurrentActionMsg     = Config.Zones.VehicleDeleter.hint
          CurrentActionData    = {}
        end
    end  

    if zone == 'Vente' then
        CurrentAction        = 'vente'
        CurrentActionMsg     = Config.Zones.Vente.hint
        CurrentActionData    = {}
    end   
end)

-- Quand le joueur sort de la zone
AddEventHandler('esx_garbagesecondary:hasExitedMarker', function(zone)

	if zone == 'Vente' then
		TriggerServerEvent('esx_garbagesecondary:stopVente')
	end
    CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

function CreateBlip()
    if PlayerData.job2 ~= nil and PlayerData.job2.name == Config.nameJob2 then                
		
		if BlipCloakRoom == nil then
			BlipCloakRoom = AddBlipForCoord(Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z)
			SetBlipSprite(BlipCloakRoom, Config.Zones.Cloakroom.BlipSprite)
			SetBlipColour(BlipCloakRoom, Config.Zones.Cloakroom.BlipColor)
			SetBlipAsShortRange(BlipCloakRoom, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Zones.Cloakroom.BlipName)
			EndTextCommandSetBlipName(BlipCloakRoom)
		end
	else

        if BlipCloakRoom ~= nil then            
            RemoveBlip(BlipCloakRoom)
            BlipCloakRoom = nil
        end
	end

	if PlayerData.job2 ~= nil and PlayerData.job2.name == Config.nameJob2 and onDuty then   

        BlipVehicle = AddBlipForCoord(Config.Zones.VehicleSpawner.Pos.x, Config.Zones.VehicleSpawner.Pos.y, Config.Zones.VehicleSpawner.Pos.z)
        SetBlipSprite(BlipVehicle, Config.Zones.VehicleSpawner.BlipSprite)
        SetBlipColour(BlipVehicle, Config.Zones.VehicleSpawner.BlipColor)
        SetBlipAsShortRange(BlipVehicle, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Zones.VehicleSpawner.BlipName)
        EndTextCommandSetBlipName(BlipVehicle)  

        BlipVente = AddBlipForCoord(Config.Zones.Vente.Pos.x, Config.Zones.Vente.Pos.y, Config.Zones.Vente.Pos.z)
        SetBlipSprite(BlipVente, Config.Zones.Vente.BlipSprite)
        SetBlipColour(BlipVente, Config.Zones.Vente.BlipColor)
        SetBlipAsShortRange(BlipVente, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Zones.Vente.BlipName)
        EndTextCommandSetBlipName(BlipVente) 

        BlipVehicleDeleter = AddBlipForCoord(Config.Zones.VehicleDeleter.Pos.x, Config.Zones.VehicleDeleter.Pos.y, Config.Zones.VehicleDeleter.Pos.z)
        SetBlipSprite(BlipVehicleDeleter, Config.Zones.VehicleDeleter.BlipSprite)
        SetBlipColour(BlipVehicleDeleter, Config.Zones.VehicleDeleter.BlipColor)
        SetBlipAsShortRange(BlipVehicleDeleter, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Zones.VehicleDeleter.BlipName)
        EndTextCommandSetBlipName(BlipVehicleDeleter)
    else

        if BlipVehicle ~= nil then
            RemoveBlip(BlipVehicle)
            BlipVehicle = nil
        end

        if BlipVente ~= nil then
            RemoveBlip(BlipVente)
            BlipVente = nil
        end

        if BlipVehicleDeleter ~= nil then
            RemoveBlip(BlipVehicleDeleter)
            BlipVehicleDeleter = nil
        end
    end    	
end

-- Activation du marker au sol
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if PlayerData.job2 ~= nil then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			if PlayerData.job2.name == Config.nameJob2 then
				if onDuty then

					for k,v in pairs(Config.Zones) do
						if v ~= Config.Zones.Cloakroom then
							if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
								DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
							end
						end
					end
					
				end
				
				local Cloakroom = Config.Zones.Cloakroom
				if(Cloakroom.Type ~= -1 and GetDistanceBetweenCoords(coords, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(Cloakroom.Type, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Cloakroom.Size.x, Cloakroom.Size.y, Cloakroom.Size.z, Cloakroom.Color.r, Cloakroom.Color.g, Cloakroom.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Detection de l'entrer/sortie de la zone du joueur
Citizen.CreateThread(function()
	while true do
		Wait(1)
		if PlayerData.job2 ~= nil then
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil
			
			if PlayerData.job2.name == Config.nameJob2 then
				if onDuty then
					for k,v in pairs(Config.Zones) do
						if v ~= Config.Zones.Cloakroom then
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) <= v.Size.x) then
								isInMarker  = true
								currentZone = k
							end
						end
					end
				end
				
				local Cloakroom = Config.Zones.Cloakroom
				if(GetDistanceBetweenCoords(coords, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, true) <= Cloakroom.Size.x) then
					isInMarker  = true
					currentZone = "Cloakroom"
				end
			end
			
			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_garbagesecondary:hasEnteredMarker', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_garbagesecondary:hasExitedMarker', LastZone)
			end
		end
	end
end)

-- Action après la demande d'accés 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if CurrentAction ~= nil then
            SetTextComponentFormat('STRING')
            AddTextComponentString(CurrentActionMsg)
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if (IsControlJustReleased(1, Keys["E"]) or IsControlJustReleased(2, Keys["RIGHT"])) and PlayerData.job2 ~= nil then
				local playerPed = GetPlayerPed(-1)
				if PlayerData.job2.name == Config.nameJob2 then
					if CurrentAction == 'cloakroom_menu' then
						if IsPedInAnyVehicle(playerPed, 0) then
							ESX.ShowNotification(_U('in_vehicle'))
						else
							CloakRoomMenu()
						end
					end
					if CurrentAction == 'vehiclespawn_menu' then
						if IsPedInAnyVehicle(playerPed, 0) then
							ESX.ShowNotification(_U('in_vehicle'))
						else
							VehicleMenu()
						end
					end
					if CurrentAction == 'vente' then
						TriggerServerEvent('esx_garbagesecondary:startVente')
					end
					if CurrentAction == 'delete_vehicle' then
					  local playerPed = GetPlayerPed(-1)
					  local vehicle   = GetVehiclePedIsIn(playerPed,  false)
					  local hash      = GetEntityModel(vehicle)
					  local plate = GetVehicleNumberPlateText(vehicle)
					  local plate = string.gsub(plate, " ", "")
					  local platePrefix = Config.platePrefix
					  
					  if string.find (plate, platePrefix) then
						local truck = Config.Vehicles.Truck
						
						if hash == GetHashKey(truck.Hash) then
							if GetVehicleEngineHealth(vehicle) <= 500 or GetVehicleBodyHealth(vehicle) <= 500 then
								ESX.ShowNotification(_U('vehicle_broken'))
							else
								TriggerServerEvent('esx_vehiclelock:vehjobSup', plate, 'no')
								DeleteVehicle(vehicle)
							end
						end
					  else
						ESX.ShowNotification(_U('bad_vehicle'))
					  end
					end
               	    CurrentAction = nil
				end
			end	
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(1, Keys["F6"]) and PlayerData.job2 ~= nil and PlayerData.job2.name == Config.nameJob2 then

			if Onjob then
				StopNPCJob(true)
				RemoveBlip(Blips['NPCTargetPoubelle'])
				Onjob = false
			else
				local playerPed = GetPlayerPed(-1)

				if IsPedInAnyVehicle(playerPed,  false) and IsVehicleModel(GetVehiclePedIsIn(playerPed,  false), GetHashKey("trash")) then
					StartNPCJob()
					Onjob = true
				else
					ESX.ShowNotification(_U('not_good_veh'))
				end
			end
		end
	end
end)

function setUniform(job, playerPed)
  TriggerEvent('esx_skin:getSkin', function(skin)

    if skin.sex == 0 then
      if Config.Uniforms[job].male ~= nil then
        TriggerEvent('esx_skin:loadClothes', skin, Config.Uniforms[job].male)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
    else
      if Config.Uniforms[job].female ~= nil then
        TriggerEvent('esx_skin:loadClothes', skin, Config.Uniforms[job].female)
      else
        ESX.ShowNotification(_U('no_outfit'))
      end
    end

  end)
end

function HelpPromt(text)
	Citizen.CreateThread(function()
		SetTextComponentFormat("STRING")
		AddTextComponentString(text)
		DisplayHelpTextFromStringLabel(0, state, 0, -1)

	end)
end