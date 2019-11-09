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

    }
}
