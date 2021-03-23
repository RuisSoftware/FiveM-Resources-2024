Config = {}
Config.Locale = 'en'

Config.Accounts = {
	bank = _U('account_bank'),
	black_money = _U('account_black_money'),
	money = _U('account_money')
}

Config.StartingAccountMoney = {bank = 50000}

Config.EnableSocietyPayouts = true -- pay from the society account that the player is employed at? Requirement: esx_society
Config.EnableHud            = false -- enable the default hud? Display current job and accounts (black, bank & cash)
Config.MaxWeight            = 50   -- the max inventory weight without backpack
Config.PaycheckInterval     = 10 * 60000 -- how often to recieve pay checks in milliseconds
Config.EnableDebug          = false

Config.IncompatibleResourcesToStop = {
	['fivem-esx-js'] = 'ES for short, the performance heavy RP framework no one uses - and source for the random unwanted ZAP ads you\'re seeing'
}