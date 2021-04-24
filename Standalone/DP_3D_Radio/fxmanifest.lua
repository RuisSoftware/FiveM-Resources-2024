fx_version 'cerulean'
games { 'gta5' }

version '1.2.0'
description 'Dutch Players Radio'

server_scripts {
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'@DP_Framework/import.lua',
	'config.lua',
	'client/*.lua'
}

dependency 'xsound'

files {
}
