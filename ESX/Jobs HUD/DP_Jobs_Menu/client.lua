local PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		DrawMarker(Config.Marker.type, Config.Marker.x, Config.Marker.y, Config.Marker.z, 0, 0, 0, 0, 0, 0, 2.0001,2.0001,2.0001, 0, Config.Color.r, Config.Color.g, Config.Color.b, 0, 0, 0, 0, 0, 0, 0)
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -251.07,  -922.15,  32.34, true) < 1 then
			DisplayHelpText("Drup op ~g~E~s~ om werk te zoeken")
		 if (IsControlJustReleased(1, 51)) then
			SetNuiFocus( true, true )
			SendNUIMessage({
				ativa = true
			})
		 end
		end
	end
end)

RegisterNUICallback('1', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobt')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('2', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobm')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('3', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobp')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('4', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobn')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('5', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobfueler')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('6', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobreporter')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('7', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobbus')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('8', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobwindowcleaner')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('9', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobjournaliste')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('10', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobRova')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('11', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobNight')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('12', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobBurger')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)


RegisterNUICallback('13', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobVuilnis')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('14', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobPallmall')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('15', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobPiloot')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('rova', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobRova')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('brinks', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobBrinks')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('builder', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobBuilder')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('slaughterer', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobslaughterer')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('lumberjack', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJoblumberjack')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('tailor', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobtailor')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('gardener', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobgardener')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)
RegisterNUICallback('pizza', function(data, cb)
	TriggerServerEvent('DP_Jobs_Menu:setJobPizza')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht3')
end)

RegisterNUICallback('fechar', function(data, cb)
	SetNuiFocus( false )
	SendNUIMessage({
	ativa = false
	})
  	cb('ok')
end)

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
