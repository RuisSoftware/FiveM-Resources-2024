local errorLabel =
[[

^4=================================
^1CLASSES: Version check failed!
^4=================================
^7
]]

local uptodateLabel =
[[

^4==============================
^2CLASSES: Is up to date!
^3 Disable version check?
^3 Check the fxmanifest.lua
^4==============================
^7
]]

local versionmismatchLabel =
[[

^4==========================================
^1CLASSES: Version mismatch!
^1 You're running ^6%s ^1and there's a ^6%s
^1 Download the new version from Github!
^3 Disable version check?
^3 Check the fxmanifest.lua
^4==========================================
^7
]]

CreateThread(function()
	local disableVersionCheck = GetResourceMetadata(GetCurrentResourceName(), 'disable_version_check') == 'yes'
	local disableVersionMessage = GetResourceMetadata(GetCurrentResourceName(), 'disable_version_check_message') == 'yes'
	if not disableVersionCheck then
		Wait(20000)
		PerformHttpRequest('https://raw.githubusercontent.com/pitermcflebor/pitermcflebor.github.io/master/classes.version',
		function(err,body)
			if err == 200 then
				local version = GetResourceMetadata(GetCurrentResourceName(), 'version')
				if version == tostring(body) then
					if not disableVersionMessage then
						print(uptodateLabel)
					end
				else
					print(versionmismatchLabel:format(version or 'Unkown', body))
				end
			else
				print(errorLabel)
			end
		end, 'GET', json.encode({}), {ContentType = 'html/text'})
	end
end)
