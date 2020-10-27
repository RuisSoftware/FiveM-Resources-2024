local error =
[[

^4=================================
^1ESX Inventory HUD for ESX 1.2
^1Version check failed
^4=================================
^7
]]

local update =
[[

^4=========================================
^2ESX Inventory HUD for ESX 1.2
^3 You use the latest version.
^3 Disable version check in fxmanifest.lua
^4=========================================
^7
]]

local mismatch =
[[

^4=================================================
^1ESX Inventory HUD for ESX 1.2: Version mismatch!
^1 You're running ^6%s ^1and there's a ^6%s
^1 Download the new version from Github!
^3 Disable version check?
^3 Check the fxmanifest.lua
^4=================================================
^7
]]

CreateThread(function()
	local disableVersionCheck = GetResourceMetadata(GetCurrentResourceName(), 'disable_version_check') == 'yes'
	local disableVersionMessage = GetResourceMetadata(GetCurrentResourceName(), 'disable_version_check_message') == 'yes'
	if not disableVersionCheck then
		Wait(20000)
		PerformHttpRequest('https://raw.githubusercontent.com/dutchplayers/ESX-1.2-Inventory-HUD/master/version.txt',
		function(err,body)
			if err == 200 then
				local version = GetResourceMetadata(GetCurrentResourceName(), 'version')
				if version == tostring(body) then
					if not disableVersionMessage then
						print(update)
					end
				else
					print(mismatch:format(version or 'Unkown', body))
				end
			else
				print(error)
			end
		end, 'GET', json.encode({}), {ContentType = 'html/text'})
	end
end)

-- Thanks to FiveM Classes.