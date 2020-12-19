ESX = nil
TriggerEvent("esx:getSharedObject", function(obj) 
	ESX = obj 
end)

local Command_Close_Inventory = "closeinventory" -- CHANGE TO YOUR COMMAND NAME
ServerItems = {}
itemShopList = {}

ESX.RegisterServerCallback("dp_inventory:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local itemSlotes = {}
	if targetXPlayer ~= nil then
		MySQL.Async.fetchAll('SELECT * FROM inventory_slote WHERE owner = @owner', {
			['@owner'] =  targetXPlayer.identifier
		},function(data)
			if #data ~= 0 then
				for i=1, #data do
					table.insert(itemSlotes, {
						slot = data[i].slot,
						item = data[i].weapon
					})
				end
			else
				itemSlotes = false
			end
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout, slotes = itemSlotes})
		end)
	else
		cb(nil)
	end
end)

RegisterNetEvent('dp_inventory:slotPut')
AddEventHandler('dp_inventory:slotPut', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item,1)
	MySQL.Async.fetchAll('SELECT * FROM inventory_slote WHERE owner = @owner AND slot = @slot', {
		['@owner'] =  xPlayer.identifier,
		['@slot'] = 1
	},function(results)
		if #results == 0 then
			MySQL.Async.execute('INSERT INTO inventory_slote (owner, weapon, slot) VALUES (@owner, @weapon, @slot)', {
				['@owner'] = xPlayer.identifier,
				['@weapon'] = item,
				['@slot'] = 1,
			})
		else
			MySQL.Async.fetchAll('SELECT * FROM inventory_slote WHERE owner = @owner AND slot = @slot', {
				['@owner'] =  xPlayer.identifier,
				['@slot'] = 2
			},function(results2)
				if #results2 == 0 then
					MySQL.Async.execute('INSERT INTO inventory_slote (owner, weapon, slot) VALUES (@owner, @weapon, @slot)', {
						['@owner'] = xPlayer.identifier,
						['@weapon'] = item,
						['@slot'] = 2,
					})
				else
					MySQL.Async.fetchAll('SELECT * FROM inventory_slote WHERE owner = @owner AND slot = @slot', {
						['@owner'] =  xPlayer.identifier,
						['@slot'] = 3
					},function(results3)
						if #results3 == 0 then
							MySQL.Async.execute('INSERT INTO inventory_slote (owner, weapon, slot) VALUES (@owner, @weapon, @slot)', {
								['@owner'] = xPlayer.identifier,
								['@weapon'] = item,
								['@slot'] = 3,
							})
						else
							MySQL.Async.fetchAll('SELECT * FROM inventory_slote WHERE owner = @owner AND slot = @slot', {
								['@owner'] =  xPlayer.identifier,
								['@slot'] = 4
							},function(results4)
								if #results4 == 0 then
									MySQL.Async.execute('INSERT INTO inventory_slote (owner, weapon, slot) VALUES (@owner, @weapon, @slot)', {
										['@owner'] = xPlayer.identifier,
										['@weapon'] = item,
										['@slot'] = 4,
									})
								else
									MySQL.Async.fetchAll('SELECT * FROM inventory_slote WHERE owner = @owner AND slot = @slot', {
										['@owner'] =  xPlayer.identifier,
										['@slot'] = 5
									},function(results5)
										if #results5 == 0 then
											MySQL.Async.execute('INSERT INTO inventory_slote (owner, weapon, slot) VALUES (@owner, @weapon, @slot)', {
												['@owner'] = xPlayer.identifier,
												['@weapon'] = item,
												['@slot'] = 5,
											})
										else
											MySQL.Sync.execute("DELETE FROM inventory_slote WHERE `owner` = @owner AND slot = @slot", {
												['@owner'] = xPlayer.identifier,
												['@slot'] = 5,
											}, function(succes)
												if succes then
													MySQL.Async.execute('INSERT INTO inventory_slote (owner, weapon, slot) VALUES (@owner, @weapon, @slot)', {
														['@owner'] = xPlayer.identifier,
														['@weapon'] = item,
														['@slot'] = 5,
													})
												end
											end)
										end
									end)
								end
							end)
						end
					end)
				end
			end)
		end
    end)
end)

