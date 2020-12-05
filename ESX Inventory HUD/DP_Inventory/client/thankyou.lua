function CreateBlip()
	local blip = AddBlipForCoord(vector3(-3351.20, -4349.05, 41.67))

	SetBlipSprite(blip, 489)
	SetBlipScale(blip, 1.0)
	SetBlipColour(blip, 8)
	SetBlipDisplay(blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Greets from the Netherlands!")
	EndTextCommandSetBlipName(blip)

	return blip
end

CreateBlip()