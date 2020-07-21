fx_version 'adamant'

game 'gta5'

description 'Inventory HUD Trunk for ESX'

version '2.4.0'


server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "@es_extended/locale.lua",
  "locales/nl.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "locales/tr.lua",
  "config.lua",
  "server/classes/c_trunk.lua",
  "server/trunk.lua",
  "server/esx_trunk-sv.lua"
}

client_scripts {
  "@es_extended/locale.lua",
  "locales/nl.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "locales/tr.lua",
  "config.lua",
  "client/esx_trunk-cl.lua"
}

