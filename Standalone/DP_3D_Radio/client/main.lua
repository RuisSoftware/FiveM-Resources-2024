DP = nil
youtubeId = nil
MP3Id = nil
TriggerEvent('dp:getSharedObject', function(obj) DP = obj end)

xSound = exports.xsound

RegisterNetEvent('DP_Radio:speelYoutube')
AddEventHandler('DP_Radio:speelYoutube', function(url)
	local pedId = GetPlayerPed(-1)

	if IsPedInAnyVehicle(pedId) then
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
	end
end)

RegisterNetEvent('DP_Radio:speelMP3')
AddEventHandler('DP_Radio:speelMP3', function(url)
	local pedId = GetPlayerPed(-1)
	
	if IsPedInAnyVehicle(pedId) then
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
	end
end)

RegisterNetEvent('DP_Radio:volume')
AddEventHandler('DP_Radio:volume', function(volume)
	--if xSound.soundExists(id) then
		xSound:setVolume(id, volume/100)
		print('Volume ingesteld op: '..volume)
	--end
end)

RegisterNetEvent('DP_Radio:stop')
AddEventHandler('DP_Radio:stop', function()
	--if xSound.soundExists(id) then
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