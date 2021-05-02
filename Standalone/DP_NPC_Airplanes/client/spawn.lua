function CreatePlane(x, y, z, heading, startZone, destination)
	mainMenu:Visible(not mainMenu:Visible())

	modelHash = GetHashKey(Config.PlaneModel)
	pilotModel = GetHashKey("s_m_m_pilot_01")
	
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		Citizen.Wait(0)
	end

	RequestModel(pilotModel)
	while not HasModelLoaded(pilotModel) do
		Citizen.Wait(0)
	end
	SetEntityCoords(PlayerPedId(), x, y, z)
	if HasModelLoaded(modelHash) and HasModelLoaded(pilotModel) then
		ClearAreaOfEverything(x, y, z, 1500, false, false, false, false, false)

		AirPlane = CreateVehicle(modelHash, x, y, z-1.0, heading, true, false)
		SetVehicleOnGroundProperly(AirPlane)
		SetVehicleEngineOn(AirPlane, true, true, true)
		SetEntityProofs(AirPlane, true, true, true, true, true, true, true, false)
		SetVehicleHasBeenOwnedByPlayer(AirPlane, true)

		pilot = CreatePedInsideVehicle(AirPlane, 6, pilotModel, -1, true, false)

		SetBlockingOfNonTemporaryEvents(pilot, true)

		local netVehid = NetworkGetNetworkIdFromEntity(AirPlane)
		SetNetworkIdCanMigrate(netVehid, true)
		NetworkRegisterEntityAsNetworked(VehToNet(AirPlane))

		local netPedid = NetworkGetNetworkIdFromEntity(pilot)
		SetNetworkIdCanMigrate(netPedid, true)
		NetworkRegisterEntityAsNetworked(pilot)

		TaskWarpPedIntoVehicle(PlayerPedId(), AirPlane, -2)

		SetModelAsNoLongerNeeded(modelHash)
		SetModelAsNoLongerNeeded(pilotModel)
	end

	if startZone == "AIRP" and destination == "DESRT" then -- goed
		TaskPlaneMission(pilot, AirPlane, 0, 0, -107.2212, 2717.5534, 61.9673, 4, GetVehicleModelMaxSpeed(modelHash), 1.0, 0.0, 10.0, 40.0)
	elseif startZone == "AIRP" and destination == "ISHEIST" then
		TaskPlaneMission(pilot, AirPlane, 0, 0, 3526.92,-3951.51,117.74, 4, GetVehicleModelMaxSpeed(modelHash), 1.0, 0.0, 10.0, 40.0)
	elseif startZone == "DESRT" and destination == "AIRP" then -- goed
		TaskVehicleDriveToCoordLongrange(pilot, AirPlane, 1403.0020751953, 2995.9179, 40.5507, GetVehicleModelMaxSpeed(modelHash), 16777216, 0.0)
		Wait(15000)
		TaskPlaneMission(pilot, AirPlane, 0, 0, -1571.5589, -556.7288, 114.4482, 4, GetVehicleModelMaxSpeed(modelHash), 1.0, 0.0, 5.0, 40.0)
	elseif startZone == "DESRT" and destination == "ISHEIST" then
		TaskVehicleDriveToCoordLongrange(pilot, AirPlane, 1403.0020751953, 2995.9179, 40.5507, GetVehicleModelMaxSpeed(modelHash), 16777216, 0.0)
		Wait(15000)
		TaskPlaneMission(pilot, AirPlane, 0, 0, 3526.92,-3951.51,117.74, 4, GetVehicleModelMaxSpeed(modelHash), 1.0, 0.0, 5.0, 40.0)
	elseif startZone == "ISHEIST" and destination == "DESRT" then
		TaskVehicleDriveToCoordLongrange(pilot, AirPlane, 4101.35,-4636.82,4.18, GetVehicleModelMaxSpeed(modelHash), 16777216, 0.0)
		Wait(15000)
		TaskPlaneMission(pilot, AirPlane, 0, 0, -107.2212, 2717.5534, 61.9673, 4, GetVehicleModelMaxSpeed(modelHash), 1.0, 0.0, 5.0, 40.0)
	elseif startZone == "ISHEIST" and destination == "AIRP" then
		TaskVehicleDriveToCoordLongrange(pilot, AirPlane, 4101.35,-4636.82,4.18, GetVehicleModelMaxSpeed(modelHash), 16777216, 0.0)
		Wait(15000)
		TaskPlaneMission(pilot, AirPlane, 0, 0, -1571.5589, -556.7288, 114.4482, 4, GetVehicleModelMaxSpeed(modelHash), 1.0, 0.0, 5.0, 40.0)
	end
end

RegisterNetEvent("airports:departure")
AddEventHandler("airports:departure",  function(x, y, z, heading, start, planeDest)
	ClearAllHelpMessages()
	CreatePlane(x, y, z, heading, start, planeDest)
end)

RegisterNetEvent("airports:moneyInvalid")
AddEventHandler("airports:moneyInvalid", function()
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(Config.Locale.NoMoney)
	SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", true, 4, Config.Locale.NoMoneyTitle, "", Config.Locale.NoMoney)
	DrawNotification(false, true)
end)
