local currentWeapon
local currentWeaponSlot
local currentWepAttachs = {}
local firsttime = true
local weaponKey = nil
local NumberCharset = {}
local Charset = {}
canFire = true

RegisterNetEvent('DP_Inventory:itemPopUp')
AddEventHandler('DP_Inventory:itemPopUp', function(weapon)
    if currentWeapon == weapon then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
        return
    elseif currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
    currentWeapon = weapon
    GiveWeapon(currentWeapon)
    TriggerEvent('DP_Inventory:notification', weapon, _U("weapon_used"), 1, false)
end)

AddEventHandler('DP_Inventory:addCurrentWeapon', function(waeponToAdd, attachments, addToSlote)
    currentWeapon = waeponToAdd
    currentWepAttachs = attachments.attach
    local doBreak = false
    if addToSlote then
        TriggerServerEvent('DP_Inventory:slotPut', waeponToAdd)
    end
end)

RegisterNetEvent('DP_Inventory:buyWeaponPolice')
AddEventHandler('DP_Inventory:buyWeaponPolice', function(xPlayer, weapon, ammo)
    local weapon_id = GeneratePoliceWeapon()
    TriggerServerEvent('DP_Inventory:buyWeapon', xPlayer, weapon, weapon_id, ammo)
end)

RegisterNetEvent('DP_Inventory:removeCurrentWeapon')
AddEventHandler('DP_Inventory:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
end)

