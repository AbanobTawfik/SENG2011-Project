using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VampireBackEnd.Dtos
{
    public class BloodDto
    {
        public string donorName { get; set; }
        public string bloodId{ get; set; }
        public string bloodType{ get; set; }
        public string bloodStatus{ get; set; }
        public string dateDonated { get; set; }
        public string locationAcquired { get; set; }
    }
}
