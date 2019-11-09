using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VampireBackEnd.Models
{
    public class UpdatedBloodInventoryReturn
    {
        public Blood[] oldBloodInventory { get; set; }
        public Blood[] newBloodInventory { get; set; }
    }
}
