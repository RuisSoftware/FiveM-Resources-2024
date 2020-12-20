RegisterNetEvent('esx_opdrachten:updateOpdracht1') -- Opdracht 1 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht1')
AddEventHandler('esx_opdrachten:updateOpdracht1', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht1 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht1 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht1` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 1 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 1 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht2') -- Opdracht 2 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht2')
AddEventHandler('esx_opdrachten:updateOpdracht2', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht2 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht2 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht2` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 2 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 2 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht3') -- Opdracht 3 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht3')
AddEventHandler('esx_opdrachten:updateOpdracht3', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht3 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht3 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht3` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 3 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 3 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht4') -- Opdracht 4 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht4')
AddEventHandler('esx_opdrachten:updateOpdracht4', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht4 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht4 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht4` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 4 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 4 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht5') -- Opdracht 5 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht5')
AddEventHandler('esx_opdrachten:updateOpdracht5', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht5 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht5 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht5` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 5 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 5 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht6') -- Opdracht 6 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht6')
AddEventHandler('esx_opdrachten:updateOpdracht6', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht6 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht6 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht6` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 6 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 6 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht7') -- Opdracht 7 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht7')
AddEventHandler('esx_opdrachten:updateOpdracht7', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht7 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht7 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht7` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 7 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
			TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 7 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht8') -- Opdracht 8 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht8')
AddEventHandler('esx_opdrachten:updateOpdracht8', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht8 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht8 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht8` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 8 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 8 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht9') -- Opdracht 9 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht9')
AddEventHandler('esx_opdrachten:updateOpdracht9', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht9 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht9 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht9` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 9 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 9 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht10') -- Opdracht 10 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht10')
AddEventHandler('esx_opdrachten:updateOpdracht10', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht10 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht10 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht10` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 10 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 10 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht11') -- Opdracht 11 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht11')
AddEventHandler('esx_opdrachten:updateOpdracht11', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht11 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht11 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht11` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 11 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 11 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht12') -- Opdracht 12 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht12')
AddEventHandler('esx_opdrachten:updateOpdracht12', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht12 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht12 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht12` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 12 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 12 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht13') -- Opdracht 13 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht13')
AddEventHandler('esx_opdrachten:updateOpdracht13', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht13 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht13 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht13` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 13 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 13 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht14') -- Opdracht 14 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht14')
AddEventHandler('esx_opdrachten:updateOpdracht14', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht14 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht14 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht14` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 14 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 14 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht15') -- Opdracht 15 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht15')
AddEventHandler('esx_opdrachten:updateOpdracht15', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht15 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht15 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht15` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 15 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 15 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht16') -- Opdracht 16 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht16')
AddEventHandler('esx_opdrachten:updateOpdracht16', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht16 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht16 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht16` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 16 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 16 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht17') -- Opdracht 17 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht17')
AddEventHandler('esx_opdrachten:updateOpdracht17', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht17 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht17 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht17` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 17 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 17 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht18') -- Opdracht 18 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht18')
AddEventHandler('esx_opdrachten:updateOpdracht18', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht18 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht18 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht18` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 18 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 18 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht19') -- Opdracht 19 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht19')
AddEventHandler('esx_opdrachten:updateOpdracht19', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht19 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht19 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht19` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 19 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 19 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht20') -- Opdracht 20 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht20')
AddEventHandler('esx_opdrachten:updateOpdracht20', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht20 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht20 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht20` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 20 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 20 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht21') -- Opdracht 21 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht21')
AddEventHandler('esx_opdrachten:updateOpdracht21', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht21 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht21 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht21` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 21 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 21 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht22') -- Opdracht 22 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht22')
AddEventHandler('esx_opdrachten:updateOpdracht22', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht22 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht22 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht22` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 22 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 22 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht23') -- Opdracht 23 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht23')
AddEventHandler('esx_opdrachten:updateOpdracht23', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht23 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht23 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht23` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 23 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 23 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht24') -- Opdracht 24 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht24')
AddEventHandler('esx_opdrachten:updateOpdracht24', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht24 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht24 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht24` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 24 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 24 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht25') -- Opdracht 25 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht25')
AddEventHandler('esx_opdrachten:updateOpdracht25', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht25 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht25 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht25` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 25 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 25 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht26') -- Opdracht 26 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht26')
AddEventHandler('esx_opdrachten:updateOpdracht26', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht26 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht26 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht26` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 26 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 26 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht27') -- Opdracht 27 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht27')
AddEventHandler('esx_opdrachten:updateOpdracht27', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht27 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht27 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht27` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 27 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 27 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht28') -- Opdracht 28 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht28')
AddEventHandler('esx_opdrachten:updateOpdracht28', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht28 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht28 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht28` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 28 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 28 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht29') -- Opdracht 29 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht29')
AddEventHandler('esx_opdrachten:updateOpdracht29', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht29 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht29 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht29` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 29 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 29 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht30') -- Opdracht 30 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht30')
AddEventHandler('esx_opdrachten:updateOpdracht30', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht30 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht30 ~= Config.VoltooidNaam then
		local voltooidOpdracht30 = 'Behaald'
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht30` = @voltooidOpdracht30 WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht30'] = voltooidOpdracht30
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 30 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 30 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht31') -- Opdracht 31 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht31')
AddEventHandler('esx_opdrachten:updateOpdracht31', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht31 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht31 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht31` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 31 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 31 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht32') -- Opdracht 32 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht32')
AddEventHandler('esx_opdrachten:updateOpdracht32', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht32 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht32 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht32` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 32 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 32 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht33') -- Opdracht 33 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht33')
AddEventHandler('esx_opdrachten:updateOpdracht33', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht33 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht33 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht33` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 33 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 33 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht34') -- Opdracht 34 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht34')
AddEventHandler('esx_opdrachten:updateOpdracht34', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht34 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht34 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht34` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 34 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 34 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht35') -- Opdracht 35 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht35')
AddEventHandler('esx_opdrachten:updateOpdracht35', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht35 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht35 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht35` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 35 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 35 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht36') -- Opdracht 36 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht36')
AddEventHandler('esx_opdrachten:updateOpdracht36', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht36 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht36 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht36` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 36 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 36 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht37') -- Opdracht 37 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht37')
AddEventHandler('esx_opdrachten:updateOpdracht37', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht37 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht37 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht37` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 37 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 37 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht38') -- Opdracht 38 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht38')
AddEventHandler('esx_opdrachten:updateOpdracht38', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht38 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht38 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht38` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 38 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 38 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht39') -- Opdracht 39 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht39')
AddEventHandler('esx_opdrachten:updateOpdracht39', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht39 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht39 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht39` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 39 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 39 zojuist behaald!')
		end
	end
end)

RegisterNetEvent('esx_opdrachten:updateOpdracht40') -- Opdracht 40 is klaar. TriggerServerEvent('esx_opdrachten:updateOpdracht40')
AddEventHandler('esx_opdrachten:updateOpdracht40', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local result = MySQL.Sync.fetchAll('SELECT opdracht40 FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	if result[1].opdracht40 ~= Config.VoltooidNaam then
		local voltooidOpdracht = Config.VoltooidNaam
		MySQL.Async.execute('UPDATE opdrachten SET `opdracht40` = @voltooidOpdracht WHERE identifier = @eigenaar', {
			['@eigenaar'] = xPlayer.identifier,
			['@voltooidOpdracht'] = voltooidOpdracht
		})
		if Config.Prijs == true then
			xPlayer.addAccountMoney('bank', Config.PrijsStartersOpdrachten)
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 40 zojuist behaald en ' .. Config.PrijsStartersOpdrachten .. ' gekregen!')
		else
		TriggerClientEvent('esx:showNotification', _source, 'Je hebt opdracht 40 zojuist behaald!')
		end
	end
end)