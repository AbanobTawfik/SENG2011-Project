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

        public async Task<Tuple<UpdatedBloodInventoryReturn, Blood[], List<string>>> Request(Request[] batchRequest)
        {
            if (_bloodInventory != null)
            {
                var oldBloodArray = await this._bloodInventory.bloodInventory.ToArrayAsync();

                var alertMessages = new List<string>();
                var bloodInventory = await this._bloodInventory.bloodInventory.ToArrayAsync();
                var threshold = this._bloodInventory.settings.Where(x => x.settingType.ToLower() == "threshold").FirstOrDefault();
                var thresholdValue = threshold.settingValue;

                UpdatedBloodInventoryReturn inventoryUpdate = new UpdatedBloodInventoryReturn()
                {
                    oldBloodInventory = oldBloodArray,
                    newBloodInventory = oldBloodArray,
                };

                var i = 0;
                var requestResult = new Blood[0];
                // for each request for a blood type
                while (i < batchRequest.Length)
                {
                    var count = 0;
                    // for each unit of blood of that blood type requested
                    while (count < batchRequest[i].volume)
                    {
                        var removeResult = await this.RemoveBlood(batchRequest[i].bloodType);
                        _ = removeResult.Item1;
                        var addBlood = removeResult.Item2;
                        requestResult = this.AddBloodToArrayResizing(requestResult, addBlood);
                        count = count + 1;
                    }
                    await this._bloodInventory.SaveChangesAsync();
                    // check for alert
                    var bloodType = batchRequest[i].bloodType;

                    var bloodCount = this._bloodInventory.bloodInventory.Where(x => x.bloodType == bloodType).Count();
                    if (bloodCount < thresholdValue)
                    {
                        // same code in request for fixing alert
                        var addCount = 0;
                        while (addCount <= thresholdValue - bloodCount)
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
                            inventoryUpdate = await AddBlood(emergencyDonor);
                            addCount++;
                        }
                        alertMessages.Add("Vampire Headquarters has fixed the alert on the blood type \"" + bloodType + "\" by adding " +
                                          (thresholdValue - bloodCount + 1) + " bags of blood to the inventory.\n The threshold is at " +
                                          thresholdValue + " bags of blood");
                    }

                    i = i + 1;
                }

                return new Tuple<UpdatedBloodInventoryReturn, Blood[], List<string>>(
                    new UpdatedBloodInventoryReturn()
                    {
                        oldBloodInventory = oldBloodArray,
                        newBloodInventory = await this._bloodInventory.bloodInventory.ToArrayAsync()
                    },
                    requestResult,
                    alertMessages
                );
            }
            return null;
        }

        public Blood[] AddBloodToArrayResizing(Blood[] arr, Blood blood)
        {
            var newResizedArray = new Blood[arr.Length + 1];
            for (var i = 0; i < arr.Length; i++)
            {
                newResizedArray[i] = arr[i];
            }
            newResizedArray[arr.Length] = blood;
            return newResizedArray;
        }

        public async Task<Tuple<UpdatedBloodInventoryReturn, Blood>> RemoveBlood(string bloodType)
        {
            if (_bloodInventory != null)
            {
                // dafny logic
                var oldBloodArray = await this._bloodInventory.bloodInventory.ToArrayAsync();

                Blood blood = null;
                var removedFromInventory = new Blood[oldBloodArray.Length - 1];
                var i = 0;
                while (i < oldBloodArray.Length)
                {
                    if (oldBloodArray[i].bloodType == bloodType)
                    {
                        blood = oldBloodArray[i];
                        for (var k = 0; k < i; k++)
                        {
                            removedFromInventory[k] = oldBloodArray[k];
                        }
                        for (var k = i + 1; k < oldBloodArray.Length; k++)
                        {
                            removedFromInventory[k - 1] = oldBloodArray[k];
                        }

                        this._bloodInventory.bloodInventory.Remove(blood);
                        await this._bloodInventory.SaveChangesAsync();
                        return new Tuple<UpdatedBloodInventoryReturn, Blood>(
                            new UpdatedBloodInventoryReturn()
                            {
                                oldBloodInventory = oldBloodArray,
                                newBloodInventory = removedFromInventory
                            },
                            blood
                        );
                    }
                    i = i + 1;
                }

                // if there is no blood of the given type
                return new Tuple<UpdatedBloodInventoryReturn, Blood>(
                    new UpdatedBloodInventoryReturn()
                    {
                        oldBloodInventory = oldBloodArray,
                        newBloodInventory = oldBloodArray,
                    },
                    blood
                );
            }
            return null;
        }

        public async Task<Blood[]> GetBloodInventory()
        {
            if (_bloodInventory != null)
            {
                return await this._bloodInventory.bloodInventory.ToArrayAsync();
            }
            return null;
        }

        public async Task<List<KeyValuePair<string, int>>> GetAlerts()
        {
            if (_bloodInventory != null)
            {
                var result = new List<KeyValuePair<string, int>>();
                var bloodInventory = await this._bloodInventory.bloodInventory.ToListAsync();
                var threshold = this._bloodInventory.settings.Where(x => x.settingType.ToLower() == "threshold").FirstOrDefault();
                var bloodTypes = new string[] { "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" };
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
                var bloodInventory = await this._bloodInventory.bloodInventory.ToArrayAsync();
                var threshold = this._bloodInventory.settings.Where(x => x.settingType.ToLower() == "threshold").FirstOrDefault();
                var bloodTypes = new string[] { "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" };
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
                            var gen = new Random();
                            DateTime start = DateTime.Now.AddDays(-43);
                            int range = (DateTime.Today - start).Days;
                            var day = start.AddDays(gen.Next(range));
                            var emergencyDonor = new Blood()
                            {
                                bloodId = new Guid(),
                                bloodStatus = "Tested",
                                bloodType = bloodType,
                                dateDonated = day.ToString(),
                                donorName = "EMERGENCY DONOR",
                                locationAcquired = "Hospital"
                            };
                            newBloodInventory = await AddBlood(emergencyDonor);
                            count++;
                        }
                        alertMessages.Add("Vampire Headquarters has fixed  the alert on the blood type \"" + bloodType + "\" by adding " +
                                          (thresholdValue - bloodCount + 1) + " bags of blood to the inventory.\n The threshold is at " +
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

        public async Task<UpdatedBloodInventoryReturn> RemoveExpired()
        {
            if (_bloodInventory != null)
            {
                var bloodInventory = await this._bloodInventory.bloodInventory.ToArrayAsync();
                var updatedInventory = new Blood[bloodInventory.Length];
                var i = 0; // index for old array
                var j = 0; // index for new array
                while (i < bloodInventory.Length)
                {
                    DateTime bloodDate;
                    var check = DateTime.TryParse(bloodInventory[i].dateDonated, out bloodDate);
                    if (check)
                    {
                        if (!(DateTime.Now.Subtract(DateTime.Parse(bloodInventory[i].dateDonated)).TotalDays >= 43))
                        {
                            updatedInventory[j] = bloodInventory[i];
                            j++;
                        }
                        else
                        {
                            // remove from db aswell
                            this._bloodInventory.bloodInventory.Remove(bloodInventory[i]);
                        }
                    }
                    else
                    {
                        // remove from db aswell
                        this._bloodInventory.bloodInventory.Remove(bloodInventory[i]);
                    }
                    i++;
                }
                var finalUpdatedInventory = new Blood[j];
                for (var k = 0; k < j; k++)
                {
                    finalUpdatedInventory[k] = updatedInventory[k];
                    k++;
                }
                await _bloodInventory.SaveChangesAsync();
                var oldAndNewBloodInventory = new UpdatedBloodInventoryReturn()
                {
                    oldBloodInventory = bloodInventory,
                    newBloodInventory = finalUpdatedInventory
                };
                return oldAndNewBloodInventory;
            }
            return null;
        }

        public void setDbContext(VampireContext bloodInventory)
        {
            this._bloodInventory = bloodInventory;
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////
        // NEW MAP CODE //
        public async Task<int> GetBloodTypeCount(string bloodType)
        {
            if (_bloodInventory != null)
            {
                var bloodInventoryAsArray = await _bloodInventory.bloodInventory.ToArrayAsync();
                var bloodInventoryAsMap = convertArrayToDictionary(bloodInventoryAsArray);
                if (bloodInventoryAsMap.ContainsKey(bloodType))
                {
                    return bloodInventoryAsMap[bloodType].Length;
                }
                else
                {
                    return -1;
                }

            }
            return -1;
        }

        public async Task<UpdatedBloodInventoryReturn> AddBloodWithMap(Blood blood)
        {
            if (_bloodInventory != null)
            {
                // dafny logic
                var oldBloodArray = await this._bloodInventory.bloodInventory.ToArrayAsync();
                var bloodInventoryAsMap = convertArrayToDictionary(oldBloodArray);
                var bloodType = blood.bloodType;
                var newBucket = new Blood[bloodInventoryAsMap[bloodType].Length + 1];
                for (var i = 0; i < bloodInventoryAsMap[bloodType].Length; i++)
                {
                    newBucket[i] = bloodInventoryAsMap[bloodType][i];
                }
                newBucket[bloodInventoryAsMap[bloodType].Length] = blood;
                bloodInventoryAsMap[bloodType] = newBucket;
                var addedToInventory = ConvertDictionaryToArray(bloodInventoryAsMap);
                await this._bloodInventory.bloodInventory.AddAsync(blood);
                await this._bloodInventory.SaveChangesAsync();
                return new UpdatedBloodInventoryReturn()
                {
                    oldBloodInventory = oldBloodArray,
                    newBloodInventory = addedToInventory
                };
            }
            return null;
        }

        public async Task<UpdatedBloodInventoryReturn> RemoveExpiredWithMap()
        {
            if (_bloodInventory != null)
            {
                var bloodTypes = new string[] { "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" };
                var oldBloodArray = await this._bloodInventory.bloodInventory.ToArrayAsync();
                var bloodInventoryAsMap = convertArrayToDictionary(oldBloodArray);
                foreach (var bloodType in bloodTypes)
                {
                    bloodInventoryAsMap[bloodType] = GetNonExpiredBlood(bloodInventoryAsMap[bloodType]);
                }
                var newInventory = ConvertDictionaryToArray(bloodInventoryAsMap);
                // very reckless to do would never reccommend dropping db and repopulating in a commonly used end-point
                foreach(var blood in this._bloodInventory.bloodInventory)
                {
                    this._bloodInventory.bloodInventory.Remove(blood);
                }
                foreach(var blood in newInventory)
                {
                    await this._bloodInventory.bloodInventory.AddAsync(blood);
                }
                await this._bloodInventory.SaveChangesAsync();
                return new UpdatedBloodInventoryReturn()
                {
                    oldBloodInventory = oldBloodArray,
                    newBloodInventory = newInventory
                };
            }
            return null;
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////
        public Blood[] GetNonExpiredBlood(Blood[] inventory)
        {
            return Filter(inventory, IsExpired);
        }

        public Blood[] Filter(Blood[] inventory, Func<Blood, bool> test)
        {
            var i = 0;
            var count = 0;
            while (i < inventory.Length)
            {
                if (test(inventory[i]))
                {
                    count++;
                }
                i++;
            }
            var ret = new Blood[count];
            i = 0;
            var j = 0;
            while (i < inventory.Length)
            {
                if (test(inventory[i]))
                {
                    ret[j] = inventory[i];
                    j++;
                }
                i++;
            }
            return ret;
        }
        ///////////////////////////////////////////////////////////////////////////////////////////////
        // Helpers //
        ///////////////////////////////////////////////////////////////////////////////////////////////
        public Blood[] RemoveExpiredBloodByType(Blood[] inventory)
        {
            return GetNonExpiredBlood(inventory);
        }

        public bool IsExpired(Blood blood)
        {
            DateTime bloodDate;
            var check = DateTime.TryParse(blood.dateDonated, out bloodDate);
            if (check)
            {
                if (!(DateTime.Now.Subtract(DateTime.Parse(blood.dateDonated)).TotalDays >= 43))
                {
                    return false;
                }
                return true;
            }
            else
            {
                return true;
            }
        }


        public Blood[] ConvertDictionaryToArray(Dictionary<string, Blood[]> inventory)
        {
            if (inventory == null)
            {
                return null;
            }
            else
            {
                var returnInventory = new Blood[0];
                foreach (var entry in inventory)
                {
                    foreach (var blood in entry.Value)
                    {
                        returnInventory = AddBloodToArray(returnInventory, blood);
                    }
                }
                return returnInventory;
            }
        }

        public Dictionary<string, Blood[]> convertArrayToDictionary(Blood[] inventory)
        {
            if (inventory == null)
            {
                return null;
            }
            else
            {
                Dictionary<string, Blood[]> inventoryReturn = new Dictionary<string, Blood[]>();
                var bloodTypes = new string[] { "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-" };
                foreach (var bloodType in bloodTypes)
                {
                    inventoryReturn.Add(bloodType, new Blood[0]);
                }
                foreach (var blood in inventory)
                {
                    if (inventoryReturn.ContainsKey(blood.bloodType))
                    {
                        inventoryReturn[blood.bloodType] = AddBloodToArray(inventoryReturn[blood.bloodType], blood);
                    }
                }
                return inventoryReturn;
            }
        }

        public Blood[] AddBloodToArray(Blood[] old, Blood adding)
        {
            if (adding == null)
            {
                return old;
            }
            else
            {
                var newBlood = new Blood[old.Length + 1];
                for (var i = 0; i < old.Length; i++)
                {
                    newBlood[i] = old[i];
                }
                newBlood[old.Length] = adding;
                return newBlood;
            }
        }
    }
}