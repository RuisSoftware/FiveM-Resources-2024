fx_version 'cerulean'
game 'gta5'

name 'esx_inventoryhud'
author 'Trsak'
editor 'Dutch Players'
description "Thé ESX Inventory HUD from Trsak and loved by many others!"
version '3.4.4'
url 'https://github.com/dutchplayers/ESX-1.2-Inventory-HUD'

ui_page "html/ui.html"

disable_version_check 'no'
disable_version_check_message 'no'

client_scripts {
	"@es_extended/locale.lua",
	"config.lua",
	"locales/*.lua",
	"client/main.lua",
	"client/glovebox.lua",
	"client/ammunition.lua",
	"client/trunk.lua",
	"client/vault.lua",
	"client/weapons.lua",
	"client/bag.lua",
	
	"client/addons/player.lua",
	"client/addons/shop.lua",
	"client/addons/trunk.lua",
	"client/addons/glovebox.lua",
	"client/addons/beds.lua",
	"client/addons/motels.lua",
	"client/addons/vault.lua",
	"client/addons/property.lua",
	"client/addons/bag.lua",
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"@es_extended/locale.lua",
	"config.lua",
	"locales/*.lua",
	"server/main.lua",
	"server/trunk.lua",
	"server/glovebox.lua",
	"server/ammunition.lua",
	"server/vault.lua",
	"server/bag.lua",
	
	"server/classes/c_trunk.lua",
	"server/classes/c_glovebox.lua",
	
	"server/versioncheck.lua",
}

files {
	"html/ui.html",
	"html/css/ui.css",
	"html/css/jquery-ui.css",
	"html/js/inventory.js",
	"html/js/config.js",
	"html/locales/*.js",
	"html/img/*.png",
	"html/img/*.svg",
	"html/img/items/*.png"
}

dependencies {
	'es_extended',
	'mythic_notify', -- DEPRECATED
	'b1g_notify', -- DEPRECATED
	't-notify', -- new notify
	'mythic_progbar'
}
