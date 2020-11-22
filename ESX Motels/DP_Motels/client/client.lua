local ESX = nil
local myMotel = false
local curMotel = nil
local curRoom = nil
local curRoomOwner = false
local inRoom = false
local roomOwner = nil
local playerIdent = nil
local inMotel = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
    playerIdent = ESX.GetPlayerData().identifier
end)

AddEventHandler('esx:onPlayerSpawn', function()
	Citizen.CreateThread(function()

		while not ESX.IsPlayerLoaded() do
			Citizen.Wait(0)
		end
		Citizen.Wait(1000)
		ESX.TriggerServerCallback('DP_Motels:getLastMotel', function(motel, room)
			if motel and room then
				if motel ~= nil and room ~= nil then
					curMotel      = motel
					curRoom       = room
					inRoom        = true
					inMotel       = true
					local roomID = nil
					local playerPed = PlayerPedId()
					local roomIdent = room
					local reqmotel = motel
					ESX.TriggerServerCallback('DP_Motels:getMotelRoomID', function(roomno)
					roomID = roomno
					end, room)
					Citizen.Wait(500)
					if roomID ~= nil then
					local instanceid = 'motel'..roomID..''..roomIdent
						TriggerEvent('instance:create', 'motelroom', {property = instanceid, owner = ESX.GetPlayerData().identifier, motel = reqmotel, room = roomIdent, vid = roomID})
					end
				end
			end
		end)
	end)
end)


function getMyMotel()
	ESX.TriggerServerCallback('DP_Motels:checkOwnership', function(owned)
		myMotel = owned
	end)
end

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
    if instance.type == 'motelroom' then
        roomOwner = ESX.GetPlayerData().identifier
		TriggerEvent('instance:enter', instance)
	end
end)

RegisterNetEvent('DP_Motels:cancelRental')
AddEventHandler('DP_Motels:cancelRental', function(room)
    local motelName = nil
    local motelRoom = nil
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
    TriggerServerEvent("DP_Motels:cancelRental", room)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "renting_motel",
        duration = 2000,
        label = _U('canceling_room')..motelRoom,
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
                disableMovement = true,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
			anim = "idle_a",
        },
        prop = {
            model = "prop_notepad_01"	
        }
	}, function(status)
        if not status then
            myMotel = false
        end
	end)
end)

function PlayerDressings()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room',
	{
		title    = _U('player_clothing'),
		align    = 'top',
		elements = {
            {label = _U('player_clothes'), value = 'player_dressing'},
	        {label = _U('remove_cloth'), value = 'remove_cloth'}
        }
	}, function(data, menu)

		if data.current.value == 'player_dressing' then 
            menu.close()
			ESX.TriggerServerCallback('DP_Motels:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
				{
					title    = _U('player_clothes'),
					align    = 'top',
					elements = elements
				}, function(data2, menu2)

					TriggerEvent('skinchanger:getSkin', function(skin)
						ESX.TriggerServerCallback('DP_Motels:getPlayerOutfit', function(clothes)
							TriggerEvent('skinchanger:loadClothes', skin, clothes)
							TriggerEvent('esx_skin:setLastSkin', skin)

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)
						end, data2.current.value)
					end)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		elseif data.current.value == 'remove_cloth' then
            menu.close()
			ESX.TriggerServerCallback('DP_Motels:getPlayerDressing', function(dressing)
				elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = _U('remove_cloth'),
					align    = 'top',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('DP_Motels:removeOutfit', data2.current.value)
					ESX.ShowNotification(_U('removed_cloth'))
				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end
	end, function(data, menu)
        menu.close()
	end)
end

RegisterNetEvent('instance:onEnter')
AddEventHandler('instance:onEnter', function(instance)
    if instance.type == 'motelroom' then
        local property = instance.data.property
        local motel = instance.data.motel
        local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
            Citizen.Wait(1000)
        local networkChannel = instance.data.vid
        NetworkSetVoiceChannel(networkChannel)
	end
end)

AddEventHandler('instance:loaded', function()
    TriggerEvent('instance:registerType', 'motelroom', function(instance)
        EnterProperty(instance.data.property, instance.data.owner, instance.data.motel, instance.data.room)
    end, function(instance)
        Citizen.InvokeNative(0xE036A705F989E049)
		ExitProperty(instance.data.property, instance.data.motel, instance.data.room)
	end)
end)

