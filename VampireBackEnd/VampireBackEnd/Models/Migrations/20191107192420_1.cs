using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace VampireBackEnd.Models.Migrations
{
    public partial class _1 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "bloodInventory",
                columns: table => new
                {
                    bloodId = table.Column<Guid>(nullable: false),
                    donorName = table.Column<string>(nullable: true),
                    bloodType = table.Column<string>(nullable: true),
                    bloodStatus = table.Column<string>(nullable: true),
                    DateDonated = table.Column<string>(nullable: true),
                    locationAcquired = table.Column<string>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_bloodInventory", x => x.bloodId);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "bloodInventory");
        }
    }
}
