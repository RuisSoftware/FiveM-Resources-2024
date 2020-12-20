ESX              = nil
local panelIngeschakeld = false
local panelLoaded  = true
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(spawn)
	isDead = false

	if not hasAlreadyJoined then
	end
	hasAlreadyJoined = true
	TriggerServerEvent('esx_opdrachten:spelerBezoekt')
end)

RegisterNUICallback("sluitPanel", function(panel)    
	if panel.verberg then
		SetNuiFocus(false, false)
	end      
end)

RegisterNetEvent('esx_opdrachten:startOpdracht1')
AddEventHandler('esx_opdrachten:startOpdracht1', function(source)
	TriggerEvent('esx:showNotification', 'startOpdracht1')
end)

RegisterNetEvent('esx_opdrachten:updateLevel1')
AddEventHandler('esx_opdrachten:updateLevel1', function(source)
	TriggerEvent('esx:showNotification', 'startOpdracht1')
end)

function openOpdrachtenMenu()
	ESX.UI.Menu.Open( 'default', GetCurrentResourceName(), 'bekijkOpdrachten', -- Replace the menu name
	  {
		title    = _U('menuTitel'),
		align = 'top', -- Menu position
		elements = { -- Contains menu elements
		  {label = _U('openHandboek'),     value = 'handboek'},
		  {label = _U('toonEerste'),     value = 'starters'},
		  {label = _U('menuTweede'),      value = 'tweede'},
		  {label = _U('menuDerde'),      value = 'derde'},
		  {label = _U('menuVierde'),      value = 'vierde'}
		}
	  },
	  function(data, menu) -- This part contains the code that executes when you press enter
		if data.current.value == 'handboek' then
			SendNUIMessage({panelTonen = true})
			SetNuiFocus(true, true)
			panelLoaded = true 
			menu.close()
		end   
		if data.current.value == 'starters' then
			ESX.TriggerServerCallback('esx_opdrachten:stuurStartersOpdrachten', function(opdrachten)
				local elements = {
				  head = { _U('rijNummer'), _U('rijOpdracht'), _U('rijVoltooid'), _U('rijInformatie') },
				  rows = {}
				}

				local Behaald = {opdrachten[1].opdracht1, opdrachten[1].opdracht2, opdrachten[1].opdracht3, opdrachten[1].opdracht4, opdrachten[1].opdracht5, opdrachten[1].opdracht6, opdrachten[1].opdracht7, opdrachten[1].opdracht8, opdrachten[1].opdracht9, opdrachten[1].opdracht10}
				for i=1, #Config.AantalStartersOpdrachten do
					table.insert(elements.rows, {
					  data = Config.AantalStartersOpdrachten[i],
					  cols = {
						Config.AantalStartersOpdrachten[i],
						Config.StartersOpdrachtenTitel[i],
						Behaald[i],
						'{{' .. _U('rijUitlegKnop') .. '|knop1}} {{' .. _U('reset') .. '|knop2}}'
					  }
					})
				end

				ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'alleOpdrachten', elements, function(data, menu)
				  if data.value == 'knop1' then
						menu.close()
						SendNUIMessage({panelTonen = true})
						SetNuiFocus(true, true)
						ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'bekijkOpdrachten')
				  elseif data.value == 'knop2' then
					-- Code 2
				  end
				end, function(data, menu)
				  menu.close()
				end)
			end)
		end 
		if data.current.value == 'tweede' then
			ESX.TriggerServerCallback('esx_opdrachten:stuurTweedeOpdrachten', function(opdrachten)
				local elements = {
				  head = { _U('rijNummer'), _U('rijOpdracht'), _U('rijVoltooid'), _U('rijInformatie') },
				  rows = {}
				}

				local Behaald = {opdrachten[1].opdracht11, opdrachten[1].opdracht12, opdrachten[1].opdracht13, opdrachten[1].opdracht14, opdrachten[1].opdracht15, opdrachten[1].opdracht16, opdrachten[1].opdracht17, opdrachten[1].opdracht18, opdrachten[1].opdracht19, opdrachten[1].opdracht20}
				for i=1, #Config.AantalTweedeOpdrachten do
					table.insert(elements.rows, {
					  data = Config.AantalTweedeOpdrachten[i],
					  cols = {
						Config.AantalTweedeOpdrachten[i],
						Config.TweedeOpdrachtenTitel[i],
						Behaald[i],
						'{{' .. _U('rijUitlegKnop') .. '|knop1}} {{' .. _U('reset') .. '|knop2}}'
					  }
					})
				end

				ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'alleOpdrachten', elements, function(data, menu)
				  if data.value == 'knop1' then
						menu.close()
						SendNUIMessage({panelTonen = true})
						SetNuiFocus(true, true)
						ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'bekijkOpdrachten')
				  elseif data.value == 'knop2' then
					-- Code 2
				  end
				end, function(data, menu)
				  menu.close()
				end)
			end)
		end 
		if data.current.value == 'derde' then
			ESX.TriggerServerCallback('esx_opdrachten:stuurDerdeOpdrachten', function(opdrachten)
				local elements = {
				  head = { _U('rijNummer'), _U('rijOpdracht'), _U('rijVoltooid'), _U('rijInformatie') },
				  rows = {}
				}

				local Behaald = {opdrachten[1].opdracht21, opdrachten[1].opdracht22, opdrachten[1].opdracht23, opdrachten[1].opdracht24, opdrachten[1].opdracht25, opdrachten[1].opdracht26, opdrachten[1].opdracht27, opdrachten[1].opdracht28, opdrachten[1].opdracht29, opdrachten[1].opdracht30}
				for i=1, #Config.AantalDerdeOpdrachten do
					table.insert(elements.rows, {
					  data = Config.AantalDerdeOpdrachten[i],
					  cols = {
						Config.AantalDerdeOpdrachten[i],
						Config.DerdeOpdrachtenTitel[i],
						Behaald[i],
						'{{' .. _U('rijUitlegKnop') .. '|knop1}} {{' .. _U('reset') .. '|knop2}}'
					  }
					})
				end

				ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'alleOpdrachten', elements, function(data, menu)
				  if data.value == 'knop1' then
						menu.close()
						SendNUIMessage({panelTonen = true})
						SetNuiFocus(true, true)
						ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'bekijkOpdrachten')
				  elseif data.value == 'knop2' then
					-- Code 2
				  end
				end, function(data, menu)
				  menu.close()
				end)
			end)
		end
		if data.current.value == 'vierde' then
			ESX.TriggerServerCallback('esx_opdrachten:stuurVierdeOpdrachten', function(opdrachten)
				local elements = {
				  head = { _U('rijNummer'), _U('rijOpdracht'), _U('rijVoltooid'), _U('rijInformatie') },
				  rows = {}
				}

				local Behaald = {opdrachten[1].opdracht31, opdrachten[1].opdracht32, opdrachten[1].opdracht33, opdrachten[1].opdracht34, opdrachten[1].opdracht35, opdrachten[1].opdracht36, opdrachten[1].opdracht37, opdrachten[1].opdracht38, opdrachten[1].opdracht39, opdrachten[1].opdracht40}
				for i=1, #Config.AantalVierdeOpdrachten do
					table.insert(elements.rows, {
					  data = Config.AantalVierdeOpdrachten[i],
					  cols = {
						Config.AantalVierdeOpdrachten[i],
						Config.VierdeOpdrachtenTitel[i],
						Behaald[i],
						'{{' .. _U('rijUitlegKnop') .. '|knop1}} {{' .. _U('reset') .. '|knop2}}'
					  }
					})
				end

				ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'alleOpdrachten', elements, function(data, menu)
				  if data.value == 'knop1' then
						menu.close()
						SendNUIMessage({panelTonen = true})
						SetNuiFocus(true, true)
						ESX.UI.Menu.Close('default', GetCurrentResourceName(), 'bekijkOpdrachten')
				  elseif data.value == 'knop2' then
					-- Code 2
				  end
				end, function(data, menu)
				  menu.close()
				end)
			end)
		end
	  end,
	  function(data, menu) -- This part contains the code  that executes when the return key is pressed.
		  menu.close() -- Close the menu
	  end)	
end

Citizen.CreateThread(function()	
						SetNuiFocus(false, false)
	while true do
    local ped = GetPlayerPed(-1)
        if not IsPedInAnyVehicle(ped, 1) and IsControlJustReleased(1, Config.Toets)  then --G
            openOpdrachtenMenu()
			--TriggerServerEvent('esx_opdrachten:updateOpdracht12') -- voor de test
			TriggerServerEvent('esx_opdrachten:spelerBezoekt') -- voor de test
        end
        Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
	TriggerServerEvent('esx_opdrachten:spelerBezoekt') -- voor de test
end)
