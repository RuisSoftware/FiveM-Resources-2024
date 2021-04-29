if Config.UseESX then -- gebruik ESX indien VIP = true.
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	ESX.RegisterServerCallback('DP_Radio:heeftItem', function(source, cb, data, data2)
		local xPlayer = ESX.GetPlayerFromId(source)
		local count = 0
		if data2 == 'pocket' then
			count = xPlayer.getInventoryItem(Config.Items.Pocket).count
		elseif data2 == 'vehicle' then
			count = xPlayer.getInventoryItem(Config.Items.Vehicle).count
		else
			print('Onbekend type')
		end
		if count >= 1 then
			cb(true)
		else
			cb(false)
		end
	end)
end

RegisterNetEvent("DP_Radio:soundStatus")
AddEventHandler("DP_Radio:soundStatus", function(type, musicId, data)
	TriggerClientEvent("DP_Radio:soundStatus", -1, type, musicId, data)
end)