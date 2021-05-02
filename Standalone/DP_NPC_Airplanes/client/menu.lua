_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("", Config.Locale.MenuTitle, "", "", "shopui_title_exec_vechupgrade", "shopui_title_exec_vechupgrade")
_menuPool:Add(mainMenu)

_menuPool:ControlDisablingEnabled(false)
_menuPool:MouseControlsEnabled(false)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

function AddAirPortMenu(menu)
	if Config.UseESX then
		SantonsButton = NativeUI.CreateItem(Config.Locale.LSA, Config.Locale.Money .. Config.Locale.MoneyCurrency .. " " ..Config.TicketPrice)
		DesrtButton = NativeUI.CreateItem(Config.Locale.SSA, Config.Locale.Money .. Config.Locale.MoneyCurrency .. " " ..Config.TicketPrice)
		CayoButton = NativeUI.CreateItem(Config.Locale.CPA, Config.Locale.Money .. Config.Locale.MoneyCurrency .. " " ..Config.TicketPrice)
	else
		SantonsButton = NativeUI.CreateItem(Config.Locale.LSA, "")
		DesrtButton = NativeUI.CreateItem(Config.Locale.SSA, "")
		CayoButton = NativeUI.CreateItem(Config.Locale.CPA, "")
	end

    menu:AddItem(SantonsButton)
    menu:AddItem(DesrtButton)
    menu:AddItem(CayoButton)
    menu.OnItemSelect = function(sender, item, index)
        if item == DesrtButton then
        	if IsEntityInZone(PlayerPedId(), "AIRP") then -- goed
        		startZone = "AIRP"
        		planeDest = "DESRT"
        		if Config.UseESX then
        			TriggerServerEvent('airports:payTicket', -1675.2446, -2798.8835, 14.5409, 327.8560, startZone, planeDest, Config.TicketPrice)
        		else
        			CreatePlane(-1675.2446, -2798.8835, 14.5409, 327.8560, startZone, planeDest)
        		end
        	elseif IsEntityInZone(PlayerPedId(), "ISHEIST") then
        		startZone = "ISHEIST"
        		planeDest = "DESRT"
        		if Config.UseESX then
        			TriggerServerEvent('airports:payTicket', 4404.76,-4526.4,4.18, 106.7817, startZone, planeDest, Config.TicketPrice)
        		else
        			CreatePlane(4404.76,-4526.4,4.18, 106.7817, startZone, planeDest)
        		end
        	else
        		ShowNotification(Config.Locale.NoPlane)
        	end
        elseif item == SantonsButton then
        	if IsEntityInZone(PlayerPedId(), "DESRT") then -- goed
        		startZone = "DESRT"
        		planeDest = "AIRP"
        		if Config.UseESX then
        			TriggerServerEvent('airports:payTicket', 1599.02453, 3231.2016, 40.4115, 105.7817, startZone, planeDest, Config.TicketPrice)
        		else
        			CreatePlane(1599.02453, 3231.2016, 40.4115, 105.7817, startZone, planeDest)
        		end
        	elseif IsEntityInZone(PlayerPedId(), "ISHEIST") then
        		startZone = "ISHEIST"
        		planeDest = "AIRP"
        		if Config.UseESX then
        			TriggerServerEvent('airports:payTicket', 4404.76,-4526.4,4.18, 106.7817, startZone, planeDest, Config.TicketPrice)
        		else
        			CreatePlane(4404.76,-4526.4,4.18, 106.7817, startZone, planeDest)
        		end
        	else
        		ShowNotification(Config.Locale.NoPlane)
        	end
        elseif item == CayoButton then
        	if IsEntityInZone(PlayerPedId(), "DESRT") then
        		startZone = "DESRT"
        		planeDest = "ISHEIST"
        		if Config.UseESX then
        			TriggerServerEvent('airports:payTicket', 1599.02453, 3231.2016, 40.4115, 105.7817, startZone, planeDest, Config.TicketPrice)
        		else
        			CreatePlane(4328.12,-4555.24,4.18,107.09, startZone, planeDest)
        		end
        	elseif IsEntityInZone(PlayerPedId(), "AIRP") then
        		startZone = "AIRP"
        		planeDest = "ISHEIST"
        		if Config.UseESX then
        			TriggerServerEvent('airports:payTicket', -1675.2446, -2798.8835, 14.5409, 327.8560, startZone, planeDest, Config.TicketPrice)
        		else
        			CreatePlane(-1675.2446, -2798.8835, 14.5409, 327.8560, startZone, planeDest)
        		end
        	else
        		ShowNotification(Config.Locale.NoPlane)
        	end
        end
    end   
end

AddAirPortMenu(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		_menuPool:ProcessMenus()
	end
end)