ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local work_truck = nil
local lastmission = nil
local plyCoords = nil
local distance = nil
local bagsoftrash = math.random(2,10)
local currentbag = bagsoftrash
local totalbagpay = 0
local garbagebag
local garbagebagdelete
local CollectionAction = nil
local taillight_r =  {}
local trashcollectionpos = nil
local namezone = "Delivery"
local namezonenum = 0
local namezoneregion = 0
local MissionRegion = 0
local viemaxvehicule = 1000
local argentretire = 0
local livraisonTotalPaye = 0
local livraisonnombre = 0
local MissionRetourCamion = false
local MissionNum = 0
local MissionLivraison = false
local isInService = false
local truckdeposit = false
local trashcollection = false
local PlayerData              = nil
local GUI                     = {}
GUI.Time                      = 0
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}

local plaquevehicule = ""
local plaquevehiculeactuel = ""
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
--------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
	jemoeder()
	jemoeder2()
	refreshBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	refreshBlips()
	jemoeder()
	jemoeder2()
end)

-- MENUS --
function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			align    = 'right',			
			elements = {
				{label = _U('job_wear'), value = 'job_wear'},				
				{label = _U('citizen_wear'), value = 'citizen_wear'}
			}
		},
		function(data, menu)
			if data.current.value == 'citizen_wear' then
				isInService = false
				--TriggerEvent('ESX_Kledingwinkels:LoadYourClothes')
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					  local model = nil

					  if skin.sex == 0 or 1 then
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

					  TriggerEvent('skinchanger:loadSkin', skin)
					  TriggerEvent('esx:restoreLoadout')
				end)
				ESX.ShowNotification(_U('drop_service'))
			end
			if data.current.value == 'job_wear' then
				isInService = true
				--TriggerEvent('esx_brinksjob:kleding')
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
						TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
						RequestModel(model)
						while not HasModelLoaded(model) do
							RequestModel(model)
							Citizen.Wait(0)
						end
						SetPlayerModel(PlayerId(), model)
						SetModelAsNoLongerNeeded(model)
					end
				end)
				ESX.ShowNotification(_U('take_service'))
			end	
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function MenuVehicleSpawner()
	local elements = {}

	for i=1, #Config.Trucks, 1 do
		table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(Config.Trucks[i])), value = Config.Trucks[i]})
	end


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vehiclespawner',
		{
			title    = _U('vehiclespawner'),
			align    = 'right',				
			elements = elements
		},
		function(data, menu)
			ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
				platenum = math.random(100, 999)
				SetVehicleNumberPlateText(vehicle, 'G ' .. platenum .. ' BB')             
                MissionLivraisonSelect()
				if data.current.value == 'phantom3' then
					ESX.Game.SpawnVehicle("trailers2", Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(trailer)
					    AttachVehicleToTrailer(vehicle, trailer, 1.1)
					end)
				end			
				TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)  
				Wait(500)
				plaquevehicule = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
			end)
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function IsATruck()
	local isATruck = false
	local playerPed = PlayerPedId()
	for i=1, #Config.Trucks, 1 do
		if IsVehicleModel(GetVehiclePedIsUsing(playerPed), Config.Trucks[i]) then
			isATruck = true
			break
		end
	end
	return isATruck
end

function isJobbrinks()
	if PlayerData ~= nil then
		local isJobbrinks = false
		if PlayerData.job.name ~= nil and PlayerData.job.name == 'brinks' then
			isJobbrinks = true
		end
		return isJobbrinks
	end
	return false
end

