Config.Jobs2.slaughterer = {
  BlipInfos = {
    Sprite = 256,
    Color = 5
  },
  Vehicles = {
    Truck = {
      Spawner = 1,
      Hash = "benson",
      Trailer = "none",
      HasCaution = true
    }
  },
  Zones = {
    CloakRoom = {--
      Pos   = {x = 959.52, y = -2184.8, z = 29.51},
      Size  = {x = 3.0, y = 3.0, z = 3.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('s_slaughter_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
    },

    AliveChicken = {--
      Pos   = {x = -64.3, y = 6235.96, z = 30.09},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('s_hen'),
      Type  = "work",
      Item  = {
        {
          name   = _U('s_alive_chicken'),
          db_name= "alive_chicken",
          time   = 5,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "nothing",
          requires_name = "Nothing",
          drop   = 100
        }
      },
      Hint  = _U('s_catch_hen')
    },

    SlaughterHouse = {
      Pos   = {x = -87.78, y = 6235.31, z = 30.091},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('s_slaughtered'),
      Type  = "work",
      Item  = {
        {
          name   = _U('s_slaughtered_chicken'),
          db_name= "slaughtered_chicken",
          time   = 5,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "alive_chicken",
          requires_name = _U('s_alive_chicken'),
          drop   = 100
        }
      },
      Hint  = _U('s_chop_animal')
    },

    Packaging = {
      Pos   = {x = -106.04, y = 6204.55, z = 30.03},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 204, g = 204, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('s_package'),
      Type  = "work",
      Item  = {
        {
          name   = _U('s_packagechicken'),
          db_name= "packaged_chicken",
          time   = 5,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "slaughtered_chicken",
          requires_name = _U('s_unpackaged'),
          drop   = 100
        }
      },
      Hint  = _U('s_unpackaged_button')
    },

    VehicleSpawner = {
      Pos   = {x = 960.72, y = -2189.32, z = 29.51},
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
      Pos   = {x = 945.34, y = -2187.36, z = 30.55},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 46.6
    },

    VehicleDeletePoint = {
      Pos   = {x = 940.5, y = -2170.05, z = 29.53},
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
      Pos   = {x = 160.63, y = -1648.36, z = 28.29},
      Color = {r = 204, g = 204, b = 0},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
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
          price  = 100,
          requires = "packaged_chicken",
          requires_name = _U('s_packagechicken'),
          drop   = 100
        }
      },
      Hint  = _U('s_deliver')
    }
  }
}
