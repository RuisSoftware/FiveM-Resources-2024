ESX = nil
ServerItems = {}
itemShopList = {}
TriggerEvent(
	"esx:getSharedObject",
	function(obj)
		ESX = obj
	end
)

ESX.RegisterServerCallback(
	"esx_inventoryhud:getPlayerInventory",
	function(source, cb, target)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if targetXPlayer ~= nil then
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout})
		else
			cb(nil)
		end
	end
)

RegisterServerEvent("esx_inventoryhud:tradePlayerItem")
AddEventHandler(
	"esx_inventoryhud:tradePlayerItem",
	function(from, target, type, itemName, itemCount)
		local _source = from

		local sourceXPlayer = ESX.GetPlayerFromId(_source)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if type == "item_standard" then
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			local targetItem = targetXPlayer.getInventoryItem(itemName)

			if itemCount > 0 and sourceItem.count >= itemCount then
				if targetItem.limit ~= -1 and (targetItem.count + itemCount) > targetItem.limit then
				else
					sourceXPlayer.removeInventoryItem(itemName, itemCount)
					TriggerClientEvent('b1g_notify:client:Notify', sourceXPlayer, { type = 'true', text = _U('item_removed') .. itemName})
					targetXPlayer.addInventoryItem(itemName, itemCount)
					TriggerClientEvent('b1g_notify:client:Notify', targetXPlayer, { type = 'true', text = _U('item_added') .. itemName})
				end
			end
		elseif type == "item_money" then
			if itemCount > 0 and sourceXPlayer.getMoney() >= itemCount then
				sourceXPlayer.removeMoney(itemCount)
				TriggerClientEvent('b1g_notify:client:Notify', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount})
				targetXPlayer.addMoney(itemCount)
				TriggerClientEvent('b1g_notify:client:Notify', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount})
			end
		elseif type == "item_account" then
			if itemCount > 0 and sourceXPlayer.getAccount(itemName).money >= itemCount then
				sourceXPlayer.removeAccountMoney(itemName, itemCount)
				TriggerClientEvent('b1g_notify:client:Notify', sourceXPlayer, { type = 'true', text = _U('money_removed') .. itemCount .. itemName})
				targetXPlayer.addAccountMoney(itemName, itemCount)
				TriggerClientEvent('b1g_notify:client:Notify', targetXPlayer, { type = 'true', text = _U('money_added') .. itemCount .. itemName})
			end
		elseif type == "item_weapon" then
			if not targetXPlayer.hasWeapon(itemName) then
				sourceXPlayer.removeWeapon(itemName)
				TriggerClientEvent('b1g_notify:client:Notify', sourceXPlayer, { type = 'true', text = _U('weapon_removed') .. itemName})
				targetXPlayer.addWeapon(itemName, itemCount)
				TriggerClientEvent('b1g_notify:client:Notify', targetXPlayer, { type = 'true', text = _U('waepon_added') .. itemName})
			end
		end
	end
)

RegisterCommand(
	"openinventory",
	function(source, args, rawCommand)
		if IsPlayerAceAllowed(source, "inventory.openinventory") then
			local target = tonumber(args[1])
			local targetXPlayer = ESX.GetPlayerFromId(target)

			if targetXPlayer ~= nil then
				TriggerClientEvent("esx_inventoryhud:openPlayerInventory", source, target, targetXPlayer.name)
			else
				TriggerClientEvent('b1g_notify:client:Notify', source, { type = 'false', text = _U('no_player')})
			end
		else
				TriggerClientEvent('b1g_notify:client:Notify', source, { type = 'false', text = _U('no_permissions')})
		end
	end
)

RegisterServerEvent("suku:sendShopItems")
AddEventHandler("suku:sendShopItems", function(source, itemList)
	itemShopList = itemList
end)

