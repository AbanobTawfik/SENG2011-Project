using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VampireBackEnd.Models
{
    public class VampireContext : DbContext
    {
        public DbSet<User> users { get; set; }
        public DbSet<Blood> bloodInventory { get; set; }
        public DbSet<Setting> settings { get; set; }
        public VampireContext(DbContextOptions<VampireContext> options) : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            var bloodTypes = new string[]{ "A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
            Random rnd = new Random();
            modelBuilder.Entity<Setting>().HasData(new Setting { settingType = "Threshold", settingValue = 0, settingId = Guid.NewGuid()});
            var initialBloodList = new List<Blood>();

            for (var i = 0; i < 100; i++)
            {
                int bloodTypeIndex = rnd.Next(8);

                initialBloodList.Add(new Blood
                {
                    bloodId = Guid.NewGuid(),
                    bloodStatus = "Tested",
                    bloodType = bloodTypes[bloodTypeIndex],
                    dateDonated = DateTime.Now.ToString(),
                    donorName = "initial hospital donor",
                    locationAcquired = "Hospital"
                });
            }
            modelBuilder.Entity<Blood>().HasData(initialBloodList);
        }

    }
}