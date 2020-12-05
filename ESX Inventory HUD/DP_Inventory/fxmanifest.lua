fx_version 'cerulean'
game 'gta5'

name 'DP_Inventory'
author 'Dutch Players'
description 'Inventory for ESX 1.2 inspired by esx_invntoryhud from Trsak'
version '1.1'
url 'https://github.com/dutchplayers/FiveM-Resources'

ui_page 'html/ui.html'

disable_version_check 'no'
disable_version_check_message 'no'

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'client/thankyou.lua',
	'client/main.lua',
	'client/glovebox.lua',
	'client/ammunition.lua',
	'client/trunk.lua',
	'client/vault.lua',
	'client/weapons.lua',
	'client/bag.lua',
	'client/camera.lua',
	'client/addons/player.lua',
	'client/addons/shop.lua',
	'client/addons/trunk.lua',
	'client/addons/glovebox.lua',
	'client/addons/beds.lua',
	'client/addons/motels.lua',
	'client/addons/vault.lua',
	'client/addons/property.lua',
	'client/addons/bag.lua',
	'client/generateWeapon.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'server/main.lua',
	'server/weapons.lua',
	'server/trunk.lua',
	'server/glovebox.lua',
	'server/ammunition.lua',
	'server/vault.lua',
	'server/bag.lua',
	'server/classes/c_trunk.lua',
	'server/classes/c_glovebox.lua',	
	'server/versioncheck.lua',
}

files {
	'html/ui.html',
	'html/css/ui.css',
	'html/css/jquery-ui.css',
	'html/js/inventory.js',
	'html/js/config.js',
	'html/locales/*.js',
	'html/img/*.png',
	'html/img/*.jpg',
	'html/img/*.svg',
	'html/img/items/*.png',
	'html/img/items/*.jpg',
	'html/img/items/*.svg'
}

dependencies {
	'es_extended',
	'mythic_notify', -- DEPRECATED
	'b1g_notify', -- DEPRECATED
	't-notify', -- new notify
	'mythic_progbar'
}
