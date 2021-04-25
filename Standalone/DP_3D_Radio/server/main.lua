if Config.UseESX then -- gebruik ESX indien VIP = true.
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

RegisterCommand('youtube', function(source, args, rawCommand)
	local _source = source
	if Config.UseESX then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local pocketRadio = xPlayer.getInventoryItem(Config.PocketItem).count
		local carRadio = xPlayer.getInventoryItem(Config.CarItem).count
		if pocketRadio > 0 then
			pocketRadio = true
		end
		if carRadio > 0 then
			carRadio = true
		end
		TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1], pocketRadio, carRadio)
	else
		TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1], true, true)
	end
end)

RegisterCommand('yt', function(source, args, rawCommand)
	local _source = source
	if Config.UseESX then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local pocketRadio = xPlayer.getInventoryItem(Config.PocketItem).count
		local carRadio = xPlayer.getInventoryItem(Config.CarItem).count
		if pocketRadio > 0 then
			pocketRadio = true
		end
		if carRadio > 0 then
			carRadio = true
		end
		TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1], pocketRadio, carRadio)
	else
		TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1], true, true)
	end
end)

RegisterCommand('mp3', function(source, args, rawCommand)
	local _source = source
	if Config.UseESX then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local pocketRadio = xPlayer.getInventoryItem(Config.PocketItem).count
		local carRadio = xPlayer.getInventoryItem(Config.CarItem).count
		if pocketRadio > 0 then
			pocketRadio = true
		end
		if carRadio > 0 then
			carRadio = true
		end
		if string.match(rawCommand, 'mp3 ') then
			local url = string.sub(rawCommand, 4)
			TriggerClientEvent('DP_Radio:speelMP3', _source, url, pocketRadio, carRadio)
		end
	else
		if string.match(rawCommand, 'mp3 ') then
			local url = string.sub(rawCommand, 4)
			TriggerClientEvent('DP_Radio:speelMP3', _source, url, true, true)
		end
	end
end)

RegisterCommand('mp4', function(source, args, rawCommand)
	local _source = source
	if Config.UseESX then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local pocketRadio = xPlayer.getInventoryItem(Config.PocketItem).count
		local carRadio = xPlayer.getInventoryItem(Config.CarItem).count
		if pocketRadio > 0 then
			pocketRadio = true
		end
		if carRadio > 0 then
			carRadio = true
		end
		if string.match(rawCommand, 'mp4 ') then
			local url = string.sub(rawCommand, 4)
			TriggerClientEvent('DP_Radio:speelMP3', _source, url, pocketRadio, carRadio)
		end
	else
		if string.match(rawCommand, 'mp4 ') then
			local url = string.sub(rawCommand, 4)
			TriggerClientEvent('DP_Radio:speelMP3', _source, url, true, true)
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
	TriggerClientEvent('DP_Radio:volume', _source, volume)
end)

RegisterCommand('v', function(source, args, rawCommand)
	local _source = source
	local volume = tonumber(args[1])
	TriggerClientEvent('DP_Radio:volume', _source, volume)
end)
