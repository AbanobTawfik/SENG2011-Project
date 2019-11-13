using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VampireBackEnd.Models;

namespace VampireBackEnd.Services
{
    public class BloodInventoryService
    {
        private VampireContext _bloodInventory = null;

        public async Task<UpdatedBloodInventoryReturn> AddBlood(Blood blood)
        {
            if (_bloodInventory != null)
            {
                // dafny logic
                var oldBloodArray = this._bloodInventory.bloodInventory.ToArray();
                // check the method its the same as the dafny logic
                var addedToInventory = new Blood[oldBloodArray.Length + 1];
                for (var i = 0; i < oldBloodArray.Length; i++)
                {
                    addedToInventory[i] = oldBloodArray[i];
                }
                addedToInventory[oldBloodArray.Length] = blood;
                this._bloodInventory.bloodInventory.Add(blood);
                await this._bloodInventory.SaveChangesAsync();
                return new UpdatedBloodInventoryReturn()
                {
                    oldBloodInventory = oldBloodArray,
                    newBloodInventory = addedToInventory
                };
            }
            return null;
        }
        public Blood[] GetBloodInventory()
        {
            if (_bloodInventory != null)
            {
                return this._bloodInventory.bloodInventory.ToArray();
            }
            return null;
        }
        public List<KeyValuePair<string, int>> GetAlerts()
        {
            if (_bloodInventory != null)
            {
                var result = new List<KeyValuePair<string, int>>();
                var bloodInventory = this._bloodInventory.bloodInventory.ToList();
                var threshold = this._bloodInventory.settings.Where(x => x.settingType.ToLower() == "threshold").FirstOrDefault();
                var bloodTypes = this._bloodInventory.bloodInventory.Select(x => x.bloodType).Distinct();
                var thresholdValue = threshold.settingValue;
                foreach (var bloodType in bloodTypes)
                {
                    var bloodCount = bloodInventory.Where(x => x.bloodType == bloodType).Count();
                    if (bloodCount < thresholdValue)
                    {
                        result.Add(new KeyValuePair<string, int>(bloodType, thresholdValue - bloodCount));
                    }
                }
                return result;
            }
            return null;
        }

        public async Task<KeyValuePair<UpdatedBloodInventoryReturn, List<string>>> FixAlerts()
        {
            if (_bloodInventory != null)
            {
                var alertMessages = new List<string>();
                var bloodInventory = this._bloodInventory.bloodInventory.ToArray();
                var threshold = this._bloodInventory.settings.Where(x => x.settingType.ToLower() == "threshold").FirstOrDefault();
                var bloodTypes = this._bloodInventory.bloodInventory.Select(x => x.bloodType).Distinct();
                var thresholdValue = threshold.settingValue;
                UpdatedBloodInventoryReturn newBloodInventory = null;
                foreach (var bloodType in bloodTypes)
                {
                    var bloodCount = bloodInventory.Where(x => x.bloodType == bloodType).Count();
                    if (bloodCount < thresholdValue)
                    {
                        // same code  in request for fixing alert
                        var count = 0;
                        while (count <= thresholdValue - bloodCount)
                        {
                            var emergencyDonor = new Blood()
                            {
                                bloodId = new Guid(),
                                bloodStatus = "Tested",
                                bloodType = bloodType,
                                dateDonated = DateTime.Now.ToString(),
                                donorName = "EMERGENCY DONOR",
                                locationAcquired = "Hospital"
                            };
                            newBloodInventory = await AddBlood(emergencyDonor);
                            count++;
                        }
                        alertMessages.Add("Vampire Headquarters has fixed  the alert on the blood type \"" + bloodType + "\" by adding " +
                                          (thresholdValue - bloodCount) + " bags of blood to the inventory.\n The threshold is at " +
                                          thresholdValue + " bags of blood");
                    }
                }
                var updatedBloodInventory = newBloodInventory == null ? bloodInventory : newBloodInventory.newBloodInventory;
                var oldAndNewBloodInventory = new UpdatedBloodInventoryReturn()
                {
                    oldBloodInventory = bloodInventory,
                    newBloodInventory = updatedBloodInventory
                };
                return new KeyValuePair<UpdatedBloodInventoryReturn, List<string>>(oldAndNewBloodInventory, alertMessages);
            }
            return default(KeyValuePair<UpdatedBloodInventoryReturn, List<string>>);
        }

        public Blood[] AddBloodToArray(Blood blood, Blood[] oldInventory)
        {
            var addedToInventory = new Blood[oldInventory.Length + 1];
            for (var i = 0; i < oldInventory.Length; i++)
            {
                addedToInventory[i] = oldInventory[i];
            }
            addedToInventory[oldInventory.Length] = blood;
            return addedToInventory;
        }

        public void setDbContext(VampireContext bloodInventory)
        {
            this._bloodInventory = bloodInventory;
        }

    }
}