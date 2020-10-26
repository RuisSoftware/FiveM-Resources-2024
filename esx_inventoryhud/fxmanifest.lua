fx_version 'cerulean'
game 'gta5'

name 'esx_inventoryhud'
author 'Trsak'
editor 'Dutch Players'
description "Thé ESX Inventory HUD from Trsak and loved by many others!"
version '3.3.6.1'
url 'https://github.com/dutchplayers/ESX-1.2-Inventory-HUD'

ui_page "html/ui.html"

disable_version_check 'no'
disable_version_check_message 'no'

client_scripts {
	"@es_extended/locale.lua",
	"config.lua",
	"locales/*.lua",
	"client/main.lua",
	"client/player.lua",
	"client/shop.lua",
	"client/weapons.lua",
	"client/trunk.lua",
	"client/glovebox.lua",
	"client/beds.lua",
	"client/motels.lua",
	"client/vault.lua",
	"client/property.lua"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	"@es_extended/locale.lua",
	"config.lua",
	"locales/*.lua",
	"server/main.lua",
	"server/versioncheck.lua"
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
	'disc-base',
	'disc-ammo',
	'mythic_notify',
	'mythic_progbar'
}
