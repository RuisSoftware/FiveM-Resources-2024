fx_version 'cerulean'
game 'gta5'

name 'Dutch Players Motels'
author 'Dutch Players'
description 'Motels for ESX 1.2 inspired by lsrp-motels.'
version '2.0'
url 'https://github.com/dutchplayers/FiveM-Resources'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
    'server/server.lua',
    'config.lua',
    'locales/*.lua'
}

client_scripts {
	'@es_extended/locale.lua',
    'client/client.lua',
    'config.lua',
    'locales/*.lua'
}

dependencies {
	'es_extended',
	'instance',
	'cron',
	'esx_addonaccount',
	'esx_addoninventory',
	'esx_datastore',
	'DP_Inventory'
}
