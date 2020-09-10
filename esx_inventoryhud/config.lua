Config = {}
Config.Locale = "nl" -- Currently supported: nl, en, tr, fr. Your translation file is really appreciated. Send it to our Github repo.
Config.IncludeCash = true -- Include cash in inventory? treu or false.
Config.IncludeWeapons = true -- Include weapons in inventory? true or nil.
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)? true or false.
Config.ExcludeAccountsList = {"bank", "money"} -- DO NOT TOUCH! Inlcuding money or black_money this way will cause bugs.
Config.OpenControl = 289
Config.CloseControl = 289
Config.MaxWeight = 80 -- Use the same weight as in your /es_extended/config.lua/
Config.Command = {Steal = "steal", CloseInv = "closeinventory", Unequip = "unequip"} -- NOT YET SUPPORTED, CHANGE IN /server/main.lua/
Config.Attachments = {"flashlight", "suppressor", "scope", "grip", "skin"} -- NOT YET SUPPORTED
Config.JobOnlyInventory = true 
Config.InventoryJob = {One = "police", Two = "nightclub", Three = nil}
-- List of item names that will close ui when used.
Config.CloseUiItems = {"phone", "weed_seed", "tunerchip", "fixkit", "medikit", "firstaid", "vicodin", "adrenaline", "vuurwerk", "vuurwerk2", "vuurwerk3", "vuurwerk4", "armbrace", "neckbrace", "bodybandage", "legbrace", "bandage", "billet"}

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 402
Config.PrisonShopBlipID = 52
Config.WeedStoreBlipID = 140
Config.WeaponShopBlipID = 110
Config.PoliceShopShopBlipID = 110

Config.Color = 2
Config.WeaponColor = 1

-- BLIPS
Config.ShowBlackMarketBlip = true
Config.ShowPoliceShopBlip = true
Config.ShowNightclubShopBlip = true
Config.ShowWeaponShopBlip = true
Config.ShowIllegalShopBlip = true
Config.ShowPrisonShopBlip = true
Config.ShowYouToolBlip = true
Config.ShowRegularShopBlip = true
Config.ShowRobsLiquorBlip = true

