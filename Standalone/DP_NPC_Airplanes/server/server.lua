if Config.UseESX then
	ESX = nil
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	RegisterServerEvent("airports:payTicket")
	AddEventHandler("airports:payTicket", function(x, y, z, heading, start, destination, price)
		if Config.UseESX then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			
			if xPlayer.getAccount('money').money >= price then
				xPlayer.removeAccountMoney('money', price)
				TriggerClientEvent("airports:departure", _source, x, y, z, heading, start, destination)
			elseif xPlayer.getAccount('bank').money >= price then
				xPlayer.removeAccountMoney('bank', price)
				TriggerClientEvent("airports:departure", _source, x, y, z, heading, start, destination)
			else
				TriggerClientEvent("airports:moneyInvalid", _source)
			end
		end		
	end)
end