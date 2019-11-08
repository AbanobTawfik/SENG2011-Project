using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VampireBackEnd.Dtos
{
    public class User
    {
        public Guid  UserId { get; set; }
        public string firstName { get; set; }
        public string lastname { get; set; }
        public string userName { get; set; }
        public string password { get; set; }
    }
}
