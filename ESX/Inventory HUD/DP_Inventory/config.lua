Config = {}
Config.ServerName = 'Texel'
Config.Locale = 'nl' -- Currently supported: nl, en, tr, fr, br, de, fa, pt, es. Your translation file is really appreciated. Send it to our Github repo or Discord server.
Config.ExcludeAccountsList = {'bank', 'money'} -- DO NOT TOUCH!

Config.IncludeCash = true -- Include cash in inventory? true or false.
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)? true or false.
Config.CameraAnimationPocket = true -- Set camera focus towards player if in inventory.
Config.CameraAnimationBag = true -- Set camera focus towards player if in inventory.
Config.CameraAnimationTrunk = true -- Set camera focus towards player if in inventory.
Config.CameraAnimationGlovebox = true -- Set camera focus towards player if in inventory.
Config.EverybodyCanRob = true -- Rob a dead or mugging or handcuffed person or allow jobs only?
Config.JobOnlyInventory = true -- Can jobs use /openinventory ID from anywere? If False only admins can do this.
Config.AllowModerators = false -- Can moderators use /openinventory ID from anywere?
Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk and glovebox. Only if this is on TRUE Config.Allow.JOBNAME will work.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.
Config.AllowNightclub = true -- If true, nightclub will be able to search players' trunks.
Config.AllowMafia = true -- If true, mafia will be able to search players' trunks.
Config.IllegalshopOpen = false -- if true everybody can enter this shop. If false only Config.InventoryJob.Illegal can enter this shop.
Config.UseLicense = false -- You must have esx_licenses working on your server. 
Config.useAdvancedShop = true -- DP_Framework shop system. Not shared, sorry. Just set to false and use the in-build custom shop.
Config.disableVersionCheck = false
Config.disableVersionMessage = false

Config.Command = {Steal = 'steal', CloseInv = 'closeinventory', Unequip = 'unequip'} -- NOT YET SUPPORTED, CHANGE IN /server/main.lua/.
Config.Attachments = {'flashlight', 'mag', 'drummag', 'suppressor', 'scope', 'grip', 'skin', 'skin1', 'skin2', 'skin3', 'skin4', 'skin5', 'skin6','skin7'} -- SUPPORTED.
Config.InventoryJob = {Police = 'police', Nightclub = 'nightclub', Mafia = 'mafia', Illegal = nil, Ambulance = 'ambulance'} -- This must be the name used in your database/jobs table.
Config.CloseUiItems = {'phone', 'weed_seed', 'tunerchip', 'fixkit', 'medikit', 'firstaid', 'vicodin', 'adrenaline', 'vuurwerk', 'vuurwerk2', 'vuurwerk3', 'vuurwerk4', 'armbrace', 'neckbrace', 'bodybandage', 'legbrace', 'bandage', 'billet'} -- List of item names that will close ui when used.
Config.License = {Weapon = 'weapon', Police = 'weapon', Nightclub = 'weapon'} -- What license is needed for this shop?

Config.OpenControl = 289 -- F2. player inventory, it is recommend to use the same as CloseControl.
Config.CloseControl = 289 -- F2. player inventory, it is recommend to use the same as OpenControl.
Config.BagControl = 288 -- F4. player bag inventory
Config.SearchBag = 249 -- N. Search a bag on the ground
Config.TakeBag = 38 -- E. Take bag on the ground
Config.OpenKeyGlovebox = 170 -- F3. glovebox inventory (in-car), it is recommend to use the same as OpenKeyTrunk.
Config.OpenKeyTrunk = 170 -- F3. trunk inventory (behind-car), it is recommend to use the same as OpenKeyGlovebox.
Config.RobKeyOne = 38 -- E
Config.RobKeyTwo = 60 -- CTRL

Config.ReloadTime = 2000 -- in miliseconds for reloading your ammunition.

