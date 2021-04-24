DP = nil
TriggerEvent('dp:getSharedObject', function(obj) DP = obj end)

RegisterCommand('youtube', function(source, args, rawCommand)
	local _source = source
	TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1])
end)

RegisterCommand('yt', function(source, args, rawCommand)
	local _source = source
	TriggerClientEvent('DP_Radio:speelYoutube', _source, args[1])
end)

RegisterCommand('mp3', function(source, args, rawCommand)
	local _source = source
	if string.match(rawCommand, 'mp3 ') then
		local url = string.sub(rawCommand, 4)
		TriggerClientEvent('DP_Radio:speelMP3', _source, url)
	end
end)

RegisterCommand('mp4', function(source, args, rawCommand)
	local _source = source
	if string.match(rawCommand, 'mp4 ') then
		local url = string.sub(rawCommand, 4)
		TriggerClientEvent('DP_Radio:speelMP3', _source, url)
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