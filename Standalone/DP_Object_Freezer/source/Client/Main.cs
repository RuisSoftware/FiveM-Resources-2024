using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.UI;
using CitizenFX.Core.Native;

namespace DP_Object_Freezer.Client
{
    public class Main : BaseScript // Main process die begint als bestand gelezen wordt
    {
        private readonly string[] props = {
            "prop_trafficlight",
            "prop_traffic_lightset_01",
            "prop_traffic_03b",
            "prop_traffic_03a",
            "prop_traffic_02b",
            "prop_traffic_02a",
            "prop_traffic_01d",
            "prop_traffic_01b",
            "prop_traffic_01a",
            "prop_traffic_01",
            "prop_streetlight_01b",
            "prop_streetlight_01",
            "prop_sign_road_03e",
            "prop_streetlight_01b",
            "prop_sign_road_03g",
            "prop_sign_road_05c",
            "prop_sign_road_05d",
            "prop_sign_road_05e",
            "prop_sign_road_05f",
            "prop_sign_road_05o",
            "prop_sign_road_05za",
            "prop_sign_road_06q",
            "prop_sign_road_06r",
            "prop_sign_road_09c",
            "prop_sign_road_09d"
        };
        public Main()
        {
            Tick += OnTick;
        }

        private async Task OnTick()
        {
            await Delay(100);
            foreach (string i in props)
            {
                float radius = (float)100.0;
                uint hash = (uint)API.GetHashKey(i);
                int player = (int)API.PlayerPedId();
                Vector3 pos = API.GetEntityCoords(player, false);
                int paal = API.GetClosestObjectOfType(pos.X, pos.Y, pos.Z, radius, hash, false, false, false);
                if (paal != 0)
                {
                    if (API.IsPedWalking(player))
                    {
                        API.FreezeEntityPosition(paal, true);
                    }
                    else if (API.IsPedRunning(player))
                    {
                        API.FreezeEntityPosition(paal, true);
                    }
                    else if (API.IsPedInAnyVehicle(player, false) && API.GetEntitySpeed(player) <= 80)
                    {
                        API.FreezeEntityPosition(paal, true);
                    }
                }
            }
        }
    }
}