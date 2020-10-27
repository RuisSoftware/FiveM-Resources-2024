ESX = nil
Items = {}
local DataStoresIndex = {}
local DataStores = {}
local SharedDataStores = {}
local arrayWeight = Config.localWeight
local VehicleList = {}
local VehicleInventory = {}

local listPlate = Config.VehiclePlate

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

AddEventHandler("onMySQLReady", function()
    local result = MySQL.Sync.fetchAll("SELECT * FROM trunk_inventory")
    local data = nil
    if #result ~= 0 then
      for i = 1, #result, 1 do
        local plate = result[i].plate
        local owned = result[i].owned
        local data = (result[i].data == nil and {} or json.decode(result[i].data))
        local dataStore = CreateDataStore(plate, owned, data)
        SharedDataStores[plate] = dataStore
      end
    end
    MySQL.Async.execute("DELETE FROM `trunk_inventory` WHERE `owned` = 0", {})
end)

function loadInventTrunk(plate)
  local result =
    MySQL.Sync.fetchAll(
    "SELECT * FROM trunk_inventory WHERE plate = @plate",
    {
      ["@plate"] = plate
    }
  )
  local data = nil
  if #result ~= 0 then
    for i = 1, #result, 1 do
      local plate = result[i].plate
      local owned = result[i].owned
      local data = (result[i].data == nil and {} or json.decode(result[i].data))
      local dataStore = CreateDataStore(plate, owned, data)
      SharedDataStores[plate] = dataStore
    end
  end
end

function getOwnedVehicle(plate)
  local found = false
  if listPlate then
    for k, v in pairs(listPlate) do
      if string.find(plate, v) ~= nil then
        found = true
        break
      end
    end
  end
  if not found then
    local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles")
    while result == nil do
      Wait(5)
    end
    if result ~= nil and #result > 0 then
      for _, v in pairs(result) do
        local vehicle = json.decode(v.vehicle)
        if vehicle.plate == plate then
          found = true
          break
        end
      end
    end
  end
  return found
end

function MakeDataStoreTrunk(plate)
	local data = {}
	local owned = getOwnedVehicle(plate)
	local dataStore = CreateDataStore(plate, owned, data)
	SharedDataStores[plate] = dataStore
	MySQL.Async.execute("INSERT INTO trunk_inventory(plate,data,owned) VALUES (@plate,'{}',@owned)",
		{
			["@plate"] = plate,
			["@owned"] = owned
		}
	)
	loadInventTrunk(plate)
end

function GetSharedDataStoreTrunk(plate)
  if SharedDataStores[plate] == nil then
    MakeDataStoreTrunk(plate)
  end
  return SharedDataStores[plate]
end

AddEventHandler("esx_trunk:GetSharedDataStoreTrunk", function(plate, cb)
    cb(GetSharedDataStoreTrunk(plate))
end)

RegisterServerEvent("esx_trunk_inventory:getOwnedVehicle")
AddEventHandler("esx_trunk_inventory:getOwnedVehicle", function()
    local vehicules = {}
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll(
      "SELECT * FROM owned_vehicles WHERE owner = @owner",
      {
        ["@owner"] = xPlayer.identifier
      },
      function(result)
        if result ~= nil and #result > 0 then
          for _, v in pairs(result) do
            local vehicle = json.decode(v.vehicle)
            table.insert(vehicules, {plate = vehicle.plate})
          end
        end
        TriggerClientEvent("esx_trunk_inventory:setOwnedVehicule", _source, vehicules)
      end)
end)

function getItemWeight(item)
  local weight = 0
  local itemWeight = 0
  if item ~= nil then
    itemWeight = Config.DefaultWeight
    if arrayWeight[item] ~= nil then
      itemWeight = arrayWeight[item]
    end
  end
  return itemWeight
end

function getInventoryWeightTrunk(inventory)
  local weight = 0
  local itemWeight = 0
  if inventory ~= nil then
    for i = 1, #inventory, 1 do
      if inventory[i] ~= nil then
        itemWeight = Config.DefaultWeight
        if arrayWeight[inventory[i].name] ~= nil then
          itemWeight = arrayWeight[inventory[i].name]
        end
        weight = weight + (itemWeight * (inventory[i].count or 1))
      end
    end
  end
  return weight
end

