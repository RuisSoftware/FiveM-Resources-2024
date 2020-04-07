=============================================================

## Disable default esx inventory:

Open `es_extended`, then find and remove this code in `client/main.lua`:
```
-- Menu interactions
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if IsControlJustReleased(0, Keys['F2']) and IsInputDisabled(0) and not isDead and not ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
			ESX.ShowInventory()
		end

	end
end)
```

=============================================================

## Add support for `esx_properties`:
## edited esx_property:
https://github.com/Nertigel/esx_property

Open `esx_property/client/main.lua` and do the following:
Find this code in OpenRoomMenu function:
```
			table.insert(elements, {label = _U('remove_object'),  value = 'room_inventory'})
			table.insert(elements, {label = _U('deposit_object'), value = 'player_inventory'})
```

And replace it with:
```
			table.insert(elements, {label = "Property inventory", value = "property_inventory"}
```

Then find this code:
```
			elseif data.current.value == 'room_inventory' then
				OpenRoomInventoryMenu(property, owner)
			elseif data.current.value == 'player_inventory' then
				OpenPlayerInventoryMenu(property, owner)
```

And replace it with:
```
			elseif data.current.value == "property_inventory" then
				menu.close()
				OpenPropertyInventoryMenu(property, owner)
```
      
And finally add this function:
```
function OpenPropertyInventoryMenu(property, owner)
	ESX.TriggerServerCallback("esx_property:getPropertyInventory", function(inventory)
		TriggerEvent("esx_inventoryhud:openPropertyInventory", inventory)
	end, owner)
end
```
      
=============================================================

## Add suport for `esx_policejob` etc...

Open `esx_policejob/client/main.lua`

Find function: OpenBodySearchMenu(player) and remove it
Add this code: 
```
function OpenBodySearchMenu(player)
	TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end
```

=============================================================

## Add support for `esx_aiomenu`:

Replace `esx_inventoryhud/client/main.lua`
```
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
                openInventory()
            end
        end
    end
```
    
with: 
```
--[[Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustReleased(0, Config.OpenControl) and IsInputDisabled(0) then
                openInventory()
            end
        end
    end
)--]]
```

Then add to `esx_inventoryhud/__resource.lua`:
```
exports {
	'openInventory'
}
```

And replace in `esx_aiomenu/client/main.lua`:
```
RegisterNUICallback('NUIopenInventory', function()
	exports['es_extended']:openInventory()
end)
```

With:
```
RegisterNUICallback('NUIopenInventory', function()
	exports['esx_inventoryhud']:openInventory()
end)
```

=============================================================

## Fix for `esx_addoninventory`:

Go to `esx_addoninventory\server\classes\addoninventory.lua` line 39
Replace `label = Items[name]` to `label = items[name]`

=============================================================
