﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using VampireBackEnd.Models;

namespace VampireBackEnd.Models.Migrations
{
    [DbContext(typeof(VampireContext))]
    [Migration("20191107192420_1")]
    partial class _1
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "2.2.6-servicing-10079")
                .HasAnnotation("Relational:MaxIdentifierLength", 128)
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("VampireBackEnd.Dtos.Blood", b =>
                {
                    b.Property<Guid>("bloodId")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("DateDonated");

                    b.Property<string>("bloodStatus");

                    b.Property<string>("bloodType");

                    b.Property<string>("donorName");

                    b.Property<string>("locationAcquired");

                    b.HasKey("bloodId");

                    b.ToTable("bloodInventory");
                });

            modelBuilder.Entity("VampireBackEnd.Dtos.User", b =>
                {
                    b.Property<Guid>("UserId")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("firstName");

                    b.Property<string>("lastname");

                    b.Property<string>("password");

                    b.Property<string>("userName");

                    b.HasKey("UserId");

                    b.ToTable("users");
                });
#pragma warning restore 612, 618
        }
    }
}