Config.InitialLockerRentPrice = 450
Config.DailyLockerRentPrice = 250
Config.LockerExterior = vector3(-286.23, 280.84, 89.89)
Config.LockerInterior = vector3(1173.24, -3196.62, -39.01)

Config.Lockers = {

	['locker1'] = {
		locker_name = 'Kluisje #1',
		location = vector3(1161.87, -3199.07, -39.01),
	},
	
	['locker2'] = {
		locker_name = 'Kluisje #2',
		location = vector3(1156.71, -3195.3, -39.01),
	},
	
	['locker3'] = {
		locker_name = 'Kluisje #3',
		location = vector3(1157.61, 3198.92, -39.01),
	},
	
	['locker4'] = {
		locker_name = 'Kluisje #4',
		location = vector3(1167.05, -3194.64, -39.01),
	},
	
	['locker5'] = {
		locker_name = 'Kluisje #5',
		location = vector3(1173.29, -3194.47, -39.01),
	},
	
	['locker6'] = {
		locker_name = 'Kluisje #6',
		location = vector3(1171.73, -3198.81, -39.01),
	},
	
}

Config.LicensePrice = 25000

Config.ShopMinimumGradePolice = 0 -- minimum grade to open the police shop
Config.ShopMinimumGradeNightclub = 0
Config.ShopMinimumGradeMafia = 0

-- BLIPS & MARKERS
Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.5}
Config.MarkerColor = {r = 0, g = 128, b = 255}
Config.Color = 2 -- currently used for most shop blip color.
Config.WeaponColor = 1 -- to be optimized....

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
Config.ShowLockerRentBlip = true
Config.LockerRentBlipID = 357
Config.LockerRentBlipSize = 1.0
Config.LockerRentBlipColor = 3

Config.Weight = 80 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg).
Config.DefaultWeight = 1 -- Default weight for an item.
Config.MaxBagWeight = 20
Config.MaxBagItemCount = 50 
Config.MaxDifferentBagItems = 5

Config.localWeight = { -- Fill this with all your items. This is only for trunk and glovebox! Change your pocket inventory weights in your database! (items table)
	bread = 1,
	water = 1,
	WEAPON_SMG = 5,
	WEAPON_PISTOL = 5,
	WEAPON_APPISTOL = 5,
	WEAPON_PUMPSHOTGUN = 5,
	WEAPON_SNOWBALL = 1
}

