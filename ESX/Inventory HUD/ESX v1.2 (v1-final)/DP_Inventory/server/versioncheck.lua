local error =
[[

^4=================================
^1❤️ ESX Inventory HUD for ESX 1.2 ❤️
^1 Version check failed
^4=================================
^7
]]

local update =
[[

^4=========================================
^2❤️ ESX Inventory HUD for ESX 1.2 ❤️
^3 You use the latest version. (^6%s^3)
^4=========================================
^7
]]

local mismatch =
[[

^4===================================================
^1❤️ ESX Inventory HUD for ESX 1.2 ❤️ 
^1 You're running ^6%s ^1and the latest is ^6%s
^4===================================================
^7
]]

CreateThread(function()
	while not Config.disableVersionCheck do
		PerformHttpRequest('https://raw.githubusercontent.com/dutchplayers/FiveM-Resources/master/ESX/Inventory%20HUD/version', function(err,body)
			if err == 200 then
				local version = GetResourceMetadata(GetCurrentResourceName(), 'version')
				if version == tostring(body) then
					if not Config.disableVersionMessage then
						print(update:format(version))
					end
				else
					print(mismatch:format(version or 'Unkown', body))
				end
			else
				print(mismatch:format(version or 'Unkown', body))
				--print(error)
			end
		end, 'GET', json.encode({}), {ContentType = 'html/text'})
		Wait(Config.versionCheckDelay*60000)
	end
end)

-- Thanks to FiveM Classes.
