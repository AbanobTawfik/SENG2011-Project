using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using VampireBackEnd.Models;
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
        public async Task<ActionResult> AddBlood([FromBody] BloodDto blood)
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
            var oldAndNewInventory = await _bloodInventoryService.AddBlood(addingBlood);
            return Ok(oldAndNewInventory);
        }

        [HttpGet]
        [Route("GetInventory")]
        public async Task<ActionResult> GetBloodInventory()
        {
            var bloodInventory = await _bloodInventoryService.GetBloodInventory();
            return Ok(bloodInventory);
        }

        [HttpGet]
        [Route("GetAlerts")]
        public async Task<ActionResult> GetAlerts()
        {
            var allAlerts = await _bloodInventoryService.GetAlerts();
            return Ok(allAlerts);
        }

        [HttpPost]
        [Route("FixAlerts")]
        public async Task<ActionResult> FixAlerts()
        {
            var updatedInventoryAndMessages = await _bloodInventoryService.FixAlerts();
            return Ok(updatedInventoryAndMessages);
        }

        [HttpPost]
        [Route("RemoveExpired")]
        public async Task<ActionResult> RemoveExpired()
        {
            var oldAndNewInventory = await _bloodInventoryService.RemoveExpired();
            return Ok(oldAndNewInventory);
        }

        [HttpPost]
        [Route("ResetDb")]
        public async Task<ActionResult> ResetDb()
        {
            foreach(var blood in this._vampireContext.bloodInventory)
            {
                this._vampireContext.bloodInventory.Remove(blood);
            }
            await this._vampireContext.SaveChangesAsync();
            var bloodTypes = new string[] { "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+",
                                            "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+",
                                            "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+",
                                            "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+", "O+",
                                            "O-", "O-", "O-", "O-", "O-", "O-", "O-", "O-", "O-", "A+",
                                            "A+", "A+", "A+", "A+", "A+", "A+", "A+", "A+", "A+", "A+",
                                            "A+", "A+", "A+", "A+", "A+", "A+", "A+", "A+", "A+", "A+",
                                            "A+", "A+", "A+", "A+", "A+", "A+", "A+", "A+", "A+", "A+",
                                            "A-", "A-", "A-", "A-", "A-", "A-", "A-", "B+", "B+", "B+",
                                            "B+", "B+", "B+", "B+", "B+", "B-", "B-", "AB+", "AB+", "AB-" };
            var rnd = new Random();
            for (var i = 0; i < 100; i++)
            {
                int bloodTypeIndex = rnd.Next(100);
                var gen = new Random();
                DateTime start = DateTime.Now.AddDays(-43);
                int range = (DateTime.Today - start).Days;
                var day = start.AddDays(gen.Next(range));
                this._vampireContext.bloodInventory.Add(new Blood
                {
                    bloodId = Guid.NewGuid(),
                    bloodStatus = "Tested",
                    bloodType = bloodTypes[bloodTypeIndex],
                    dateDonated = day.ToString(),
                    donorName = "initial hospital donor",
                    locationAcquired = "Hospital"
                });
            }
            await this._vampireContext.SaveChangesAsync();
            return Ok();
        }
    }
}