function getTotalInventoryWeightTrunk(plate)
  local total
  TriggerEvent("esx_trunk:GetSharedDataStoreTrunk", plate, function(store)
      local W_weapons = getInventoryWeightTrunk(store.get("weapons") or {})
      local W_coffre = getInventoryWeightTrunk(store.get("coffre") or {})
      local W_blackMoney = 0
      local blackAccount = (store.get("black_money")) or 0
      if blackAccount ~= 0 then
        W_blackMoney = blackAccount[1].amount / 10
      end
	  
	  local W_cashMoney = 0
      local cashAccount = (store.get("money")) or 0
      if cashAccount ~= 0 then
        W_cashMoney = cashAccount[1].amount / 10
      end
      total = W_weapons + W_coffre + W_blackMoney + W_cashMoney
    end)
  return total
end

ESX.RegisterServerCallback("esx_trunk:getInventoryV", function(source, cb, plate)
    TriggerEvent("esx_trunk:GetSharedDataStoreTrunk", plate, function(store)
        local blackMoney = 0
		local cashMoney = 0
        local items = {}
        local weapons = {}
        weapons = (store.get("weapons") or {})

        local blackAccount = (store.get("black_money")) or 0
        if blackAccount ~= 0 then
          blackMoney = blackAccount[1].amount
        end

	local cashAccount = (store.get("money")) or 0
        if cashAccount ~= 0 then
          cashMoney = cashAccount[1].amount
        end

        local coffre = (store.get("coffre") or {})
        for i = 1, #coffre, 1 do
          table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
        end

        local weight = getTotalInventoryWeightTrunk(plate)
        cb(
          {
            blackMoney = blackMoney,
			cashMoney = cashMoney,
            items = items,
            weapons = weapons,
            weight = weight
          }
        )
      end)
end)

