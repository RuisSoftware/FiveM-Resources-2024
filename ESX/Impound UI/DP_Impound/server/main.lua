DP = nil

TriggerEvent('dp:getSharedObject', function(obj)
	DP = obj
end)

DP.RegisterServerCallback('DP_Impound:loadVehicles', function(source, cb)
	
	local s = source
	local x = DP.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT plate, vehicle FROM owned_vehicles WHERE owner = @owner AND stored = 0', {['@owner'] = x.identifier}, function(vehicles)

		cb(vehicles)
	end)
end)

DP.RegisterServerCallback('DP_Impound:loadVehicle', function(source, cb, plate)
	
	local s = source
	local x = DP.GetPlayerFromId(s)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {['@plate'] = plate}, function(vehicle)
		cb(vehicle)
	end)
end)

DP.RegisterServerCallback('DP_Impound:isOwned', function(source, cb, plate)
	
	local s = source
	local x = DP.GetPlayerFromId(s)
	
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


RegisterNetEvent('DP_Impound:saveProps')
AddEventHandler('DP_Impound:saveProps', function(plate, props)
	local xProps = json.encode(props)
	MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle=@props WHERE plate=@plate", {['@plate'] = plate, ['@props'] = xProps})
end)