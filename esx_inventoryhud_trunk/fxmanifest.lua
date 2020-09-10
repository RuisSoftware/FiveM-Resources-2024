fx_version 'cerulean'
game 'gta5'

name 'esx_inventoryhud_trunk'
author 'Trsak'
description "Thé ESX Inventory HUD from Trsak and loved by many others!"
version '3.0'
url 'https://github.com/dutchplayers/ESX-1.2-Inventory-HUD'

server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "@es_extended/locale.lua",
  "locales/*.lua",
  "config.lua",
  "server/classes/c_trunk.lua",
  "server/trunk.lua",
  "server/esx_trunk-sv.lua"
}

client_scripts {
  "@es_extended/locale.lua",
  "locales/*.lua",
  "config.lua",
  "client/esx_trunk-cl.lua"
}

dependencies {
	'esx_inventoryhud'
}