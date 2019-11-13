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
        private BloodInventoryService _bloodInventoryService;
        public RequestController(BloodInventoryService bloodInventoryService)
        {
            this._bloodInventoryService = bloodInventoryService;
        }

        // example of GET api/Vampire
        [HttpGet]
        // can change routes 
        [Route("Request")]
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