RegisterNetEvent('dp_inventory:putInToSlot')
AddEventHandler('dp_inventory:putInToSlot',function(item, slot)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM inventory_slote WHERE weapon = @weapon AND owner = @owner AND slot = @slot', {
        ['@weapon'] = item,
		['@owner'] =  xPlayer.identifier,
		['@slot'] = slot
	},function(results)
		if #results == 0 then
			MySQL.Async.execute('INSERT INTO inventory_slote (owner, weapon, slot) VALUES (@owner, @weapon, @slot)', {
				['@owner'] = xPlayer.identifier,
				['@weapon'] = item,
				['@slot'] = slot,
			})
		end
    end)
end)

RegisterNetEvent('dp_inventory:removeFromSlot')
AddEventHandler('dp_inventory:removeFromSlot',function(item, slot)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Sync.execute("DELETE FROM inventory_slote WHERE `owner` = @owner AND weapon = @weapon", {
		['@owner'] = xPlayer.identifier,
		['@weapon'] = item,
	})
end)

ESX.RegisterServerCallback("dp_inventory:getPlayerInventoryWeight", function(source,cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerweight = xPlayer.getWeight()
	cb(playerweight)
end)

RegisterNetEvent("dp_inventory:clearweapons")
AddEventHandler("dp_inventory:clearweapons", function(target)
	TriggerClientEvent('dp_inventory:clearfastitems',target)
end)

ESX.RegisterServerCallback('dp_inventory:takePlayerItem', function(source, cb, item, count)
	local player = ESX.GetPlayerFromId(source)
	local invItem = player.getInventoryItem(item)
	if invItem.count - count < 0 then
		cb(false)
	else
		player.removeInventoryItem(item, count)
		cb(true)
	end
end)

ESX.RegisterServerCallback('dp_inventory:addPlayerItem', function(source, cb, item, count)
	local player = ESX.GetPlayerFromId(source)
	if player.canCarryItem(item, count) then
		player.addInventoryItem(item, count)
		cb(true)
	else
		cb(false)
	end
end)

RegisterServerEvent("dp_inventory:tradePlayerItem")
AddEventHandler("dp_inventory:tradePlayerItem", function(from, target, type, itemName, itemCount)
	local _source = from
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local item = sourceXPlayer.getInventoryItem(itemName)

	if type == "item_standard" then
		if itemCount > 0 and item.count >= itemCount then
			if  targetXPlayer.canCarryItem(itemName, itemCount) then
				if itemName == 'WEAPON_PISTOL' or itemName == 'WEAPON_FLASHLIGHT' or itemName == 'WEAPON_STUNGUN' or itemName == 'WEAPON_KNIFE' or itemName == 'WEAPON_ASSAULTSMG'
				or itemName == 'WEAPON_BAT' or itemName == 'WEAPON_ADVANCEDRIFLE' or itemName == 'WEAPON_APPISTOL' or itemName == 'WEAPON_ASSAULTRIFLE' or itemName == 'WEAPON_ASSAULTSHOTGUN'
				or itemName == 'WEAPON_AUTOSHOTGUN' or itemName == 'WEAPON_CARBINERIFLE' or itemName == 'WEAPON_COMBATPISTOL' or itemName == 'WEAPON_PUMPSHOTGUN' or itemName == 'WEAPON_SMG' then
					TriggerEvent('dp_inventory:changeWeaponOwner', sourceXPlayer.identifier, targetXPlayer.identifier, itemName)
				end
				sourceXPlayer.removeInventoryItem(itemName, itemCount)
				targetXPlayer.addInventoryItem(itemName, itemCount)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source , { type = 'error', text = _U('player_inv_no_space') })
			end
		end
	elseif type == "item_money" then
		if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
			sourceXPlayer.removeMoney(itemCount)
			targetXPlayer.addMoney(itemCount)
		end
	elseif type == "item_account" then
		if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
			sourceXPlayer.removeAccountMoney(itemName, itemCount)
			targetXPlayer.addAccountMoney(itemName, itemCount)
		end
	end
end)

