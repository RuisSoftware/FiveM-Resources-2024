if Config.UseVIP then -- gebruik ESX indien VIP = true.
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

youtubeId = nil
MP3Id = nil
pedId = GetPlayerPed(-1)
statusVIP = nil
xSound = exports.xsound

RegisterNetEvent('DP_Radio:speelYoutube')
AddEventHandler('DP_Radio:speelYoutube', function(url, pocketRadio, carRadio)
	if isVIP() then
		if IsPedInAnyVehicle(pedId) and carRadio then
			local vehId = GetVehiclePedIsIn(pedId, false)
			youtubeId = "youtube-"..vehId
			xSound:PlayUrlPos(youtubeId ,"https://www.youtube.com/watch?v=" .. url, 1, GetEntityCoords(vehId))
			xSound:onPlayStart(youtubeId, function()
				CreateThread(function()
					while true do
						Wait(200)
						if youtubeId == nil then
							break
						else
							xSound:Position(youtubeId, GetEntityCoords(vehId))
						end
					end
				end)
			end)
		else
			if pocketRadio then
				youtubeId = "youtube-"..pedId
				xSound:PlayUrlPos(youtubeId ,"https://www.youtube.com/watch?v=" .. url, 1, GetEntityCoords(pedId))
				xSound:onPlayStart(youtubeId, function()
					CreateThread(function()
						while true do
							Wait(200)
							if youtubeId == nil then
								break
							else
								xSound:Position(youtubeId, GetEntityCoords(pedId))
							end
						end
					end)
				end)
			else
				exports['t-notify']:SendTextAlert('error', "Om buiten een voertuig radio te beluisteren heb je een radio item nodig.", 5500, true)
			end
		end
	else
		exports['t-notify']:SendTextAlert('error', "Je bent geen VIP bewoner. Bezoek onze Discord voor meer informatie.", 5500, true)
	end
end)

RegisterNetEvent('DP_Radio:speelMP3')
AddEventHandler('DP_Radio:speelMP3', function(url, pocketRadio, carRadio)
	if isVIP() then
		if IsPedInAnyVehicle(pedId) and carRadio then
			local vehId = GetVehiclePedIsIn(pedId, false)
			MP3Id = "MP3-"..vehId
			xSound:PlayUrlPos(MP3Id , url, 1, GetEntityCoords(vehId))
			xSound:onPlayStart(MP3Id, function()
				CreateThread(function()
					while true do
						Wait(200)
						if MP3Id == nil then
							break
						else
							xSound:Position(MP3Id, GetEntityCoords(vehId))
						end
					end
				end)
			end)
		else
			if pocketRadio then
				MP3Id = "MP3-"..pedId
				xSound:PlayUrlPos(MP3Id , url, 1, GetEntityCoords(pedId))
				xSound:onPlayStart(MP3Id, function()
					CreateThread(function()
						while true do
							Wait(200)
							if MP3Id == nil then
								break
							else
								xSound:Position(MP3Id, GetEntityCoords(pedId))
							end
						end
					end)
				end)
			else
				exports['t-notify']:SendTextAlert('error', "Om buiten een voertuig radio te beluisteren heb je een radio item nodig.", 5500, true)
			end
		end
	else
		exports['t-notify']:SendTextAlert('error', "Je bent geen VIP bewoner. Bezoek onze Discord voor meer informatie.", 5500, true)
	end
end)

RegisterNetEvent('DP_Radio:volume')
AddEventHandler('DP_Radio:volume', function(volume)
	--if xSound.soundExists(youtubeId) then
	if youtubeId ~= nil then
		xSound:setVolume(youtubeId, volume/100)
		print('YouTube volume ingesteld op: ' .. volume)
	end
	if MP3Id ~= nil then
	--if xSound.soundExists(MP3Id) then
		xSound:setVolume(MP3Id, volume/100)
		print('MP3 volume ingesteld op: ' .. volume)
	end
end)

RegisterNetEvent('DP_Radio:stop')
AddEventHandler('DP_Radio:stop', function()
	--if xSound.soundExists(youtubeId) then
	if youtubeId ~= nil then
		xSound:Destroy(youtubeId)
		print('Radio gestopt: '..youtubeId)
		youtubeId = nil
	end
	if MP3Id ~= nil then
		xSound:Destroy(MP3Id)
		print('Radio gestopt: '..MP3Id)
		MP3Id = nil
	end
	--end
end)

function isVIP()
	if Config.UseVIP then
		ESX.TriggerServerCallback('pxrp_vip:getVIPStatus', function(isVIP)
			if isVIP then
				statusVIP = true
			else
				statusVIP = false
			end
		end, GetPlayerServerId(pedId), '1')
	else
		statusVIP = true
	end
	while statusVIP == nil do
		Wait(0)
	end
	return statusVIP
end