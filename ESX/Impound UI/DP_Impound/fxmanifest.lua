fx_version "bodacious"
games {"gta5"}

name "impound-ui"
description "Impound UI"
author "german-admiral-man"
contributor "Dutch Players"
version "1.0.2"
url "https://github.com/german-admiral-man/Impound-UI"
ui_page 'html/ui.html'

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/*.lua'
}

client_scripts {
  '@pmc-keybinds/import.lua', -- https://github.com/pitermcflebor/pmc-keybinds
  'client/*.lua'
}

files {
  'html/ui*.html',
  'html/ui*.css', 
  'html/ui*.js',
  'html/close*.png',
  'html/logo*.gif',
  'html/car*.png'
}