Config.LicensePrice = 25000
Config.License = {Weapon = "weapon", Police = "weapon", Nightclub = "weapon"} -- What license is needed for this shop?

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
            {name = 'lemon'},
            {name = 'phone'},
            {name = 'hamburger'},
            {name = 'icedcoffee'},
            {name = 'juice'},
            {name = 'coffeecup'},
            {name = 'cucumbers'},
            {name = 'garlic'},
            {name = 'energy'},
            {name = 'lemonade'},
            {name = 'banana'},
            {name = 'dildo'},
            {name = 'icetea'},
            {name = 'sim'}     
        }
    },

    IlegalShop = {
        Locations = {
            { x = 468.58, y = -3205.64, z = 9.79 },
        },
        Items = {
            { name = 'bread' , price = 1},
            { name = 'water',price = 1 }
        }
    },

    RobsLiquor = {
        Locations = {
            { x = 1135.808, y = -982.281, z = 45.415 },
        },
        Items = {
            {name = 'beer', price = 1},
            {name = 'wine', price = 1},
            {name = 'vodka', price = 1},
            {name = 'tequila', price = 1},
            {name = 'whisky', price = 1},
            {name = 'grand_cru', price = 1}

        }
    },

    YouTool = {
        Locations = {
            { x = 2748.0, y = 3473.0, z = 55.68 },
        },
        Items = {
            {name = 'drill', price = 1},
            {name = 'binocular', price = 1},
            {name = 'fixkit', price = 1},
            {name = 'gps', price = 1},
            {name = 'lockpick', price = 1},
            {name = 'scubagear', price = 1},
            {name = 'blowtorch', price = 1},
            {name = '1gbag', price = 1},
            {name = '5gbag', price = 1},
            {name = '50gbag', price = 1},
            {name = '100gbag', price = 1},
            {name = 'lowgradefert', price = 1},
            {name = 'highgradefert', price = 1},
            {name = 'plantpot', price = 1},
            {name = 'drugscales', price = 1}
        }
    },

    PrisonShop = {
        Locations = {
            { x = -1103.05, y = -823.72, z = 14.48 },
        },
        Items = {
            {name = 'bread', price = 1},
            {name = 'water', price = 1},
            {name = 'cigarette', price = 1},
            {name = 'lighter'}, price = 1,
            {name = 'sandwich', price = 1},
            {name = 'chips', price = 1}
        }
    },

    WeaponShop = {
        Locations = {
            { x = 22.09, y = -1107.28, z = 28.80 }
          
        },

        Items = {
            {name = "WEAPON_FLASHLIGHT", price = 1},
            {name = "WEAPON_STUNGUN", price = 1},
            {name = "WEAPON_KNIFE", price = 1},
            {name = "WEAPON_BAT", price = 1},
            {name = "WEAPON_PISTOL", price = 1},
            {name = "WEAPON_PUMPSHOTGUN",price = 1},
            {name = "WEAPON_SMOKEGRENADE",price = 1},
            {name = "WEAPON_FIREEXTINGUISHER",price = 1},
            {name = "WEAPON_CROWBAR",price = 1},
            {name = "WEAPON_BZGAS",price = 1},
            {name = "disc_ammo_pistol",price = 1},
            {name = "disc_ammo_pistol_large",price = 1},
            {name = "disc_ammo_shotgun",price = 1},
            {name = "disc_ammo_shotgun_large",price = 1},
            {name = "disc_ammo_smg",price = 1},
            {name = "disc_ammo_smg_large",price = 1},
            {name = "disc_ammo_rifle",price = 1},
            {name = "disc_ammo_rifle_large",price = 1},
            {name = "disc_ammo_snp",price = 1},
            {name = "disc_ammo_snp_large",price = 1},
            --{name = "flashlight",price = 1},
            --{name = "grip",price = 1},
            --{name = "scope",price = 1},
            --{name = "skin",price = 1},
            --{name = "supressor",price = 1}
        }
    },


    PoliceShop = {
       Locations = {
           { x = 451.68, y = -980.02, z = 29.69 },

        },
        Items = {
            {name = "WEAPON_FLASHLIGHT", price = 1},
            {name = "WEAPON_STUNGUN", price = 1},
            {name = "WEAPON_KNIFE", price = 1},
            {name = "WEAPON_BAT", price = 1},
            {name = "WEAPON_PISTOL", price = 1},
            {name = "WEAPON_PUMPSHOTGUN",price = 1},
            {name = "WEAPON_SMOKEGRENADE",price = 1},
            {name = "WEAPON_FIREEXTINGUISHER",price = 1},
            {name = "WEAPON_CROWBAR",price = 1},
            {name = "WEAPON_BZGAS",price = 1},
            {name = "disc_ammo_pistol",price = 1},
            {name = "disc_ammo_pistol_large",price = 1},
            {name = "disc_ammo_shotgun",price = 1},
            {name = "disc_ammo_shotgun_large",price = 1},
            {name = "disc_ammo_smg",price = 1},
            {name = "disc_ammo_smg_large",price = 1},
            {name = "disc_ammo_rifle",price = 1},
            {name = "disc_ammo_rifle_large",price = 1},
            {name = "disc_ammo_snp",price = 1},
            {name = "disc_ammo_snp_large",price = 1},
        }
	},
	
	BlackMarket = {
        Locations = {
            { x = -1297.96, y = -392.60, z = 35.47 },
        
        },

        Items = {
            {name = "WEAPON_PISTOL", price = 1},
            {name = "disc_ammo_pistol",price = 1},
            {name = "disc_ammo_pistol_large",price = 1}		
        }
    },
	
    LicenseShop = {
        Locations = {
            { x = 12.47, y = -1105.5, z = 29.8}
        }
    },
	
    ShopNightclub = {
        Locations = {
            { x = -1518.48, y = 113.1, z = 49.05 }
      
        },
        Items = {
            {name = 'beer', price = 1},
            {name = 'wine', price = 1},
            {name = 'vodka', price = 1},
            {name = 'tequila', price = 1},
            {name = 'whisky', price = 1},
            {name = 'grand_cru', price = 1}
        }
    },
}

Config.Throwables = { -- WEAPON NAME & WEAPON HASH
    WEAPON_MOLOTOV = 615608432,
    WEAPON_GRENADE = -1813897027,
    WEAPON_STICKYBOMB = 741814745,
    WEAPON_PROXMINE = -1420407917,
    WEAPON_SMOKEGRENADE = -37975472,
    WEAPON_PIPEBOMB = -1169823560,
    WEAPON_FLARE = 1233104067,
    WEAPON_SNOWBALL = 126349499
}

Config.FuelCan = 883325847

Config.PropList = { -- Here you can change the prop when using the item.
    cash = {["model"] = 'prop_cash_pile_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}
}