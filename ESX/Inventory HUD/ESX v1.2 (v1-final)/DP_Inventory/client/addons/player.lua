local targetPlayer
local targetPlayerName

Citizen.CreateThread(function()
	TriggerEvent("chat:addSuggestion", "/openinventory", _U("openinv_help"), {{name = _U("openinv_id"), help = _U("openinv_help")}})
end)

AddEventHandler( "onResourceStop", function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent("chat:removeSuggestion", "/openinventory")
	end
end)

RegisterNetEvent("DP_Inventory:openPlayerInventory")
AddEventHandler("DP_Inventory:openPlayerInventory", function(target, playerName)
	targetPlayer = target
	targetPlayerName = playerName
	setPlayerInventoryData()
	openPlayerInventory()
	TriggerServerEvent('DP_Inventory:disableTargetInv', target)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.RobKeyOne) and IsControlPressed(1, Config.RobKeyTwo) then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
				if not Config.EverybodyCanRob then
					if (Config.AllowPolice and PlayerData.job.name == Config.InventoryJob.Police) or (Config.AllowNightclub and PlayerData.job.name == Config.InventoryJob.Nightclub) or (Config.AllowMafia and PlayerData.job.name == Config.InventoryJob.Mafia) or (Config.AllowMafia and PlayerData.job.name == Config.InventoryJob.Ambulance) then
						local searchPlayerPed = GetPlayerPed(closestPlayer)
						if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityPlayingAnim(searchPlayerPed, 'missminuteman_1ig_2', 'handsup_base', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 or IsEntityPlayingAnim(searchPlayerPed, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(searchPlayerPed, "mp_arrest_paired", "crook_p2_back_right", 3) then
							exports['mythic_progbar']:Progress({
								name = "openGlovebox",
								duration = 3500,
								label = _U('robbing'),
								useWhileDead = false,
								canCancel = true,
								controlDisables = {},
								animation = {},
								prop = {},
							}, function(status)
								if not status then
									TriggerEvent("DP_Inventory:openPlayerInventory", GetPlayerServerId(closestPlayer), GetPlayerName(closestPlayer))
								end
							end)
						else
							exports['mythic_notify']:DoHudText('error', _U('player_not_dead'))
						end
					else
						exports['mythic_notify']:DoHudText('error', _U('no_permissions'))
					end
				else
					local searchPlayerPed = GetPlayerPed(closestPlayer)
					if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityPlayingAnim(searchPlayerPed, 'missminuteman_1ig_2', 'handsup_base', 3) or IsEntityDead(searchPlayerPed) or GetEntityHealth(searchPlayerPed) <= 0 or IsEntityPlayingAnim(searchPlayerPed, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(searchPlayerPed, "mp_arrest_paired", "crook_p2_back_right", 3) then
						exports['mythic_progbar']:Progress({
							name = "openGlovebox",
							duration = 3500,
							label = _U('robbing'),
							useWhileDead = false,
							canCancel = true,
							controlDisables = {},
							animation = {},
							prop = {},
						}, function(status)
							if not status then
								TriggerEvent("DP_Inventory:openPlayerInventory", GetPlayerServerId(closestPlayer), GetPlayerName(closestPlayer))
							end
						end)  
					else
						exports['mythic_notify']:DoHudText('error', _U('player_not_dead'))
					end
				end
            end
        end
    end
end)

function refreshPlayerInventory()
	setPlayerInventoryData()
end

function setPlayerInventoryData()
	ESX.TriggerServerCallback("DP_Inventory:getPlayerInventory", function(data)
		SendNUIMessage({
			action = "setInfoText",
			text = "<strong>" .. _U("player_inventory") .. "</strong><br>" .. targetPlayerName .. " (" .. targetPlayer .. ")"
		})

		items = {}
		inventory = data.inventory
		accounts = data.accounts
		money = data.money
		weapons = data.weapons

		if Config.IncludeCash and money ~= nil and money > 0 then
			moneyData = {
				label = _U("cash"),
				name = "cash",
				type = "item_money",
				count = money,
				usable = false,
				rare = false,
				weight = -1,
				canRemove = true
			}
			table.insert(items, moneyData)
		end

		if Config.IncludeAccounts and accounts ~= nil then
			for key, value in pairs(accounts) do
				if not shouldSkipAccount(accounts[key].name) then
					local canDrop = accounts[key].name ~= "bank"
					if accounts[key].money > 0 then
						accountData = {
							label = accounts[key].label,
							count = accounts[key].money,
							type = "item_account",
							name = accounts[key].name,
							usable = false,
							rare = false,
							weight = -1,
							canRemove = canDrop
						}
						table.insert(items, accountData)
					end
				end
			end
		end

		if inventory ~= nil then
			for key, value in pairs(inventory) do
				if inventory[key].count <= 0 then
					inventory[key] = nil
				else
					inventory[key].type = "item_standard"
					table.insert(items, inventory[key])
				end
			end
		end

		SendNUIMessage({
			action = "setSecondInventoryItems",
			itemList = items
		})
	end, targetPlayer)
end

function openPlayerInventory()
	loadPlayerInventory()
	isInInventory = true
	SendNUIMessage({
		action = "display",
		type = "player"
	})
	SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoPlayer", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		if data.item.type == "item_weapon" then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end
		TriggerServerEvent("DP_Inventory:tradePlayerItem", GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count)
	end
	Wait(250)
	refreshPlayerInventory()
	loadPlayerInventory()
	cb("ok")
end)

RegisterNUICallback("TakeFromPlayer", function(data, cb)
	if IsPedSittingInAnyVehicle(playerPed) then
		return
	end
	if type(data.number) == "number" and math.floor(data.number) == data.number then
		local count = tonumber(data.number)
		if data.item.type == "item_weapon" then
			count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
		end
		TriggerServerEvent("DP_Inventory:tradePlayerItem", targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count)
	end
	Wait(250)
	refreshPlayerInventory()
	loadPlayerInventory()
	cb("ok")
end)
