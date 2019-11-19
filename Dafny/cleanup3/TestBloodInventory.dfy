
include "BloodInventory.dfy"

////////////////////////////////////////////////////////////////////////////////
// Testing RemoveExpiredBlood

// method TestRemoveExpiredBlood1()
// {
//     var inv := new BloodInventory();
//     var amt;

//     var blood1 := new Blood(AP, "Bob",   1, "Hospital A");
//     inv.AddBlood(blood1);
//     var blood2 := new Blood(AP, "Rason", 2, "Hospital B");
//     inv.AddBlood(blood2);
//     // it will take a very long time to verify if you add more

//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 2;

//     inv.RemoveExpiredBlood(44);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
// }

// method TestRemoveExpiredBlood2()
// {
//     var inv := new BloodInventory();
//     var amt;

//     var blood1 := new Blood(AP, "Bob",   1, "Hospital A");
//     inv.AddBlood(blood1);
//     var blood2 := new Blood(AP, "Rason", 1, "Hospital B");
//     inv.AddBlood(blood2);
//     // it will take a very long time to verify if you add more

//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 2;

//     inv.RemoveExpiredBlood(44);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 0;
// }

// method TestRemoveExpiredBlood3()
// {
//     var inv := new BloodInventory();
//     var amt;

//     var blood1 := new Blood(AP, "Bob",   1, "Hospital A");
//     inv.AddBlood(blood1);
//     var blood2 := new Blood(AP, "Rason", 1, "Hospital B");
//     inv.AddBlood(blood2);
//     // it will take a very long time to verify if you add more

//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 2;

//     inv.RemoveExpiredBlood(2);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 2;
// }

// method TestRemoveExpiredBlood4()
// {
//     var inv := new BloodInventory();
//     var amt;

//     var blood1 := new Blood(AP, "Bob",   1, "Hospital A");
//     inv.AddBlood(blood1);
//     var blood2 := new Blood(BP, "Rason", 2, "Hospital B");
//     inv.AddBlood(blood2);
//     // it will take a very long time to verify if you add more

//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 1;

//     inv.RemoveExpiredBlood(44);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 0;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 1;
// }

// method TestRemoveExpiredBlood5()
// {
//     var inv := new BloodInventory();
//     var amt;

//     var blood1 := new Blood(AP, "Bob",   1, "Hospital A");
//     inv.AddBlood(blood1);
//     var blood2 := new Blood(BP, "Rason", 1, "Hospital B");
//     inv.AddBlood(blood2);
//     // it will take a very long time to verify if you add more

//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 1;

//     inv.RemoveExpiredBlood(44);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 0;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 0;
// }

////////////////////////////////////////////////////////////////////////////////

// method TestAddBlood()
// {
//     var inv := new BloodInventory();
//     var amt;
    
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 0;
//     amt := inv.GetBloodTypeCount(AM);
//     assert amt == 0;

//     var blood1 := new Blood(AP, "Bob",  5, "Prince of Wales Hospital");
//     inv.AddBlood(blood1);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(AM);
//     assert amt == 0;

//     var blood2 := new Blood(BP, "Michael", 2, "Royal North Shore Hospital");
//     inv.AddBlood(blood2);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(AM);
//     assert amt == 0;

//     var blood3 := new Blood(AP, "Lucas", 10, "Westmead Hospital");
//     inv.AddBlood(blood3);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 2;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(AM);
//     assert amt == 0;
// }