RegisterServerEvent("esx_trunk:getItem")
AddEventHandler("esx_trunk:getItem", function(plate, type, item, count, max, owned)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if type == "item_standard" then
      local targetItem = xPlayer.getInventoryItem(item)
		if xPlayer.canCarryItem(item, count) then
     -- if targetItem.weight == -1 or ((targetItem.count + count) <= 50) then
        TriggerEvent(
          "esx_trunk:GetSharedDataStoreTrunk",
          plate,
          function(store)
            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                if (coffre[i].count >= count and count > 0) then
                  xPlayer.addInventoryItem(item, count)
                  if (coffre[i].count - count) == 0 then
                    table.remove(coffre, i)
                  else
                    coffre[i].count = coffre[i].count - count
                  end

                  break
                else
                
				TriggerClientEvent('b1g_notify:client:Notify', _source, { type = 'true', text = _U("invalid_quantity") })
                end
              end
            end

            store.set("coffre", coffre)

            local blackMoney = 0
			local cashMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end
			
			local cashAccount = (store.get("money")) or 0
			if cashAccount ~= 0 then
			  cashMoney = cashAccount[1].amount
			end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeightTrunk(plate)

            text = _U("trunk_info", plate, (weight / 100), (max / 100))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, cashMoney, items, weapons)
          end)
      else
      
				TriggerClientEvent('b1g_notify:client:Notify', _source, { type = 'false', text = _U("player_inv_no_space") })
      end
    end

    if type == "item_account" then
      TriggerEvent("esx_trunk:GetSharedDataStoreTrunk", plate, function(store)
          local blackMoney = store.get("black_money")
          if (blackMoney[1].amount >= count and count > 0) then
            blackMoney[1].amount = blackMoney[1].amount - count
            store.set("black_money", blackMoney)
            xPlayer.addAccountMoney(item, count)

            local blackMoney = 0
	    local cashMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end
			
			local cashAccount = (store.get("money")) or 0
			if cashAccount ~= 0 then
			  cashMoney = cashAccount[1].amount
			end

            local coffre = (store.get("coffre") or {})
            for i = 1, #coffre, 1 do
              table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
            end

            local weight = getTotalInventoryWeightTrunk(plate)

            text = _U("trunk_info", plate, (weight / 100), (max / 100))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, cashMoney, items, weapons)
          else
			TriggerClientEvent('b1g_notify:client:Notify', _source, { type = 'true', text = _U("invalid_amount") })
          end
        end)
    end
	
	if type == "item_money" then
      TriggerEvent("esx_trunk:GetSharedDataStoreTrunk", plate, function(store)
          local cashMoney = store.get("money")
          if (cashMoney[1].amount >= count and count > 0) then
            cashMoney[1].amount = cashMoney[1].amount - count
            store.set("money", cashMoney)
            xPlayer.addMoney(count)

            local blackMoney = 0
	    local cashMoney = 0
            local items = {}
            local weapons = {}
            weapons = (store.get("weapons") or {})

            local blackAccount = (store.get("black_money")) or 0
            if blackAccount ~= 0 then
              blackMoney = blackAccount[1].amount
            end
			
			local cashAccount = (store.get("money")) or 0
			if cashAccount ~= 0 then
			  cashMoney = cashAccount[1].amount
			end

            local coffres = (store.get("coffres") or {})
            for i = 1, #coffres, 1 do
              table.insert(items, {name = coffres[i].name, count = coffres[i].count, label = ESX.GetItemLabel(coffres[i].name)})
            end

            local weight = getTotalInventoryWeightTrunk(plate)

            text = _U("trunk_info", plate, (weight / 100), (max / 100))
            data = {plate = plate, max = max, myVeh = owned, text = text}
            TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, cashMoney, items, weapons)
          else
            TriggerClientEvent("pNotify:SendNotification", _source,
              {
                text = _U("invalid_amount"),
                type = "error",
                queue = "trunk",
                timeout = 3000,
                layout = "bottomCenter"
              }
            )
          end
        end)
    end

    if type == "item_weapon" then
      TriggerEvent("esx_trunk:GetSharedDataStoreTrunk", plate, function(store)
          local storeWeapons = store.get("weapons")

          if storeWeapons == nil then
            storeWeapons = {}
          end

          local weaponName = nil
          local ammo = nil

          for i = 1, #storeWeapons, 1 do
            if storeWeapons[i].name == item then
              weaponName = storeWeapons[i].name
              ammo = storeWeapons[i].ammo

              table.remove(storeWeapons, i)

              break
            end
          end

          store.set("weapons", storeWeapons)

          xPlayer.addWeapon(weaponName, ammo)

          local blackMoney = 0
	  local cashMoney = 0
          local items = {}
          local weapons = {}
          weapons = (store.get("weapons") or {})

          local blackAccount = (store.get("black_money")) or 0
          if blackAccount ~= 0 then
            blackMoney = blackAccount[1].amount
          end
		  
		  local cashAccount = (store.get("money")) or 0
		  if cashAccount ~= 0 then
		    cashMoney = cashAccount[1].amount
		  end

          local coffre = (store.get("coffre") or {})
          for i = 1, #coffre, 1 do
            table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
          end

          local weight = getTotalInventoryWeightTrunk(plate)

          text = _U("trunk_info", plate, (weight / 100), (max / 100))
          data = {plate = plate, max = max, myVeh = owned, text = text}
          TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, cashMoney, items, weapons)
        end)
    end
end)

