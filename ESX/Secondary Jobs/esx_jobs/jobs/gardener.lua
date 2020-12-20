Config.Jobs.gardener = {
  BlipInfos = {
    Sprite = 67,
    Color = 3
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
    CloakRoom = {
      Pos   = {x = 2243.28, y = 5154.22, z = 56.88},
      Size  = {x = 3.0, y = 3.0, z = 1.0},
      Color = {r = 0, g = 0, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('m_gardener_locker'),
      Type  = "cloakroom",
      Hint  = _U('cloak_change'),
      GPS = {x = 2240.00, y = 5159.62, z = 56.89}
    },

    Ble = {
      Pos   = {x = 2155.56, y = 5163.24, z = 53.20},
      Size  = {x = 25.0, y = 25.0, z = 1.0},
      Color = {r = 0, g = 0, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('m_ble'),
      Type  = "work",
      Item  = {
        {
          name   = _U('m_ble'),
          db_name= "corn",
          time   = 5,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "nothing",
          requires_name = "Nothing",
          drop   = 100
        }
      },
      Hint  = _U('m_recoltble'),
      GPS = {x = 2897.90, y = 4379.80, z = 49.37},
    },

    Moulure = {
      Pos   = {x = 2897.90, y = 4379.80, z = 49.37},
      Size  = {x = 25.0, y = 25.0, z = 1.0},
      Color = {r = 0, g = 0, b = 0},
      Marker= 1,
      Blip  = true,
      Name  = _U('m_ble_smelting'),
      Type  = "work",
      Item  = {
        {
          name   = _U('m_farine'),
          db_name= "faina",
          time   = 5,
          max    = 20,
          add    = 1,
          remove = 1,
          requires = "corn",
          requires_name = _U('ble'),
          drop   = 100
        },
      },
      Hint  = _U('m_ble_button'),
      GPS = {x = -54.53, y = -223.37, z = 44.44}
    },

    VehicleSpawner = {
      Pos   = {x = 2240.00, y = 5159.62, z = 56.89},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 0, g = 0, b = 0},
      Marker= 1,
      Blip  = false,
      Name  = _U('spawn_veh'),
      Type  = "vehspawner",
      Spawner = 1,
      Hint  = _U('spawn_veh_button'),
      Caution = 100,
      GPS = {x = 2155.56, y = 2326.24, z = 42.398}
    },

    VehicleSpawnPoint = {
      Pos   = {x = 2243.79, y = 5137.74, z = 55.02},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Marker= -1,
      Blip  = false,
      Name  = _U('service_vh'),
      Type  = "vehspawnpt",
      Spawner = 1,
      Heading = 49.00,
      GPS = 0
    },

    VehicleDeletePoint = {
      Pos   = {x = 2238.69, y = 5171.78, z = 58.53},
      Size  = {x = 5.0, y = 5.0, z = 1.0},
      Color = {r = 166, g = 0, b = 0},
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

    farine = {
      Pos   = {x = -54.53, y = -223.37, z = 44.44},
      Color = {r = 0, g = 0, b = 0},
      Size  = {x = 5.0, y = 5.0, z = 3.0},
      Marker= 1,
      Blip  = true,
      Name  = _U('m_sell_farine'),
      Type  = "delivery",
      Spawner = 1,
      Item  = {
        {
          name   = _U('delivery'),
          time   = 3,
          remove = 1,
          max    = 20, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
          price  = 50,
          requires = "faina",
          requires_name = _U('m_farine'),
          drop   = 100
        }
      },
      Hint  = _U('m_deliver_farine'),
      GPS = {x = 2155.56, y = 5163.24, z = 53.20},
    },

  },
}
