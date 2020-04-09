

Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in glovebox.
Config.AllowPolice = true -- If true, police will be able to search players' glovebox.

Config.Locale = "nl"

Config.OpenKey = 170

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Weight = 1000

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

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "police",
    ambulance = "ambulance",
    mecano = "mechano"
}
