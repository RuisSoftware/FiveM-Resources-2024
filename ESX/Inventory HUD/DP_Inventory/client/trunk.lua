local lastVehicle = nil
local lastOpen = false
local vehiclePlate = {}
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil
local lastChecked = 0
local vehStorage = {}

function setVehicleTable()
	local vehicleTable = {['adder']=1, ['osiris']=0, ['pfister811']=0, ['penetrator']=0, ['autarch']=0, ['bullet']=0, ['cheetah']=0, ['cyclone']=0, ['voltic']=0, ['reaper']=1, ['entityxf']=0, ['t20']=0, ['taipan']=0, ['tempesta']=2, ['tezeract']=0, ['torero']=1, ['turismor']=0, ['fmj']=0, ['gp1']=2, ['infernus ']=0, ['italigtb']=1, ['italigtb2']=1, ['nero']=2, ['nero2']=0, ['vacca']=1, ['vagner']=0, ['visione']=0, ['prototipo']=0, ['xa21']=2, ['zentorno']=0, ['pounder']=3}

	for k, v in pairs(vehicleTable) do
		getHash = GetHashKey(k)
		vehStorage[getHash] = v
	end
end

setVehicleTable()

RegisterNetEvent("DP_Inventory_trunk:setOwnedVehicule")
AddEventHandler("DP_Inventory_trunk:setOwnedVehicule", function(vehicle)
	vehiclePlate = vehicle
end)

function getItemyWeight(item)
	local weight = 0
	local itemWeight = 0
	if item ~= nil then
		itemWeight = Config.DefaultWeight
		if arrayWeight[item] ~= nil then
		itemWeight = arrayWeight[item]
		end
	end
	return itemWeight
end

function VehicleInFront()
	local pos = playerCoords
	local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
	local a, b, c, d, result = GetRaycastResult(rayHandle)
	return result
end

function OpenTrunk()
	local playerPed = PlayerPedId()
	if not IsPedInAnyVehicle(playerPed) then
		local coords = GetEntityCoords(playerPed)
		local vehicle = vehicleInFront
		myVeh = false
		PlayerData = ESX.GetPlayerData()

		for i = 1, #vehiclePlate do
			local vPlate = all_trim(vehiclePlate[i].plate)
			local vFront = all_trim(vehicleInFrontPlate)
			if vPlate == vFront then
				myVeh = true
			elseif lastChecked < GetGameTimer() - 60000 then
				TriggerServerEvent("DP_Inventory_trunk:getOwnedVehicle")
				lastChecked = GetGameTimer()
				Wait(2000)
				for i = 1, #vehiclePlate do
					local vPlate = all_trim(vehiclePlate[i].plate)
					local vFront = all_trim(vehicleInFrontPlate)
					if vPlate == vFront then
						myVeh = true
					end
				end
			end
		end

		if not Config.CheckOwnership or (Config.AllowPolice and PlayerData.job.name == Config.InventoryJob.Police) or (Config.AllowNightclub and PlayerData.job.name == Config.InventoryJob.Nightclub) or (Config.AllowMafia and PlayerData.job.name == Config.InventoryJob.Mafia) or (Config.CheckOwnership and myVeh) then
			if vehicleInFrontPlate ~= nil or vehicleInFrontPlate ~= "" or vehicleInFrontPlate ~= " " then
				vehHash = GetEntityModel(vehicleInFront)
				checkVehicle = vehStorage[vehHash]
				if checkVehicle == 1 then 
					open, vehBone = 4, GetEntityBoneIndexByName(vehicleInFront, 'bonnet')
				elseif checkVehicle == nil then 
					open, vehBone = 5, GetEntityBoneIndexByName(vehicleInFront, 'boot') 
				elseif checkVehicle == 2 then 
					open, vehBone = 5, GetEntityBoneIndexByName(vehicleInFront, 'boot') 
				else
					exports['t-notify']:Alert({
						style  	=  'error',
						message =  _U('no_veh_nearby'),
						length 	= 5500
					})
					return 
				end
				local vehiclePos = GetWorldPositionOfEntityBone(vehicleInFront, vehBone)
		
				local pedDistance = GetDistanceBetweenCoords(vehiclePos, coords, 1)
				if (open == 5 and checkVehicle == nil) then if pedDistance < 3.0 then CloseToVehicle = true end elseif (open == 5 and checkVehicle == 2) then if pedDistance < 3.0 then CloseToVehicle = true end elseif open == 4 then if pedDistance < 3.0 then CloseToVehicle = true end end	
			
				if vehicleInFront > 0 and GetPedInVehicleSeat(vehicleInFront, -1) ~= PlayerPedId() and CloseToVehicle then
					lastVehicle = vehicleInFront
					local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicleInFront))
					local locked = GetVehicleDoorLockStatus(vehicleInFront)
					local class = GetVehicleClass(vehicleInFront)
					ESX.UI.Menu.CloseAll()
					if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "inventory") then
						SetVehicleDoorShut(vehicleInFront, open, false)
					else
						if locked == 1 then
							SetVehicleDoorOpen(vehicleInFront, open, false, false)
							ESX.UI.Menu.CloseAll()
							if vehicleInFrontPlate ~= nil or vehicleInFrontPlate ~= "" or vehicleInFrontPlate ~= " " then
								CloseToVehicle = true
								exports['mythic_progbar']:Progress({
									name = "OpenTrunk",
									duration = 2000,
									label = _U('opentrunk'),
									useWhileDead = false,
									canCancel = true,
									controlDisables = {},
									animation = nil,
									prop = {},
								}, function(status)
									if not status then
										if vehicleInFront == lastVehicle then
											OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehicleInFront), Config.TrunkSize[class], myVeh)
											if Config.CameraAnimationTrunk == true then
												DeleteSkinCam()
												loadCamera(0, 3)
											end
										else
											exports['t-notify']:Alert({
												style  	=  'error',
												message =  _U('trunk_closed'),
												length 	= 5500
											})
										end
									end
								end)
							end
						else
							exports['t-notify']:Alert({
								style  	=  'error',
								message =  _U('trunk_closed'),
								length 	= 5500
							})
						end
					end
				else
					exports['t-notify']:Alert({
						style  	=  'error',
						message =  _U('no_veh_nearby'),
						length 	= 5500
					})
				end
				lastOpen = true
				GUI.Time = GetGameTimer()
			end
		else
			exports['t-notify']:Alert({
				style  	=  'error',
				message =  _U('nacho_veh'),
				length 	= 5500
			})
		end
	end
