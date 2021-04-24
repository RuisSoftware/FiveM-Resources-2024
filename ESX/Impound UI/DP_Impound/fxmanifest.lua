fx_version "bodacious"
games {"gta5"}

name "impound-ui"
description "Impound UI"
author "german-admiral-man"
contributor "Dutch Players"
version "1.0.1"
url "https://github.com/german-admiral-man/Impound-UI"
ui_page 'html/ui.html'

server_scripts {
  '@async/async.lua',
  '@mysql-async/lib/MySQL.lua',
  'server/main*.lua'
}

client_scripts {
  '@DP_Framework/import.lua',
  'client/main*.lua'
}

files {
  'html/ui*.html',
  'html/ui*.css', 
  'html/ui*.js',
  'html/close*.png',
  'html/logo*.gif',
  'html/car*.png'
}