ESX.RegisterServerCallback("suku:getShopItems", function(source, cb, shoptype)
	itemShopList = {}
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local itemInformation = {}

	for i=1, #itemResult, 1 do

		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end

		itemInformation[itemResult[i].name].name = itemResult[i].name
		itemInformation[itemResult[i].name].label = itemResult[i].label
		--itemInformation[itemResult[i].name].limit = itemResult[i].limit
		itemInformation[itemResult[i].name].rare = itemResult[i].rare
		itemInformation[itemResult[i].name].can_remove = itemResult[i].can_remove
		itemInformation[itemResult[i].name].price = itemResult[i].price

		if shoptype == "regular" then
			for _, v in pairs(Config.Shops.RegularShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						--limit = itemInformation[itemResult[i].name].limit,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
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
						--limit = itemInformation[itemResult[i].name].limit,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
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
						--limit = itemInformation[itemResult[i].name].limit,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
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
						--limit = itemInformation[itemResult[i].name].limit,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end
		end
		if shoptype == "weaponshop" then
			local weapons = Config.Shops.WeaponShop.Weapons
			for _, v in pairs(Config.Shops.WeaponShop.Weapons) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_weapon",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						--limit = 1,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			local ammo = Config.Shops.WeaponShop.Ammo
			for _,v in pairs(Config.Shops.WeaponShop.Ammo) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_ammo",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						--limit = 1,
						weaponhash = v.weaponhash,
						ammo = v.ammo,
						rare = itemInformation[itemResult[i].name].rare,
						can_remove = itemInformation[itemResult[i].name].can_remove,
						price = itemInformation[itemResult[i].name].price,
						count = 99999999
					})
				end
			end

			for _, v in pairs(Config.Shops.WeaponShop.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						--limit = itemInformation[itemResult[i].name].limit,
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

ESX.RegisterServerCallback("suku:getCustomShopItems", function(source, cb, shoptype, customInventory)
	itemShopList = {}
	local itemResult = MySQL.Sync.fetchAll('SELECT * FROM items')
	local itemInformation = {}

	for i=1, #itemResult, 1 do

		if itemInformation[itemResult[i].name] == nil then
			itemInformation[itemResult[i].name] = {}
		end

		itemInformation[itemResult[i].name].name = itemResult[i].name
		itemInformation[itemResult[i].name].label = itemResult[i].label
		----itemInformation[itemResult[i].name].limit = itemResult[i].limit
		itemInformation[itemResult[i].name].rare = itemResult[i].rare
		itemInformation[itemResult[i].name].can_remove = itemResult[i].can_remove
		itemInformation[itemResult[i].name].price = itemResult[i].price

		if shoptype == "normal" then
			for _, v in pairs(customInventory.Items) do
				if v.name == itemResult[i].name then
					table.insert(itemShopList, {
						type = "item_standard",
						name = itemInformation[itemResult[i].name].name,
						label = itemInformation[itemResult[i].name].label,
						limit = itemInformation[itemResult[i].name].limit,
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
						--limit = 1,
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
						--limit = 1,
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
						--limit = itemInformation[itemResult[i].name].limit,
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

RegisterNetEvent("suku:SellItemToPlayer")
AddEventHandler("suku:SellItemToPlayer",function(source, type, item, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type == "item_standard" then
		local targetItem = xPlayer.getInventoryItem(item)
		if xPlayer.canCarryItem(item, count) then
        --if targetItem.limit == -1 or ((targetItem.count + count) <= targetItem.limit) then
            local list = itemShopList
            for i = 1, #list, 1 do
				if list[i].name == item then
					local totalPrice = count * list[i].price
					if xPlayer.getMoney() >= totalPrice then
						xPlayer.removeMoney(totalPrice)
						xPlayer.addInventoryItem(item, count)
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You purchased '..count.." "..list[i].label })
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have enough money!' })
					end
				end
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have enough space in your inventory!' })
        end
	end
	
	if type == "item_weapon" then
        local targetItem = xPlayer.getInventoryItem(item)
        if targetItem.count < 1 then
            local list = itemShopList
            for i = 1, #list, 1 do
				if list[i].name == item then
					local targetWeapon = xPlayer.hasWeapon(tostring(list[i].name)) 
					if not targetWeapon then
						local totalPrice = 1 * list[i].price
						if xPlayer.getMoney() >= totalPrice then
							xPlayer.removeMoney(totalPrice)
							xPlayer.addWeapon(list[i].name, list[i].ammo)
							TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You purchased a '..list[i].label })
						else
							TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have enough money!' })
						end
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You already own this weapon!' })
					end
				end
            end
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You already own this weapon!' })
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
						TriggerClientEvent("suku:AddAmmoToWeapon", source, list[i].weaponhash, ammo)
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'You purchased '..count.." "..list[i].label })
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not have enough money!' })
					end
				else
					TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You do not own the weapon for this ammo type!' })
				end
            end
        end
    end
end)
