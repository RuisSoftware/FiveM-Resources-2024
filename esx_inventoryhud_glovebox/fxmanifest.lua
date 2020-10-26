fx_version 'cerulean'
game 'gta5'

name 'esx_inventoryhud_glovebox'
author 'Trsak'
editor 'Dutch Players'
description "Thé ESX Inventory HUD from Trsak and loved by many others!"
version '3.3.6.1'
url 'https://github.com/dutchplayers/ESX-1.2-Inventory-HUD'

server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "@es_extended/locale.lua",
  "locales/*.lua",
  "config.lua",
  "server/classes/c_glovebox.lua",
  "server/glovebox.lua",
  "server/esx_glovebox-sv.lua"
}

client_scripts {
  "@es_extended/locale.lua",
  "locales/*.lua",
  "config.lua",
  "client/esx_glovebox-cl.lua"
}

dependencies {
	'esx_inventoryhud'
}