using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using VampireBackEnd.Dtos;

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

        public void setDbContext(VampireContext bloodInventory)
        {
            this._bloodInventory = bloodInventory;
        }
    }
}