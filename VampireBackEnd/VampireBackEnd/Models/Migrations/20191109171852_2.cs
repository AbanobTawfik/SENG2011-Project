using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace VampireBackEnd.Models.Migrations
{
    public partial class _2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "DateDonated",
                table: "bloodInventory",
                newName: "dateDonated");

            migrationBuilder.CreateTable(
                name: "settings",
                columns: table => new
                {
                    settingId = table.Column<Guid>(nullable: false),
                    settingType = table.Column<string>(nullable: true),
                    settingValue = table.Column<int>(nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_settings", x => x.settingId);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "settings");

            migrationBuilder.RenameColumn(
                name: "dateDonated",
                table: "bloodInventory",
                newName: "DateDonated");
        }
    }
}
