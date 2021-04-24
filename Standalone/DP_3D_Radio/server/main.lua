if Config.UseESX then -- gebruik ESX indien VIP = true.
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterCommand('youtube', function(source, args, rawCommand)
	local _source = source
	if Config.UseESX then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local item = xPlayer.getInventoryItem('hifi').count
	else
		local item = 1
	end
	if item > 0 then
		TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1], true)
	else
		TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1], false)
	end
end)

RegisterCommand('yt', function(source, args, rawCommand)
	local _source = source
	if Config.UseESX then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local item = xPlayer.getInventoryItem('hifi').count
	else
		local item = 1
	end
	if item > 0 then
		TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1], true)
	else
		TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1], false)
	end
end)

RegisterCommand('mp3', function(source, args, rawCommand)
	local _source = source
	if Config.UseESX then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local item = xPlayer.getInventoryItem('hifi').count
	else
		local item = 1
	end
	if string.match(rawCommand, 'mp3 ') then
		local url = string.sub(rawCommand, 4)
		if item > 0 then
			TriggerClientEvent('DP_Radio:speelMP3', _source, url, true)
		else
			TriggerClientEvent('DP_Radio:speelMP3', _source, url, false)
		end
	end
end)

RegisterCommand('mp4', function(source, args, rawCommand)
	local _source = source
	if Config.UseESX then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local item = xPlayer.getInventoryItem('hifi').count
	else
		local item = 1
	end
	if string.match(rawCommand, 'mp4 ') then
		local url = string.sub(rawCommand, 4)
		if item > 0 then
			TriggerClientEvent('DP_Radio:speelMP3', _source, url, true)
		else
			TriggerClientEvent('DP_Radio:speelMP3', _source, url, false)
		end
	end
end)

RegisterCommand('stopradio', function(source, args, rawCommand)
	local _source = source
	TriggerClientEvent('DP_Radio:stop', _source)
end)

RegisterCommand('volume', function(source, args, rawCommand)
	local _source = source
	local volume = tonumber(args[1])
	if volume < 0 or volume > 100 then
		print('Volume minimaal 1 en maximaal 100!')
	else
		TriggerClientEvent('DP_Radio:volume', _source, volume)
	end
end)

RegisterCommand('v', function(source, args, rawCommand)
	local _source = source
	local volume = tonumber(args[1])
	if volume < 0 or volume > 100 then
		print('Volume minimaal 1 en maximaal 100!')
	else
		TriggerClientEvent('DP_Radio:volume', _source, volume)
	end
end)