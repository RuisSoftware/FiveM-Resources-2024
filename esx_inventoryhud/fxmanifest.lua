fx_version 'adamant'

game 'gta5'

description 'Inventory HUD for ESX'

version '2.4.0'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  "@es_extended/locale.lua",
  "server/main.lua",
  "locales/nl.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "locales/tr.lua",
  "config.lua"
}

client_scripts {
  "@es_extended/locale.lua",
  "client/main.lua",
  "client/shop.lua",	
  "client/trunk.lua",
  "client/glovebox.lua",
  "client/beds.lua",
  "client/motels.lua",
  "client/vault.lua",
  "client/property.lua",
  "client/player.lua",
  "locales/nl.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "locales/tr.lua",
  "config.lua"
}

ui_page {
	'html/ui.html'
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  -- JS LOCALES
  "html/locales/en.js",
  "html/locales/nl.js",
  "html/locales/fr.js",
  -- IMAGES
  "html/img/*.png",
  "html/img/items/*.png",
}

dependencies {
	'es_extended'
}
