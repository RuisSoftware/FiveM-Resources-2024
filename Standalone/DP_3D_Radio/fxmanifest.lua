fx_version 'cerulean'
games { 'gta5' }

version '1.2.0'
description 'Dutch Players 3D Audio'

server_scripts {
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'config.lua',
	'client/*.lua'
}

dependencies {
	'xsound',
	'es_extended', -- if you want to use ESX
	--'pxrp_vip' -- if you want to use the radio for VIP only.
}
