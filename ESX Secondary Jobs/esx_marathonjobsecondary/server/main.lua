ESX = nil
MarathonTimes = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('onMySQLReady', function()
	MySQL.Async.fetchAll(	
	'SELECT * FROM marathon_times WHERE 1',
    {},
    function (result)								
      for i = 1, #result, 1 do
        table.insert(MarathonTimes, result[i])
      end
    end)
end)


ESX.RegisterServerCallback('esx_marathonjobsecondary:getTimes', function(source, cb, gang)
	cb(MarathonTimes)
end)

RegisterServerEvent('esx_marathonjobsecondary:onRecord')
AddEventHandler('esx_marathonjobsecondary:onRecord', function(track, laptime)						
	
	local _track = track
	local _laptime = laptime
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _runner = GetPlayerName(_source)
	
	Citizen.Trace("Tourrecord " .. _track .. ", naam :" .. GetPlayerName(source) .. " laptime: " .. _laptime .. "\n")
	
	local found = false
	local record = false
	
	for i = 1, #MarathonTimes, 1 do
		if MarathonTimes[i].track == _track then
			found = true
			if MarathonTimes[i].laptime > _laptime then
				record = true
				MarathonTimes[i].laptime = _laptime
				MarathonTimes[i].runner = _runner
			end
			break
		end
	end
	
	if not found then
		table.insert(MarathonTimes, {id = -1, track = _track, runner = _runner, laptime = _laptime})
		xPlayer.addMoney(11000)
		TriggerClientEvent('esx:showNotification', _source, '~g~Nieuw ~w~record~y~!!!~g~+~y~5000~g~€ ~w~bonus!')
		Citizen.Trace("Lap record inserted!\n")
		MySQL.Async.execute(
		'INSERT INTO `marathon_times` (`track`, `runner`, `laptime`) VALUES (@track, @runner, @laptime)',
		{
			['@track']   = _track,
			['@runner'] = _runner,
			['@laptime'] = _laptime
		})	
	elseif found and record then
		table.insert(MarathonTimes, {id = -1 , track = _track, runner = _runner, laptime = _laptime})
		xPlayer.addMoney(11000)
		TriggerClientEvent('esx:showNotification', _source, '~g~Versla het record! ~g~+~w~5000~g~€ ~w~bonus!')
		Citizen.Trace("Lap record updated!\n")
		MySQL.Async.execute(
		'UPDATE `marathon_times` SET laptime = @laptime, runner = @runner WHERE track = @track',
		{
			['@laptime']   = _laptime,
			['@runner'] = _runner,
			['@track'] = _track
		})
	else
		TriggerClientEvent('esx:showNotification', _source, '~w~Helaas zijn je records ~r~ verslagen!')
	end
end)

RegisterServerEvent('esx_marathonjobsecondary:getPaid')
AddEventHandler('esx_marathonjob:getPaidsecondary', function(amount)						
	local xPlayer = ESX.GetPlayerFromId(source)					
	xPlayer.addMoney(math.floor(amount))
end)

RegisterServerEvent('esx_marathonjobsecondary:getPunished')
AddEventHandler('esx_marathonjobsecondary:getPunished', function(amount)					
	local xPlayer = ESX.GetPlayerFromId(source)		
	xPlayer.removeMoney(math.floor(amount)) 
end)

RegisterServerEvent('esx_marathonjobsecondary:giveAward')
AddEventHandler('esx_marathonjobsecondary:giveAward', function(award)					
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(award, 1)
end)

RegisterServerEvent('esx_marathonjobsecondary:onWaypoint')
AddEventHandler('esx_marathonjobsecondary:onWaypoint', function()					
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('bread', 1)
	xPlayer.addInventoryItem('water', 1)
end)


