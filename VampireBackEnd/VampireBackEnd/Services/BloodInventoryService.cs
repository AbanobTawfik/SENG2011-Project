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

        public UpdatedBloodInventoryReturn AddBlood(Blood blood)
        {
            if(_bloodInventory != null)
            {
                // dafny logic
                var oldBloodArray = this._bloodInventory.bloodInventory.ToArray();
                var addedToInventory = new Blood[oldBloodArray.Length + 1];
                for(var i = 0; i < oldBloodArray.Length; i++)
                {
                    addedToInventory[i] = oldBloodArray[i];
                }
                addedToInventory[oldBloodArray.Length] = blood;
                // add into db just for showing effect, similair to a ghost var
                this._bloodInventory.bloodInventory.Add(blood);
                this._bloodInventory.SaveChangesAsync();
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
            var result = new List<KeyValuePair<string, int>>();
            var bloodInventory = this._bloodInventory.bloodInventory.ToList();
            var threshold = this._bloodInventory.settings.Where(x => x.settingType.ToLower() == "threshold").FirstOrDefault();
            var bloodTypes = this._bloodInventory.bloodInventory.Select(x => x.bloodType).Distinct();
            if (threshold != null && bloodInventory != null && bloodTypes != null) 
            {
                var thresholdValue = threshold.settingValue;
                foreach(var bloodType in bloodTypes)
                {
                    var count = bloodInventory.Where(x => x.bloodType == bloodType).Count();
                    if(count < thresholdValue)
                    {
                        result.Add(new KeyValuePair<string, int>(bloodType, thresholdValue - count));
                    }
                }
                return result;
            }
            return null;
        }

        public void setDbContext(VampireContext bloodInventory)
        {
            this._bloodInventory = bloodInventory;
        }

    }
}