function EnterProperty(name, owner, motel, room)
    curMotel      = motel
    curRoom       = room
    inRoom        = true
    inMotel       = true
    local playerPed     = PlayerPedId() 
    TriggerServerEvent('DP_Motels:SaveMotel', curMotel, curRoom)
    Citizen.CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(0)
        end
        for k,v in pairs(Config.Zones) do     
                if curMotel == k then
                    SetEntityCoords(playerPed, v.roomLoc.x, v.roomLoc.y, v.roomLoc.z)
                end
        end
		DoScreenFadeIn(800)
	end)
end

RegisterNetEvent('DP_Motels:enterRoom')
AddEventHandler('DP_Motels:enterRoom', function(room, motel)
    local roomID = nil
    local playerPed = PlayerPedId()
    local roomIdent = room
    local reqmotel = motel
    ESX.TriggerServerCallback('DP_Motels:getMotelRoomID', function(roomno)
		roomID = roomno
    end, room)
    Citizen.Wait(500)
    if roomID ~= nil then
		local instanceid = 'motel'..roomID..''..roomIdent
        TriggerEvent('instance:create', 'motelroom', {property = instanceid, owner = ESX.GetPlayerData().identifier, motel = reqmotel, room = roomIdent, vid = roomID})
    end
end)

RegisterNetEvent('DP_Motels:exitRoom')
AddEventHandler('DP_Motels:exitRoom', function(motel, room)
    local roomID = room
    local playerPed = PlayerPedId()
    Citizen.Wait(500)
    roomOwner = nil
    TriggerEvent('instance:leave')
end)

RegisterNetEvent('DP_Motels:roomOptions')
AddEventHandler('DP_Motels:roomOptions', function(room, motel)
    local motelName = nil
    local motelRoom = nil
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'DP_Motels',
        {
            title    = motelName.._U('room')..motelRoom,
            align    = 'top',
            elements = { 
                { label = _U('enter_room'), value = 'enter' },
                { label = _U('cancel_room'), value = 'cancel' }
            }
        },
    function(data, entry)
        local value = data.current.value
        if value == 'enter' then
            entry.close()
            TriggerEvent("DP_Motels:enterRoom", room, motel)

        elseif value == 'cancel' then
            entry.close()
            TriggerEvent("DP_Motels:cancelRental", room)
        end
    end,
    function(data, entry)
        entry.close()
    end)
end)

RegisterNetEvent('DP_Motels:roomMenu')
AddEventHandler('DP_Motels:roomMenu', function(room, motel)
    local motelName = nil
    local motelRoom = nil
    local roomID = nil
    local owner = ESX.GetPlayerData().identifier
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
   
	options = {}

	if Config.SwitchCharacterSup then
		table.insert(options, {label = _U('change_character'), value = 'changechar'})
	end
		table.insert(options, {label = _U('leave_room'), value = 'leaveroom'})
	if roomOwner == playerIdent then
		table.insert(options, {label = _U('open_inventory'), value = 'inventory'})
		table.insert(options, {label = _U('invite_player'), value = 'inviteplayer'})
	end
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'DP_Motels',
        {
            title    = motelName.._U('room')..motelRoom,
            align    = 'top',
            elements = options
        },
    function(data, menu)
        local value = data.current.value
        if value == 'changechar' then
            menu.close()
            TriggerServerEvent("kashactersS:SaveSwitchedPlayer")
            TriggerEvent("mythic_progbar:client:progress", {
                name = "renting_motel",
                duration = 2000,
                label = _U('changing_character'),
                useWhileDead = false,
                canCancel = true,
                controlDisables = {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
                },
        }, function(status)
			if not status then
				inMotel = false
				TriggerEvent('kashactersC:ReloadCharacters')
			end
        end)
        elseif value == 'leaveroom' then
        menu.close()
        TriggerEvent('DP_Motels:exitRoom', curMotel, curRoom)
        elseif value == 'inventory' then
            menu.close()
            owner = ESX.GetPlayerData().identifier
        if roomOwner == owner then
			TriggerEvent("mythic_progbar:client:progress", {
				name = "renting_motel",
				duration = 1500,
				label = _U('opening_inventory'),
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
				},
			}, function(status)
				if not status then
					OpenPropertyInventoryMenu('motels', owner)
				end
			end)    
        else
            TriggerClientEvent('esx:showNotification', _U('not_your_room'))  
        end
        elseif value == 'inviteplayer' then
            local myInstance = nil
            local roomIdent = room
            local reqmotel = motel
            for k,v in pairs(Config.Zones) do
                for kk,vm in pairs(v.Rooms) do       
                    if room == vm.instancename then
                        playersInArea = ESX.Game.GetPlayersInArea(vm.entry, 5.0)
                    end
                end
            end
			local elements      = {}
            if playersInArea ~= nil then
                for i=1, #playersInArea, 1 do
                    if playersInArea[i] ~= PlayerId() then
                        table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
                    end
                end
            else
                table.insert(elements, {label = _U('doorbell')})
            end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_invite',
			{
				title    = motelName.._U('room')..motelRoom .. ' - ' .. _U('invite') ..' Bewoner',
				align    = 'top',
				elements = elements,
            }, function(data2, menu2)
                ESX.TriggerServerCallback('DP_Motels:getMotelRoomID', function(roomno)
                    print(room)
                    roomID = roomno
                    end, room)
                myInstance = 'motel'..roomID..''..roomIdent
				TriggerEvent('instance:invite', 'motelroom', GetPlayerServerId(data2.current.value), {property = myInstance, owner = ESX.GetPlayerData().identifier, motel = reqmotel, room = roomIdent, vid = roomID})
				ESX.ShowNotification(_U('you_invited', GetPlayerName(data2.current.value)))
			end, function(data2, menu2)
				menu2.close()
			end)
        end
    end,
    function(data, menu)
        menu.close()
    end)
