fx_version 'cerulean'
game 'gta5'

version '1.4'
name 'DP_NPC_Airplanes'
description 'Fly to airfields like Cayo Perico'
author 'ghosty'
edits 'by Dutch Players' 

dependencies {
	'NativeUI', 
	'DP_Framework',
	--'es_extended'
}

client_scripts {
    '@DP_Framework/import.lua',
	'@NativeUI/NativeUI.lua',
    'config.lua',
    'client/*.lua',
}

server_script {
    'config.lua',
    'server/*.lua'
}
