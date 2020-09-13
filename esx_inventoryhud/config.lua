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
Config.JobOnlyInventory = true -- true = only Config.InventoryJob can open someone else inventory. False = everybody can 'steal' items from someone else.
Config.IllegalshopOpen = false -- if true everybody can enter this shop. If false only Config.InventoryJob.Ilelgal can enter this shop.
Config.InventoryJob = {Police = "police", Nightclub = "nightclub", Mafia = "mafia", Illegal = nil}
-- List of item names that will close ui when used.
Config.CloseUiItems = {"phone", "weed_seed", "tunerchip", "fixkit", "medikit", "firstaid", "vicodin", "adrenaline", "vuurwerk", "vuurwerk2", "vuurwerk3", "vuurwerk4", "armbrace", "neckbrace", "bodybandage", "legbrace", "bandage", "billet"}

Config.Color = 2
Config.WeaponColor = 1

-- BLIPS
Config.ShowDrugMarketBlip = true
Config.DrugStoreBlipID = 140
Config.ShowRegularShopBlip = true
Config.ShopBlipID = 52
Config.ShowRobsLiquorBlip = true
Config.LiquorBlipID = 93
Config.ShowYouToolBlip = true
Config.YouToolBlipID = 402
Config.ShowBlackMarketBlip = true
Config.BlackMarketBlipID = 110
Config.ShowPoliceShopBlip = true
Config.PoliceShopBlipID = 110
Config.ShowNightclubShopBlip = true
Config.NightclubShopBlipID = 110
Config.ShowWeaponShopBlip = true
Config.WeaponShopBlipID = 110
Config.ShowIllegalShopBlip = true
Config.IllegalShopBlipID = 110
Config.ShowPrisonShopBlip = true
Config.PrisonShopBlipID = 52

Config.LicensePrice = 25000
Config.License = {Weapon = "weapon", Police = "weapon", Nightclub = "weapon"} -- What license is needed for this shop?

Config.Shops = {
    RegularShop = {
        Locations = {
			{x = 373.875,   y = 325.896,  z = 102.566},
			--{x = 2557.458,  y = 382.282,  z = 107.622},
			--{x = -3038.939, y = 585.954,  z = 6.908},
			--{x = -3241.927, y = 1001.462, z = 11.830},
			--{x = 547.431,   y = 2671.710, z = 41.156},
			--{x = 1961.464,  y = 3740.672, z = 31.343},
			--{x = 2678.916,  y = 3280.671, z = 54.241},
			--{x = 1729.216,  y = 6414.131, z = 34.037},
			--{x = -48.519,   y = -1757.514, z = 28.421},
			--{x = 1163.373,  y = -323.801,  z = 68.205},
			--{x = -707.501,  y = -914.260,  z = 18.215},
			--{x = -1820.523, y = 792.518,   z = 137.118},
			--{x = 1698.388,  y = 4924.404,  z = 41.063},
			--{x = 25.723,   y = -1346.966, z = 28.497}, 
        },
        Items = {
            {name = 'bread', price = 1},
            {name = 'water', price = 1},
            {name = 'lemon', price = 1},
            {name = 'phone', price = 1},
            {name = 'hamburger', price = 1},
            {name = 'icedcoffee', price = 1},
            {name = 'juice', price = 1},
            {name = 'coffeecup', price = 1},
            {name = 'cucumbers', price = 1},
            {name = 'garlic', price = 1},
            {name = 'energy', price = 1},
            {name = 'lemonade', price = 1},
            {name = 'banana', price = 1},
            {name = 'dildo', price = 1},
            {name = 'icetea', price = 1},
            {name = 'sim', price = 1}     
        }
    },

    IlegalShop = {
        Locations = {
           -- { x = 468.58, y = -3205.64, z = 9.79 },
        },
        Items = {
            { name = 'bread' , price = 1},
            { name = 'water',price = 1 }
        }
    },

    DrugShop = {
        Locations = {
           -- { x = 468.58, y = -3205.64, z = 9.79 },
        },
        Items = {
            { name = 'bread' , price = 1},
            { name = 'water',price = 1 }
        }
    },

    RobsLiquor = {
        Locations = {
          --  { x = 1135.808, y = -982.281, z = 45.415 },
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
           -- { x = 2748.0, y = 3473.0, z = 55.68 },
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
          --  { x = -1103.05, y = -823.72, z = 14.48 },
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


    PoliceShop = { -- available for Config.InventoryJob.Police
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
	
	BlackMarket = { -- available for Config.InventoryJob.Mafia
        Locations = {
          --  { x = -1297.96, y = -392.60, z = 35.47 },
        
        },

        Items = {
            {name = "WEAPON_PISTOL", price = 1},
            {name = "disc_ammo_pistol",price = 1},
            {name = "disc_ammo_pistol_large",price = 1}		
        }
    },
	
    LicenseShop = {
       Locations = {
      --      { x = 12.47, y = -1105.5, z = 29.8}
        }
    },
	
    ShopNightclub = { -- available for Config.InventoryJob.Nightclub
        Locations = {
       --     { x = -1518.48, y = 113.1, z = 49.05 }
      
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