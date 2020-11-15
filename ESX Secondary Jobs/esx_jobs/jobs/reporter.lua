Config.Jobs.reporter = {
  BlipInfos = {
    Sprite = 184,
    Color = 1
  },
  Vehicles = {
    Truck = {
      Spawner = 1,
      Hash = "rumpo",
      Trailer = "none",
      HasCaution = true
    }
  },
  Zones = {
    VehicleSpawner = {
      Pos   = { x = -1096.311, y = -252.916, z = 36.670 },
      Size  = {x = 1.5, y = 1.5, z = 0.5 },
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('reporter_name'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('reporter_garage'),
      Caution = 100
    },

    VehicleSpawnPoint = {
      Pos   = { x = -1100.610, y =-263.117, z = 36.670 },
      Size  = {x = 3.0, y = 3.0, z = 1.0 },
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 200.1
    },

    VehicleDeletePoint = {
      Pos   = { x = -1098.209,  y = -257.944, z = 36.400 },
      Size  = {x = 3.0, y = 3.0, z = 0.6 },
      Color = {r = 255, g = 0, b = 0},
      Marker= 1,
      Blip  = false,
      Name  = _U('return_vh'),
      Type  = "vehdelete",
      Hint  = _U('return_vh_button'),
      Spawner = 1,
      Caution = 100,
      GPS = 0,
      Teleport = { x = -1094.085, y = -261.900, z = 36.670 }
    }
  }
}
