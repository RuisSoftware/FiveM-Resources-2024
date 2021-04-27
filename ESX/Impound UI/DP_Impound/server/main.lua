ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

ESX.RegisterServerCallback('DP_Impound:loadVehicles', function(source, cb)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	local vehicles = {}
	MySQL.Async.fetchAll('SELECT plate, vehicle FROM owned_vehicles WHERE owner = @owner AND stored = 0', {['@owner'] = x.identifier}, function(vehicles)
		cb(vehicles)
	end)
end)

ESX.RegisterServerCallback('DP_Impound:laadPrijzen1', function(source, cb)
	MySQL.Async.fetchAll('SELECT price, model, name FROM vehicles', {
	}, function(result)
		if result then
			cb(result)
		else
			cb(nil)
		end
	end)
end)

--[[ESX.RegisterServerCallback('DP_Impound:laadPrijzen3', function(source, cb)
	MySQL.Async.fetchAll('SELECT price, model, name FROM vs_cars', {
	}, function(result)
		if result then
			cb(result)
		else
			cb(nil)
		end
	end)
end)]]

ESX.RegisterServerCallback('DP_Impound:laadPrijs1', function(source, cb, model)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	local geld = x.getAccount('bank').money
	MySQL.Async.fetchScalar('SELECT price FROM vehicles WHERE model = @model', {
		['@model'] = model
	}, function(result)
		if result then
			if geld >= result*0.01 then
				x.removeAccountMoney('bank', result*0.01)
				cb(true)
			else
				cb('Je hebt niet genoeg geld.')
			end
		else
			cb('Ongeldig voertuig.')
		end
	end)
end)

--[[ESX.RegisterServerCallback('DP_Impound:laadPrijs3', function(source, cb, model)
	local s = source
	local x = ESX.GetPlayerFromId(s)
	local geld = x.getAccount('bank').money
	
	MySQL.Async.fetchScalar('SELECT price FROM vs_cars WHERE model = @model', {
		['@model'] = model
	}, function(result)
		if result then
			if geld >= result*0.01 then
				x.removeAccountMoney('bank', result*0.01)
				cb(true)
			else
				cb('Je hebt niet genoeg geld.')
			end
		else
			x.removeAccountMoney('bank', 100)
			cb(true)
		end
	end)
end)]]

ESX.RegisterServerCallback('DP_Impound:loadVehicle', function(source, cb, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(vehicle)
		cb(vehicle)
	end)
end)

ESX.RegisterServerCallback('DP_Impound:isOwned', function(source, cb, plate)
	
	local s = source
	local x = ESX.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate AND owner = @owner', {['@plate'] = plate, ['@owner'] = x.identifier}, function(vehicle)
		if next(vehicle) then
			cb(true)
		else
			cb(false)
		end
	end)
end)

 RegisterNetEvent('DP_Impound:changeState')
 AddEventHandler('DP_Impound:changeState', function(plate, state)
 	MySQL.Sync.execute("UPDATE owned_vehicles SET stored=@state WHERE plate=@plate", {['@state'] = state, ['@plate'] = plate})
 end)
 
--RegisterNetEvent('fd_impound:changeState')
--AddEventHandler('fd_impound:changeState', function(plate, state)
--	MySQL.Sync.execute("UPDATE owned_vehicles SET state=@state = '0' WHERE plate=@plate", {['@state'] = state, ['@plate'] = plate})
--end)


RegisterNetEvent('DP_Impound:saveProps')
AddEventHandler('DP_Impound:saveProps', function(plate, props)
	local xProps = json.encode(props)
	MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@props WHERE plate=@plate", {['@plate'] = plate, ['@props'] = xProps})
end)