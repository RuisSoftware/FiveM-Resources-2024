# Dutch Players Edit // esx-inventoryhud // SUPPORTED ESX 1.2 // IMPORTANT TO READ!
All working inventory hud which are taken offline
I did not make any of these scripts, i only edited a bit. I do not take any credits.

I uploaded this because multiple ESX inventory huds are taken offline.
Somewere i try updating this, but i am an amateur. Please do pull requests if you know better!

Currently this is working (somehow) on our 64 players ESX 1.2 OneSync server, but we do have an issue:
- Users can stack their items unlimited. I needed to update most of other resources to check weight/limit. 


Requirements
------------
- es_extended
- pNotify (or change the lines)

Installation
------------
You need to do a couple steps to get it working.
First you start adding the resources to your server.cfg.
server.cfg
------------
- Put all folders in your resources folder and start:
```
start esx_inventoryhud
start esx_inventoryhud_trunk
start esx_inventoryhud_glovebox
```

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

To add glovebox support, do the following: 
------------


Features
------------

    Drag and drop
    Using items
    Dropping items
    Giving items
    Cash included -- UNUSABLE AT THE MOMENT
    Accounts support (bank, black money, ...)
    Weapons support
    esx_property support
    Another players inventory support
    Fully configurable (check config.lua and html/js/config.js)
    Locale files included (check locales/ and html/locales/ directories)


Screens
------------

    https://i.imgur.com/eHD01Tl.png
    

Language
------------
Currently i have translated the inventory to Dutch - Netherlands. Please change it yourself.
    
    
Follow this also: https://github.com/nertigel/esx_inventoryhud
------------

Original threads and credits to the owners: 
https://forum.fivem.net/t/esx-inventoryhud-glovebox/687328

https://forum.fivem.net/t/release-esx-inventory-hud-2-0/388318

https://forum.fivem.net/t/addon-esx-inventory-hud-vehicle-trunk/458152
