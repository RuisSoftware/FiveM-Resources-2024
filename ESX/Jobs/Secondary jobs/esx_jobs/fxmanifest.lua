fx_version 'adamant'

game 'gta5'

description 'ESX Jobs'

version '1.1.0'

server_scripts {
	'@es_extended/locale.lua',
	'locales/nl.lua',
	'config.lua',

	'jobs/*.lua',

	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/nl.lua',
	'config.lua',

	'jobs/*.lua',

	'client/main.lua'
}

dependencies {
	'es_extended'
}
