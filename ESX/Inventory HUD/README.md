# Dutch Players Inventory // ESX 1.2 ONLY
# Important
 Go to you es_extended/server/main.lua line 423 the event name is esx:onPickup and add after line 430 this code
 ```lua
if pickup.weaponID ~= nil then
	TriggerEvent('DP_Inventory:weaponID', pickup.weaponID, xPlayer.identifier)
end
```
Very important so when somebody pick the weapon from ground is the same it should like like that after
 ![IMPORTANT](https://imgur.com/XnC2QIk.png)
    Then go to es_extended/server/functions.lua line 285 and add this
 ```lua
if name == 'WEAPON_PISTOL' or name == 'WEAPON_FLASHLIGHT' or name == 'WEAPON_STUNGUN' or name == 'WEAPON_KNIFE' or name == 'WEAPON_BAT' or name == 'WEAPON_ADVANCEDRIFLE' or name == 'WEAPON_APPISTOL' or name == 'WEAPON_ASSAULTRIFLE'
or name == 'WEAPON_ASSAULTSHOTGUN' or name == 'WEAPON_ASSAULTSMG' or name == 'WEAPON_AUTOSHOTGUN' or name == 'WEAPON_CARBINERIFLE' or name == 'WEAPON_SNIPERRIFLE' or name == 'WEAPON_COMBATPISTOL' or name == 'WEAPON_PUMPSHOTGUN' or name == 'WEAPON_SMG' then
	local hash = GetHashKey(name)
	MySQL.Async.fetchAll('SELECT * FROM ammunition WHERE hash = @hash AND owner = @owner', {
		['@hash'] = hash,
		['@owner'] =  xPlayer.identifier
	},function(results)
		if #results ~= 0 then
			if results[1].weapon_id then
				ESX.Pickups[pickupId].weaponID = results[1].weapon_id
				MySQL.Async.execute('UPDATE ammunition SET owner = @owner WHERE id = @id and hash = @hash and weapon_id = @weapon_id', {
					['@id'] = results[1].id,
					['@owner'] = nil,
					['@weapon_id'] = results[1].weapon_id,
					['@hash'] = hash
				}, function(results2)
				end)
			else
				ESX.Pickups[pickupId].weaponID = nil
			end
		end
	end)
end
```
    so it looks like that
![IMPORTANT](https://imgur.com/Umzssai.png)

![welcome](https://www.gemeentenieuwstad.nl/wp-content/uploads/2020/10/welcome.png)
If you are using another weapon shop we have added a support for that you just simple do this when you are giving the weapon to the player.
You have to change some names this is an exmaple that i am using just change the attachment table and if you have a value in there that is not an attachment just blacklist it like the tint value in the `example:`
```lua
local wepInfo = {}
wepInfo.count = 100
wepInfo.weapon_id = exports['DP_Inventory']:GenerateWeapon()
if cachedData["attachedComponents"] ~= nil then
	wepInfo.attach = {}
	for k,v in pairs(cachedData["attachedComponents"]) do
		if k ~= 'tint' then
			table.insert(wepInfo.attach, k)
		end
	end
end
local skin = GetPedWeaponTintIndex(cachedData["ped"], GetHashKey(weaponModel))
skin = 'skin'..skin
table.insert(wepInfo.attach, skin)
TriggerServerEvent('dp_inventory:updateAmmoCount', GetHashKey(weaponModel), wepInfo)
local addToSlote = true
TriggerEvent('dp_inventory:addCurrentWeapon', weaponModel, wepInfo, addToSlote)
```

For police job you ca do like that and when they buy it its going to have a unique weapon id.
This is clined line 1092
```lua
local hasWeapon = false
for number,items in pairs(PlayerData.inventory) do
	if items.name == v.weapon then 
		hasWeapon = true
	end
end
```
esx_policejob/client/main.lua line 1184 replace all with the code
```lua
function OpenWeaponComponentShop(components, weaponName, parentShop)
	ESX.TriggerServerCallback('DP_Inventory:getAttachments', function(componentsDB)
		for i=1,#components do
			if type(components[i]) == 'table' then
				for k,v in pairs(components[i]) do
					if k == 'name' then
						if v == 'clip_default' then
							table.remove(components, i)
						end
					end
				end
			end
			if componentsDB ~= nil then
				for j=i, #componentsDB do
					if components[i] ~= nil then
						if componentsDB[j] == components[i].name then
							components[i].label = ('%s: <span style="color:green;">%s</span>'):format(components[i].componentNameL, _U('armory_owned'))
							components[i].hasComponent = true
						elseif componentsDB[j] == 'mag' and components[i].name == 'clip_extended' then
							components[i].label = ('%s: <span style="color:green;">%s</span>'):format(components[i].componentNameL, _U('armory_owned'))
							components[i].hasComponent = true
						end
					end
				end
			end
		end
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
			title    = _U('armory_componenttitle'),
			align    = 'top-left',
			elements = components
		}, function(data, menu)
			if data.current.hasComponent then
				ESX.ShowNotification(_U('armory_hascomponent'))
			else
				ESX.TriggerServerCallback('esx_policejob:buyWeapon', function(bought)
					if bought then
						if data.current.price > 0 then
							ESX.ShowNotification(_U('armory_bought', data.current.componentLabel, ESX.Math.GroupDigits(data.current.price)))
						end
	
						menu.close()
						parentShop.close()
						OpenBuyWeaponsMenu()
					else
						ESX.ShowNotification(_U('armory_money'))
					end
				end, weaponName, 2, data.current.componentNum)
			end
		end, function(data, menu)
			menu.close()
		end)
	end, weaponName)
end
```
esx_policejob/server/main.lua line 371 replace all with the code
```lua
ESX.RegisterServerCallback('esx_policejob:buyWeapon', function(source, cb, weaponName, type, componentNum)
	local xPlayer = ESX.GetPlayerFromId(source)
	local authorizedWeapons, selectedWeapon = Config.AuthorizedWeapons[xPlayer.job.grade_name]

	for k,v in ipairs(authorizedWeapons) do
		if v.weapon == weaponName then
			selectedWeapon = v
			break
		end
	end

	if not selectedWeapon then
		print(('esx_policejob: %s attempted to buy an invalid weapon.'):format(xPlayer.identifier))
		cb(false)
	else
		-- Weapon
		if type == 1 then
			if xPlayer.getMoney() >= selectedWeapon.price then
				xPlayer.removeMoney(selectedWeapon.price)
				TriggerClientEvent('DP_Inventory:buyWeaponPolice', source, xPlayer, weaponName, 14)
				cb(true)
			else
				cb(false)
			end

		-- Weapon Component
		elseif type == 2 then
			local price = selectedWeapon.components[componentNum]
			local weaponNum, weapon = ESX.GetWeapon(weaponName)
			local component = weapon.components[componentNum]

			if component then
				if xPlayer.getMoney() >= price then
					xPlayer.removeMoney(price)
					local compName = component.name
					if compName == 'clip_extended' then
						compName = 'mag'
					end
					TriggerEvent('DP_Inventory:giveWeaponComponent',xPlayer, compName, weaponName)
					cb(true)
				else
					cb(false)
				end
			else
				print(('esx_policejob: %s attempted to buy an invalid weapon component.'):format(xPlayer.identifier))
				cb(false)
			end
		end
	end
end)
```
Your number 1 inventory for ESX 1.2!

We have edited the original esx_inventoryhud resource from [Trsak](https://forum.cfx.re/t/release-esx-inventory-hud-2-4-properties-trunks-players-shops-storages/).

This inventory only works with the latest version of ESX. You can download v1-final here: https://github.com/esx-framework/es_extended/tree/v1-final

Your help is much appreciated in a pull request!

We did not make any of these scripts. We do not take any credits. Did we forget to mention you in the credits? Then let us know in our Discord server or create an issue!
    
> Read other support files to make esx_inventoryhud work with esx_policejob and esx_property!

![features](https://www.gemeentenieuwstad.nl/wp-content/uploads/2020/10/features.png)
- Drag and drop to use an item
- Double click to use an item
- Dropping items and pick them up
- Giving items to other players
- Item hotbar with saved position in database
- Use item by 1-5 key
- Accounts support (bank, black money, ...)
- Weapons and ammunition clips as item
- Weapon attachements (like a flashlight on your pistol)
- Configurable shops in config (police, nightclub, blackmarket, weapons)
- Property support (esx_property)
- Motels support (lsrp-motels)
- Rentable lockers (integrated)
- Trunk support (integrated)
- Glovebox support (integrated)
- Bag support (integrated)
- Pocket support (integrated)
- Another players inventory support (rob somebody)
- Fully configurable (check config.lua and html/js/config.js)
- Multiple languages supported (check locales/ and html/locales/ directories)
- Multiple styles (minimum resolution is 720p and maximum is 4K)

![bugs](https://www.gemeentenieuwstad.nl/wp-content/uploads/2020/10/sendpr.png)
The latest MySQL plugin could break this resource! Only use: https://github.com/dutchplayers/MySQL-for-ESX-Inventory-HUD
Do you have an improvement or bugfix? Feel free to share it in a Pull Request! 

![languages](https://www.gemeentenieuwstad.nl/wp-content/uploads/2020/10/languages.png)
Currently 9 supported languages! Spread some ❤️ and send your language in a Pull Request or to Discord.

![screenshots](https://www.gemeentenieuwstad.nl/wp-content/uploads/2020/10/screenshots.png)
Itembar:
![1](https://raw.githubusercontent.com/dutchplayers/ESX-1.2-Inventory-HUD/master/Example_01.jpg)
Pocket inventory:
![2](https://raw.githubusercontent.com/dutchplayers/ESX-1.2-Inventory-HUD/master/example_02.jpg)
Bag inventory:
![3](https://cdn.discordapp.com/attachments/538834196458897408/779952927376539728/DP_Inventory.jpg)
Glovebox inventory:
![4](https://raw.githubusercontent.com/dutchplayers/ESX-1.2-Inventory-HUD/master/example_04.jpg)
Trunk inventory:
![5](https://raw.githubusercontent.com/dutchplayers/ESX-1.2-Inventory-HUD/master/example_05.jpg)
Job vault inventory:
![6](https://raw.githubusercontent.com/dutchplayers/ESX-1.2-Inventory-HUD/master/example_06.jpg)
A supermarket:
![7](https://raw.githubusercontent.com/dutchplayers/ESX-1.2-Inventory-HUD/master/example_07.jpg)
Police armory:
![8](https://raw.githubusercontent.com/dutchplayers/ESX-1.2-Inventory-HUD/master/example_08.jpg)

![css](https://www.gemeentenieuwstad.nl/wp-content/uploads/2020/10/customcss.png)
Do you want another design? Check our [wiki](https://github.com/dutchplayers/ESX-1.2-Inventory-HUD/wiki/11.-Custom-Design-(OPTIONAL))

![support](https://www.gemeentenieuwstad.nl/wp-content/uploads/2020/10/support.png)
- We can give you support in our [International Discord Server](https://www.dutch-players.nl/joindiscord)
- Or visit our [Dutch Website](https://www.dutch-players.nl/)

![thanks](https://www.gemeentenieuwstad.nl/wp-content/uploads/2020/10/thanks.png)
If you like our edits please write a review on [Disboard](https://disboard.org/nl/server/411618887227146251#reviews)
- Original esx_inventoryhud resource made by Trsak
- To all [contributors](https://github.com/dutchplayers/ESX-1.2-Inventory-HUD/graphs/contributors)
- Vault Script By Monster TaerAttO

![original](https://www.gemeentenieuwstad.nl/wp-content/uploads/2020/10/originalthreads.png)
We have used these resources.
- https://forum.fivem.net/t/esx-inventoryhud-glovebox/687328
- https://forum.fivem.net/t/release-esx-inventory-hud-2-0/388318
- https://forum.fivem.net/t/addon-esx-inventory-hud-vehicle-trunk/458152
