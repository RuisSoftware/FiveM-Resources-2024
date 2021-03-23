RegisterNUICallback("devtoolOpening", function(data,cb)
	if Config.ClientRestart.Enabled then
		RestartGame()
	else
		TriggerServerEvent('antidevtool')
	end
end)