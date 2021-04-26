using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CitizenFX.Core;
using CitizenFX.Core.UI;
using CitizenFX.Core.Native;

namespace DP_Anti_Bunny_Jump.Client
{
    public class Main : BaseScript // Main process die begint als bestand gelezen wordt
    {
        public Main()
        {
            Tick += OnTick;
            Tick += OnTick2;
        }
        public bool gesprongen;

        private async Task OnTick()
        {
            await Delay(0);
            if (API.IsPedJumping(API.GetPlayerPed(-1)))
            {
                gesprongen = true;
                await Delay(55000);
                gesprongen = false;
            }
        }
        private async Task OnTick2()
        {
            await Delay(0);
            if (gesprongen)
            {
                API.DisableControlAction(0, 22, true);
            }
        }
    }
}