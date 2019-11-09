using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace VampireBackEnd.Models.Migrations
{
    public partial class _3 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "bloodInventory",
                columns: new[] { "bloodId", "bloodStatus", "bloodType", "dateDonated", "donorName", "locationAcquired" },
                values: new object[,]
                {
                    { new Guid("6b654831-314e-48e7-a4e2-055f7f51fb79"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("e56594b5-1acc-4720-8fe3-23c31fc7f6ba"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("0b0e4d7d-2a99-4ac6-89da-de2a081c533c"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("709dd211-b13d-49a2-947c-da295792e206"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("6fc2a258-1fc5-464a-a811-47521d8081ea"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("1cc7d6d1-3f2a-46a1-8756-9aeb72c60b16"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("4d7631e3-ae09-4e6c-8afc-002f9fa6a5cb"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("51ccadf0-6a21-43b2-907e-d33a863d7f40"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("b17097bc-7388-4150-b00a-00464a85b4e4"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("75c62a66-d14d-4bb7-ae6d-2fc834523922"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("21e7f537-be00-4a58-b2ae-bead444c0d56"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("8938f70f-badd-44d9-bdf2-6d31fa3c569e"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("c5c301cd-f0d8-4bd4-af86-575d2a716970"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("93fff5c7-7707-416e-b380-f885c4bc933b"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("b51d8da4-81f7-41ce-a542-c0f2b63cb634"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("dfa96d36-3806-4b26-b740-b2bf0341a86b"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("ee66084b-7fb4-434b-9708-0ed949856053"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("70e6f677-6c45-4c97-a9e9-2381a0d835a3"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("6a2935e7-7170-4abc-a52b-9522527e97ed"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("7e5ef537-14be-4eb9-8f2f-faa0b01d4797"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("74486e5d-be0d-4013-a9cc-da18fb105d64"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("22397977-c0b8-4570-b558-611ad295ac7a"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("2e67f31b-79e4-4164-bd91-366a08b83879"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("d5cfde5a-0985-4c6c-8897-18e4cffe5bcf"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("6951e028-b61d-42cc-9e7d-7f551d6313a9"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("d7450b1b-92f2-4c39-8632-178ba426d979"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("49705eba-5060-4a47-8234-c7167c25dee9"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("0ee0eb89-7225-419c-adeb-0944aa0f8962"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("0a920e06-474e-4992-a0c0-4d493878920f"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("46e9ac39-17bd-405b-8ee3-110493f3b7c5"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("286d2b4a-0cd6-41ea-b362-35f40f00aad6"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("267076c1-6df1-497c-9fe7-f332c88a9e61"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("9b96768d-928b-4cb1-adb9-9362723a3f5b"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("185d2c2a-735a-452a-9935-83bd9616148d"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("9f498bd1-e661-4211-9865-4305c69b470d"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("8344c260-7873-4271-94c6-a2470eed7540"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("34ba7bd1-f3ba-4441-aa82-ca5fb23e9384"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("49302b16-7afc-4c04-ade3-177738a760e1"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("c8c3e071-994e-43aa-8dce-93535e37ca30"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("f88565d2-1b85-460b-b123-972ec15df189"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("d2ee396d-b92b-48eb-a2a0-798bf6b5d2bf"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("e7bec5af-b043-44b1-9710-2e577b1a88c4"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("687bf522-33e2-4caf-9b29-a025c2317e82"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("73f17d35-0304-4e0d-aa27-27921744231f"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("8324b981-0b7b-427f-bb9e-a6660b8ff54e"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("4dfb0f6c-7d04-4f41-aac4-dc01a1d4baf3"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("2cb82ac8-d9d6-4e78-a711-beb5ce7f78ed"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("b0398970-478d-46f9-9927-be10c4bd2880"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("f3356e5f-b10a-4333-8d1b-d601d8596955"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("4da2eaf6-aa1b-48bc-96fe-b316cc9d0664"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("131a22b7-a35b-4836-b98f-ba92c117dd58"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("eb4ceb26-42b8-426e-850a-5d3c4ed8f1f2"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("7f00ec96-0615-4693-9dc4-393b745c86ff"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("67cf439e-af2b-42e2-9354-453b068e8518"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("0b7280f5-d744-4c21-9666-14b77f656a78"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("aebd4c37-ab18-4079-b46e-0bd51c2ac0fc"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("dc461ca0-4efe-4d06-bb48-c6d3bea9568e"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("3ccb28e1-cee1-4bfb-98bd-e237ddfc6b2a"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("5fbb9bc2-b1e4-4ad8-a561-f2d1d27d99c7"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("19f2ff0b-9242-492a-8ac4-d25b5bc83485"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("fca92a38-ca5c-4fce-9b36-0bedd2c88b7a"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("ca9bac5a-2ea6-4993-83a5-3019d3c69e0e"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("13413076-1b3e-497b-ad82-ecffe827d0e8"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("633a173a-e088-4f67-baa4-d54d9fcaf372"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("b8b5c174-8177-4581-b08a-9ca7e396de01"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("9d81a1e2-75ab-45e8-aff9-518e296506fe"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("0f8923f0-aff5-4fd8-a353-c8711a95147a"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("c0a52209-88fc-43b4-a18a-0f7c355be358"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("3066f9c8-5ed4-4323-9a81-aa743f22f2c9"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("ebd9e224-68dc-430d-97d0-423c8edc08c3"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("b26eb9de-693b-458f-a097-a09cf4d3986b"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("3b5bbacd-ae24-428e-b761-1bb3e69eac86"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("e63af662-9ac9-44f0-9510-369a91de10bd"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("89cd9c40-a898-4963-a9d1-462e42d29544"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("aaf9d371-80d9-4b2a-ac52-f89158b0a72a"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("2d12ac68-776d-429b-84c4-1df8a8219783"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("b851cb1b-65f1-4f98-9517-065bb260c8af"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("89c03137-771a-4e96-9d16-b7ee922a6254"), "Tested", "A+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("4387a009-1cb8-42e4-a381-664148ad60cb"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("4f178ae6-39af-4473-97e9-6a5c527835fc"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("02073c12-a394-45d5-b5cc-9dcf0c9dfe44"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("0060d4c5-666f-44e2-b37c-9af7c55c903b"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("2a128f8a-39e0-4d98-97fc-1e9187647f83"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("6259a366-1545-43ca-9cd4-3b600aa1af62"), "Tested", "A-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("9f005150-6488-4502-be1e-9de513f7a14f"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("3c196d77-a88d-4e0a-90b0-898fd2e86139"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("73c67d3b-4af4-42af-8616-cacb506c32aa"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("d0076034-e326-45a0-83ea-a7aacc778b23"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("4f9bd1fe-a71b-49ef-b1bc-d71c734e466e"), "Tested", "AB-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("cd73679f-48c9-4294-ba71-fb18b56541b9"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("4daccae5-1055-4fcd-a18f-9f1cbb467099"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("a88d6800-0bd3-4e43-baf1-866b2b66e9a0"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("91c5ec4b-771b-4ce5-9c82-30805252b9aa"), "Tested", "AB+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("389497d5-53c6-4c24-bb69-03d3249932c9"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("6ca17520-8b72-4f9a-b487-a6356416ca03"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("7087d36d-cddf-4d32-94cb-e442dc6304e6"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("33715b66-8b00-4cd5-9b43-c4d7d440c98d"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("579e2d94-ff75-4bcf-9d99-abc70855c641"), "Tested", "B-", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("dea536ca-2424-4866-93ad-d1c0057dad46"), "Tested", "B+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" },
                    { new Guid("71f21ed9-8d5c-4ba5-8612-3d2cc0e4c3c5"), "Tested", "O+", "11/10/2019 5:16:50 AM", "initial hospital donor", "Hospital" }
                });

            migrationBuilder.InsertData(
                table: "settings",
                columns: new[] { "settingId", "settingType", "settingValue" },
                values: new object[] { new Guid("17315d9b-143f-40a0-96cf-104a63c755bc"), "Threshold", 0 });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("0060d4c5-666f-44e2-b37c-9af7c55c903b"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("02073c12-a394-45d5-b5cc-9dcf0c9dfe44"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("0a920e06-474e-4992-a0c0-4d493878920f"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("0b0e4d7d-2a99-4ac6-89da-de2a081c533c"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("0b7280f5-d744-4c21-9666-14b77f656a78"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("0ee0eb89-7225-419c-adeb-0944aa0f8962"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("0f8923f0-aff5-4fd8-a353-c8711a95147a"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("131a22b7-a35b-4836-b98f-ba92c117dd58"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("13413076-1b3e-497b-ad82-ecffe827d0e8"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("185d2c2a-735a-452a-9935-83bd9616148d"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("19f2ff0b-9242-492a-8ac4-d25b5bc83485"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("1cc7d6d1-3f2a-46a1-8756-9aeb72c60b16"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("21e7f537-be00-4a58-b2ae-bead444c0d56"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("22397977-c0b8-4570-b558-611ad295ac7a"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("267076c1-6df1-497c-9fe7-f332c88a9e61"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("286d2b4a-0cd6-41ea-b362-35f40f00aad6"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("2a128f8a-39e0-4d98-97fc-1e9187647f83"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("2cb82ac8-d9d6-4e78-a711-beb5ce7f78ed"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("2d12ac68-776d-429b-84c4-1df8a8219783"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("2e67f31b-79e4-4164-bd91-366a08b83879"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("3066f9c8-5ed4-4323-9a81-aa743f22f2c9"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("33715b66-8b00-4cd5-9b43-c4d7d440c98d"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("34ba7bd1-f3ba-4441-aa82-ca5fb23e9384"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("389497d5-53c6-4c24-bb69-03d3249932c9"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("3b5bbacd-ae24-428e-b761-1bb3e69eac86"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("3c196d77-a88d-4e0a-90b0-898fd2e86139"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("3ccb28e1-cee1-4bfb-98bd-e237ddfc6b2a"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("4387a009-1cb8-42e4-a381-664148ad60cb"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("46e9ac39-17bd-405b-8ee3-110493f3b7c5"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("49302b16-7afc-4c04-ade3-177738a760e1"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("49705eba-5060-4a47-8234-c7167c25dee9"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("4d7631e3-ae09-4e6c-8afc-002f9fa6a5cb"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("4da2eaf6-aa1b-48bc-96fe-b316cc9d0664"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("4daccae5-1055-4fcd-a18f-9f1cbb467099"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("4dfb0f6c-7d04-4f41-aac4-dc01a1d4baf3"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("4f178ae6-39af-4473-97e9-6a5c527835fc"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("4f9bd1fe-a71b-49ef-b1bc-d71c734e466e"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("51ccadf0-6a21-43b2-907e-d33a863d7f40"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("579e2d94-ff75-4bcf-9d99-abc70855c641"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("5fbb9bc2-b1e4-4ad8-a561-f2d1d27d99c7"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("6259a366-1545-43ca-9cd4-3b600aa1af62"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("633a173a-e088-4f67-baa4-d54d9fcaf372"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("67cf439e-af2b-42e2-9354-453b068e8518"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("687bf522-33e2-4caf-9b29-a025c2317e82"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("6951e028-b61d-42cc-9e7d-7f551d6313a9"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("6a2935e7-7170-4abc-a52b-9522527e97ed"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("6b654831-314e-48e7-a4e2-055f7f51fb79"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("6ca17520-8b72-4f9a-b487-a6356416ca03"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("6fc2a258-1fc5-464a-a811-47521d8081ea"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("7087d36d-cddf-4d32-94cb-e442dc6304e6"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("709dd211-b13d-49a2-947c-da295792e206"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("70e6f677-6c45-4c97-a9e9-2381a0d835a3"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("71f21ed9-8d5c-4ba5-8612-3d2cc0e4c3c5"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("73c67d3b-4af4-42af-8616-cacb506c32aa"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("73f17d35-0304-4e0d-aa27-27921744231f"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("74486e5d-be0d-4013-a9cc-da18fb105d64"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("75c62a66-d14d-4bb7-ae6d-2fc834523922"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("7e5ef537-14be-4eb9-8f2f-faa0b01d4797"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("7f00ec96-0615-4693-9dc4-393b745c86ff"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("8324b981-0b7b-427f-bb9e-a6660b8ff54e"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("8344c260-7873-4271-94c6-a2470eed7540"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("8938f70f-badd-44d9-bdf2-6d31fa3c569e"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("89c03137-771a-4e96-9d16-b7ee922a6254"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("89cd9c40-a898-4963-a9d1-462e42d29544"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("91c5ec4b-771b-4ce5-9c82-30805252b9aa"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("93fff5c7-7707-416e-b380-f885c4bc933b"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("9b96768d-928b-4cb1-adb9-9362723a3f5b"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("9d81a1e2-75ab-45e8-aff9-518e296506fe"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("9f005150-6488-4502-be1e-9de513f7a14f"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("9f498bd1-e661-4211-9865-4305c69b470d"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("a88d6800-0bd3-4e43-baf1-866b2b66e9a0"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("aaf9d371-80d9-4b2a-ac52-f89158b0a72a"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("aebd4c37-ab18-4079-b46e-0bd51c2ac0fc"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("b0398970-478d-46f9-9927-be10c4bd2880"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("b17097bc-7388-4150-b00a-00464a85b4e4"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("b26eb9de-693b-458f-a097-a09cf4d3986b"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("b51d8da4-81f7-41ce-a542-c0f2b63cb634"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("b851cb1b-65f1-4f98-9517-065bb260c8af"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("b8b5c174-8177-4581-b08a-9ca7e396de01"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("c0a52209-88fc-43b4-a18a-0f7c355be358"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("c5c301cd-f0d8-4bd4-af86-575d2a716970"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("c8c3e071-994e-43aa-8dce-93535e37ca30"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("ca9bac5a-2ea6-4993-83a5-3019d3c69e0e"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("cd73679f-48c9-4294-ba71-fb18b56541b9"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("d0076034-e326-45a0-83ea-a7aacc778b23"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("d2ee396d-b92b-48eb-a2a0-798bf6b5d2bf"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("d5cfde5a-0985-4c6c-8897-18e4cffe5bcf"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("d7450b1b-92f2-4c39-8632-178ba426d979"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("dc461ca0-4efe-4d06-bb48-c6d3bea9568e"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("dea536ca-2424-4866-93ad-d1c0057dad46"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("dfa96d36-3806-4b26-b740-b2bf0341a86b"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("e56594b5-1acc-4720-8fe3-23c31fc7f6ba"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("e63af662-9ac9-44f0-9510-369a91de10bd"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("e7bec5af-b043-44b1-9710-2e577b1a88c4"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("eb4ceb26-42b8-426e-850a-5d3c4ed8f1f2"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("ebd9e224-68dc-430d-97d0-423c8edc08c3"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("ee66084b-7fb4-434b-9708-0ed949856053"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("f3356e5f-b10a-4333-8d1b-d601d8596955"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("f88565d2-1b85-460b-b123-972ec15df189"));

            migrationBuilder.DeleteData(
                table: "bloodInventory",
                keyColumn: "bloodId",
                keyValue: new Guid("fca92a38-ca5c-4fce-9b36-0bedd2c88b7a"));

            migrationBuilder.DeleteData(
                table: "settings",
                keyColumn: "settingId",
                keyValue: new Guid("17315d9b-143f-40a0-96cf-104a63c755bc"));
        }
    }
}
