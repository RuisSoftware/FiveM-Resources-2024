fx_version 'adamant'

game 'gta5'

description 'Inventory HUD Trunk for ESX 1.2'

version '2.3.1'


server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "@es_extended/locale.lua",
  "locales/nl.lua",
  "locales/en.lua",
  "locales/fr.lua",
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
  "config.lua",
  "client/esx_trunk-cl.lua"
}

dependencies {
  'es_extended',
  'cron',
  'esx_addonaccount',
  'esx_addoninventory',
  'esx_datastore',
  'esx_license',
  'B1G_NOTIFY'
}