AddEventHandler('esx_brinksjob:hasEnteredMarker', function(zone)
	local playerPed = PlayerPedId()

	if zone == 'CloakRoom' then
		MenuCloakRoom()
	end
	if zone == 'VehicleSpawner' then
		if isInService and isJobbrinks() then
			if MissionRetourCamion or MissionLivraison then
				CurrentAction = 'hint'
                CurrentActionMsg  = _U('already_have_truck')
			else
				MenuVehicleSpawner()
			end
		end
	end
	if zone == namezone then
		if CollectionAction == nil then
			if isInService and MissionLivraison and MissionNum == namezonenum and MissionRegion == namezoneregion and isJobbrinks() then
				if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
					VerifPlaqueVehiculeActuel()
					if plaquevehicule == plaquevehiculeactuel then
						if Blips['delivery'] ~= nil then
							RemoveBlip(Blips['delivery'])
							Blips['delivery'] = nil
						end

						CurrentAction     = 'delivery'
    	                CurrentActionMsg  = _U('delivery')
					else
						CurrentAction = 'hint'
                	    CurrentActionMsg  = _U('not_your_truck')
					end
				else
					CurrentAction = 'hint'
            	    CurrentActionMsg  = _U('not_your_truck2')
				end
			end
		end	
	end	
	if zone == 'AnnulerMission' then
		if isInService and MissionLivraison and isJobbrinks() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()
				
				if plaquevehicule == plaquevehiculeactuel then
                    CurrentAction     = 'retourcamionannulermission'
                    CurrentActionMsg  = _U('cancel_mission')
				else
					CurrentAction = 'hint'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'retourcamionperduannulermission'
			end
		end
	end
	if zone == 'RetourCamion' then
		if isInService and MissionRetourCamion and isJobbrinks() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()

				if plaquevehicule == plaquevehiculeactuel then
                    CurrentAction     = 'retourcamion'
				else
                    CurrentAction     = 'retourcamionannulermission'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'retourcamionperdu'
			end
		end
	end
end)

AddEventHandler('esx_brinksjob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
    CurrentActionMsg = ''
end)

function nouvelledestination()
	livraisonnombre = livraisonnombre+1
	livraisonTotalPay = livraisonTotalPaye+destination.Paye+totalbagpay
	livraisonTotalPaye = livraisonTotalPay*0.5
	if livraisonnombre >= Config.MaxDelivery then
		MissionLivraisonStopRetourDepot()
	else

		livraisonsuite = math.random(0, 100)
		
		if livraisonsuite <= 10 then
			MissionLivraisonStopRetourDepot()
		elseif livraisonsuite <= 80 then
			MissionLivraisonSelect()
		elseif livraisonsuite <= 100 then
			if MissionRegion == 1 then
				MissionRegion = 2
			elseif MissionRegion == 2 then
				MissionRegion = 1
			end
			MissionLivraisonSelect()	
		end
	end
end

function retourcamion_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	
	MissionRetourCamion = false
	livraisonnombre = 0
	MissionRegion = 0
	
	donnerlapaye()
end

function retourcamion_non()
	
	if livraisonnombre >= Config.MaxDelivery then
		ESX.ShowNotification(_U('need_it'))
	else
		ESX.ShowNotification(_U('ok_work'))
		nouvelledestination()
	end
end

function retourcamionperdu_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	MissionRetourCamion = false
	livraisonnombre = 0
	MissionRegion = 0
	
	donnerlapayesanscamion()
end

function retourcamionperdu_non()
	ESX.ShowNotification(_U('scared_me'))
end

function retourcamionannulermission_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	
	MissionLivraison = false
	livraisonnombre = 0
	MissionRegion = 0
	
	donnerlapaye()
end

function retourcamionannulermission_non()	
	ESX.ShowNotification(_U('resume_delivery'))
end

function retourcamionperduannulermission_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	
	MissionLivraison = false
	livraisonnombre = 0
	MissionRegion = 0
	
	donnerlapayesanscamion()
end

function retourcamionperduannulermission_non()	
	ESX.ShowNotification(_U('resume_delivery'))
