Config = {}


Config.PriceRental            = 500      -- How much rental of a Motel Room apartment is - 0 = Free.
Config.Locale                 = 'nl'    -- Currently only English and Dutch supported.
Config.SwitchCharacterSup     = false    -- Optional Please ensure you have added xXFriendlysXx Switch Character fix aswell.

Config.RoomMarker = {
    Owned = {r = 255, g = 0, b = 0},     -- Owned Motel Color
	x = 0.5, y = 0.5, z = 0.7  -- Standard Size Circle
}

Config.Zones = {

    Paleto = {
        Name = "Motel",
        Pos = {x = -93.59, y = 6341.61, z = 31.49, color = 23, sprite = 475, size = 1.0},
        roomExit = {x = 151.25, y = -1007.74, z = -99.00}, -- The Exit marker of the room, usually the only door hehe
        roomLoc = {x = 151.25, y = -1007.74, z = -99.00}, -- Where you will spawn IN the motel room
        BedStash = {x = 154.47, y = -1005.92, z = -99.0},  -- The Secret Stash Location of the Bed
        Inventory = {x = 151.83, y = -1001.32, z = -99.00},  -- The Inventory of the Room Main Storage
        Menu = {x = 151.32, y = -1003.05, z = -99.0}, -- Room Options Menu
        Boundries = 26.0, -- The Boundry Radius of the Motel (Will check ownerships etc.. if player is within this radius)
        Rooms = {
            Room1 = {
                number = 1,
                instancename = "boven1",
                entry = {x = -103.12, y = 6331.01, z = 31.58},
			},
            Room2 = {
                number = 2,
                instancename = "boven2",
                entry = {x = -106.52, y = 6334.06, z = 31.58},
			},
			Room3 = {
                number = 3,
                instancename = "boven3",
                entry = {x = -107.60, y = 6339.79, z = 31.58},
			},
			Room4 = {
                number = 4,
                instancename = "boven4",
                entry = {x = -102.11, y = 6345.33, z = 31.58},
			},
			Room5 = {
                number = 5,
                instancename = "boven5",
                entry = {x = -98.84, y = 63348.62, z = 31.58},
			},
			Room6 = {
                number = 6,
                instancename = "boven6",
                entry = {x = -93.57, y = 6353.87, z = 31.58},
			},
			Room7 = {
                number = 7,
                instancename = "boven7",
                entry = {x = -90.18, y = 6357.25, z = 31.58},
			},
			Room8 = {
                number = 8,
                instancename = "boven8",
                entry = {x = -84.71, y = 6362.75, z = 31.58},
			},
			Room9 = {
                number = 9,
                instancename = "boven9",
                entry = {x = -84.95, y = 6362.48, z = 35.50},
			},
			Room10 = {
                number = 10,
                instancename = "boven10",
                entry = {x = -90.27, y = 6357.12, z = 35.50},
			},
			Room11 = {
                number = 11,
                instancename = "boven11",
                entry = {x = -93.57, y = 6353.89, z = 35.50},
			},
			Room12 = {
                number = 12,
                instancename = "boven12",
                entry = {x = -98.82, y = 6348.52, z = 35.50},
			},
			Room13 = {
                number = 13,
                instancename = "boven13",
                entry = {x = -102.26, y = 6345.13, z = 35.50},
			},
			Room14 = {
                number = 14,
                instancename = "boven14",
                entry = {x = -107.59, y = 63339.74, z = 35.50},
			},
			Room15 = {
                number = 15,
                instancename = "boven15",
                entry = {x = -106.52, y = 6334.06, z = 35.50},
			},
			Room16 = {
                number = 16,
                instancename = "boven16",
                entry = {x = -103.37, y = 6330.73, z = 35.50},
			},
		}
	},
	--[[
    PinkCage = {
        Name = "Motel",
        Pos = {x = 324.55, y = -212.44, z = 54.15, color = 23, sprite = 475, size = 1.0},
        roomExit = {x = 151.25, y = -1007.74, z = -99.00}, -- The Exit marker of the room, usually the only door hehe
        roomLoc = {x = 151.25, y = -1007.74, z = -99.00}, -- Where you will spawn IN the motel room
        BedStash = {x = 154.47, y = -1005.92, z = -99.0},  -- The Secret Stash Location of the Bed
        Inventory = {x = 151.83, y = -1001.32, z = -99.00},  -- The Inventory of the Room Main Storage
        Menu = {x = 151.32, y = -1003.05, z = -99.0}, -- Room Options Menu
        Boundries = 26.0, -- The Boundry Radius of the Motel (Will check ownerships etc.. if player is within this radius)
        Rooms = {
            Room1 = {
                number = 1,
                instancename = "PinkCage1",
                entry = {x = 312.83, y = -218.79, z = 54.22},
                    },

            Room2 = {
                number = 2,
                instancename = "PinkCage2",
                entry = {x = 310.9, y = -217.97, z = 54.22},
                    },

             Room3 = {
                number = 3,
                instancename = "PinkCage3",
                entry = {x = 307.24, y = -216.69, z = 54.22},
                    },

             Room4 = {
                number = 4,
                instancename = "PinkCage4",
                entry = {x = 307.58, y = -213.3, z = 54.22},
                     },

             Room5 = {
                number = 5,
                instancename = "PinkCage5",
                entry = {x = 309.51, y = -207.92, z = 54.22},
                    },

             Room5a = {
                number = "5a",
                instancename = "PinkCage5a",
                entry = {x = 311.27, y = -203.33, z = 54.22},
                    },

             Room6 = {
                number = 6,
                instancename = "PinkCage6",
                entry = {x = 313.36, y = -198.07, z = 54.22},
                    },

             Room7 = {
                number = 7,
                instancename = "PinkCage7",
                entry = {x = 315.77, y = -194.82, z = 54.22},
                    },

             Room8 = {
                number = 8,
                instancename = "PinkCage8",
                entry = {x = 319.4, y = -196.21, z = 54.22},
                    },

             Room9 = {
                number = 9,
                instancename = "PinkCage9",
                entry = {x = 321.44, y = -196.99, z = 54.22},
                    },

             Room11 = {
                number = 11,
                instancename = "PinkCage11",
                entry = {x = 312.83, y = -218.79, z = 58.02},
                    },

            Room12 = {
                number = 12,
                instancename = "PinkCage12",
                entry = {x = 310.9, y = -217.97, z = 58.02},
                    },

             Room13 = {
                number = 13,
                instancename = "PinkCage13",
                entry = {x = 307.24, y = -216.69, z = 58.02},
                    },

             Room14 = {
                number = 14,
                instancename = "PinkCage14",
                entry = {x = 307.58, y = -213.3, z = 58.02},
                    },

             Room15 = {
                number = 15,
                instancename = "PinkCage15",
                entry = {x = 309.51, y = -207.92, z = 58.02},
                    },

             Room16 = {
                number = 16,
                instancename = "PinkCage16",
                entry = {x = 311.27, y = -203.33, z = 58.02},
                    },

             Room17 = {
                number = 17,
                instancename = "PinkCage17",
                entry = {x = 313.36, y = -198.07, z = 58.02},
                    },

             Room18 = {
                number = 18,
                instancename = "PinkCage18",
                entry = {x = 315.77, y = -194.82, z = 58.02},
                    },

             Room19 = {
                number = 19,
                instancename = "PinkCage19",
                entry = {x = 319.4, y = -196.21, z = 58.02},
                    },

             Room20 = {
                number = 20,
                instancename = "PinkCage20",
                entry = {x = 321.44, y = -196.99, z = 58.02},
             },

             -- Left Side

             Room21 = {
                number = 21,
                instancename = "PinkCage21",
                entry = {x = 329.43, y = -225.02, z = 54.22},
             },
             Room22 = {
                number = 22,
                instancename = "PinkCage22",
                entry = {x = 331.44, y = -225.97, z = 54.22},
             },
             Room23 = {
                number = 23,
                instancename = "PinkCage23",
                entry = {x = 334.97, y = -227.36, z = 54.22},
             },
             Room24 = {
                number = 24,
                instancename = "PinkCage24",
                entry = {x = 337.09, y = -224.81, z = 54.22},
             },
             Room25 = {
                number = 25,
                instancename = "PinkCage25",
                entry = {x = 339.21, y = -219.45, z = 54.22},
             },
             Room26 = {
                number = 26,
                instancename = "PinkCage26",
                entry = {x = 340.8, y = -214.89, z = 54.22},
             },
             Room27 = {
                number = 27,
                instancename = "PinkCage27",
                entry = {x = 342.88, y = -209.6, z = 54.22},
             },
             Room28 = {
                number = 28,
                instancename = "PinkCage28",
                entry = {x = 344.59, y = -205.01, z = 54.22},
             },
             Room29 = {
                number = 29,
                instancename = "PinkCage29",
                entry = {x = 346.81, y = -199.73, z = 54.22},
             },

             --

             Room30 = {
                number = 30,
                instancename = "PinkCage30",
                entry = {x = 329.43, y = -225.02, z = 58.02},
             },
             Room31 = {
                number = 31,
                instancename = "PinkCage31",
                entry = {x = 331.44, y = -225.97, z = 58.02},
             },
             Room32 = {
                number = 32,
                instancename = "PinkCage32",
                entry = {x = 334.97, y = -227.36, z = 58.02},
             },
             Room33 = {
                number = 33,
                instancename = "PinkCage33",
                entry = {x = 337.09, y = -224.81, z = 58.02},
             },
             Room34 = {
                number = 34,
                instancename = "PinkCage34",
                entry = {x = 339.21, y = -219.45, z = 58.02},
             },
             Room35 = {
                number = 35,
                instancename = "PinkCage35",
                entry = {x = 340.8, y = -214.89, z = 58.02},
             },
             Room36 = {
                number = 36,
                instancename = "PinkCage36",
                entry = {x = 342.88, y = -209.6, z = 58.02},
             },
             Room37 = {
                number = 37,
                instancename = "PinkCage37",
                entry = {x = 344.59, y = -205.01, z = 58.02},
             },
             Room38 = {
                number = 38,
                instancename = "PinkCage38",
                entry = {x = 346.81, y = -199.73, z = 58.02},
             },

		}
	}]]



}