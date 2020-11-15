fx_version 'cerulean'
games { 'gta5' }

author 'Dutch Players'
description 'Texel RP Opdrachten'
version '1.0'

ui_page 'ui/ui.html'

files {
	'ui/ui.html',
	'ui/achtergrond.jpg',
	'ui/opdrachten.html',
	'ui/ui.css',
	'ui/opdrachten.css',
}

client_script {
	'@es_extended/locale.lua',
	'locales/nl.lua',
	'config.lua',
	'client/algemeen.lua',
}

server_script {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/nl.lua',
	'config.lua',
	'server/algemeen.lua',
	'server/updateOpdracht.lua',
	'server/nieuweSpeler.lua',
}
