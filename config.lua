Config = {}
Config.Locale = "nl" -- Currently supported: nl, en, tr, fr. Your translation file is really appreciated. Send it to our Github repo.
Config.IncludeCash = true -- Include cash in inventory? true or false.
Config.IncludeWeapons = true -- Include weapons in inventory? true or nil.
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)? true or false.
Config.ExcludeAccountsList = {"bank", "money"} -- DO NOT TOUCH! Inlcuding money or black_money this way will cause bugs.
Config.OpenControl = 289 -- player inventory
Config.CloseControl = 289 -- player inventory
Config.OpenKeyGlovebox = 170
Config.OpenKeyTrunk = 170
Config.ReloadTime = 2000 --ms
Config.MaxWeight = 80 -- Use the same weight as in your /es_extended/config.lua/ ## used for glovebox and trunk
Config.Command = {Steal = "steal", CloseInv = "closeinventory", Unequip = "unequip"} -- NOT YET SUPPORTED, CHANGE IN /server/main.lua/
Config.Attachments = {"flashlight", "suppressor", "scope", "grip", "skin"} -- NOT YET SUPPORTED
Config.JobOnlyInventory = true -- true = only Config.InventoryJob can open someone elses inventory. False = everybody can 'steal' items from someone else.
Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk and glovebox.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.
Config.IllegalshopOpen = false -- if true everybody can enter this shop. If false only Config.InventoryJob.Ilelgal can enter this shop.
Config.InventoryJob = {Police = "police", Nightclub = "nightclub", Mafia = "mafia", Illegal = nil}
-- List of item names that will close ui when used.
Config.CloseUiItems = {"phone", "weed_seed", "tunerchip", "fixkit", "medikit", "firstaid", "vicodin", "adrenaline", "vuurwerk", "vuurwerk2", "vuurwerk3", "vuurwerk4", "armbrace", "neckbrace", "bodybandage", "legbrace", "bandage", "billet"}

Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.5}
Config.MarkerColor = {r = 0, g = 128, b = 255}
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

Config.Weight = 80 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.DefaultWeight = 1 -- Default weight for an item

Config.localWeight = {
    bread = 1,
    water = 1,
    WEAPON_SMG = 5
}

Config.GloveboxSize = {
    [0] = 300, --Compact
    [1] = 400, --Sedan
    [2] = 700, --SUV
    [3] = 250, --Coupes
    [4] = 300, --Muscle
    [5] = 100, --Sports Classics
    [6] = 50, --Sports
    [7] = 50, --Super
    [8] = 50, --Motorcycles
    [9] = 1800, --Off-road
    [10] = 3000, --Industrial
    [11] = 700, --Utility
    [12] = 1000, --Vans
    [13] = 0, --Cycles
    [14] = 50, --Boats
    [15] = 200, --Helicopters
    [16] = 0, --Planes
    [17] = 400, --Service
    [18] = 400, --Emergency
    [19] = 0, --Military
    [20] = 3000, --Commercial
    [21] = 0 --Trains
}

Config.TrunkSize = {
    [0] = 3000, --Compact
    [1] = 4000, --Sedan
    [2] = 7000, --SUV
    [3] = 2500, --Coupes
    [4] = 3000, --Muscle
    [5] = 1000, --Sports Classics
    [6] = 500, --Sports
    [7] = 500, --Super
    [8] = 500, --Motorcycles
    [9] = 18000, --Off-road
    [10] = 30000, --Industrial
    [11] = 7000, --Utility
    [12] = 10000, --Vans
    [13] = 0, --Cycles
    [14] = 500, --Boats
    [15] = 2000, --Helicopters
    [16] = 0, --Planes
    [17] = 4000, --Service
    [18] = 4000, --Emergency
    [19] = 0, --Military
    [20] = 30000, --Commercial
    [21] = 0 --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "police",
    police = "police",
    ambulance = "ambulance",
    mecano = "mechano",
    mechanic = "mechanic",
    police = "police",
    nightclub = "club",
    bahamas = "bahamas",
    cardealer = "dealer"
}