end

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function donnerlapaye()
	ped = PlayerPedId()
	vehicle = GetVehiclePedIsIn(ped, false)
	vievehicule = GetVehicleEngineHealth(vehicle)
	calculargentretire = round(viemaxvehicule-vievehicule)
	
	if calculargentretire <= 0 then
		argentretire = 0
	else
		argentretire = calculargentretire
	end

    ESX.Game.DeleteVehicle(vehicle)

	local amount = livraisonTotalPaye-argentretire
	
	if vievehicule >= 1 then
		if livraisonTotalPaye == 0 then
			ESX.ShowNotification(_U('not_delivery'))
			ESX.ShowNotification(_U('pay_repair'))
			ESX.ShowNotification(_U('repair_minus')..argentretire)
			TriggerServerEvent("esx_brinksjob:pay", amount)
			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then
				ESX.ShowNotification(_U('shipments_plus')..livraisonTotalPaye)
				TriggerServerEvent("esx_brinksjob:pay", amount)
				livraisonTotalPaye = 0
			else
				ESX.ShowNotification(_U('shipments_plus')..livraisonTotalPaye)
				ESX.ShowNotification(_U('repair_minus')..argentretire)
					TriggerServerEvent("esx_brinksjob:pay", amount)
				livraisonTotalPaye = 0
			end
		end
	else
		if livraisonTotalPaye ~= 0 and amount <= 0 then
			ESX.ShowNotification(_U('truck_state'))
			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then
				ESX.ShowNotification(_U('shipments_plus')..livraisonTotalPaye)
					TriggerServerEvent("esx_brinksjob:pay", amount)
				livraisonTotalPaye = 0
			else
				ESX.ShowNotification(_U('shipments_plus')..livraisonTotalPaye)
				ESX.ShowNotification(_U('repair_minus')..argentretire)
				TriggerServerEvent("esx_brinksjob:pay", amount)
				livraisonTotalPaye = 0
			end
		end
	end
end

function donnerlapayesanscamion()
	ped = PlayerPedId()
	argentretire = Config.TruckPrice
	
	-- donne paye
	local amount = livraisonTotalPaye-argentretire
	
	if livraisonTotalPaye == 0 then
		ESX.ShowNotification(_U('no_delivery_no_truck'))
		ESX.ShowNotification(_U('truck_price')..argentretire)
		TriggerServerEvent("esx_brinksjob:pay", amount)
		livraisonTotalPaye = 0
	else
		if amount >= 1 then
			ESX.ShowNotification(_U('shipments_plus')..livraisonTotalPaye)
			ESX.ShowNotification(_U('truck_price')..argentretire)
			TriggerServerEvent("esx_brinksjob:pay", amount)
			livraisonTotalPaye = 0
		else
			ESX.ShowNotification(_U('truck_state'))
			livraisonTotalPaye = 0
		end
	end
end

function selecttrashbin()
	local PlayerPed = PlayerPedId()
	local PlayerCoords = GetEntityCoords(PlayerPed)
	local NewBin = GetClosestObjectOfType(PlayerCoords, 0.5, GetHashKey("hei_prop_gold_trolly_empty"), false, false)
	--local NewBin, NewBinDistance = ESX.Game.GetClosestObject(Config.DumpstersAvaialbe)
	trashcollectionpos = GetEntityCoords(NewBin)
end

