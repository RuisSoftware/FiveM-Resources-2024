ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('DP_Jobs_Menu:setJobt')
AddEventHandler('DP_Jobs_Menu:setJobt', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("taxi", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('DP_Jobs_Menu:setJobm')
AddEventHandler('DP_Jobs_Menu:setJobm', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("bennys", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('DP_Jobs_Menu:setJobp')
AddEventHandler('DP_Jobs_Menu:setJobp', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("fisherman", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('DP_Jobs_Menu:setJobn')
AddEventHandler('DP_Jobs_Menu:setJobn', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("miner", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJobfueler')
AddEventHandler('DP_Jobs_Menu:setJobfueler', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("fueler", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJobreporter')
AddEventHandler('DP_Jobs_Menu:setJobreporter', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("reporter", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJobbus')
AddEventHandler('DP_Jobs_Menu:setJobbus', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("bus", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)
RegisterServerEvent('DP_Jobs_Menu:setJobwindowcleaner')
AddEventHandler('DP_Jobs_Menu:setJobwindowcleaner', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("windowcleaner", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)
RegisterServerEvent('DP_Jobs_Menu:setJobjournaliste')
AddEventHandler('DP_Jobs_Menu:setJobjournaliste', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("journaliste", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJobRova')
AddEventHandler('DP_Jobs_Menu:setJobRova', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("garbage", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJobNight')
AddEventHandler('DP_Jobs_Menu:setJobNight', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("nightclub", 1) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJobBurger')
AddEventHandler('DP_Jobs_Menu:setJobBurger', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("burgershot", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJobVuilnis')
AddEventHandler('DP_Jobs_Menu:setJobVuilnis', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("garbage", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)


RegisterServerEvent('DP_Jobs_Menu:setJobPallmall')
AddEventHandler('DP_Jobs_Menu:setJobPallmall', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("papierosy", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)



RegisterServerEvent('DP_Jobs_Menu:setJobRova')
AddEventHandler('DP_Jobs_Menu:setJobRova', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("garbage", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)
RegisterServerEvent('DP_Jobs_Menu:setJobBrinks')
AddEventHandler('DP_Jobs_Menu:setJobBrinks', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("brinks", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)
RegisterServerEvent('DP_Jobs_Menu:setJobBuilder')
AddEventHandler('DP_Jobs_Menu:setJobBuilder', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("builder", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJobPiloot')
AddEventHandler('DP_Jobs_Menu:setJobPiloot', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("lsia", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJobslaughterer')
AddEventHandler('DP_Jobs_Menu:setJobslaughterer', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("slaughterer", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Menu:setJoblumberjack')
AddEventHandler('DP_Jobs_Menu:setJoblumberjack', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("lumberjack", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)
RegisterServerEvent('DP_Jobs_Menu:setJobtailor')
AddEventHandler('DP_Jobs_Menu:setJobtailor', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("tailor", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)
RegisterServerEvent('DP_Jobs_Menu:setJobgardener')
AddEventHandler('DP_Jobs_Menu:setJobgardener', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("gardener", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)
RegisterServerEvent('DP_Jobs_Menu:setJobPizza')
AddEventHandler('DP_Jobs_Menu:setJobPizza', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob("pizza", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)