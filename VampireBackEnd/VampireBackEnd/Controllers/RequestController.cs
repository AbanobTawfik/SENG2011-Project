using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using VampireBackEnd.Models;
using VampireBackEnd.Services;

namespace VampireBackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RequestController : ControllerBase
    {
        private VampireContext _vampireContext;
        private BloodInventoryService _bloodInventoryService;
        public RequestController(VampireContext vampireContext, BloodInventoryService bloodInventoryService)
        {
            this._vampireContext = vampireContext;
            this._bloodInventoryService = bloodInventoryService;
            this._bloodInventoryService.setDbContext(vampireContext);
        }

        // example of GET api/Vampire
        [HttpPost]
        // can change routes 
        [Route("Blood")]
        public async Task<ActionResult> RequestBlood([FromBody] RequestDto[] request)
        {
            Request[] batchRequest = new Request[request.Length];
            for (int i = 0; i < request.Length; i++)
            {
                batchRequest[i] = new Request()
                {
                    bloodType = request[i].bloodType,
                    volume = request[i].volume,
                };
            }
            var updatedInventoryBloodAndMessages = await _bloodInventoryService.Request(batchRequest);
            return Ok(updatedInventoryBloodAndMessages);
        }
    }
}