end
local count = 0

CreateThread(function()
	while true do
		Wait(50)
		if CloseToVehicle then
			local playerPed = GetPlayerPed(-1)
			local coords = GetEntityCoords(playerPed)
			local vehicle = vehicleInFront
			
			if checkVehicle == 1 then 
				open, vehBone = 4, GetEntityBoneIndexByName(vehicle, 'bonnet')
			elseif checkVehicle == nil then 
				open, vehBone = 5, GetEntityBoneIndexByName(vehicle, 'boot') 
			elseif checkVehicle == 2 then 
				open, vehBone = 5, GetEntityBoneIndexByName(vehicle, 'boot') 
			else 
				return 
			end
			
			local vehiclePos = GetWorldPositionOfEntityBone(vehicle, vehBone)
			local pedDistance = GetDistanceBetweenCoords(vehiclePos, coords, 1)

			local isClose = false
			if (open == 5 and checkVehicle == nil) then 
				if pedDistance < 3.0 then 
					isClose = true 
				end 
			elseif (open == 5 and checkVehicle == 2) then 
				if pedDistance < 3.0 then 
					isClose = true 
				end 
			elseif open == 4 then 
				if pedDistance < 3.0 then 
					isClose = true 
				end 
			end
			if DoesEntityExist(vehicle) and isClose then
				CloseToVehicle = true
			else
				CloseToVehicle = false
				lastOpen = false
				ESX.UI.Menu.CloseAll()
				SetVehicleDoorShut(lastVehicle, open, false)
				lastVehicle = nil
			end
		end
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent("DP_Inventory_trunk:getOwnedVehicle")
	lastChecked = GetGameTimer()
end)

function OpenCoffreInventoryMenu(plate, max, myVeh)
	ESX.TriggerServerCallback("DP_Inventory_trunk:getInventoryV", function(inventory)
		text = _U("trunk_info", plate, (inventory.weight / 100), (max / 100))
		data = {plate = plate, max = max, myVeh = myVeh, text = text}
		TriggerEvent("DP_Inventory:openTrunkInventory", data, inventory.blackMoney, inventory.cashMoney, inventory.items, inventory.weapons)
	end, plate)
end

function all_trim(s)
	if s then
		return s:match "^%s*(.*)":match "(.-)%s*$"
	else
		return "noTagProvided"
	end
end

function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
		if type(k) ~= "number" then
			k = '"' .. k .. '"'
		end
		s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end