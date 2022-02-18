isPedInAnyVehicle = false
isPedInAnyPlane = false
isPedInAnyHeli = false
isPedOnFoot = false
playerCoords = {}
vehicleInFront = nil
vehicleInFrontPlate = nil
playerPedId = nil
isPlayerDead = false

CreateThread(function()
	while true do
		playerPedId = PlayerPedId()
		isPlayerDead = IsPlayerDead(playerPedId)
		playerCoords = GetEntityCoords(playerPedId)
		isPedOnFoot = IsPedOnFoot(playerPedId)
		isPedInAnyVehicle = IsPedInAnyVehicle(playerPedId)
		isPedInAnyHeli = IsPedInAnyHeli(playerPedId)
		isPedInAnyPlane = IsPedInAnyPlane(playerPedId)
		vehicleInFront = VehicleInFront()
		if vehicleInFront ~= nil and vehicleInFront ~= 0 then
			vehicleInFrontPlate = GetVehicleNumberPlateText(vehicleInFront)
		end
		Wait(100)
	end
end)