using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace VampireBackEnd.Dtos
{
    public class VampireContext : DbContext
    {
        public DbSet<User> users { get; set; }
        public VampireContext(DbContextOptions<VampireContext> options) : base(options)
        {
        }

    }
}
