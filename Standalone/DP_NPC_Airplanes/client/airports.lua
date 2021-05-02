Citizen.CreateThread(function()
	while true do
		Wait(0)
		for k,v in pairs(Config.Markers) do
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.x, v.y, v.z, true) < 80.0 then
				if not IsPedInAnyPlane(PlayerPedId()) then
					if not _menuPool:IsAnyMenuOpen() then
						DrawMarker(1, v.x, v.y, v.z-1.0001, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 255, 219, 77, 155, 0, 0, 2, 0, 0, 0, 0)
					end
				end
			end
		end
		
	end
end)

function IsPlayerNearAirport()
	for k,v in pairs(Config.Markers) do
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId(), true), v.x, v.y, v.z, true) < 2.0 then
			if not _menuPool:IsAnyMenuOpen() then
				if not IsHelpMessageBeingDisplayed() then
					BeginTextCommandDisplayHelp("STRING")
					AddTextComponentSubstringPlayerName(GetLabelText("MATC_DPADRIGHT"))
					EndTextCommandDisplayHelp(0, 0, 1, -1)
				end
			else
				ClearAllHelpMessages()
			end
			return true
		end
	end
end