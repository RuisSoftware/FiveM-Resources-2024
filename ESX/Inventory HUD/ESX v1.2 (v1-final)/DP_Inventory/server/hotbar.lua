RegisterNetEvent('DP_Inventory:slotPut')
AddEventHandler('DP_Inventory:slotPut', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item,1)
	MySQL.Async.fetchAll('SELECT * FROM inventory_hotbar WHERE owner = @owner AND slot = @slot', {
		['@owner'] =  xPlayer.identifier,
		['@slot'] = 1
	},function(results)
		if #results == 0 then
			MySQL.Async.execute('INSERT INTO inventory_hotbar (owner, item, slot) VALUES (@owner, @item, @slot)', {
				['@owner'] = xPlayer.identifier,
				['@item'] = item,
				['@slot'] = 1,
			})
		else
			MySQL.Async.fetchAll('SELECT * FROM inventory_hotbar WHERE owner = @owner AND slot = @slot', {
				['@owner'] =  xPlayer.identifier,
				['@slot'] = 2
			},function(results2)
				if #results2 == 0 then
					MySQL.Async.execute('INSERT INTO inventory_hotbar (owner, item, slot) VALUES (@owner, @item, @slot)', {
						['@owner'] = xPlayer.identifier,
						['@item'] = item,
						['@slot'] = 2,
					})
				else
					MySQL.Async.fetchAll('SELECT * FROM inventory_hotbar WHERE owner = @owner AND slot = @slot', {
						['@owner'] =  xPlayer.identifier,
						['@slot'] = 3
					},function(results3)
						if #results3 == 0 then
							MySQL.Async.execute('INSERT INTO inventory_hotbar (owner, item, slot) VALUES (@owner, @item, @slot)', {
								['@owner'] = xPlayer.identifier,
								['@item'] = item,
								['@slot'] = 3,
							})
						else
							MySQL.Async.fetchAll('SELECT * FROM inventory_hotbar WHERE owner = @owner AND slot = @slot', {
								['@owner'] =  xPlayer.identifier,
								['@slot'] = 4
							},function(results4)
								if #results4 == 0 then
									MySQL.Async.execute('INSERT INTO inventory_hotbar (owner, item, slot) VALUES (@owner, @item, @slot)', {
										['@owner'] = xPlayer.identifier,
										['@item'] = item,
										['@slot'] = 4,
									})
								else
									MySQL.Async.fetchAll('SELECT * FROM inventory_hotbar WHERE owner = @owner AND slot = @slot', {
										['@owner'] =  xPlayer.identifier,
										['@slot'] = 5
									},function(results5)
										if #results5 == 0 then
											MySQL.Async.execute('INSERT INTO inventory_hotbar (owner, item, slot) VALUES (@owner, @item, @slot)', {
												['@owner'] = xPlayer.identifier,
												['@item'] = item,
												['@slot'] = 5,
											})
										else
											MySQL.Sync.execute("DELETE FROM inventory_hotbar WHERE `owner` = @owner AND slot = @slot", {
												['@owner'] = xPlayer.identifier,
												['@slot'] = 5,
											}, function(succes)
												if succes then
													MySQL.Async.execute('INSERT INTO inventory_hotbar (owner, item, slot) VALUES (@owner, @item, @slot)', {
														['@owner'] = xPlayer.identifier,
														['@item'] = item,
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

RegisterNetEvent('DP_Inventory:putInToSlot')
AddEventHandler('DP_Inventory:putInToSlot',function(item, slot)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM inventory_hotbar WHERE item = @item AND owner = @owner AND slot = @slot', {
        ['@item'] = item,
		['@owner'] =  xPlayer.identifier,
		['@slot'] = slot
	},function(results)
		if #results == 0 then
			MySQL.Async.execute('INSERT INTO inventory_hotbar (owner, item, slot) VALUES (@owner, @item, @slot)', {
				['@owner'] = xPlayer.identifier,
				['@item'] = item,
				['@slot'] = slot,
			})
		end
    end)
end)

RegisterNetEvent('DP_Inventory:removeFromSlot')
AddEventHandler('DP_Inventory:removeFromSlot',function(item, slot)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Sync.execute("DELETE FROM inventory_hotbar WHERE `owner` = @owner AND item = @item", {
		['@owner'] = xPlayer.identifier,
		['@item'] = item,
	})
end)