RegisterCommand("openinventory", function(source, args, rawCommand) -- ADMIN WATCH
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local group = xPlayer.getGroup()
	if group == 'admin' or (Config.AllowModerators and group == 'mod') then
		local target = tonumber(args[1])
		local targetXPlayer = ESX.GetPlayerFromId(target)
		if targetXPlayer ~= nil then
			TriggerClientEvent("dp_inventory:openPlayerInventory", source, target, targetXPlayer.name)
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('no_player') })
		end
	else
		if Config.JobOnlyInventory then
			if (Config.AllowPolice and xPlayer.job.name == Config.InventoryJob.Police) or (Config.AllowNightclub and xPlayer.job.name == Config.InventoryJob.Nightclub) or (Config.AllowMafia and xPlayer.job.name == Config.InventoryJob.Mafia) or (Config.AllowMafia and xPlayer.job.name == Config.InventoryJob.Ambulance) then
				TriggerClientEvent("dp_inventory:openPlayerInventory", source, target, targetXPlayer.name)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('no_permissions') })
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = _U('no_permissions') })
		end
	end
end)

RegisterCommand(Command_Close_Inventory, function(source)
	local _source = source
	TriggerClientEvent('dp_inventory:closeinventory', _source)
end)

RegisterServerEvent("dp_inventory:sendShopItems")
AddEventHandler("dp_inventory:sendShopItems", function(source, itemList)
	itemShopList = itemList
end)

ESX.RegisterServerCallback("dp_inventory:getShopItems", function(source, cb, shoptype)
	itemShopList = {}
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local itemInformation = {}
	for i=1, #itemResult, 1 do
		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end
		itemInformation[itemResult[i].name].name = itemResult[i].name
		itemInformation[itemResult[i].name].label = itemResult[i].label
		itemInformation[itemResult[i].name].weight = itemResult[i].weight
		itemInformation[itemResult[i].name].rare = itemResult[i].rare
		itemInformation[itemResult[i].name].can_remove = itemResult[i].can_remove
		if shoptype == "regular" then
			for _, v in pairs(Config.Shops.RegularShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "ilegal" then
			for _, v in pairs(Config.Shops.IlegalShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "robsliquor" then
			for _, v in pairs(Config.Shops.RobsLiquor.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "youtool" then
			for _, v in pairs(Config.Shops.YouTool.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "policeshop" then
			for _, v in pairs(Config.Shops.PoliceShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "prison" then
			for _, v in pairs(Config.Shops.PrisonShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "weaponshop" then
			for _, v in pairs(Config.Shops.WeaponShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "drugs" then
			for _, v in pairs(Config.Shops.DrugShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "nightclubshop" then
			for _, v in pairs(Config.Shops.NightclubShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "blackmarket" then
			for _, v in pairs(Config.Shops.BlackMarket.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = v.price,
						count = 99999999
					})
				end
			end
		end
	end
	cb(itemShopList)
end)

ESX.RegisterServerCallback("dp_inventory:getCustomShopItems", function(source, cb, shoptype, customInventory)
	itemShopList = {}
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local itemInformation = {}
	for i=1, #itemResult, 1 do
		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end
		itemInformation[itemResult[i].name].name = itemResult[i].name
		itemInformation[itemResult[i].name].label = itemResult[i].label
		itemInformation[itemResult[i].name].weight = itemResult[i].weight
		itemInformation[itemResult[i].name].rare = itemResult[i].rare
		itemInformation[itemResult[i].name].can_remove = itemResult[i].can_remove
		if shoptype == "normal" then
			for _, v in pairs(customInventory.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end

		if shoptype == "weapon" then
			local weapons = customInventory.Weapons
			for _, v in pairs(customInventory.Weapons) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_weapon",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 0,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
			local ammo = customInventory.Ammo
			for _,v in pairs(customInventory.Ammo) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_ammo",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = 0,
						weaponhash = v.weaponhash,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			for _, v in pairs(customInventory.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						weight = itemInformation[itemResult[i].name].weight,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
	end
	cb(itemShopList)
end)

RegisterNetEvent("dp_inventory:SellItemToPlayer")
AddEventHandler("dp_inventory:SellItemToPlayer",function(source, type, item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if type == "item_standard" then
		local targetItem = xPlayer.getInventoryItem(item)
		if xPlayer.canCarryItem(item, count) then
			local list = itemShopList
			for i = 1, #list, 1 do
				if list[i].name == item then
					local totalPrice = count * list[i].price
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = _U('item_added')..count.." "..list[i].label })
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_money') })
					end
				end
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('insufficient_space') })
		end
	end
	if type == "item_weapon" then
		if xPlayer.canCarryItem(item, count) then
			local list = itemShopList
			for i = 1, #list, 1 do
				if list[i].name == item then
					local totalPrice = count * list[i].price
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = _U('item_added')..count.." "..list[i].label })
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_money') })
					end
				end
			end
		else
			TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('insufficient_space') })
		end
	end

	if type == "item_ammo" then
		local targetItem = xPlayer.getInventoryItem(item)
		local list = itemShopList
		for i = 1, #list, 1 do
			if list[i].name == item then
				local targetWeapon = xPlayer.hasWeapon(list[i].weaponhash)
				if targetWeapon then
					local totalPrice = count * list[i].price
					local ammo = count * list[i].ammo
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						TriggerClientEvent("dp_inventory:AddAmmoToWeapon", source, list[i].weaponhash, ammo)
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = _U('item_added')..count.." "..list[i].label })
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('no_money') })
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = _U('insufficient_space') })
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	Citizen.Wait(10)
	MySQL.Async.fetchAll('SELECT * FROM items WHERE LCASE(name) LIKE \'%weapon_%\'', {}, function(results)
		for k, v in pairs(results) do
			ESX.RegisterUsableItem(v.name, function(source)
				TriggerClientEvent('dp_inventory:itemPopUp', source, v.name)
			end)
		end
	end)
