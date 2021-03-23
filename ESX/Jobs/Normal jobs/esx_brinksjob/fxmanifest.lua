fx_version 'cerulean'
games {'gta5'}

author 'Edited by Dutch Players'
description 'Brinks Job for ESX 1.2'
version '1.2.0'
--this_is_a_map "yes"

server_scripts {
    '@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'@NativeUI/NativeUI.lua',
	'@es_extended/locale.lua',
	'@pmc-keybinds/import.lua',
	'locales/*.lua',
	'config.lua',
	'client/*.lua'
}

dependencies {
	'es_extended',
	'pmc-keybinds'
}