RegisterKey('keyboard', 'E',
	function()
	end,
	function()
        if CurrentAction ~= nil or CollectionAction ~= nil then
			if CollectionAction == 'collection' then
				RequestAnimDict("anim@heists@narcotics@trash") 
				while not HasAnimDictLoaded("anim@heists@narcotics@trash") do 
				Citizen.Wait(0)
				end
				local coords = GetEntityCoords(PlayerPedId())
				for k,v in pairs(Config.Karretjes) do
					if(GetDistanceBetweenCoords(coords, v, true) < 3.5) then
						if currentbag > 0 then
							trashcollection = false
							truckdeposit = true
							TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
							Citizen.Wait(4000)
							ClearPedTasks(PlayerPedId())
							local randombag = math.random(0,2)
							if randombag == 0 then
								garbagebag = CreateObject(GetHashKey("prop_cs_heist_bag_02"), 0, 0, 0, true, true, true) -- creates object
								AttachEntityToEntity(garbagebag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, 0.0, -0.05, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
							elseif randombag == 1 then
								garbagebag = CreateObject(GetHashKey("prop_cs_heist_bag_02"), 0, 0, 0, true, true, true) -- creates object
								AttachEntityToEntity(garbagebag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, 0.0, -0.05, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
							elseif randombag == 2 then
								garbagebag = CreateObject(GetHashKey("prop_cs_heist_bag_02"), 0, 0, 0, true, true, true) -- creates object
								AttachEntityToEntity(garbagebag, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.12, 0.0, -0.05, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
							end   
							TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
							currentbag  = currentbag - 1
							CollectionAction = 'deposit'
						else
							TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)
							Citizen.Wait(4000)
							ClearPedTasks(PlayerPedId())
							setring = false
							bagsoftrash = math.random(2,10)
							currentbag = bagsoftrash 
							CollectionAction = nil
							ESX.ShowNotification("Verzameling voltooid ga terug naar de vrachtwagen!")
							while not IsPedInVehicle(PlayerPedId(), work_truck, false) do
								Citizen.Wait(0)
							end
							trashcollection = false
							truckdeposit = false
							SetVehicleDoorShut(work_truck,5,false)
							Citizen.Wait(2000)
							nouvelledestination()
						end
					end
				end

			elseif CollectionAction == 'deposit'  then
				local taillight_r = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "taillight_r"))
				local taillight_l = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "taillight_l"))
				local newposx = (taillight_r.x - taillight_l.x) / 2
				local newposy = (taillight_r.y - taillight_l.y) / 2
				plyCoords = GetEntityCoords(PlayerPedId(), false)
				dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, taillight_r.x - newposx, taillight_r.y - newposy, taillight_r.z)
				if dist <= 2.0 then
					ClearPedTasks(PlayerPedId())
					Citizen.Wait(5)
					TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
					Citizen.Wait(800)
					local garbagebagdelete = DeleteEntity(garbagebag)
					totalbagpay = totalbagpay+Config.BagPay
					Citizen.Wait(100)
					ClearPedTasks(PlayerPedId())
					CollectionAction = 'collection'
					truckdeposit = false
					trashcollection = true
				end
			end

			if CurrentAction == 'delivery' then
				work_truck = GetVehiclePedIsIn(PlayerPedId(), false)
				SetVehicleDoorOpen(work_truck,5,false, false)
				if Blips['delivery'] ~= nil then
					RemoveBlip(Blips['delivery'])
					Blips['delivery'] = nil
				end
				MissionLivraison = false
				--selecttrashbin()
				trashcollection = true
				CollectionAction = 'collection'
			end

			if CurrentAction == 'retourcamion' then
				retourcamion_oui()
			end

			if CurrentAction == 'retourcamionperdu' then
				retourcamionperdu_oui()
			end

			if CurrentAction == 'retourcamionannulermission' then
				retourcamionannulermission_oui()
			end

			if CurrentAction == 'retourcamionperduannulermission' then
				retourcamionperduannulermission_oui()
			end

			CurrentAction = nil
		end
	end
)

Citizen.CreateThread(function()  
	while true do
		Citizen.Wait(0)
		if CurrentAction ~= nil or CollectionAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)
		end
	end
end)

function jemoeder()
	-- Activate menu when player is inside marker
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if ESX ~= nil and isJobbrinks() then

				local coords      = GetEntityCoords(PlayerPedId())
				local isInMarker  = false
				local currentZone = nil

				for k,v in pairs(Config.Zones) do
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
						isInMarker  = true
						currentZone = k
					end
				end
				
				for k,v in pairs(Config.Cloakroom) do
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
						isInMarker  = true
						currentZone = k
					end
				end
				
				for k,v in pairs(Config.Livraison) do
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
						isInMarker  = true
						currentZone = k
					end
				end

				if isInMarker and not hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = true
					lastZone                = currentZone
					TriggerEvent('esx_brinksjob:hasEnteredMarker', currentZone)
				end

				if not isInMarker and hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = false
					TriggerEvent('esx_brinksjob:hasExitedMarker', lastZone)
				end
			else
				break
			end
		end
	end)
end

