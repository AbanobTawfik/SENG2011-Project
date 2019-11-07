using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using VampireBackEnd.Dtos;
using VampireBackEnd.Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace VampireBackEnd.Controllers
{
    [Route("api/[controller]")]
    public class BloodInventoryController : Controller
    {
        private VampireContext _vampireContext;
        private BloodInventoryService _bloodInventoryService;
        public BloodInventoryController(VampireContext vampireContext, BloodInventoryService bloodInventoryService)
        {
            this._vampireContext = vampireContext;
            this._bloodInventoryService = bloodInventoryService;
            this._bloodInventoryService.setDbContext(vampireContext);
        }

        [HttpPost]
        [Route("AddBlood")]
        public ActionResult Get([FromBody] BloodDto blood)
        {
            Guid bloodId = new Guid();
            Blood addingBlood = new Blood()
            {
                bloodId = bloodId,
                bloodStatus = blood.bloodStatus,
                bloodType = blood.bloodType,
                dateDonated = blood.dateDonated,
                donorName = blood.donorName,
                locationAcquired = blood.locationAcquired

            };
            var oldAndNewInventory = _bloodInventoryService.AddBlood(addingBlood);
            return Ok(oldAndNewInventory);
        }

       
    }
}
