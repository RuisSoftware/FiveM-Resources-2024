Config.Jobs.lumberjack = {
  BlipInfos = {
    Sprite = 237,
    Color = 4
  },
  Vehicles = {
    Truck = {
      Spawner = 1,
      Hash = "phantom",
      Trailer = "trailers",
      HasCaution = true
    }
  },
  Zones = {
    CloakRoom = {
      Pos   = {x = 1213.87, y = -1249.42, z = 36.33},--
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('lj_locker_room'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
    },

    Wood = {
      Pos   = {x = -541.63, y = 5380.57, z = 69.5},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('lj_mapblip'),
      Type  = "work",
      Item  = {
        {
          name   = _U('lj_wood'),
          db_name= "wood",
          time   = 5,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "nothing",
          requires_name = "Nothing",
          drop   = 100
        }
      },
      Hint  = _U('lj_pickup')
    },

    CuttedWood = {
      Pos   = {x = -555.81, y = 5319.26, z = 72.6},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('lj_cutwood'),
      Type  = "work",
      Item  = {
        {
          name   = _U('lj_cutwood'),
          db_name= "cutted_wood",
          time   = 3,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "wood",
          requires_name = _U('lj_wood'),
          drop   = 100
        }
      },
      Hint  = _U('lj_cutwood_button')
    },

    Planks = {
      Pos   = {x = -507.3, y = 5263.43, z = 80.62},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('lj_board'),
      Type  = "work",
      Item  = {
        {
          name   = _U('lj_planks'),
          db_name= "packaged_plank",
          time   = 3,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "cutted_wood",
          requires_name = _U('lj_cutwood'),
          drop   = 100
        }
      },
      Hint  = _U('lj_pick_boards')
    },

    VehicleSpawner = {
      Pos   = {x = 1213.97, y = -1262.41, z = 35.23},--
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = false,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_veh_button'),
      Caution = 100
    },

    VehicleSpawnPoint = {
      Pos   = {x = 1194.6257324219, y = -1286.955078125, z = 34.121524810791},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 285.1
    },

    VehicleDeletePoint = {
      Pos   = {x = 1202.86, y = -1231.87, z = 35.23},--
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 255, g = 0, b = 0},
      Marker= 1,
      Blip  = false,
      Name  = _U('return_vh'),
      Type  = "vehdelete",
      Hint  = _U('return_vh_button'),
      Spawner = 1,
      Caution = 100,
      GPS = 0,
      Teleport = 0
    },

    Delivery = {
      Pos   = {x = 1198.97, y = -1353.38, z = 35.23},
      Color = {r = 204, g = 204, b = 0},
      Size  = {x = 5.0, y = 5.0, z = 3.0},
      Marker= 1,
      Blip  = true,
      Name  = _U('delivery_point'),
      Type  = "delivery",
      Spawner = 1,
      Item  = {
        {
          name   = _U('delivery'),
          time   = 3,
          remove = 1,
          max    = 20, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
          price  = 50,
          requires = "packaged_plank",
          requires_name = _U('lj_planks'),
          drop   = 100
        }
      },
      Hint  = _U('lj_deliver_button')
    }
  }
}
