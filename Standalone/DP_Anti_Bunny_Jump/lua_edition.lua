Citizen.CreateThread(function()
	while true do
		if IsPedJumping(GetPlayerPed(-1)) then
			gesprongen = true
			Wait(2500)
			gesprongen = false
		else
			Wait(0)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if gesprongen then
			DisableControlAction(0,22,true)
		end
	end
end)