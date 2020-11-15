fx_version 'bodacious'

game 'gta5'

description 'ESX Marathon Runner'

version '1.2.0'

client_scripts {
    'config.lua',
	'timer.lua',
    'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}