RegisterServerEvent("esx_trunk:putItem")
AddEventHandler("esx_trunk:putItem", function(plate, type, item, count, max, owned, label)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayerOwner = ESX.GetPlayerFromIdentifier(owner)

    if type == "item_standard" then
      local playerItemCount = xPlayer.getInventoryItem(item).count

      if (playerItemCount >= count and count > 0) then
        TriggerEvent(
          "esx_trunk:GetSharedDataStoreTrunk",
          plate,
          function(store)
            local found = false
            local coffre = (store.get("coffre") or {})

            for i = 1, #coffre, 1 do
              if coffre[i].name == item then
                coffre[i].count = coffre[i].count + count
                found = true
              end
            end
            if not found then
              table.insert(
                coffre,
                {
                  name = item,
                  count = count
                }
              )
            end
            if (getTotalInventoryWeightTrunk(plate) + (getItemWeight(item) * count)) > max then
      
				TriggerClientEvent('b1g_notify:client:Notify', _source, { type = 'true', text = _U("insufficient_space") })
            else
              -- Checks passed, storing the item.
              store.set("coffre", coffre)
              xPlayer.removeInventoryItem(item, count)

              MySQL.Async.execute(
                "UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate",
                {
                  ["@plate"] = plate,
                  ["@owned"] = owned
                }
              )
            end
          end)
      else
    
				TriggerClientEvent('b1g_notify:client:Notify', _source, { type = 'true', text = _U("invalid_quantity") })
      end
    end

    if type == "item_account" then
      local playerAccountMoney = xPlayer.getAccount(item).money

      if (playerAccountMoney >= count and count > 0) then
        TriggerEvent("esx_trunk:GetSharedDataStoreTrunk", plate, function(store)
            local blackMoney = (store.get("black_money") or nil)
            if blackMoney ~= nil then
              blackMoney[1].amount = blackMoney[1].amount + count
            else
              blackMoney = {}
              table.insert(blackMoney, {amount = count})
            end

            if (getTotalInventoryWeightTrunk(plate) + blackMoney[1].amount / 10) > max then
         
				TriggerClientEvent('b1g_notify:client:Notify', _source, { type = 'true', text = _U("insufficient_space") })
            else
              -- Checks passed. Storing the item.
              xPlayer.removeAccountMoney(item, count)
              store.set("black_money", blackMoney)

              MySQL.Async.execute(
                "UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate",
                {
                  ["@plate"] = plate,
                  ["@owned"] = owned
                }
              )
            end
          end)
      else
		TriggerClientEvent('b1g_notify:client:Notify', _source, { type = 'true', text = _U("invalid_amount") })
      end
    end
	
	if type == "item_money" then
      local playerAccountMoney = xPlayer.getMoney()

      if (playerAccountMoney >= count and count > 0) then
        TriggerEvent("esx_trunk:GetSharedDataStoreTrunk", plate, function(store)
            local cashMoney = (store.get("money") or nil)
            if cashMoney ~= nil then
              cashMoney[1].amount = cashMoney[1].amount + count
            else
              cashMoney = {}
              table.insert(cashMoney, {amount = count})
            end

            if (getTotalInventoryWeightTrunk(plate) + cashMoney[1].amount / 10) > max then
            
				TriggerClientEvent('b1g_notify:client:Notify', _source, { type = 'true', text = _U("insufficient_space") })
            else
              -- Checks passed. Storing the item.
              xPlayer.removeMoney(count)
              store.set("money", cashMoney)

              MySQL.Async.execute(
                "UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate",
                {
                  ["@plate"] = plate,
                  ["@owned"] = owned
                }
              )
            end
          end)
      else
		TriggerClientEvent('b1g_notify:client:Notify', _source, { type = 'true', text = _U("invalid_amount") })
      end
    end

	if type == "item_weapon" then
		if xPlayer.hasWeapon(item) then
			TriggerEvent("esx_trunk:GetSharedDataStoreTrunk",plate,function(store)
				xPlayer.removeWeapon(item)
				store.set("weapons", storeWeapons)

				MySQL.Async.execute(
				  "UPDATE trunk_inventory SET owned = @owned WHERE plate = @plate",
				  {
					["@plate"] = plate,
					["@owned"] = owned
				  }
				)
			end)
		end
	end

    TriggerEvent("esx_trunk:GetSharedDataStoreTrunk", plate, function(store)
        local blackMoney = 0
		local cashMoney = 0
        local items = {}
        local weapons = {}
        weapons = (store.get("weapons") or {})

        local blackAccount = (store.get("black_money")) or 0
        if blackAccount ~= 0 then
          blackMoney = blackAccount[1].amount
        end
		
		local cashAccount = (store.get("money")) or 0
        if cashAccount ~= 0 then
          cashMoney = cashAccount[1].amount
        end

        local coffre = (store.get("coffre") or {})
        for i = 1, #coffre, 1 do
          table.insert(items, {name = coffre[i].name, count = coffre[i].count, label = ESX.GetItemLabel(coffre[i].name)})
        end

        local weight = getTotalInventoryWeightTrunk(plate)

        text = _U("trunk_info", plate, (weight / 100), (max / 100))
        data = {plate = plate, max = max, myVeh = owned, text = text}
        TriggerClientEvent("esx_inventoryhud:refreshTrunkInventory", _source, data, blackMoney, cashMoney, items, weapons)
      end)
end)

ESX.RegisterServerCallback("esx_trunk:getPlayerInventory", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = xPlayer.getAccount("black_money").money
	local cashMoney = xPlayer.getMoney()
    local items = xPlayer.inventory

    cb(
      {
        blackMoney = blackMoney,
		cashMoney = cashMoney,
        items = items
      }
    )
end)

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end