end)

RegisterNetEvent('DP_Motels:rentRoom')
AddEventHandler('DP_Motels:rentRoom', function(room)
    local motelName = nil
    local motelRoom = nil
    for k,v in pairs(Config.Zones) do
        for kk,vm in pairs(v.Rooms) do       
            if room == vm.instancename then
                motelName = v.Name
                motelRoom = vm.number
            end
        end
    end
    TriggerServerEvent('DP_Motels:rentRoom', room)
    TriggerEvent("mythic_progbar:client:progress", {
        name = "renting_motel",
        duration = 2000,
        label = _U('renting')..motelRoom,
        useWhileDead = false,
        canCancel = true,
        controlDisables = {
			disableMovement = true,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
        },
        animation = {
            animDict = "missheistdockssetup1clipboard@idle_a",
			anim = "idle_a",
        },
        prop = {
            model = "prop_notepad_01"	
        }
	}, function(status)
		if not status then
		end
	end)
end)

function roomMarkers()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    -- Exit Marker
   --[[ for k,v in pairs(Config.Zones) do
        for km,vm in pairs(v.Rooms) do
            distance = GetDistanceBetweenCoords(coords, v.roomExit.x, v.roomExit.y, v.roomExit.z, true)
            if (distance < 1.0) then
                if curRoom ~= nil then
                    DrawText3D(v.roomExit.x, v.roomExit.y, v.roomExit.z + 0.35, 'Druk op [~g~E~s~] om de woning te verlaten')
                    if IsControlJustReleased(0, 38) then
                        ESX.UI.Menu.CloseAll()
                        TriggerEvent('DP_Motels:exitRoom', curMotel, curRoom)
                    end
                end  
            end
        end
    end]]
	
	for k,v in pairs(Config.Zones) do
        distance = GetDistanceBetweenCoords(coords, v.roomExit.x, v.roomExit.y, v.roomExit.z, true)
        if distance < 1.5 then
            DrawText3D(v.roomExit.x, v.roomExit.y, v.roomExit.z + 0.15, _U('exit'))
            DrawMarker(20, v.roomExit.x, v.roomExit.y, v.roomExit.z + -0.11, 0, 0.50, 0, 0, 0, 0, 0.45,0.25,0.25, 255, 0, 0, 255, 0.0, 0.10, 0, 0.0, 0, 0.0, 0)
			if IsControlJustReleased(0, 38) then
				TriggerEvent('DP_Motels:exitRoom', curRoom, curMotel)
			end
        end
    end

    -- Room Menu Marker
    for k,v in pairs(Config.Zones) do
        distance = GetDistanceBetweenCoords(coords, v.Menu.x, v.Menu.y, v.Menu.z, true)
        if distance < 1.0 then
            DrawText3D(v.Menu.x, v.Menu.y, v.Menu.z + 0.35, _U('open_room_menu'))
			if IsControlJustReleased(0, 38) then
				TriggerEvent('DP_Motels:roomMenu', curRoom, curMotel)
			end
        end
    end

    -- Clothing Menu
    for k,v in pairs(Config.Zones) do
        distance = GetDistanceBetweenCoords(coords, v.Inventory.x, v.Inventory.y, v.Inventory.z, true)
        if distance < 1.0 then
            if roomOwner == playerIdent then
				DrawText3D(v.Inventory.x, v.Inventory.y, v.Inventory.z + 0.35, _U('open_clothes'))
                if IsControlJustReleased(0, 38) then
                    PlayerDressings()
                end
            end
        end
    end

    -- Bed Stash Marker
    for k,v in pairs(Config.Zones) do
        distance = GetDistanceBetweenCoords(coords, v.BedStash.x, v.BedStash.y, v.BedStash.z, true)
        if distance < 1.0 then
            if roomOwner == playerIdent then
				DrawText3D(v.BedStash.x, v.BedStash.y, v.BedStash.z + 0.1, _U('open_stash'))
                if IsControlJustReleased(0, 38) then
                    OpenStash()
                end
            end
        end
    end
