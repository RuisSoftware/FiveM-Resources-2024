RegisterNetEvent('esx_opdrachten:spelerBezoekt') -- Deze begint als speler is ingeladen. Word getriggerd via es_extended.
AddEventHandler('esx_opdrachten:spelerBezoekt', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local resultaat = MySQL.Sync.fetchAll('SELECT * FROM opdrachten WHERE identifier = @eigenaar', {
		['@eigenaar'] = xPlayer.identifier
	})
	--------------------
	if resultaat[1] == nil then
		MySQL.Async.execute('INSERT INTO opdrachten (`identifier`) VALUES (@eigenaar);', {
			['@eigenaar'] = xPlayer.identifier
		}, function ()
			--TriggerClientEvent('esx:showNotification', _source, "Je hebt opdracht 1 nog niet behaald.")
		end)
	end
	--------------------
	if resultaat[1] then
		if resultaat[1].opdracht1 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht1` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht2 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht2` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht3 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht3` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht4 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht4` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht5 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht5` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht6 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht6` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht7== nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht7` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht8 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht8` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht9 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht9` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht10 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht10` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht11 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht11` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht12 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht12` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht13 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht13` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht14 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht14` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht15 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht15` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht16 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht16` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht17== nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht17` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht18 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht18` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht19 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht19` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht20 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht20` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht21 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht21` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht22 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht22` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht23 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht23` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht24 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht24` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht25 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht25` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht26 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht26` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht27== nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht27` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht28 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht28` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht29 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht29` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht30 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht30` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht31 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht31` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht32 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht32` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht33 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht33` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht34 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht34` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht35 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht35` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht36 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht36` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht37== nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht37` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht38 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht38` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht39 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht39` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
		if resultaat[1].opdracht40 == nil then -- Update opdracht nil naar 0 indien deze in database op nil staat.
			local l = Config.NietVoltooidNaam
			MySQL.Async.execute('UPDATE opdrachten SET `opdracht40` = @l WHERE identifier = @eigenaar', {
				['@eigenaar'] = xPlayer.identifier,
				['@l'] = l
			})
		end
	end
	--------------------
end)

