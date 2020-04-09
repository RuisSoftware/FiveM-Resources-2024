
Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.

Config.Locale = "nl"

Config.OpenKey = 170

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Weight = 25000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 10

Config.localWeight = {
    bread = 125,
    water = 330,
    WEAPON_SMG = 5000
}

Config.VehicleWeight = {
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
    cop = "LSPD",
    ambulance = "EMS0",
    mecano = "MECA"
}
