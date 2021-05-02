if Config.UseESX then
	DP = nil
	TriggerEvent('dp:getSharedObject', function(obj) DP = obj end)

	RegisterServerEvent("airports:payTicket")
	AddEventHandler("airports:payTicket", function(x, y, z, heading, destination, price)
		if Config.UseESX then
			local _source = source
			local xPlayer = DP.GetPlayerFromId(_source)
			
			if xPlayer.getAccount('money').money >= price then
				xPlayer.removeAccountMoney('money', price)
				TriggerClientEvent("airports:departure", _source, x, y, z, heading, destination)
			elseif xPlayer.getAccount('bank').money >= price then
				xPlayer.removeAccountMoney('bank', price)
				TriggerClientEvent("airports:departure", _source, x, y, z, heading, destination)
			else
				TriggerClientEvent("airports:moneyInvalid", _source)
			end
		end		
	end)
end