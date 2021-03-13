fx_version 'cerulean'
game 'gta5'

name 'DP_Dutch_Radio'
author 'Dutch Players'
description 'Free, Dutch Radio'
version '1.2.2'
url 'https://github.com/dutchplayers/FiveM-Resources'

supersede_radio "RADIO_01_CLASS_ROCK" { url = "	http://icecast.omroep.nl/radio1-bb-mp3", volume = 0.2, name = "Radio 1" }
supersede_radio "RADIO_02_POP" { url = "http://icecast.omroep.nl/radio2-bb-mp3", volume = 0.2, name = "Radio 2" }
supersede_radio "RADIO_03_HIPHOP_NEW" { url = "http://icecast.omroep.nl/3fm-bb-mp3", volume = 0.2, name = "3FM" }
supersede_radio "RADIO_04_PUNK" { url = "http://21313.live.streamtheworld.com/SKYRADIO.mp3", volume = 0.2, name = "Skyradio" }
supersede_radio "RADIO_05_TALK_01" { url = "http://playerservices.streamtheworld.com/api/livestream-redirect/SRGSTR08.mp3", volume = 0.2, name = "Skyradio Christmas" }
supersede_radio "RADIO_06_COUNTRY" { url = "http://playerservices.streamtheworld.com/api/livestream-redirect/RADIO538.mp3", volume = 0.2, name = "Radio 538" }
supersede_radio "RADIO_07_DANCE_01" { url = "http://playerservices.streamtheworld.com/api/livestream-redirect/TLPSTR11.mp3", volume = 0.2, name = "Radio 538 Hitzone" }
supersede_radio "RADIO_08_MEXICAN" { url = "https://stream.100p.nl/100pctnl.mp3", volume = 0.2, name = "100%NL" }
supersede_radio "RADIO_09_HIPHOP_OLD" { url = "	https://stream.100p.nl/web01_mp3", volume = 0.2, name = "100%NL Feest" }
---------------geen radio icon
supersede_radio "RADIO_12_REGGAE" { url = "https://icecast-qmusicnl-cdp.triple-it.nl/Qmusic_nl_live_96.mp3", volume = 0.2, name = "QMusic" }
supersede_radio "RADIO_13_JAZZ" { url = "https://stream.slam.nl/slam_mp3", volume = 0.2, name = "Slam!" }
supersede_radio "RADIO_14_DANCE_02" { url = "http://stream.radiocorp.nl/web10_mp3", volume = 0.2, name = "Slam! Non Stop" }
supersede_radio "RADIO_15_MOTOWN" { url = "http://stream.radiocorp.nl/web12_mp3", volume = 0.2, name = "Slam! The Boom Room" }
supersede_radio "RADIO_20_THELAB" { url = "http://streaming.slam.nl/web11_mp3", volume = 0.2, name = "Slam! Hardstyle" }
supersede_radio "RADIO_16_SILVERLAKE" { url = "http://icecast.omroep.nl/funx-bb-mp3", volume = 0.2, name = "FunX NL" }
supersede_radio "RADIO_17_FUNK" { url = "http://icecast.omroep.nl/funx-arab-bb-mp3", volume = 0.2, name = "FunX Arab" }
supersede_radio "RADIO_18_90S_ROCK" { url = "http://icecast.omroep.nl/funx-dance-bb-mp3", volume = 0.2, name = "FunX Dance" }
supersede_radio "RADIO_21_DLC_XM17" { url = "http://ice.cr2.streamzilla.xlcdn.com:8000/sz=efteling=hdstream", volume = 0.2, name = "Efteling Radio" }
supersede_radio "RADIO_22_DLC_BATTLE_MIX1_RADIO" { url = "http://178.19.116.253/stream", volume = 0.2, name = "Geheime Zender - GigantFM" }

this_is_a_map 'yes'

files {
	"index.html"
}

ui_page "index.html"

client_scripts {
	"data.js",
	"client.js"
}