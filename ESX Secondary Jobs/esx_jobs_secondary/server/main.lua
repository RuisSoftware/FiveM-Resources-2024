local playersWorking = {}

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local timeNow = os.clock()

		for playerId,data in pairs(playersWorking) do
			Citizen.Wait(10)
			local xPlayer = ESX.GetPlayerFromId(playerId)

			-- is player still online?
			if xPlayer then
				local distance = #(xPlayer.getCoords(true) - data.zoneCoords)

				-- player still within zone limits?
				if distance <= data.zoneMaxDistance then
					-- calculate the elapsed time
					local timeElapsed = timeNow - data.time

					if timeElapsed > data.jobItem[1].time then
						data.time = os.clock()

						for k,v in ipairs(data.jobItem) do
							local itemQtty, requiredItemQtty = 0, 0

							if v.name ~= _U('delivery') then
								itemQtty = xPlayer.getInventoryItem(v.db_name).count
							end

							if data.jobItem[1].requires ~= 'nothing' then
								requiredItemQtty = xPlayer.getInventoryItem(data.jobItem[1].requires).count
							end
			
							if v.name ~= _U('delivery') and itemQtty >= v.max then
								TriggerClientEvent('tnotify:client:SendTextAlert', playerId, {style = 'info', duration = 5500, message = 'Je draag het maximum van dit item.  Ga door naar de volgende locatie.', sound = true })
								playersWorking[playerId] = nil
							elseif v.requires ~= 'nothing' and requiredItemQtty <= 0 then
								TriggerClientEvent('tnotify:client:SendTextAlert', playerId, {style = 'info', duration = 5500, message = 'Je hebt niet genoeg:  ' .. data.jobItem[1].requires_name, sound = true })
								playersWorking[playerId] = nil
							else
								if v.name ~= _U('delivery') then
									-- chances to drop the item
									if v.drop == 100 then
										xPlayer.addInventoryItem(v.db_name, v.add)
									else
										local chanceToDrop = math.random(100)
										if chanceToDrop <= v.drop then
											xPlayer.addInventoryItem(v.db_name, v.add)
										end
									end
								else
									xPlayer.addMoney(v.price)
								end
							end
						end
			
						if data.jobItem[1].requires ~= 'nothing' then
							local itemToRemoveQtty = xPlayer.getInventoryItem(data.jobItem[1].requires).count
							if itemToRemoveQtty > 0 then
								xPlayer.removeInventoryItem(data.jobItem[1].requires, data.jobItem[1].remove)
							end
						end
					end
				else
					playersWorking[playerId] = nil
				end
			else
				playersWorking[playerId] = nil
			end
		end
	end
end)

RegisterServerEvent('esx_secondaryjobs:startWork')
AddEventHandler('esx_secondaryjobs:startWork', function(zoneIndex)
	if not playersWorking[source] then
		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer then
			local jobObject = Config.Jobs2[xPlayer.job2.name]

			if jobObject then
				local jobZone = jobObject.Zones[zoneIndex]

				if jobZone and jobZone.Item then
					playersWorking[source] = {
						jobItem = jobZone.Item,
						zoneCoords = vector3(jobZone.Pos.x, jobZone.Pos.y, jobZone.Pos.z),
						zoneMaxDistance = jobZone.Size.x,
						time = os.clock()
					}
				end
			end
		end
	end
end)

RegisterServerEvent('esx_secondaryjobs:stopWork')
AddEventHandler('esx_secondaryjobs:stopWork', function()
	if playersWorking[source] then
		playersWorking[source] = nil
	end
end)

RegisterNetEvent('esx_secondaryjobs:caution')
AddEventHandler('esx_secondaryjobs:caution', function(cautionType, cautionAmount, spawnPoint, vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)

	if cautionType == 'take' then
		if cautionAmount <= Config.MaxCaution and cautionAmount > 0 then
			TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
				if xPlayer.getAccount('bank').money >= cautionAmount then
					xPlayer.removeAccountMoney('bank', cautionAmount)
					account.addMoney(cautionAmount)
					TriggerClientEvent('tnotify:client:SendTextAlert', source, {style = 'info', duration = 5500, message = _U('bank_deposit_taken', ESX.Math.GroupDigits(cautionAmount)), sound = true })
					TriggerClientEvent('esx_secondaryjobs:spawnJobVehicle', xPlayer.source, spawnPoint, vehicle)
				else
					TriggerClientEvent('tnotify:client:SendTextAlert', source, {style = 'info', duration = 5500, message = _U('caution_afford', ESX.Math.GroupDigits(cautionAmount)), sound = true })
				end
			end)
		end
	elseif cautionType == 'give_back' then
		if cautionAmount <= 1 and cautionAmount > 0 then
			TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
				local caution = account.money
				local toGive = ESX.Math.Round(caution * cautionAmount)
	
				xPlayer.addAccountMoney('bank', toGive)
				account.removeMoney(toGive)
				TriggerClientEvent('tnotify:client:SendTextAlert', source, {style = 'info', duration = 5500, message = _U('bank_deposit_returned', ESX.Math.GroupDigits(toGive)), sound = true })
			end)
		end
	end
end)
