using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using VampireBackEnd.Services;

namespace VampireBackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class VampireController : ControllerBase
    {
        private BloodInventoryService _bloodInventoryService;
        public VampireController(BloodInventoryService bloodInventoryService)
        {
            this._bloodInventoryService = bloodInventoryService;
        }
        // example of GET api/Vampire
        [HttpGet]
        // can change routes 
        [Route("Request")]
        public ActionResult<IEnumerable<string>> Get()
        {
            return new string[] { "value1", "value2" };
        }
       
    }
}
