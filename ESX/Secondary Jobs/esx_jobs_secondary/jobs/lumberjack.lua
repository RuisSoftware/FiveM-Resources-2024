Config.Jobs2.lumberjack = {
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
      Pos   = {x = 1218.33, y = -1267.08, z = 35.42},--
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('lj_locker_room'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
    },

    Wood = {
      Pos   = {x = -579.32, y = 5373.57, z = 69.5},
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
      Pos   = {x = -560.87, y = 5315.73, z = 72.6},
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
      Pos   = {x = -516.99, y = 5256.77, z = 79.65},
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
      Pos   = {x = 1220.4, y = -1269.76, z = 34.36},--
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
      Pos   = {x = 1222.2, y = -1289.41, z = 34.21},
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
      Pos   = {x = 1192.39, y = -1341.0, z = 34.13},
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
          max    = 20, -- if not present, probably an error at itemQtty >= item.max in DP_Banen_Algemeen_sv.lua
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
