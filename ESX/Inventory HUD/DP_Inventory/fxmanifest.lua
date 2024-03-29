fx_version 'cerulean'
game 'gta5'

name 'DP_Inventory'
author 'Dutch Players'
credits 'Once based on esx_inventoryhud from Trsak'
description 'Inventory for ESX legacy.'
version '1.3.8'
url 'https://github.com/dutchplayers/FiveM-Resources'

ui_page 'html/ui.html'

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/*.lua',
	'client/localdata.lua',
	'client/main.lua',
	'client/controls.lua',
	'client/glovebox.lua',
	'client/ammunition.lua',
	'client/trunk.lua',
	'client/vault.lua',
	'client/weapons.lua',
	'client/bag.lua',
	'client/camera.lua',
	'client/lockers.lua',
	'client/addons/player.lua',
	'client/addons/shop.lua',
	'client/addons/trunk.lua',
	'client/addons/glovebox.lua',
	'client/addons/beds.lua',
	'client/addons/motels.lua',
	'client/addons/vault.lua',
	'client/addons/property.lua',
	'client/addons/bag.lua',
	'client/addons/lockers.lua'
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
	'server/shop.lua',
	'server/hotbar.lua',
	'server/lockers.lua',
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

exports {
	'GenerateWeapon',
	'OpenInventory'
}

dependencies {
	'es_extended',
	't-notify',
	'mythic_progbar'
}