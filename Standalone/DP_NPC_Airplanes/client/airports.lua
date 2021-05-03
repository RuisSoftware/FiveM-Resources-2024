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

Citizen.CreateThread(function()
	while true do
		Wait(0)
		for k,v in pairs(Config.Markers) do
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.x, v.y, v.z, true) < 80.0 then
				if not IsPedInAnyPlane(PlayerPedId()) then
					if Config.ESXMenu then
						DrawMarker(1, v.x, v.y, v.z-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 255, 219, 77, 155, 0, 0, 2, 0, 0, 0, 0)
					else
						if not _menuPool:IsAnyMenuOpen() then
							DrawMarker(1, v.x, v.y, v.z-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 255, 219, 77, 155, 0, 0, 2, 0, 0, 0, 0)
						end
					end
				end
			end
		end
		
	end
end)

function IsPlayerNearAirport()
	for k,v in pairs(Config.Markers) do
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.x, v.y, v.z, true) < 2.0 then
			if Config.ESXMenu then
				if not IsHelpMessageBeingDisplayed() then
					BeginTextCommandDisplayHelp("STRING")
					AddTextComponentSubstringPlayerName(GetLabelText("MATC_DPADRIGHT"))
					EndTextCommandDisplayHelp(0, 0, 1, -1)
				end
			else
				if not _menuPool:IsAnyMenuOpen() then
					if not IsHelpMessageBeingDisplayed() then
						BeginTextCommandDisplayHelp("STRING")
						AddTextComponentSubstringPlayerName(GetLabelText("MATC_DPADRIGHT"))
						EndTextCommandDisplayHelp(0, 0, 1, -1)
					end
				else
					ClearAllHelpMessages()
				end
			end
			return true
		end
	end
end