local weapons = {
	[tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = { 
		['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'),
		['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP'),
		['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['mag'] = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },
    [tostring(GetHashKey('WEAPON_PISTOL'))] = { 
		['mag'] = GetHashKey('COMPONENT_PISTOL_CLIP_02'),
		['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },
    [tostring(GetHashKey('WEAPON_SNIPERRIFLE'))] = { 
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MAX'),
		['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02')
    },
    [tostring(GetHashKey('WEAPON_PUMPSHOTGUN'))] = { 
		['suppressor'] = GetHashKey('COMPONENT_AT_SR_SUPP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },
    [tostring(GetHashKey('WEAPON_SPECIALCARBINE'))] = { 
        ['mag'] = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'),
        ['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },
    [tostring(GetHashKey('WEAPON_ASSAULTRIFLE'))] = { 
        ['mag'] = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MACRO'),
        ['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },
    [tostring(GetHashKey('WEAPON_ASSAULTSMG'))] = { 
        ['mag'] = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MACRO'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },
    [tostring(GetHashKey('WEAPON_MICROSMG'))] = { 
        ['mag'] = GetHashKey('COMPONENT_MICROSMG_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MACRO'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },
    [tostring(GetHashKey('WEAPON_SMG'))] = { 
        ['mag'] = GetHashKey('COMPONENT_SMG_CLIP_02'),
        ['drummag'] = GetHashKey('COMPONENT_SMG_CLIP_03'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    },
    [tostring(GetHashKey('WEAPON_APPISTOL'))] = { 
        ['mag'] = GetHashKey('COMPONENT_APPISTOL_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },
    [tostring(GetHashKey('WEAPON_COMBATPISTOL'))] = { 
        ['mag'] = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_PI_SUPP'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },
    [tostring(GetHashKey('WEAPON_PISTOL50'))] = { 
        ['mag'] = GetHashKey('COMPONENT_PISTOL50_CLIP_02'),
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_PI_FLSH')
    },
    [tostring(GetHashKey('WEAPON_ADVANCEDRIFLE'))] = { 
        ['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP'),
        ['scope'] = GetHashKey('COMPONENT_AT_SCOPE_SMALL'),
        ['mag'] = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
    }
}

RegisterNetEvent('DP_Inventory:useAttach')
AddEventHandler('DP_Inventory:useAttach', function(attach)
    local playerPed = PlayerPedId()
    local hasAttach = false
    if currentWeapon ~= nil then
        local hash = GetHashKey(currentWeapon)
        for i = 1, #currentWepAttachs do
            if currentWepAttachs[i] == attach then
                hasAttach = true
            end
        end
        if weapons[tostring(hash)] ~= nil and weapons[tostring(hash)][attach] ~= nil and not hasAttach then
            ESX.TriggerServerCallback('DP_Inventory:removeItem', function(cb)
                if cb then
                    table.insert(currentWepAttachs, attach)
                    GiveWeaponComponentToPed(playerPed, hash, weapons[tostring(hash)][attach])
                end
            end, attach)
        elseif string.find(attach, 'skin') then
            local number = tonumber(string.match(attach, "%d+"))
            ESX.TriggerServerCallback('DP_Inventory:removeItem', function(cb)
                if cb then
                    for k,v in pairs(currentWepAttachs) do
                        if v == 'skin' or v == 'skin1' or v == 'skin2' or v == 'skin3' or v == 'skin4' or v == 'skin5' or v == 'skin6' or v == 'skin7' then
                            table.remove(currentWepAttachs, k)
                        end
                    end
                    table.insert(currentWepAttachs, attach)
                    SetPedWeaponTintIndex(playerPed, hash, number)
                end
            end, attach)
        else
            exports['b1g_notify']:Notify('error', _U("not_compatible"))
        end
    else
        exports['b1g_notify']:Notify('error', _U("no_weapon_selected"))
    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 172) and not IsEntityDead(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), true) and not removingAttach then
            if currentWeapon ~= nil then
                removingAttach = true
                local playerPed = PlayerPedId()
                local hash = GetHashKey(currentWeapon)
                for i = 1, #currentWepAttachs do
                    if currentWepAttachs[i] ~= nil then
                        if string.find(currentWepAttachs[i], 'skin') == nil then
                            TriggerEvent("mythic_progbar:client:progress", {
                                name = "washing_gsr",
                                duration = 1500,
                                label = _U('waiting_remove'),
                                useWhileDead = false,
                                canCancel = false,
                                controlDisables = {
                                    disableMovement = false,
                                    disableCarMovement = false,
                                    disableMouse = false,
                                    disableCombat = false,
                                },
                            }, function(status)
                                if not status then
                                    RemoveWeaponComponentFromPed(playerPed, hash, weapons[tostring(hash)][currentWepAttachs[i]])
                                    ESX.TriggerServerCallback('DP_Inventory:addPlayerItem', function(cb)end, currentWepAttachs[i], 1)
                                    table.remove(currentWepAttachs, i)
                                    removingAttach = false
                                end
                            end)
                        end
                    end
                end
            else
                exports['b1g_notify']:Notify('error', _U("no_gun_in_hand"))
            end
		end
	end
end)

function RemoveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    currentWeapon = nil
    ESX.TriggerServerCallback('DP_Inventory:doesWeaponHas', function(hasWeaponId)
        if hasWeaponId then
            weaponKey = hasWeaponId
        else
            weaponKey = GenerateWeapon()
        end
        local wepInfo = { 
            count = GetAmmoInPedWeapon(playerPed, hash),
            attach = currentWepAttachs,
            weapon_id = weaponKey
        }
        TriggerServerEvent('DP_Inventory:updateAmmoCount', hash, wepInfo)
        canFire = false
        disable()
        if checkh[weapon] == hash then
            if GetSelectedPedWeapon(playerPed) == hash then
                ESX.TriggerServerCallback('DP_Inventory:addPlayerItem', function(cb)
                end, weapon, 1)
            end
        end
        if ESX.GetPlayerData().job ~= nil and ESX.GetPlayerData().job.name == 'police' then --and GetWeapontypeGroup(hash) == 416676503 then
            if not HasAnimDictLoaded("reaction@intimidation@cop@unarmed") then
                loadAnimDict( "reaction@intimidation@cop@unarmed" )
            end
            TaskPlayAnim(playerPed, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
            Citizen.Wait(100)
        else
            if not HasAnimDictLoaded("reaction@intimidation@1h") then
                loadAnimDict( "reaction@intimidation@1h" )
            end
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "outro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
            Citizen.Wait(1600)
        end
        RemoveWeaponFromPed(playerPed, hash)
        ClearPedTasks(playerPed)
        canFire = true
        TriggerEvent('DP_Inventory:notification', weapon, _U("weapon_pulled"), 1, false)
    end, hash)
end

function GiveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    if not HasAnimDictLoaded("reaction@intimidation@1h") then
        loadAnimDict( "reaction@intimidation@1h" )
    end
    if weapon == 'WEAPON_PETROLCAN' then
        local coords = GetEntityCoords(playerPed)
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.0) then
            TriggerEvent('DP_Inventory:removeCurrentWeapon')
            TriggerEvent('joca_fuel:useJerryCan')
        else
            canFire = false
            disable()
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
            Citizen.Wait(1600)
            GiveWeaponToPed(playerPed, hash, 1, false, true)
            SetPedAmmo(playerPed, hash, 1000)
            ClearPedTasks(playerPed)
            canFire = true
        end
    else
      ESX.TriggerServerCallback('DP_Inventory:getAmmoCount', function(gunInfo)
        currentWepAttachs = gunInfo.attachments
        canFire = false
        disable()
        if ESX.GetPlayerData().job ~= nil and ESX.GetPlayerData().job.name == 'police' then --and GetWeapontypeGroup(hash) == 416676503 then
            if not HasAnimDictLoaded("rcmjosh4") then
                loadAnimDict( "rcmjosh4" )
            end
            TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.Wait(500)
        else
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)          
            Citizen.Wait(1600)
        end
        GiveWeaponToPed(playerPed, hash, 1, false, true)
        for i = 1, #currentWepAttachs do
            if weapons[tostring(hash)] ~= nil then
                GiveWeaponComponentToPed(playerPed, hash, weapons[tostring( hash )][currentWepAttachs[i]])
            end
            if currentWepAttachs[i] == 'skin1' then SetPedWeaponTintIndex(playerPed, hash, 1)
            elseif currentWepAttachs[i] == 'skin2' then SetPedWeaponTintIndex(playerPed, hash, 2)
            elseif currentWepAttachs[i] == 'skin3' then SetPedWeaponTintIndex(playerPed, hash, 3)
            elseif currentWepAttachs[i] == 'skin4' then SetPedWeaponTintIndex(playerPed, hash, 4)
            elseif currentWepAttachs[i] == 'skin5' then SetPedWeaponTintIndex(playerPed, hash, 5)
            elseif currentWepAttachs[i] == 'skin6' then SetPedWeaponTintIndex(playerPed, hash, 6)
            elseif currentWepAttachs[i] == 'skin7' then SetPedWeaponTintIndex(playerPed, hash, 7)
            end
        end
        if checkh[weapon] == hash then
            ESX.TriggerServerCallback('DP_Inventory:takePlayerItem', function(cb)
                SetPedAmmo(playerPed, hash, 1)
            end, weapon, 1)
        elseif Config.FuelCan == hash and gunInfo.ammoCount == nil then
            SetPedAmmo(playerPed, hash, 1000)
        else
            SetPedAmmo(playerPed, hash, gunInfo.ammoCount or 0)
        end
        ClearPedTasks(playerPed)
        canFire = true
      end, hash)
    end
end

function disable()
	Citizen.CreateThread(function ()
		while not canFire do
			Citizen.Wait(10)
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(player, true)
		end
	end)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GenerateWeapon()
	local generatedWeapon
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedWeapon = GetRandomLetter(30) .. GetRandomNumber(30)

		ESX.TriggerServerCallback('DP_Inventory:isWeaponNumberTaken', function(isWeaponTaken)
			if not isWeaponTaken then
				doBreak = true
			end
		end, generatedWeapon)

		if doBreak then
			break
		end
	end

	return generatedWeapon
end

function GeneratePoliceWeapon()
	local generatedPoliceWeapon
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		generatedPoliceWeapon = GetRandomLetter(15) .. GetRandomNumber(15) .. 'POLICE' ..GetRandomLetter(5) .. 'POLICE' ..GetRandomNumber(5)

		ESX.TriggerServerCallback('DP_Inventory:isWeaponNumberTaken', function(isWeaponTaken)
			if not isWeaponTaken then
				doBreak = true
			end
		end, generatedPoliceWeapon)

		if doBreak then
			break
		end
	end

	return generatedPoliceWeapon
end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
