if Config.UseVIP then -- gebruik ESX indien VIP = true.
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end
pedId = PlayerPedId()
statusVIP = nil
xSound = exports.xsound
local musicId
local playing = false
local janee = false

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    musicId = "player" .. pedId
    local pos
    while true do
        Citizen.Wait(100)
        if xSound:soundExists(musicId) and playing then
            if xSound:isPlaying(musicId) then
                pos = GetEntityCoords(pedId)
                TriggerServerEvent("DP_Radio:soundStatus", "position", musicId, { position = pos })
            else
                Citizen.Wait(Config.PositionSyncInterval)
            end
        else
            Citizen.Wait(Config.PositionSyncInterval)
        end
    end
end)

RegisterCommand(Config.Commands.MP3, function(source, args, rawCommand)
	if isVIP() then
		if IsPedInAnyVehicle(pedId) then
			local vehId = GetVehiclePedIsIn(pedId, false)
			musicId = "vehicle"..vehId
			if heeftItem('vehicle') then
				if string.match(rawCommand, 'mp3 ') then
					local url = string.sub(rawCommand, 4)
					local pos = GetEntityCoords(pedId)
					playing = true
					TriggerServerEvent("DP_Radio:soundStatus", "play", musicId, { position = pos, link = url })
				else
					print('Ongeldige URL')
				end
			else
				print('Geen item HIFI')
			end
		else
			musicId = "player" .. pedId
			if heeftItem('pocket') then
				if string.match(rawCommand, 'mp3 ') then
					local url = string.sub(rawCommand, 4)
					local pos = GetEntityCoords(pedId)
					playing = true
					TriggerServerEvent("DP_Radio:soundStatus", "play", musicId, { position = pos, link = url })
				else
					print('Ongeldige URL')
				end
			else
				print('Geen item HIFI')
			end
		end
	else
		print('Je bent geen VIP')
	end
end, false)

RegisterCommand(Config.Commands.MP4, function(source, args, rawCommand)
	if isVIP() then
		if IsPedInAnyVehicle(pedId) then
			local vehId = GetVehiclePedIsIn(pedId, false)
			musicId = "vehicle"..vehId
			if heeftItem('vehicle') then
				if string.match(rawCommand, 'mp4 ') then
					local url = string.sub(rawCommand, 4)
					local pos = GetEntityCoords(pedId)
					playing = true
					TriggerServerEvent("DP_Radio:soundStatus", "play", musicId, { position = pos, link = url })
				else
					print('Ongeldige URL')
				end
			else
				print('Geen item HIFI')
			end
		else
			musicId = "player" .. pedId
			if heeftItem('pocket') then
				if string.match(rawCommand, 'mp4 ') then
					local url = string.sub(rawCommand, 4)
					local pos = GetEntityCoords(pedId)
					playing = true
					TriggerServerEvent("DP_Radio:soundStatus", "play", musicId, { position = pos, link = url })
				else
					print('Ongeldige URL')
				end
			else
				print('Geen item HIFI')
			end
		end
	else
		print('Je bent geen VIP')
	end
end, false)

RegisterCommand(Config.Commands.YoutubeLong, function(source, args, rawCommand)
	if args[1] then
		if isVIP() then
			if IsPedInAnyVehicle(pedId) then
				local vehId = GetVehiclePedIsIn(pedId, false)
				musicId = "vehicle"..vehId
				if heeftItem('vehicle') then
					local url = "https://www.youtube.com/watch?v=" .. args[1]
					local pos = GetEntityCoords(pedId)
					playing = true
					TriggerServerEvent("DP_Radio:soundStatus", "play", musicId, { position = pos, link = url })
				else
					print('Geen item HIFI')
				end
			else
				musicId = "player" .. pedId
				if heeftItem('pocket') then
					local url = "https://www.youtube.com/watch?v=" .. args[1]
					local pos = GetEntityCoords(pedId)
					playing = true
					TriggerServerEvent("DP_Radio:soundStatus", "play", musicId, { position = pos, link = url })
				else
					print('Geen item HIFI')
				end
			end
		else
			print('Je bent geen VIP')
		end
	else
		print('Ongeldig ID')
	end
end, false)

RegisterCommand(Config.Commands.YoutubeShort, function(source, args, rawCommand)
	if args[1] then
		if isVIP() then
			if IsPedInAnyVehicle(pedId) then
				local vehId = GetVehiclePedIsIn(pedId, false)
				musicId = "vehicle"..vehId
				if heeftItem('vehicle') then
					local url = "https://www.youtube.com/watch?v=" .. args[1]
					local pos = GetEntityCoords(pedId)
					playing = true
					TriggerServerEvent("DP_Radio:soundStatus", "play", musicId, { position = pos, link = url })
				else
					print('Geen item HIFI')
				end
			else
				musicId = "player" .. pedId
				if heeftItem('pocket') then
					local url = "https://www.youtube.com/watch?v=" .. args[1]
					local pos = GetEntityCoords(pedId)
					playing = true
					TriggerServerEvent("DP_Radio:soundStatus", "play", musicId, { position = pos, link = url })
				else
					print('Geen item HIFI')
				end
			end
		else
			print('Je bent geen VIP')
		end
	else
		print('Ongeldig ID')
	end
end, false)

RegisterCommand(Config.Commands.StopRadioLong, function(source, args, rawCommand)
	TriggerServerEvent("DP_Radio:soundStatus", "stop", musicId)
end)

RegisterCommand(Config.Commands.StopRadioShort, function(source, args, rawCommand)
	TriggerServerEvent("DP_Radio:soundStatus", "stop", musicId)
end)

RegisterCommand(Config.Commands.VolumeLong, function(source, args, rawCommand)
	local _source = source
	local volume = tonumber(args[1])
	if volume < 0 or volume > 100 then
		print('Volume minimaal 1 en maximaal 100!')
	else
		TriggerServerEvent("DP_Radio:soundStatus", "volume", musicId, volume)
	end
end)

RegisterCommand(Config.Commands.VolumeShort, function(source, args, rawCommand)
	local _source = source
	local volume = tonumber(args[1])
	if volume < 0 or volume > 100 then
		print('Volume minimaal 1 en maximaal 100!')
	else
		TriggerServerEvent("DP_Radio:soundStatus", "volume", musicId, volume)
	end
end)

RegisterNetEvent("DP_Radio:soundStatus")
AddEventHandler("DP_Radio:soundStatus", function(type, musicId, data)
    if type == "position" then
        if xSound:soundExists(musicId) then
            xSound:Position(musicId, data.position)
        end
    end

    if type == "play" then
        xSound:PlayUrlPos(musicId, data.link, 1, data.position)
        xSound:Distance(musicId, 20)
    end

    if type == "stop" then
		xSound:Destroy(musicId)
    end

    if type == "volume" then
		xSound:setVolume(musicId, data/100)
    end
end)

function heeftItem(type) -- check for item count. Without ESX, always true.
	if Config.UseESX then
		ESX.TriggerServerCallback('DP_Radio:heeftItem', function(data)
			if data then
				janee = true
			else
				janee = false
			end
		end, GetPlayerServerId(pedId), type)
	else
		janee = true
	end
	return janee
end

function isVIP() -- check for VIP status. Without pxrp_vip, always true.
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