ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobVuilnis')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobVuilnis', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("eboueur", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobGarden')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobGarden', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("gardener", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobpostnl')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobpostnl', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("gopostal", 0)-- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobzwembad')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobzwembad', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("poolcleaner", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setsetJobRunner')
AddEventHandler('DP_Jobs_Secondary_Menu:setsetJobRunner', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("runner", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobtrucker')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobtrucker', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("trucker", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobbus')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobbus', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("works", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobSlacht')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobSlacht', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("slaughterer", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobTuinier')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobTuinier', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("gardener", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobMijn')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobMijn', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("miner", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobVlogger')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobVlogger', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("reporter", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobVisser')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobVisser', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("fisherman", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobHout')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobHout', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("lumberjack", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

RegisterServerEvent('DP_Jobs_Secondary_Menu:setJobKleding')
AddEventHandler('DP_Jobs_Secondary_Menu:setJobKleding', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.setJob2("tailor", 0) -- 0 is job grade
	TriggerClientEvent('esx:showNotification', source, 'Je bent aangenomen ~g~' .. xPlayer.getName())	
end)

SetConvarServerInfo('Gemeente:', 'Nieuwstad')
SetConvarServerInfo('Website van de gemeente Nieuwstad:', 'https://www.GemeenteNieuwstad.nl')
SetConvarServerInfo('Eiland:', 'Texel')
SetConvarServerInfo('Website van het Texel:', 'https://www.TexelRP.nl')
SetConvarServerInfo('★', '★')
SetConvarServerInfo('Discord Link:', 'https://www.dutch-players.nl/joindiscord')
SetConvarServerInfo('Discord Code:', 'MyFj7yp')
SetConvarServerInfo('★', '★')
SetConvarServerInfo('Vaste banen:', 'Je hebt een ruime keuze aan vaste banen! Kies uit meer dan 25 vaste banen!')
SetConvarServerInfo('Bijbanen:', 'Je kunt extra geld verdienen door een bijbaan! Kies uit meer dan 5 bijbanen!')
SetConvarServerInfo('Kamer van Koophandel:', 'Begin je eigen supermarkt, computerwinkel, apotheek, bouwmarkt, sexwinkel of restaurant en manage je eigen personeel!')
SetConvarServerInfo('★', '★')
SetConvarServerInfo('Clubs:', 'Galaxy, Bahamas, Homobar, en de Wallen.')
SetConvarServerInfo('Recreatie:', 'Fietsen, bowlen, golfen, parachute springen, gokken, surfen, sporten, vissen, goud zoeken en meer...')
SetConvarServerInfo('Drugs:', 'Wiet, Cocaine, Meth, XTC, Opium')
SetConvarServerInfo('Dieren:', 'Koop je eigen huisdier en wild dier! Je hebt keuze uit ruim 15 verschillende dieren!')