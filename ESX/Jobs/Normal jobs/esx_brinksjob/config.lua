Config              = {}
Config.DrawDistance = 100.0
Config.MaxDelivery	= 15
Config.TruckPrice	= 1000
Config.Locale       = 'nl'
Config.BagPay       = 45

Config.Trucks = {
	"stockade"
	--"scrap"
}

Config.Cloakroom = {
	CloakRoom = {
			Pos   = {x = 4.38, y = -659.40, z = 33.45},
			Size  = {x = 0.5, y = 0.5, z = 0.5},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1
		},
}

Config.Zones = {
	VehicleSpawner = {
			Pos   = {x = -5.16, y = -662.46, z = 33.48},
			Size  = {x = 0.5, y = 0.5, z = 0.5},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1
		},

	VehicleSpawnPoint = {
			Pos   = {x = -4.92, y = -668.67, z = 32.34},
			Size  = {x = 0.5, y = 0.5, z = 0.5},
			Color = {r = 204, g = 204, b = 0},
			Type  = -1
		},
}
Config.DumpstersAvaialbe = {
    "hei_prop_gold_trolly_empty"
}

Config.Karretjes = {
	vector3(145.8151, -1045.348, 28.84),
	vector3(310.0866, -283.79, 53.64),
	vector3(258.6059, 227.7934, 101.15),
	vector3(928.8882, 41.19627, 80.55),
	vector3(1177.141, 2712.652, 37.56),
	vector3(1689.435, 3757.685, 34.15),
	vector3(-106.1013, 6478.188, 31.1),
	vector3(-60.16819, 6524.831, 30.94),
	vector3(-68.50596, 6255.74, 30.54),
	vector3(-2956.842, 480.5, 15.15),
	vector3(-3024.907, 82.20398, 11.07),
	vector3(-1539.486, -576.0658, 25.16),
	vector3(-2287.094, 366.1983, 174.1017),
	vector3(-1215.582, 342.678, 70.59),
	vector3(-1370.508, 62.52071, 53.16),
	vector3(255.2422, -46.45, 69.39),
	vector3(1164.424, -314.72, 68.66),
	vector3(1144.753, -451.52, 66.43),
	vector3(868.5784, -1627.2, 29.69),
	vector3(-523.3246, -2894.862, 5.750384),
	vector3(-933.6499, -3070.282, 13.38),
	vector3(-398.3184, -1884.842, 21.01),
	vector3(-40.77108, -1752.63, 28.87),
	vector3(-10.16431, -657.0882, 32.91),
	vector3(-572.6447, -615.28, 29.9),
	vector3(-1711.016, -1110.89, 12.62),
	vector3(-1623.624, -502.2869, 35.87),
	vector3(-1153.834, -525.2897, 31.66215),
	vector3(-1055.178, -231.2552, 43.521),
	vector3(230.2951, -406.8289, 47.35),
	vector3(-630.916, -228.6611, 37.49),
	vector3(12.4, -1105.607, 29.26),
	vector3(-3175.135, 1084.427, 20.29),
	vector3(-1891.079, 2051.21, 140.45),
	vector3(-1212.212, -337.0112, 37.25),
	vector3(605.9669, 2745.641, 41.46),
	vector3(-1143.161, -2694.128, 13.4),
	vector3(1387.874, 3607.51, 34.45),
	vector3(-355.1849, -54.58998, 48.49)
}

Config.Livraison = {
-------------------------------------------Los Santos
	-- Flecca Downtown
	Delivery1LS = {
			Pos   = {x = 156.45, y = -1042.85, z = 29.32},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 400
		},
	-- Blain County Savings
	Delivery2LS = {
			Pos   = {x = -116.59, y = 6457.05, z = 31.45},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 1000
		},
	-- GunShop Sandy
	Delivery3LS = {
			Pos   = {x = 1685.1549, y = 3752.0849, z = 33.0},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 325
		},
	-- Casino
	Delivery4LS = {
			Pos   = {x = 923.47, y = 47.38, z = 80.76},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 1050
		},
	-- Highway Flecca Bank
	Delivery5LS = {
			Pos   = {x = -2959.11, y = 467.45, z = 15.21},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 300
		},
	--Flecca R68
	Delivery6LS = {
			Pos   = {x = 1175.85, y = 2697.30, z = 37.98},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 100
		},
	--Bay City Ave Maze Bank
	Delivery7LS = {
			Pos   = {x = -1552.11, y = -578.83, z = 25.71},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 200
		},
	--Bay City Hotel Del Perro
	Delivery8LS = {
			Pos   = {x = -1899.67, y = 2030.75, z = 140.74},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 200
		},
	--New empire way (airport)
	Delivery9LS = {
			Pos   = {x = -1136.90, y = -2690.85, z = 13.95},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 200
		},
	--standard Bank
	Delivery10LS = {
			Pos   = {x = 220.98, y = 217.34, z = 105.40},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 300
		},
------------------------------------------- Blaine County
	-- Harwick Ave Bank
	Delivery1BC = {
			Pos   = {x = -345.35, y = -30.09, z = 47.39},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 1750
		},
	-- Staduim Davis Ave
	Delivery2BC = {
			Pos   = {x = -390.14, y = -1880.17, z = 20.53},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 150
		},
	-- Alqonquin blvd liq store
	Delivery3BC = {
			Pos   = {x = 1400.52, y = 3593.65, z = 34.86},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 350
		},
	-- Bay City Hotel
	Delivery4BC = {
			Pos   = {x = -1898.09, y = 2047.94, z = 140.78},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 255
		},
	-- Mirror Park Complex
	Delivery5BC = {
			Pos   = {x = 1145.76, y = -466.52, z = 66.58},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 250
		},
	-- Route 68 Complex
	Delivery6BC = {
			Pos   = {x = 570.01, y = 2728.37, z = 42.06},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 150
		},
	-- Great Ocean Complex
	Delivery7BC = {
			Pos   = {x = -3159.17, y = 1079.44, z = 20.69},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 200
		},
	-- Movie Complex
	Delivery8BC = {
			Pos   = {x = -1148.65, y = -525.86, z = 32.34},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 1200
		},
	-- Standard Bank
	Delivery9BC = {
			Pos   = {x = 229.57, y = 199.02, z = 104.89},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 250
		},
	-- Rockford gas station
	Delivery10BC = {
			Pos   = {x = -1187.04, y = -332.09, z = 37.11},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 150
		},
		
	RetourCamion = {
			Pos   = {x = 61.81, y = -614.86, z = 30.67},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 0
		},
	
	AnnulerMission = {
			Pos   = {x = -0.89, y = -702.60, z = 31.34},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 0
		},
}
