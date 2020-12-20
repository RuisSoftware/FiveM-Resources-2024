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
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  -248.1,  -913.46,  32.34, true) < 1 then
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
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobVuilnis')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('2', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobGarden')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('3', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobpostnl')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('4', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobzwembad')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('5', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setsetJobRunner')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('6', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobtrucker')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('8', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobVisser')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('9', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobbus')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('10', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobSlacht')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('11', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobTuinier')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('12', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobMijn')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('13', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobVlogger')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('14', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobHout')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
end)

RegisterNUICallback('15', function(data, cb)
	TriggerServerEvent('DP_Jobs_Secondary_Menu:setJobKleding')
  	cb('ok')
	TriggerServerEvent('esx_opdrachten:updateOpdracht4')
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
