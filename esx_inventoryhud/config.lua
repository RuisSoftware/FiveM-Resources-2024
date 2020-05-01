Config = {}
Config.Locale = 'nl'
Config.IncludeCash = true -- DONT TOUCH!
Config.IncludeWeapons = true -- TRUE or FALSE
Config.IncludeAccounts = true -- TRUE or FALSE
Config.ExcludeAccountsList = {"bank"} --  DONT TOUCH!
Config.OpenControl = 289 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.

-- List of item names that will close ui when used
Config.CloseUiItems = {"phone", "weed_seed", "tunerchip", "fixkit", "medikit"}

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 402
Config.PrisonShopBlipID = 52
Config.WeedStoreBlipID = 140
Config.WeaponShopBlipID = 110

Config.ShopLength = 14
Config.LiquorLength = 10
Config.YouToolLength = 2
Config.PrisonShopLength = 2

Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.5}
Config.MarkerColor = {r = 0, g = 128, b = 255}
Config.Color = 2
Config.WeaponColor = 1

Config.WeaponLicence = {x = 12.47, y = -1105.5, z = 29.8}
Config.LicensePrice = 5000

Config.Shops = {
    RegularShop = {
        Locations = {
			{x = 373.875,   y = 325.896,  z = 102.566},
			{x = 2557.458,  y = 382.282,  z = 107.622},
			{x = -3038.939, y = 585.954,  z = 6.908},
			{x = -3241.927, y = 1001.462, z = 11.830},
			{x = 547.431,   y = 2671.710, z = 41.156},
			{x = 1961.464,  y = 3740.672, z = 31.343},
			{x = 2678.916,  y = 3280.671, z = 54.241},
            {x = 1729.216,  y = 6414.131, z = 34.037},
            {x = -48.519,   y = -1757.514, z = 28.421},
			{x = 1163.373,  y = -323.801,  z = 68.205},
			{x = -707.501,  y = -914.260,  z = 18.215},
			{x = -1820.523, y = 792.518,   z = 137.118},
            {x = 1698.388,  y = 4924.404,  z = 41.063},
            {x = 25.723,   y = -1346.966, z = 28.497}, 

        },
        Items = {
            {name = 'bread'},
            {name = 'water'},
            {name = 'cigarette'},
            {name = 'lighter'},
            {name = 'rollingpaper'},
            {name = 'phone'},
            {name = 'sandwich'},
            {name = 'hamburger'},
            {name = 'cupcake'},
            {name = 'chips'},
            {name = 'pistachio'},
            {name = 'chocolate'},
            {name = 'cashew'},
            {name = 'cocacola'},
            {name = 'drpepper'},
            {name = 'energy'},
            {name = 'lemonade'},
            {name = 'icetea'}
        }
    },

    RobsLiquor = {
		Locations = {
			{x = 1135.808,  y = -982.281,  z = 45.415},
	
        },
        Items = {
            {name = 'beer'},
            {name = 'wine'},
            {name = 'vodka'},
            {name = 'tequila'},
            {name = 'whisky'},
            {name = 'grand_cru'}
        }
	},

    YouTool = {
        Locations = {
            {x = 2748.0, y = 3473.0, z = 55.68},
        },
        Items = {
            {name = 'drill'},
            {name = 'binocular'},
            {name = 'fixkit'},
            {name = 'gps'},
            {name = 'lockpick'},
            {name = 'scubagear'},
            {name = 'blowtorch'},
            {name = '1gbag'},
            {name = '5gbag'},
            {name = '50gbag'},
            {name = '100gbag'},
            {name = 'lowgradefert'},
            {name = 'highgradefert'},
            {name = 'plantpot'},
            {name = 'drugscales'}
        }
    },

    PrisonShop = {
        Locations = {
            {x = 1728.41, y = 2584.31, z = 45.84},
        },
        Items = {
            {name = 'bread'},
            {name = 'water'},
            {name = 'cigarette'},
            {name = 'lighter'},
            {name = 'sandwich'},
            {name = 'chips'}
        }
    },

    WeaponShop = {
        Locations = {
            { x = -662.180, y = -934.961, z = 20.829 },
        
        },
        Weapons = {
            {name = "WEAPON_FLASHLIGHT", ammo = 1},
            {name = "WEAPON_STUNGUN", ammo = 1},
            {name = "WEAPON_KNIFE", ammo = 1},
            {name = "WEAPON_BAT", ammo = 1},
            {name = "WEAPON_PISTOL", ammo = 45},
            {name = "WEAPON_PUMPSHOTGUN", ammo = 25}
        },
        Ammo = {
            {name = "9mm_rounds", weaponhash = "WEAPON_PISTOL", ammo = 24},
            {name = "shotgun_shells", weaponhash = "WEAPON_PUMPSHOTGUN", ammo = 12}
        },
        Items = {

        }
    },
    LicenseShop = {
        Locations = {
            { x = 12.47, y = -1105.5, z = 29.8}
        }
    }
}
