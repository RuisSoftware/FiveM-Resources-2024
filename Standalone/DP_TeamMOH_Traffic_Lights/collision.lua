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
			local gate = GetClosestObjectOfType(pos.x, pos.y, pos.z, 100.0, GetHashKey(freezeList[id]), 0, 0, 0)
			if gate ~= 0 and IsPedWalking(PlayerPedId()) or IsPedRunning(PlayerPedId()) or GetEntitySpeed(PlayerPedId()) >= Config.FreezeDistance then
				FreezeEntityPosition(gate, true)
			end
		end
		Citizen.Wait(Config.WaitingTime)
	end
end)