function jemoeder2()
	-- DISPLAY MISSION MARKERS AND MARKERS
	Citizen.CreateThread(function()
		while true do
			Wait(0)
			if ESX ~= nil and isJobbrinks() then
				if truckdeposit then
					local taillight_r = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "taillight_r"))
					local taillight_l = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "taillight_l"))
					local newposx = (taillight_r.x - taillight_l.x) / 2
					local newposy = (taillight_r.y - taillight_l.y) / 2
					plyCoords = GetEntityCoords(PlayerPedId(), false)
					DrawMarker(27, taillight_r.x - newposx , taillight_r.y - newposy, taillight_r.z, 0, 0, 0, 0, 0, 0, 1.25, 1.25, 1.0001, 0, 128, 0, 200, 0, 0, 0, 0)
					dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z,taillight_r.x - newposx , taillight_r.y - newposy, taillight_r.z)
					if dist <= 2.0 then
						ESX.Game.Utils.DrawText3D(vector3(taillight_r.x - newposx, taillight_r.y - newposy,taillight_r.z + 0.50), "[E] Leg de tas in de bus.", 1.0)
					end
				end

				if trashcollection then
					local coords = GetEntityCoords(PlayerPedId())
					for k,v in pairs(Config.Karretjes) do
						local dist = GetDistanceBetweenCoords(coords, v, true)
						if dist < 50.0 then
							DrawMarker(2, v, 0, 0, 0, 0, 0, 0, 0.5,0.5,0.5, 255, 1,1, 200, 1, 1, 1, 1)
							if currentbag == 0 then
								ESX.Game.Utils.DrawText3D(v + vector3(0.0, 0.0, 1.0), "[E] Afronden", 1.0)				
							else
								ESX.Game.Utils.DrawText3D(v + vector3(0.0, 0.0, 1.0), "[E] Verzamelen ["..currentbag.."/"..bagsoftrash.."]", 1.0)
							end
						end
					end
				end
				
				if MissionLivraison then
					DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
					DrawMarker(Config.Livraison.AnnulerMission.Type, Config.Livraison.AnnulerMission.Pos.x, Config.Livraison.AnnulerMission.Pos.y, Config.Livraison.AnnulerMission.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Livraison.AnnulerMission.Size.x, Config.Livraison.AnnulerMission.Size.y, Config.Livraison.AnnulerMission.Size.z, Config.Livraison.AnnulerMission.Color.r, Config.Livraison.AnnulerMission.Color.g, Config.Livraison.AnnulerMission.Color.b, 100, false, true, 2, false, false, false, false)
				elseif MissionRetourCamion then
					DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
				end
				
				for k,v in pairs(Config.Zones) do
					if isInService and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
						DrawMarker(2, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, true, true, 2, true, false, false, false)
					end
				end

				for k,v in pairs(Config.Cloakroom) do
					if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
						DrawMarker(2, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, true, true, 2, true, false, false, false)
					end
				end
			else
				break
			end
		end
	end)
end

function refreshBlips()
	if PlayerData.job.name == "brinks" then
		local blip = AddBlipForCoord(Config.Cloakroom.CloakRoom.Pos.x, Config.Cloakroom.CloakRoom.Pos.y, Config.Cloakroom.CloakRoom.Pos.z)
	  
		SetBlipSprite (blip, 67)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 25)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('blip_job'))
		EndTextCommandSetBlipName(blip)
		--exports['ESX_Framework']:SetBlipInfoTitle(blip, "Vaste baan", rockstarVerified)
		--exports['ESX_Framework']:AddBlipInfoName(blip, "Brinks", "")
		--exports['ESX_Framework']:AddBlipInfoHeader(blip, "Gradatie:", PlayerData.job.grade_label)
		--exports['ESX_Framework']:SetBlipInfoImage(blip, "world_blips", "supermarkt")
		--exports['ESX_Framework']:AddBlipInfoText(blip, "Dit is je vaste baan", "")
		--exports['ESX_Framework']:AddBlipInfoText(blip, "Type", "Werk")
		--exports['ESX_Framework']:AddBlipInfoIcon(blip, "Opdracht", "", "", 9, false)
	end
end

