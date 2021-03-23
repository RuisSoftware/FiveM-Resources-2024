Config = {}

Config.DropPlayer = {Enabled = true, Message = 'Devtools are disabled'} -- default true. Kicks a player from the server with kick message.
Config.BanPlayer = {Enabled = false, ServerEvent = 'yourban:trigger', Message = 'Devtools are disabled.'} -- Put your server sided trigger name to ban the source automaticly.
Config.ClientRestart = {Enabled = false} -- defualt false. Shutdown the client game without calling the server. No kick message available.
