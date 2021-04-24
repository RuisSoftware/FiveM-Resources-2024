fx_version 'cerulean'
games { 'gta5' }

version '1.2.0'
description 'Dutch Players 3D Audio'

server_scripts {
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'@pmc-keybinds/import.lua',
	'config.lua',
	'client/*.lua'
}

dependencies {
	'xsound',
	'pmc-keybinds'
}