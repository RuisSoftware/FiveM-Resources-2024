ESX                			 = nil
local PlayersVente			 = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_cityworkssecondary:GiveItem')
AddEventHandler('esx_cityworkssecondary:GiveItem', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local Quantity = xPlayer.getInventoryItem(Config.Zones.Vente.ItemRequires).count

	if Quantity >= 15 then
		TriggerClientEvent('esx:showNotification', _source, _U('stop_npc'))
		return
	else
		local amount = Config.Zones.Vente.ItemAdd
		local item = Config.Zones.Vente.ItemDb_name
		xPlayer.addInventoryItem(item, amount)
		TriggerClientEvent('esx:showNotification', _source, 'De reparaties zijn voltooid, ga naar de volgende plaatsen.')
	end

end)

local function Vente(source)

	SetTimeout(Config.Zones.Vente.ItemTime, function()

		if PlayersVente[source] == true then

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local Quantity = xPlayer.getInventoryItem(Config.Zones.Vente.ItemRequires).count

			if Quantity < Config.Zones.Vente.ItemRemove then
				TriggerClientEvent('esx:showNotification', _source, '~r~Je hebt geen cheques meer om te verzilveren.')
				PlayersVente[_source] = false
			else
				local amount = Config.Zones.Vente.ItemRemove
				local item = Config.Zones.Vente.ItemRequires
				Citizen.Wait(1500)
				xPlayer.removeInventoryItem(item, amount)
				xPlayer.addMoney(Config.Zones.Vente.ItemPrice)
				TriggerClientEvent('esx:showNotification', _source, 'Je ontving ~g~€' .. Config.Zones.Vente.ItemPrice)
				Vente(_source)
			end

		end
	end)
end

RegisterServerEvent('esx_cityworkssecondary:startVente')
AddEventHandler('esx_cityworkssecondary:startVente', function()

	local _source = source

	if PlayersVente[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~Geen cheques, geen geld!')
		PlayersVente[_source] = false
	else
		PlayersVente[_source] = true
		TriggerClientEvent('esx:showNotification', _source, '~g~Cheques ~w~verzilveren...')
		Vente(_source)
	end
end)

RegisterServerEvent('esx_cityworkssecondary:stopVente')
AddEventHandler('esx_cityworkssecondary:stopVente', function()

	local _source = source

	if PlayersVente[_source] == true then
		PlayersVente[_source] = false
	else
		PlayersVente[_source] = true
	end
end)
