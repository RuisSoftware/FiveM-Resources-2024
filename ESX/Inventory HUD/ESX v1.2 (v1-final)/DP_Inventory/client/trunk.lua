local GUI = {}
local PlayerData = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time = 0
local vehiclePlate = {}
local arrayWeight = Config.localWeight
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil
local lastChecked = 0
local vehStorage = {}

function setVehicleTable()
	local vehicleTable = {['adder']=1, ['osiris']=0, ['pfister811']=0, ['penetrator']=0, ['autarch']=0, ['bullet']=0, ['cheetah']=0, ['cyclone']=0, ['voltic']=0, ['reaper']=1, ['entityxf']=0, ['t20']=0, ['taipan']=0, ['tempesta']=2, ['tezeract']=0, ['torero']=1, ['turismor']=0, ['fmj']=0, ['gp1']=2, ['infernus ']=0, ['italigtb']=1, ['italigtb2']=1, ['nero']=2, ['nero2']=0, ['vacca']=1, ['vagner']=0, ['visione']=0, ['prototipo']=0, ['xa21']=2, ['zentorno']=0}
	--[[
		0 = vehicle has no storage
		1 = vehicle storage is in bonnet
	]]
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
	local pos = GetEntityCoords(PlayerPedId())
	local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 4.0, 0.0)
	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
	local a, b, c, d, result = GetRaycastResult(rayHandle)
	return result
end

function openTrunk()
	local playerPed = PlayerPedId()
	

	if not IsPedInAnyVehicle(playerPed) then
		local coords = GetEntityCoords(playerPed)
		local vehicle = VehicleInFront()
		globalplate = GetVehicleNumberPlateText(vehicle)
		myVeh = false
		PlayerData = ESX.GetPlayerData()

		for i = 1, #vehiclePlate do
			local vPlate = all_trim(vehiclePlate[i].plate)
			local vFront = all_trim(GetVehicleNumberPlateText(vehicle))
			if vPlate == vFront then
				myVeh = true
			elseif lastChecked < GetGameTimer() - 60000 then
				TriggerServerEvent("DP_Inventory_trunk:getOwnedVehicle")
				lastChecked = GetGameTimer()
				Wait(2000)
				for i = 1, #vehiclePlate do
					local vPlate = all_trim(vehiclePlate[i].plate)
					local vFront = all_trim(GetVehicleNumberPlateText(vehicle))
					if vPlate == vFront then
						myVeh = true
					end
				end
			end
		end

		if not Config.CheckOwnership or (Config.AllowPolice and PlayerData.job.name == Config.InventoryJob.Police) or (Config.AllowNightclub and PlayerData.job.name == Config.InventoryJob.Nightclub) or (Config.AllowMafia and PlayerData.job.name == Config.InventoryJob.Mafia) or (Config.CheckOwnership and myVeh) then
			if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
				local vehFront = VehicleInFront()
				vehHash = GetEntityModel(vehFront)
				checkVehicle = vehStorage[vehHash]
				if checkVehicle == 1 then open, vehBone = 4, GetEntityBoneIndexByName(vehFront, 'bonnet')
				elseif checkVehicle == nil then open, vehBone = 5, GetEntityBoneIndexByName(vehFront, 'boot') elseif checkVehicle == 2 then open, vehBone = 5, GetEntityBoneIndexByName(vehicle, 'boot') else exports['t-notify']:SendTextAlert('info', _U('no_veh_nearby'), 5500, false) return end
				local vehiclePos = GetWorldPositionOfEntityBone(vehFront, vehBone)
		
				local pedDistance = GetDistanceBetweenCoords(vehiclePos, coords, 1)
				if (open == 5 and checkVehicle == nil) then if pedDistance < 3.0 then CloseToVehicle = true end elseif (open == 5 and checkVehicle == 2) then if pedDistance < 3.0 then CloseToVehicle = true end elseif open == 4 then if pedDistance < 3.0 then CloseToVehicle = true end end	
			
				if vehFront > 0 and GetPedInVehicleSeat(vehFront, -1) ~= PlayerPedId() and CloseToVehicle then
					lastVehicle = vehFront
					local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehFront))
					local locked = GetVehicleDoorLockStatus(vehFront)
					local class = GetVehicleClass(vehFront)
					ESX.UI.Menu.CloseAll()
					if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "inventory") then
						SetVehicleDoorShut(vehFront, open, false)
					else
						if locked == 1 then
							SetVehicleDoorOpen(vehFront, open, false, false)
							ESX.UI.Menu.CloseAll()
							if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
								CloseToVehicle = true
								exports['mythic_progbar']:Progress({
									name = "openTrunk",
									duration = 2000,
									label = _U('opentrunk'),
									useWhileDead = false,
									canCancel = true,
									controlDisables = {},
									animation = nil,
									prop = {},
								}, function(status)
									if not status then
										if VehicleInFront() == lastVehicle then
											OpenCoffreInventoryMenu(GetVehicleNumberPlateText(vehFront), Config.TrunkSize[class], myVeh)
											if Config.CameraAnimationTrunk == true then
												DeleteSkinCam()
												loadCamera(0, 3)
											end
										else
											exports['t-notify']:SendTextAlert('error', _U('trunk_closed'), 5500, false)
										end
									end
								end)
							end
						else
							exports['t-notify']:SendTextAlert('error', _U('trunk_closed'), 5500, false)
						end
					end
				else
					exports['t-notify']:SendTextAlert('error', _U('no_veh_nearby'), 5500, false)
				end
				lastOpen = true
				GUI.Time = GetGameTimer()
			end
		else
			exports['t-notify']:SendTextAlert('error', _U('nacho_veh'), 5500, false)
		end
	end
end
local count = 0

-- Key controls
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, Config.OpenKeyTrunk) and (GetGameTimer() - GUI.Time) > 1000 then
			openTrunk()
			GUI.Time = GetGameTimer()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
	Wait(50)

	if CloseToVehicle then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = VehicleInFront()
		
		if checkVehicle == 1 then open, vehBone = 4, GetEntityBoneIndexByName(vehicle, 'bonnet')
		elseif checkVehicle == nil then open, vehBone = 5, GetEntityBoneIndexByName(vehicle, 'boot') elseif checkVehicle == 2 then open, vehBone = 5, GetEntityBoneIndexByName(vehicle, 'boot') else return end
		
		local vehiclePos = GetWorldPositionOfEntityBone(vehicle, vehBone)
		local pedDistance = GetDistanceBetweenCoords(vehiclePos, coords, 1)

		local isClose = false
		if (open == 5 and checkVehicle == nil) then if pedDistance < 3.0 then isClose = true end elseif (open == 5 and checkVehicle == 2) then if pedDistance < 3.0 then isClose = true end elseif open == 4 then if pedDistance < 3.0 then isClose = true end end
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
