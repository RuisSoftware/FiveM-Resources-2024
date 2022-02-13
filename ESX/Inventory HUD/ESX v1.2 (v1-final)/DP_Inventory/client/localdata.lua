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
		
		if isPlayerDead then Wait(100) return end
		
		playerCoords = GetEntityCoords(playerPedId)
		isPedOnFoot = IsPedOnFoot(playerPedId)
		
		if not isPedOnFoot then
			isPedInAnyVehicle = IsPedInAnyVehicle(playerPedId)
		else
			vehicleInFront = VehicleInFront()
			if vehicleInFront ~= nil and vehicleInFront ~= 0 then
				vehicleInFrontPlate = GetVehicleNumberPlateText(vehicleInFront)
			end
		end
		Wait(100)
	end
end)