Config.GloveboxSize = { -- Related to Config.localWeight.
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

Config.TrunkSize = { -- Related to Config.localWeight.
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
	taxi = 'TAXI',
	cop = 'police',
	police = 'police',
	ambulance = 'ambulance',
	mecano = 'mechano',
	mechanic = 'mechanic',
	police = 'police',
	nightclub = 'club',
	bahamas = 'bahamas',
	cardealer = 'dealer'
}

Config.Shops = {
	RegularShop = {
		Locations = {
			{x = 270.45,   y = -980.84,  z = 28.36}
			--{x = 374.875,   y = 327.896,  z = 102.566}
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
			{name = 'bread', price = 6},
			{name = 'water', price = 6},
			{name = 'lemon', price = 6},
			{name = 'phone', price = 550},
			{name = 'hamburger', price = 7},
			{name = 'icedcoffee', price = 7},
			{name = 'juice', price = 7},
			{name = 'coffeecup', price = 7},
			{name = 'cucumbers', price = 6},
			{name = 'garlic', price = 6},
			{name = 'energy', price = 8},
			{name = 'lemonade', price = 7},
			{name = 'banana', price = 6},
			{name = 'dildo', price = 35},
			{name = 'icetea', price = 7},
			{name = 'stressbal', price = 7},
			{name = 'neckbrace', price = 130},
			{name = 'armbrace', price = 130},
			{name = 'legbrace', price = 130},
			{name = 'bodybandage', price = 130},
			{name = 'bandage', price = 65},
			{name = 'hoestdrank', price = 15},
			{name = 'antibiotico', price = 19},
			{ name = 'antibioticorosacea', price = 28}
		}
	},

	GroothandelSupermarkt = {
		Locations = {
			{ x = 50.57, y = -1754.93, z = 28.61 }
		},
		Items = {
			{ name = 'bread', price = 1},
			{ name = 'water', price = 1},
			{ name = 'medikit', price = 1000},
			{ name = 'bandage', price = 25},
			{ name = 'cough_med', price = 2},
			{ name = 'hoestdrank', price = 2},
			{ name = 'antibiotico', price = 5},
			{ name = 'antibioticorosacea', price = 10},
			{ name = "bodybandage",       price = 50},
			{ name = "neckbrace",       price = 50},
			{ name = "armbrace",       price = 50},
			{ name = "legbrace",       price = 50},
			{ name = "croquettes",       price = 3},
			{ name = "martini",       price = 3},
			{ name = "tequila",       price = 3},
			{ name = "whisky",       price = 3},
			{ name = "rhum",       price = 3},
			{ name = "vodka",       price = 3},
			{ name = "tyton",       price = 3},
			{ name = "jagercerbere",       price = 4},
			{ name = "mixapero",       price = 4},
			{ name = "mojito",       price = 4},
			{ name = "rhumcoca",       price = 4},
			{ name = "rhumfruit",       price = 4},
			{ name = "vodkafruit",       price = 4},
			{ name = "vodkaenergy",       price = 4},
			{ name = "whiskycoca",       price = 4},
			{ name = "jagerbomb",       price = 4},
			{ name = "hamburger",       price = 5},
			{ name = "bolchips",       price = 1},
			{ name = "bolpistache",       price = 1},
			{ name = "bolnoixcajou",       price = 1},
			{ name = "bolcacahuetes",       price = 1},
			{ name = "limonade",       price = 2},
			{ name = "drpepper",       price =3},
			{ name = "energy",       price = 3},
			{ name = "icetea",       price = 3},
			{ name = "jusfruit",       price = 3},
			{ name = "wine",       price = 4},
			{ name = "smoothie",       price = 3},
			{ name = "margarita",       price = 3},
			{ name = "frappe",       price = 4},
			{ name = "latte",       price = 4},
			{ name = "cocktail",       price = 4},
			{ name = "champagne",       price =4},
			{ name = "cappuchino",       price = 4},
			{ name = "milkshake",       price = 4},
			{ name = "milkshake2",       price = 4},
			{ name = "milkshake3",       price = 4},
			{ name = "beercan",       price = 4},
			{ name = "chocolatemilk",       price = 4},
			{ name = "coffeecup",       price = 4},
			{ name = "coconutdrink",       price = 4},
			{ name = "icedcoffee",       price = 4},
			{ name = "icedcoffee2",       price = 4},
			{ name = "fixkit",       price = 1000},
			{ name = "dierenvoeding",       price = 5},
			{ name = "fishbait",       price = 15},
			{ name = "fishingrod",       price = 55},
			{ name = "turtlebait",       price = 35},
			{ name = "lokalizator",       price = 420},
			{ name = "hifi",       price = 25},
			{ name = "raspberry",       price = 50},
			{ name = "phone",       price = 500},
			{ name = "sim",       price = 5},
			{ name = "dildo",       price = 13},
			{ name = "dildo2",       price = 15},
			{ name = "saucisson",       price = 5},
			{ name = "soda",       price = 4},
			{ name = "apple",       price = 4},
			{ name = "aubergine",       price = 5},
			{ name = "avocado",       price = 6},
			{ name = "banana",       price = 4},
			{ name = "beetroot",       price = 5},
			{ name = "broccoli",       price = 5},
			{ name = "carrot",       price = 5},
			{ name = "cherries",       price = 6},
			{ name = "coconut",       price = 8},
			{ name = "corn",       price = 4},
			{ name = "cucumbers",       price = 5},
			{ name = "garlic",       price = 6},
			{ name = "kiwi",       price = 5},
			{ name = "lemon",       price = 5},
			{ name = "mango",       price = 9},
			{ name = "orange",       price = 6},
			{ name = "paprika",       price = 5},
			{ name = "pear",       price = 4},
			{ name = "pineapple",       price = 6},
			{ name = "pumpkin",       price = 5},
			{ name = "radish",       price = 5},
			{ name = "strawberry",       price = 7},
			{ name = "tomato",       price = 5},
			{ name = "tea",       price = 5},
			{ name = "watermelon",       price = 8},
			{ name = "milkbottle",       price = 6},
			{ name = "milkbox",       price = 6},
			{ name = "billet",       price = 55},
			{ name = "cheese",       price = 25},
			{ name = "stroopwafel",       price = 5},
			{ name = "vuurwerk",       price = 25},
			{ name = "vuurwerk2",       price = 25},
			{ name = "vuurwerk3",       price = 25},
			{ name = "vuurwerk4",       price = 25},
			{ name = "duikvrouw0",       price = 185},
			{ name = "duikvrouw1",       price = 185},
			{ name = "duikvrouw12",       price = 185},
			{ name = "duikvrouw13",       price = 185},
			{ name = "duikvrouw14",       price = 185},
			{ name = "duikvrouw15",       price = 185},
			{ name = "duikvrouw16",       price = 185},
			{ name = "duikvrouw17",       price = 185},
			{ name = "duikvrouw18",       price = 185},
			{ name = "duikvrouw19",       price = 185},
			{ name = "duikvrouw2",       price = 185},
			{ name = "duikvrouw3",       price = 185},
			{ name = "duikvrouw4",       price = 185},
			{ name = "duikvrouw5",       price = 185},
			{ name = "duikvrouw6",       price = 185},
			{ name = "duikvrouw7",       price = 185},
			{ name = "duikvrouw8",       price = 185},
			{ name = "duikvrouw9",       price = 185},
			{ name = "duikvrouw10",       price = 185},
			{ name = "duikvrouw20",       price = 185},
			{ name = "duikvrouw21",       price = 185},
			{ name = "duikvrouw22",       price = 185},
			{ name = "duikvrouw23",       price = 185},
			{ name = "duikvrouw24",       price = 185},
			{ name = "duikvrouw25",       price = 185},
			{ name = "duikvrouw26",       price = 185},
			{ name = "general_spray_paint",       price = 200},
			{ name = "bironlack_spray_paint",       price = 200},
			{ name = "sponge",       price = 5},
		}
	},

	IlegalShop = {
		Locations = {
			--{ x = 468.58, y = -3205.64, z = 9.79 }
		},
		Items = {
			{ name = 'bread', price = 1},
			{ name = 'water', price = 1}
		}
	},

	DrugShop = {
		Locations = {
			{ x = 377.0, y = -828.49, z = 28.3 }
		},
		Items = {
			{ name = 'joint', price = 10},
			{ name = 'blunt', price = 15}
		}
	},

	RobsLiquor = {
		Locations = {
		 	--{ x = 1135.808, y = -982.281, z = 45.415 }
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
		 	-- { x = -1103.05, y = -823.72, z = 14.48 }
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
			--{ x = 22.09, y = -1107.28, z = 28.80 }
		},
		Items = {
			{name = 'ammunition_pistol', price = 1},
			{name = 'ammunition_pistol_large', price = 1},
			{name = 'ammunition_shotgun', price = 1},
			{name = 'ammunition_shotgun_large', price = 1},
			{name = 'ammunition_smg', price = 1},
			{name = 'ammunition_smg_large', price = 1},
			{name = 'ammunition_rifle', price = 1},
			{name = 'ammunition_rifle_large', price = 1},
			{name = 'ammunition_snp', price = 1},
			{name = 'ammunition_snp_large', price = 1},
			{name = 'flashlight',price = 1},
			--{name = 'grip',price = 1},
			--{name = 'scope',price = 1},
			--{name = 'skin',price = 1},
			--{name = 'suppressor',price = 1}
		}
	},

	PoliceShop = { -- available for Config.InventoryJob.Police
		Locations = {
			{ x = 484.14 , y = -1004.69, z = 24.73 }
		},
		Items = {
			{name = 'WEAPON_FLASHLIGHT', price = 100},
			{name = 'WEAPON_STUNGUN', price = 100},
			{name = 'WEAPON_NIGHTSTICK', price = 100},
			{name = 'WEAPON_PISTOL', price = 100},
			{name = 'WEAPON_FIREEXTINGUISHER',price = 100},
			{name = 'ammunition_pistol',price = 100},
			{name = 'ammunition_pistol_large',price = 100},
			{name = 'ammunition_shotgun',price = 100},
			{name = 'ammunition_shotgun_large',price = 100},
			{name = 'ammunition_smg',price = 100},
			{name = 'ammunition_smg_large',price = 100},
			{name = 'ammunition_rifle',price = 100},
			{name = 'ammunition_rifle_large',price = 100},
			{name = 'ammunition_snp',price = 100},
			{name = 'ammunition_snp_large',price = 100},
			{name = 'ammunition_fireextinguisher',price = 100},
			{name = 'bulletproof',price = 1000},
			{name = 'binoculars',price = 50},
			{name = 'flashlight',price = 100}
		}
	},

	BlackMarket = { -- available for Config.InventoryJob.Mafia
		Locations = {
			-- { x = -1297.96, y = -392.60, z = 35.47 }
		},
		Items = {
			{name = 'WEAPON_PISTOL', price = 10000},
			{name = 'ammunition_pistol',price = 1000},
			{name = 'ammunition_pistol_large',price = 1000}
		}
	},

	LicenseShop = {
		Locations = {
	    	{x = 12.47, y = -1105.5, z = 29.8}
		}
	},

	ShopNightclub = { -- available for Config.InventoryJob.Nightclub
		Locations = {
	    	{ x = 22.09, y = -1107.28, z = 28.80 }
		},
		Items = {
			{name = 'WEAPON_FLASHLIGHT', price = 100},
			{name = 'WEAPON_KNIFE', price = 100},
			{name = 'WEAPON_BAT', price = 100},
			{name = 'WEAPON_PISTOL', price = 100},
			{name = 'WEAPON_PUMPSHOTGUN',price = 100},
			{name = 'WEAPON_SMOKEGRENADE',price = 100},
			{name = 'WEAPON_FIREEXTINGUISHER',price = 100},
			{name = 'WEAPON_CROWBAR',price = 100},
			{name = 'WEAPON_BZGAS',price = 100},
			{name = 'ammunition_pistol',price = 100},
			{name = 'ammunition_pistol_large',price = 100},
			{name = 'ammunition_shotgun',price = 100},
			{name = 'ammunition_shotgun_large',price = 100},
			{name = 'ammunition_smg',price = 100},
			{name = 'ammunition_smg_large',price = 100},
			{name = 'ammunition_rifle',price = 100},
			{name = 'ammunition_rifle_large',price = 100},
			{name = 'ammunition_snp',price = 100},
			{name = 'ammunition_snp_large',price = 100},
			{name = 'ammunition_fireextinguisher',price = 100},
			{name = 'bulletproof',price = 1000},
			{name = 'binoculars',price = 50},
			{name = 'flashlight',price = 100}
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
	cash = {['model'] = 'prop_cash_pile_02', ['bone'] = 28422, ['x'] = 0.02, ['y'] = 0.02, ['z'] = -0.08, ['xR'] = 270.0, ['yR'] = 180.0, ['zR'] = 0.0}
}

Config.EnableInventoryHUD = true

Config.Ammo = {
	{
		name = 'ammunition_pistol',
		weapons = {
			'WEAPON_PISTOL',
			'WEAPON_APPISTOL',
			'WEAPON_SNSPISTOL',
			'WEAPON_COMBATPISTOL',
			'WEAPON_HEAVYPISTOL',
			'WEAPON_MACHINEPISTOL',
			'WEAPON_MARKSMANPISTOL',
			'WEAPON_PISTOL50',
			'WEAPON_VINTAGEPISTOL'
		},
		count = 30
	},
	{
		name = 'ammunition_pistol_large',
		weapons = {
			'WEAPON_PISTOL',
			'WEAPON_APPISTOL',
			'WEAPON_SNSPISTOL',
			'WEAPON_COMBATPISTOL',
			'WEAPON_HEAVYPISTOL',
			'WEAPON_MACHINEPISTOL',
			'WEAPON_MARKSMANPISTOL',
			'WEAPON_PISTOL50',
			'WEAPON_VINTAGEPISTOL'
		},
		count = 60
	},
	{
		name = 'ammunition_shotgun',
		weapons = {
			'WEAPON_ASSAULTSHOTGUN',
			'WEAPON_AUTOSHOTGUN',
			'WEAPON_BULLPUPSHOTGUN',
			'WEAPON_DBSHOTGUN',
			'WEAPON_HEAVYSHOTGUN',
			'WEAPON_PUMPSHOTGUN',
			'WEAPON_SAWNOFFSHOTGUN'
		},
		count = 12
	},
	{
		name = 'ammunition_shotgun_large',
		weapons = {
			'WEAPON_ASSAULTSHOTGUN',
			'WEAPON_AUTOSHOTGUN',
			'WEAPON_BULLPUPSHOTGUN',
			'WEAPON_DBSHOTGUN',
			'WEAPON_HEAVYSHOTGUN',
			'WEAPON_PUMPSHOTGUN',
			'WEAPON_SAWNOFFSHOTGUN'
		},
		count = 18
	},
	{
		name = 'ammunition_smg',
		weapons = {
			'WEAPON_ASSAULTSMG',
			'WEAPON_MICROSMG',
			'WEAPON_MINISMG',
			'WEAPON_SMG'
		},
		count = 45
	},
	{
		name = 'ammunition_smg_large',
		weapons = {
			'WEAPON_ASSAULTSMG',
			'WEAPON_MICROSMG',
			'WEAPON_MINISMG',
			'WEAPON_SMG'
		},
		count = 65
	},
	{
		name = 'ammunition_rifle',
		weapons = {
			'WEAPON_ADVANCEDRIFLE',
			'WEAPON_ASSAULTRIFLE',
			'WEAPON_BULLPUPRIFLE',
			'WEAPON_CARBINERIFLE',
			'WEAPON_SPECIALCARBINE',
			'WEAPON_COMPACTRIFLE'
		},
		count = 45
	},
	{
		name = 'ammunition_rifle_large',
		weapons = {
			'WEAPON_ADVANCEDRIFLE',
			'WEAPON_ASSAULTRIFLE',
			'WEAPON_BULLPUPRIFLE',
			'WEAPON_CARBINERIFLE',
			'WEAPON_SPECIALCARBINE',
			'WEAPON_COMPACTRIFLE'
		},
		count = 65
	},
	{
		name = 'ammunition_snp',
		weapons = {
			'WEAPON_SNIPERRIFLE',
			'WEAPON_HEAVYSNIPER',
			'WEAPON_MARKSMANRIFLE'
		},
		count = 10
	},
	{
		name = 'ammunition_snp_large',
		weapons = {
			'WEAPON_SNIPERRIFLE',
			'WEAPON_HEAVYSNIPER',
			'WEAPON_MARKSMANRIFLE'
		},
		count = 15
	},
	{
		name = 'ammunition_fireextinguisher',
		weapons = {
			'WEAPON_FIREEXTINGUISHER'
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