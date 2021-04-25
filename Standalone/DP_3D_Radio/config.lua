Config = {}
-- ### To Make This Resource Standalone Set All Options To False ### --
Config.UseVIP = true -- Dependencie PXRP_VIP( https://github.com/dutchplayers/pxrp_vip )
Config.UseESX = true -- To disable audio system if player is not in car and does not have radio item. If set to false, players are always able to use the commands.
Config.AlwaysNeedItem = true -- Config.UseESX must set to true if you want to use this options. With this option set to true users always need an item to use the car radio.
Config.UsePocketRadio = true -- Config.UseESX must set to true if you want to use this options. With this option set to true users always need an item to use the radio outside vehicle.
Config.PocketItem = 'hifi'
Config.CarItem = 'carradio'
Config.CarMovementInverval = 50 -- ms between potition sync in car
Config.PocketMovementInverval = 500 -- ms between potition sync not in car