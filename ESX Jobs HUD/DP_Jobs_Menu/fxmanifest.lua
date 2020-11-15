fx_version 'adamant'
game 'gta5'

name 'DP_Jobs_Menu'
author 'Dutch Players'
description 'ESX Jobs HUD'

version '1.0'
ui_page "html/ui.html"

files {
  "html/ui.html",
  "html/js/index.js",
  "html/css/style.css"
}

client_script {
  '@es_extended/locale.lua',
  'config.lua',
  'client.lua'
}

server_script {
  '@es_extended/locale.lua',
  'config.lua',
  'server.lua'
}

dependencies {
	'es_extended'
}
