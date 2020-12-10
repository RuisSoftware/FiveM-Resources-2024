--[[------------------------------------------------------------------------
    Wapen recoil
------------------------------------------------------------------------]]--
onWeed = true
onCoke = false
onMeth = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wapen = GetCurrentPedWeapon(PlayerPedId())
			if Config.Recoils[wapen] and Config.Recoils[wapen] ~= 0 then
				a = 0
				if GetFollowPedCamViewMode() ~= 4 then -- third person
					repeat
						Wait(0)
						pitch = GetGameplayCamRelativePitch()
						if onWeed then
							local recoil = pitch+Config.Recoils[wapen]
							totalRecoil = recoil*Config.Multiplier.Weed
						elseif onCoke then
							local recoil = pitch+Config.Recoils[wapen]
							totalRecoil = recoil*Config.Multiplier.Coke
						elseif onMeth then
							local recoil = pitch+Config.Recoils[wapen]
							totalRecoil = recoil*Config.Multiplier.Meth
						else
							if Config.noDrugsRecoil then
								local recoil = pitch+Config.Recoils[wapen]
								totalRecoil = recoil*Config.Multiplier.noDrugs
							else
								totalRecoil = 0.0
							end
						end
						SetGameplayCamRelativePitch(totalRecoil, 0.2)
						a = a+0.1
					until a >= Config.Recoils[wapen]
				else -- first person
					repeat
						Wait(0)
						pitch = GetGameplayCamRelativePitch()
						if Config.Recoils[wapen] > 0.1 then
							local recoil = pitch+Config.Recoils[wapen]
							if onWeed then
								totalRecoil = recoil*Config.Multiplier.Weed
							elseif onCoke then
								totalRecoil = recoil*Config.Multiplier.Coke
							elseif onMeth then
								totalRecoil = recoil*Config.Multiplier.Meth
							else
								if Config.noDrugsRecoil then
									totalRecoil = recoil*Config.Multiplier.noDrugs
								else
									totalRecoil = 0.0
								end
							end
							SetGameplayCamRelativePitch(totalRecoil, 1.2)
							a = a+0.6
						else
							local recoil = pitch+0.016
							if onWeed then
								totalRecoil = recoil*Config.Multiplier.Weed
							elseif onCoke then
								totalRecoil = recoil*Config.Multiplier.Coke
							elseif onMeth then
								totalRecoil = recoil*Config.Multiplier.Meth
							else
								if Config.noDrugsRecoil then
									totalRecoil = recoil*Config.Multiplier.noDrugs
								else
									totalRecoil = 0.0
								end
							end
							SetGameplayCamRelativePitch(totalRecoil, 0.333)
							a = a+0.1
						end
					until a >= Config.Recoils[wapen]
				end
			end
		end
	end
end)

RegisterNetEvent('DP_Recoil:usedWeed')
AddEventHandler('DP_Recoil:usedWeed', function()
	onWeed = true
	Citizen.CreateThread(function()
		while onWeed do
			print('onWeed nu true')
			Wait(6000)
			onWeed = false
			print('onWeed nu false')
		end
	end)
end)

RegisterNetEvent('DP_Recoil:usedMeth')
AddEventHandler('DP_Recoil:usedMeth', function()
	onMeth = true
	Citizen.CreateThread(function()
		while onMeth do
			Wait(6000)
			onMeth = false
		end
	end)
end)

RegisterNetEvent('DP_Recoil:usedCoke')
AddEventHandler('DP_Recoil:usedCoke', function()
	onCoke = true
	Citizen.CreateThread(function()
		while onCoke do
			Wait(6000)
			onCoke = false
		end
	end)
end)

TriggerEvent('DP_Recoil:usedWeed')