# Dutch Players Edit // esx-inventoryhud // esx jobs support
Add suport for `esx_policejob` etc...

Open `esx_policejob/client/main.lua`

Find function: OpenBodySearchMenu(player) and remove it.
Add this code: 
```
function OpenBodySearchMenu(player)
	TriggerEvent("esx_inventoryhud:openPlayerInventory", GetPlayerServerId(player), GetPlayerName(player))
end
```

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

# Original threads: 
https://forum.fivem.net/t/esx-inventoryhud-glovebox/687328

https://forum.fivem.net/t/release-esx-inventory-hud-2-0/388318

https://forum.fivem.net/t/addon-esx-inventory-hud-vehicle-trunk/458152