end)

RegisterServerEvent('dp_inventory:updateAmmoCount')
AddEventHandler('dp_inventory:updateAmmoCount', function(hash, wepInfo)
	local player = ESX.GetPlayerFromId(source)
	for i=1, #wepInfo.attach do
		if wepInfo.attach[i] ~= nil then
			if wepInfo.attach[i] == 'skin' then
				table.remove(wepInfo.attach,i)
			end
		end
	end
	MySQL.Async.execute('UPDATE ammunition SET count = @count, attach = @attach WHERE hash = @hash AND owner = @owner and weapon_id = @weapon_id', {
		['@owner'] = player.identifier,
		['@hash'] = hash,
		['@count'] = wepInfo.count,
		['@weapon_id'] = wepInfo.weapon_id,
		['@attach'] = json.encode(wepInfo.attach)
	}, function(results)
		if results == 0 then
			MySQL.Async.execute('INSERT INTO ammunition (owner, hash, count, attach, weapon_id, original_owner) VALUES (@owner, @hash, @count, @attach, @weapon_id, @original_owner)', {
				['@owner'] = player.identifier,
				['@hash'] = hash,
				['@original_owner'] = player.identifier,
				['@count'] = wepInfo.count,
				['@weapon_id'] = wepInfo.weapon_id,
				['@attach'] = json.encode(wepInfo.attach)
			})
		end
	end)
end)

ESX.RegisterServerCallback('dp_inventory:isWeaponNumberTaken', function(source, cb, weapon)
	MySQL.Async.fetchAll('SELECT 1 FROM ammunition WHERE weapon_id = @weapon_id', {
		['@weapon_id'] = weapon
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('dp_inventory:getAmmoCount', function(source, cb, hash)
	local player = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE owner = @owner and hash = @hash', {
		['@owner'] = player.identifier,
		['@hash'] = hash
	}, function(results)
		if #results == 0 then
			local cbResult = {
				ammoCount = nil,
				attachments = {}
			}
			cb(cbResult)
		else
			local cbResult = {
				ammoCount = results[1].count,
				attachments = json.decode(results[1].attach)
			}
			cb(cbResult)
		end
	end)
end)

Citizen.CreateThread(function()
	for i = 1, #Config.Attachments do
		ESX.RegisterUsableItem(Config.Attachments[i], function(source)
			TriggerClientEvent("dp_inventory:useAttach", source, Config.Attachments[i])
		end)
	end
end)

ESX.RegisterServerCallback('GetCharacterNameServer', function(source, cb, target)
	local xTarget = ESX.GetPlayerFromId(target)
	local result = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
		['@identifier'] = xTarget.identifier
	})
	local firstname = result[1].firstname
	local lastname  = result[1].lastname
	cb(''.. firstname .. ' ' .. lastname ..'')
end)

ESX.RegisterServerCallback('dp_inventory:buyLicense', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)
		TriggerEvent('esx_license:addLicense', source, 'weapon', function()
			cb(true)
		end)
	else
		TriggerClientEvent('b1g_notify:client:Notify', source, { type = 'false', text = _U('no_money')})
		cb(false)
	end
end)
