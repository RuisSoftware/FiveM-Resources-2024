RegisterKey('keyboard', 'E',
	function()
	end,
	function()
		if IsPlayerNearAirport() then
			mainMenu:Visible(not mainMenu:Visible())		
		end
	end
)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)

		if not landing then
			if IsEntityInAir(AirPlane) then
				SetVehicleLandingGear(AirPlane, 1)
			end
			if startZone == "AIRP" and planeDest == "DESRT" then
				if IsEntityInZone(AirPlane, "DESRT") or IsEntityInZone(PlayerPedId(), "GREATC") then
					TaskPlaneLand(pilot, AirPlane, 881.4462, 3060.4829, 41.1682+10.0001, 1657.07, 3238.21, 40.5669+1.0001)
					SetPedKeepTask(pilot, true)
					landing = true
				end
			elseif startZone == "AIRP" and planeDest == "ISHEIST" then --
				if IsEntityInZone(AirPlane, "ISHEIST") or IsEntityInZone(AirPlane, "OCEANA") then
					TaskPlaneLand(pilot, AirPlane, 4009.69,-4670.94,4.18+1.0001, 4274.53,-4574.21,4.18+1.0001)
					SetPedKeepTask(pilot, true)
					landing = true
				end
			elseif startZone == "DESRT" and planeDest == "AIRP" then
				if IsEntityInZone(AirPlane, "RICHM") or IsEntityInZone(AirPlane, "OCEANA") then
					TaskPlaneLand(pilot, AirPlane, -1792.00122, -2882.29980, 13.9440+1.0001, -998.5266, -3341.3579, 13.9444+1.0001)
					SetPedKeepTask(pilot, true)
					landing = true
				end
			elseif startZone == "DESRT" and planeDest == "ISHEIST" then --
				if IsEntityInZone(AirPlane, "ISHEIST") or IsEntityInZone(AirPlane, "OCEANA") then
					TaskPlaneLand(pilot, AirPlane, 4009.69,-4670.94,4.18+1.0001, 4274.53,-4574.21,4.18+1.0001)
					SetPedKeepTask(pilot, true)
					landing = true
				end
			elseif startZone == "ISHEIST" and planeDest == "AIRP" then
				if IsEntityInZone(AirPlane, "RICHM") or IsEntityInZone(AirPlane, "OCEANA") then
					TaskPlaneLand(pilot, AirPlane, -1792.00122, -2882.29980, 13.9440+1.0001, -998.5266, -3341.3579, 13.9444+1.0001)
					SetPedKeepTask(pilot, true)
					landing = true
				end
			elseif startZone == "ISHEIST" and planeDest == "DESRT" then
				if IsEntityInZone(AirPlane, "DESRT") or IsEntityInZone(PlayerPedId(), "GREATC") then
					TaskPlaneLand(pilot, AirPlane, 881.4462, 3060.4829, 41.1682+10.0001, 1657.07, 3238.21, 40.5669+1.0001)
					SetPedKeepTask(pilot, true)
					landing = true
				end
			end
		end

		if not IsEntityInZone(PlayerPedId(), startZone) then
			if not IsEntityInAir(AirPlane) and IsPedInVehicle(PlayerPedId(), AirPlane, false) then
				TaskVehicleTempAction(pilot, Airplane, 27, -1)
				SetVehicleHandbrake(AirPlane, true)

				if GetEntitySpeed(AirPlaine) == 0.0 then
					if IsEntityInZone(PlayerPedId(), "AIRP") then
						Wait(500)
						DoScreenFadeOut(200)
						while not IsScreenFadedOut() do
							Citizen.Wait(0)
						end
						DeleteVehicle(AirPlane)
						DeleteEntity(pilot)
						SetEntityCoords(PlayerPedId(), -1042.0395, -2740.7780, 20.1692)
						SetEntityHeading(PlayerPedId(), 340.2285)
						Wait(800)
						DoScreenFadeIn(500)
					else
						TaskLeaveVehicle(PlayerPedId(), AirPlane, 0)
						Wait(5000)
						DeleteVehicle(AirPlane)
						DeleteEntity(pilot)
					end
				end
			end

			if not IsPedInVehicle(PlayerPedId(), AirPlane, false) and landing == true then
				SetVehicleHandbrake(AirPlane, false)
				SetBlockingOfNonTemporaryEvents(pilot, false)
				
				SetEntityAsNoLongerNeeded(pilot)
				SetEntityAsNoLongerNeeded(AirPlane)

				startZone = nil
				planeDest = nil
				landing = false
			end
		end

	end
end)