function MissionLivraisonSelect()
    TriggerServerEvent('esx:clientLog', "MissionLivraisonSelect num")
    TriggerServerEvent('esx:clientLog', MissionRegion)
	if MissionRegion == 0 then

            TriggerServerEvent('esx:clientLog', "MissionLivraisonSelect 1")
		MissionRegion = math.random(1,2)
	end
	
	if MissionRegion == 1 then -- Los santos
            TriggerServerEvent('esx:clientLog', "MissionLivraisonSelect 2")
		MissionNum = math.random(1, 10)
		while lastmission == MissionNum do
			Citizen.Wait(50)
			MissionNum = math.random(1, 10)
		end
		if MissionNum == 1 then destination = Config.Livraison.Delivery1LS namezone = "Delivery1LS" namezonenum = 1 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 2 then destination = Config.Livraison.Delivery2LS namezone = "Delivery2LS" namezonenum = 2 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 3 then destination = Config.Livraison.Delivery3LS namezone = "Delivery3LS" namezonenum = 3 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 4 then destination = Config.Livraison.Delivery4LS namezone = "Delivery4LS" namezonenum = 4 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 5 then destination = Config.Livraison.Delivery5LS namezone = "Delivery5LS" namezonenum = 5 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 6 then destination = Config.Livraison.Delivery6LS namezone = "Delivery6LS" namezonenum = 6 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 7 then destination = Config.Livraison.Delivery7LS namezone = "Delivery7LS" namezonenum = 7 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 8 then destination = Config.Livraison.Delivery8LS namezone = "Delivery8LS" namezonenum = 8 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 9 then destination = Config.Livraison.Delivery9LS namezone = "Delivery9LS" namezonenum = 9 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 10 then destination = Config.Livraison.Delivery10LS namezone = "Delivery10LS" namezonenum = 10 namezoneregion = 1 lastmission = MissionNum
		end
		
	elseif MissionRegion == 2 then -- Blaine County

		TriggerServerEvent('esx:clientLog', "MissionLivraisonSelect 3")
		MissionNum = math.random(1, 10)
	
		if MissionNum == 1 then destination = Config.Livraison.Delivery1BC namezone = "Delivery1BC" namezonenum = 1 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 2 then destination = Config.Livraison.Delivery2BC namezone = "Delivery2BC" namezonenum = 2 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 3 then destination = Config.Livraison.Delivery3BC namezone = "Delivery3BC" namezonenum = 3 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 4 then destination = Config.Livraison.Delivery4BC namezone = "Delivery4BC" namezonenum = 4 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 5 then destination = Config.Livraison.Delivery5BC namezone = "Delivery5BC" namezonenum = 5 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 6 then destination = Config.Livraison.Delivery6BC namezone = "Delivery6BC" namezonenum = 6 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 7 then destination = Config.Livraison.Delivery7BC namezone = "Delivery7BC" namezonenum = 7 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 8 then destination = Config.Livraison.Delivery8BC namezone = "Delivery8BC" namezonenum = 8 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 9 then destination = Config.Livraison.Delivery9BC namezone = "Delivery9BC" namezonenum = 9 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 10 then destination = Config.Livraison.Delivery10BC namezone = "Delivery10BC" namezonenum = 10 namezoneregion = 2 lastmission = MissionNum
		end
		
	end
	
	MissionLivraisonLetsGo()
end

-- Fonction active mission livraison
function MissionLivraisonLetsGo()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	
	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_delivery'))
	EndTextCommandSetBlipName(Blips['delivery'])
	
	Blips['annulermission'] = AddBlipForCoord(Config.Livraison.AnnulerMission.Pos.x,  Config.Livraison.AnnulerMission.Pos.y,  Config.Livraison.AnnulerMission.Pos.z)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_goal'))
	EndTextCommandSetBlipName(Blips['annulermission'])

	if MissionRegion == 1 then -- Los santos
		ESX.ShowNotification(_U('meet_ls'))
	elseif MissionRegion == 2 then -- Blaine County
		ESX.ShowNotification(_U('meet_bc'))
	elseif MissionRegion == 0 then -- au cas ou
		ESX.ShowNotification(_U('meet_del'))
	end  

	MissionLivraison = true
end

--Fonction retour au depot
function MissionLivraisonStopRetourDepot()
	destination = Config.Livraison.RetourCamion
	
	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_depot'))
	EndTextCommandSetBlipName(Blips['delivery'])
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	ESX.ShowNotification(_U('return_depot'))
	
	MissionRegion = 0
	MissionLivraison = false
	MissionNum = 0
	MissionRetourCamion = true
end

function SavePlaqueVehicule()
	plaquevehicule = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
end

function VerifPlaqueVehiculeActuel()
	plaquevehiculeactuel = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false))
end
