# Dutch Players Edit // esx-inventoryhud // esx_property support
To add property support, do the following: 
------------
1a. `Open `esx_property/client/main.lua` and do the following:
Find this code in OpenRoomMenu function:
```
			table.insert(elements, {label = _U('remove_object'),  value = 'room_inventory'})
			table.insert(elements, {label = _U('deposit_object'), value = 'player_inventory'})
```

1b. And replace it with:
```
			table.insert(elements, {label = "Property inventory", value = "property_inventory"}
```

2a. Then find this code:
```
			elseif data.current.value == 'room_inventory' then
				OpenRoomInventoryMenu(property, owner)
			elseif data.current.value == 'player_inventory' then
				OpenPlayerInventoryMenu(property, owner)
```

2b. And replace it with:
```
			elseif data.current.value == "property_inventory" then
				menu.close()
				OpenPropertyInventoryMenu(property, owner)
```
      
3. And finally add this function:
```
function OpenPropertyInventoryMenu(property, owner)
	ESX.TriggerServerCallback("esx_property:getPropertyInventory", function(inventory)
		TriggerEvent("esx_inventoryhud:openPropertyInventory", inventory)
	end, owner)
end`
```
    
# Original threads: 
https://forum.fivem.net/t/esx-inventoryhud-glovebox/687328

https://forum.fivem.net/t/release-esx-inventory-hud-2-0/388318

https://forum.fivem.net/t/addon-esx-inventory-hud-vehicle-trunk/458152
