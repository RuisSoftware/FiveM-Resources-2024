Citizen.CreateThread(function()
	if Config.WaitingTime <= 50 and Config.UseExtendedPropList == true then
		print('Warning: setting the Config.WaitingTime lower than 50 while using Config.UseExtendedPropList will extremely slow down your client performance.')
		Config.WaitingTime = nil
	end
	if Config.UseExtendedPropList == true then
		freezeList = Config.PropsExtended
	else
		freezeList = Config.Props
	end
	while true do
		if Config.WaitingTime == nil then
			break
		end
		for id = 1, #freezeList do
			local pos = GetEntityCoords(PlayerPedId(), false)
			local object = GetClosestObjectOfType(pos.x, pos.y, pos.z, 100.0, GetHashKey(freezeList[id]), 0, 0, 0)
			if (object ~= 0 and IsPedWalking(PlayerPedId())) or (object ~= 0 and IsPedRunning(PlayerPedId())) or (object ~= 0 and IsPedInAnyVehicle(PlayerPedId(), false) and GetEntitySpeed(PlayerPedId())) <= Config.MaxSpeed then
				FreezeEntityPosition(object, true)
			end
		end
		Citizen.Wait(Config.WaitingTime)
	end
end)