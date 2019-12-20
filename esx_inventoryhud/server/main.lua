ESX = nil

TriggerEvent(
	"esx:getSharedObject",
	function(obj)
		ESX = obj
	end
)

ESX.RegisterServerCallback(
	"esx_inventoryhud:getPlayerInventory",
	function(source, cb, target)
		local targetXPlayer = ESX.GetPlayerFromId(target)

		if targetXPlayer ~= nil then
			cb({inventory = targetXPlayer.inventory, money = targetXPlayer.getMoney(), accounts = targetXPlayer.accounts, weapons = targetXPlayer.loadout})
		else
			cb(nil)
		end
	end
)
