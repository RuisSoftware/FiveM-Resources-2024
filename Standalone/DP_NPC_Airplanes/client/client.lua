if Config.UseESX then
	ESX = nil
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
	end)
end

RegisterKey('keyboard', 'E',
	function()
	end,
	function()
		if IsPlayerNearAirport() then
			if Config.ESXMenu then
				OpenMenu()
			else
				mainMenu:Visible(not mainMenu:Visible())	
			end	
		end
	end
)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, false)
end

RegisterNetEvent("airports:moneyInvalid")
AddEventHandler("airports:moneyInvalid", function()
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(Config.Locale.NoMoney)
	SetNotificationMessage("CHAR_BLOCKED", "CHAR_BLOCKED", true, 4, Config.Locale.NoMoneyTitle, "", Config.Locale.NoMoney)
	DrawNotification(false, true)
end)