end


function enteredMarker()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if myMotel then 
		for k,v in pairs(Config.Zones) do
			for km,vm in pairs(v.Rooms) do
				if vm.instancename == myMotel then
					distance = GetDistanceBetweenCoords(coords, vm.entry.x, vm.entry.y, vm.entry.z, true)
					if (distance < v.Boundries) then
						DrawMarker(20, vm.entry.x, vm.entry.y, vm.entry.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.RoomMarker.x, Config.RoomMarker.y, Config.RoomMarker.z, Config.RoomMarker.Owned.r, Config.RoomMarker.Owned.g, Config.RoomMarker.Owned.b, 100, false, true, 2, false, false, false, false)	
					end
					if (distance < 1.0) then
						DrawText3D(vm.entry.x, vm.entry.y, vm.entry.z + 0.35, _U('open_options'))
						if IsControlJustReleased(0, 38) then
							TriggerEvent("DP_Motels:roomOptions", vm.instancename, k)
						end
					end
				end
			end
		end
	else
        for k,v in pairs(Config.Zones) do
            distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
            if (distance < v.Boundries) then
                for km,vm in pairs(v.Rooms) do
                    distance = GetDistanceBetweenCoords(coords, vm.entry.x, vm.entry.y, vm.entry.z, true)
                    if (distance < 1.0) then
                        DrawText3D(vm.entry.x, vm.entry.y, vm.entry.z + 0.35, _U('open_room_1')..vm.number.._U('open_room_2')..Config.PriceRental)
                        if IsControlJustReleased(0, 38) then
                            TriggerEvent('DP_Motels:rentRoom', vm.instancename)
                        end
                    end
                end
            end
        end
    end
end

function ExitProperty(name, motel, room)
	local property  = name
    local playerPed = PlayerPedId()
    inRoom          = false
    inMotel         = false
    TriggerServerEvent('DP_Motels:DelMotel')
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)
		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end
        for k,v in pairs(Config.Zones) do
            for km,vm in pairs(v.Rooms) do
                if room == vm.instancename then
					SetEntityCoords(playerPed, vm.entry.x, vm.entry.y, vm.entry.z)
                end
            end
        end
		DoScreenFadeIn(800)
	end)
end

Citizen.CreateThread(function()
    Citizen.Wait(0)
    while true do
       Citizen.Wait(0)
       enteredMarker() 
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(0)
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if inRoom then
			roomMarkers()
		end 

		if not inMotel then
			for k,v in pairs(Config.Zones) do
				distance = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
				if (distance < v.Boundries) then
					getMyMotel()
					Citizen.Wait(3000)
				end
			end
		end
	end
end)

function OpenPropertyInventoryMenu(property, owner)
	ESX.TriggerServerCallback("DP_Motels:getPropertyInventory",function(inventory)
		TriggerEvent("DP_Inventory:openMotelsInventory", inventory)
	end, owner)
end

function OpenPropertyInventoryMenuBed(property, owner)
	ESX.TriggerServerCallback("DP_Motels:getPropertyInventoryBed", function(inventory)
		TriggerEvent("DP_Inventory:openMotelsInventoryBed", inventory)
	end, owner)
end

function OpenStash()
    owner = ESX.GetPlayerData().identifier
    ESX.TriggerServerCallback('DP_Motels:checkIsOwner', function(isOwner)
        if isOwner then
			TriggerEvent("mythic_progbar:client:progress", {
				name = "renting_motel",
				duration = 1500,
				label = _U('opening_stash'),
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
						disableMovement = true,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
				},
			}, function(status)
				if not status then
					OpenPropertyInventoryMenuBed('motelsbed', owner)
				end
			end)    
        else
            TriggerEvent('esx:showNotification', _U('not_your_room'))  
        end
    end, curRoom, owner)
end

DrawText3D = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords()) 
	local scale = 0.45
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0150, 0.030 + factor , 0.030, 66, 66, 66, 150)
	end
end