Config.Shops = {
    RegularShop = {
        Locations = {
			{x = 373.875,   y = 325.896,  z = 102.566}
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
			--{x = 25.723,   y = -1346.966, z = 28.497}
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
           -- { x = 468.58, y = -3205.64, z = 9.79 }
        },
        Items = {
            { name = 'bread', price = 1},
            { name = 'water', price = 1}
        }
    },

    DrugShop = {
        Locations = {
           -- { x = 468.58, y = -3205.64, z = 9.79 }
        },
        Items = {
            { name = 'bread', price = 1},
            { name = 'water', price = 1}
        }
    },

    RobsLiquor = {
        Locations = {
          --  { x = 1135.808, y = -982.281, z = 45.415 }
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
           -- { x = 2748.0, y = 3473.0, z = 55.68 }
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
          --  { x = -1103.05, y = -823.72, z = 14.48 }
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
            {name = "ammunition_pistol", price = 1},
            {name = "ammunition_pistol_large", price = 1},
            {name = "ammunition_shotgun", price = 1},
            {name = "ammunition_shotgun_large", price = 1},
            {name = "ammunition_smg", price = 1},
            {name = "ammunition_smg_large", price = 1},
            {name = "ammunition_rifle", price = 1},
            {name = "ammunition_rifle_large", price = 1},
            {name = "ammunition_snp", price = 1},
            {name = "ammunition_snp_large", price = 1}--,
            --{name = "flashlight",price = 1},
            --{name = "grip",price = 1},
            --{name = "scope",price = 1},
            --{name = "skin",price = 1},
            --{name = "supressor",price = 1}
        }
    },


    PoliceShop = { -- available for Config.InventoryJob.Police
       Locations = {
           { x = 451.68, y = -980.02, z = 29.69 }

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
            {name = "ammunition_pistol",price = 1},
            {name = "ammunition_pistol_large",price = 1},
            {name = "ammunition_shotgun",price = 1},
            {name = "ammunition_shotgun_large",price = 1},
            {name = "ammunition_smg",price = 1},
            {name = "ammunition_smg_large",price = 1},
            {name = "ammunition_rifle",price = 1},
            {name = "ammunition_rifle_large",price = 1},
            {name = "ammunition_snp",price = 1},
            {name = "ammunition_snp_large",price = 1}
        }
	},
	
	BlackMarket = { -- available for Config.InventoryJob.Mafia
        Locations = {
          --  { x = -1297.96, y = -392.60, z = 35.47 }
        
        },

        Items = {
            {name = "WEAPON_PISTOL", price = 1},
            {name = "ammunition_pistol",price = 1},
            {name = "ammunition_pistol_large",price = 1}		
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

Config.EnableInventoryHUD = true

Config.Ammo = {
    {
        name = 'ammunition_pistol',
        weapons = {
            `WEAPON_PISTOL`,
            `WEAPON_APPISTOL`,
            `WEAPON_SNSPISTOL`,
            `WEAPON_COMBATPISTOL`,
            `WEAPON_HEAVYPISTOL`,
            `WEAPON_MACHINEPISTOL`,
            `WEAPON_MARKSMANPISTOL`,
            `WEAPON_PISTOL50`,
            `WEAPON_VINTAGEPISTOL`
        },
        count = 30
    },
    {
        name = 'ammunition_pistol_large',
        weapons = {
            `WEAPON_PISTOL`,
            `WEAPON_APPISTOL`,
			`WEAPON_SNSPISTOL`,
            `WEAPON_COMBATPISTOL`,
            `WEAPON_HEAVYPISTOL`,
            `WEAPON_MACHINEPISTOL`,
            `WEAPON_MARKSMANPISTOL`,
            `WEAPON_PISTOL50`,
            `WEAPON_VINTAGEPISTOL`
        },
        count = 60
    },
	{
        name = 'ammunition_shotgun',
        weapons = {
            `WEAPON_ASSAULTSHOTGUN`,
			`WEAPON_AUTOSHOTGUN`,
            `WEAPON_BULLPUPSHOTGUN`,
			`WEAPON_DBSHOTGUN`,
            `WEAPON_HEAVYSHOTGUN`,
            `WEAPON_PUMPSHOTGUN`,
            `WEAPON_SAWNOFFSHOTGUN`
        },
        count = 12
    },
	{
        name = 'ammunition_shotgun_large',
        weapons = {
            `WEAPON_ASSAULTSHOTGUN`,
			`WEAPON_AUTOSHOTGUN`,
            `WEAPON_BULLPUPSHOTGUN`,
			`WEAPON_DBSHOTGUN`,
            `WEAPON_HEAVYSHOTGUN`,
            `WEAPON_PUMPSHOTGUN`,
            `WEAPON_SAWNOFFSHOTGUN`
        },
        count = 18
    },
	{
        name = 'ammunition_smg',
        weapons = {
            `WEAPON_ASSAULTSMG`,
			`WEAPON_MICROSMG`,
            `WEAPON_MINISMG`,
            `WEAPON_SMG`
        },
        count = 45
    },
	{
        name = 'ammunition_smg_large',
        weapons = {
            `WEAPON_ASSAULTSMG`,
			`WEAPON_MICROSMG`,
            `WEAPON_MINISMG`,
            `WEAPON_SMG`
        },
        count = 65
    },
	{
        name = 'ammunition_rifle',
        weapons = {
            `WEAPON_ADVANCEDRIFLE`,
			`WEAPON_ASSAULTRIFLE`,
            `WEAPON_BULLPUPRIFLE`,
            `WEAPON_CARBINERIFLE`,
			`WEAPON_SPECIALCARBINE`,
			`WEAPON_COMPACTRIFLE`
        },
        count = 45
    },
	{
        name = 'ammunition_rifle_large',
        weapons = {
            `WEAPON_ADVANCEDRIFLE`,
			`WEAPON_ASSAULTRIFLE`,
            `WEAPON_BULLPUPRIFLE`,
            `WEAPON_CARBINERIFLE`,
			`WEAPON_SPECIALCARBINE`,
			`WEAPON_COMPACTRIFLE`
        },
        count = 65
    },
	{
        name = 'ammunition_snp',
        weapons = {
            `WEAPON_SNIPERRIFLE`,
			`WEAPON_HEAVYSNIPER`,
            `WEAPON_MARKSMANRIFLE`
        },
        count = 10
    },
	{
        name = 'ammunition_snp_large',
        weapons = {
            `WEAPON_SNIPERRIFLE`,
			`WEAPON_HEAVYSNIPER`,
            `WEAPON_MARKSMANRIFLE`
        },
        count = 15
    },
	{
        name = 'ammunition_fireextinguisher',
        weapons = {
            `WEAPON_FIREEXTINGUISHER`
        },
        count = 15
    }
}

Config.VaultBox = 'p_v_43_safe_s'
Config.Vault = {
	vault = {
		coords = vector3(-544.61, -197.39, 37.22),
		heading = 298.73,
		needItemLicense = 'apple', --'licence_vault' -- If you don't want to use items Allow you to leave it blank or needItemLicense = nil
		InfiniteLicense = true -- Should one License last forever?
	},
	police = { -- blokkenpark kantoor
		coords = vector3(452.99, -973.48, 29.69),
		heading = 270.00,
		needItemLicense = false,
	},
	ambulance = {
		coords = vector3(337.54, -584.01, 27.9),
		heading = 74.52,
		needItemLicense = false,
	},
	mechanic = {
		coords = vector3(-201.79, -1314.48, 30.09),
		heading = 358.01,
		needItemLicense = false,
	},
	nachtclub = {
		coords = vector3(-1496.15, 124.61, 55.67),
		heading = 229.74,
		needItemLicense = false,
	},
	bahamas = {
		coords = vector3(-1382.2, -610.09, 29.82),
		heading = 344.18,
		needItemLicense = false,
	},
	taxi = {
		coords = vector3(891.57, -173.07, 73.67),
		heading = 57.67,
		needItemLicense = false,
	},
	pizza = {
		coords = vector3(447.25, 140.5, 99.2),
		heading = 160.61,
		needItemLicense = false,
	},
	cardealer = {
		coords = vector3(-12.53, -1663.25, 32.04),
		heading = 169.96,
		needItemLicense = false,
	},
	starbucks = {
		coords = vector3(-632.35, 226.28, 80.88),
		heading = 86.65,
		needItemLicense = false,
	},
	gemeente = {
		coords = vector3(-549.06, -199.27, 69.98),
		heading = 212.86,
		needItemLicense = false,
	},
	pilot = {
		coords = vector3(-931.34, -2933.14, 12.95),
		heading = 327.39,
		needItemLicense = false,
	}
}

