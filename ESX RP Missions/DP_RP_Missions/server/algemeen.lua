ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("esx_opdrachten:stuurStartersOpdrachten", function(source, cb)	
	local opdrachten = {}
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll("SELECT opdracht1, opdracht2, opdracht3, opdracht4, opdracht5, opdracht6, opdracht7, opdracht8, opdracht9, opdracht10 FROM opdrachten WHERE identifier = @identifier", { ["@identifier"] = xPlayer.identifier }, function(result)
		for i = 1, #result, 1 do
			table.insert(opdrachten, { opdracht1 = result[i].opdracht1, opdracht2 = result[i].opdracht2, opdracht3 = result[i].opdracht3, opdracht4 = result[i].opdracht4, opdracht5 = result[i].opdracht5, opdracht6 = result[i].opdracht6, opdracht7 = result[i].opdracht7, opdracht8 = result[i].opdracht8, opdracht9 = result[i].opdracht9, opdracht10 = result[i].opdracht10    })
		end
		cb(opdrachten)
	end)
end)

ESX.RegisterServerCallback("esx_opdrachten:stuurTweedeOpdrachten", function(source, cb)	
	local opdrachten = {}
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll("SELECT opdracht11, opdracht12, opdracht13, opdracht14, opdracht15, opdracht16, opdracht17, opdracht18, opdracht19, opdracht20 FROM opdrachten WHERE identifier = @identifier", { ["@identifier"] = xPlayer.identifier }, function(result)
		for i = 1, #result, 1 do
			table.insert(opdrachten, { opdracht11 = result[i].opdracht11, opdracht12 = result[i].opdracht12, opdracht13 = result[i].opdracht13, opdracht14 = result[i].opdracht14, opdracht15 = result[i].opdracht15, opdracht16 = result[i].opdracht16, opdracht17 = result[i].opdracht17, opdracht18 = result[i].opdracht18, opdracht19 = result[i].opdracht19, opdracht20 = result[i].opdracht20    })
		end

		cb(opdrachten)
	end)
end)

ESX.RegisterServerCallback("esx_opdrachten:stuurDerdeOpdrachten", function(source, cb)	
	local opdrachten = {}
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll("SELECT opdracht21, opdracht22, opdracht23, opdracht24, opdracht25, opdracht26, opdracht27, opdracht28, opdracht29, opdracht30 FROM opdrachten WHERE identifier = @identifier", { ["@identifier"] = xPlayer.identifier }, function(result)
		for i = 1, #result, 1 do
			table.insert(opdrachten, { opdracht21 = result[i].opdracht21, opdracht22 = result[i].opdracht22, opdracht23 = result[i].opdracht23, opdracht24 = result[i].opdracht24, opdracht25 = result[i].opdracht25, opdracht26 = result[i].opdracht26, opdracht27 = result[i].opdracht27, opdracht28 = result[i].opdracht28, opdracht29 = result[i].opdracht29, opdracht30 = result[i].opdracht30    })
		end
		cb(opdrachten)
	end)
end)

ESX.RegisterServerCallback("esx_opdrachten:stuurVierdeOpdrachten", function(source, cb)	
	local opdrachten = {}
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll("SELECT opdracht31, opdracht32, opdracht33, opdracht34, opdracht35, opdracht36, opdracht37, opdracht38, opdracht39, opdracht40 FROM opdrachten WHERE identifier = @identifier", { ["@identifier"] = xPlayer.identifier }, function(result)
		for i = 1, #result, 1 do
			table.insert(opdrachten, { opdracht31 = result[i].opdracht31, opdracht32 = result[i].opdracht32, opdracht33 = result[i].opdracht33, opdracht34 = result[i].opdracht34, opdracht35 = result[i].opdracht35, opdracht36 = result[i].opdracht36, opdracht37 = result[i].opdracht37, opdracht38 = result[i].opdracht38, opdracht39 = result[i].opdracht39, opdracht40 = result[i].opdracht40    })
		end
		cb(opdrachten)
	end)
end)

AddEventHandler('playerDropped', function()
	-- Bewaar de bron voor het geval we deze verliezen (wat vaak gebeurt)
	local playerId = source

	-- Heeft de speler ooit meegedaan?
	if playerId then
		local xPlayer = ESX.GetPlayerFromId(playerId)

		-- Is het de moeite waard om alle clients te vertellen dat ze moeten vernieuwen?
		if xPlayer then
			Citizen.Wait(5000)
		end
	end
end)