using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace VampireBackEnd.Models
{
    public class Setting
    {
        public Guid settingId { get; set; }
        public string settingType { get; set; }
        public int settingValue { get; set; }
    }
}
