using System;
using System.Collections.Generic;
using System.Text;

namespace VampireBackEnd.Models
{
    public class Request
    {
        public Guid requestId { get; set; }
        public string bloodType { get; set; }
        public int volume { get; set; }
    }
}
