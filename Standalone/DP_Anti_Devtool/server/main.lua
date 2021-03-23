RegisterNetEvent('antidevtool')
AddEventHandler('antidevtool', function()
	local _source = source
	if Config.DropPlayer.Enabled then
		DropPlayer(_source, Config.DropPlayer.Message)
	elseif Config.BanPlayer.Enabled then
		TriggerServerEvent(Config.BanPlayer.ServerEvent, _source, Config.BanPlayer.Message) -- You can replace this line with your ban trigger.
	end
end)