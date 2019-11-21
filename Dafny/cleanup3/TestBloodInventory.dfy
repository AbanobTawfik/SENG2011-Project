
include "BloodInventory.dfy"

////////////////////////////////////////////////////////////////////////////////
// Blackbox tests for AddBlood

// method TestAddBlood()
// {
//     var inv := new BloodInventory();
//     var amt;
    
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 0;
//     amt := inv.GetBloodTypeCount(AM);
//     assert amt == 0;

//     var blood1 := new Blood(AP, "Bob",      5, "Hospital A");
//     inv.AddBlood(blood1);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(AM);
//     assert amt == 0;

//     var blood2 := new Blood(BP, "Rason",    2, "Hospital B");
//     inv.AddBlood(blood2);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(AM);
//     assert amt == 0;

//     var blood3 := new Blood(AP, "Michael", 10, "Hospital C");
//     inv.AddBlood(blood3);
//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 2;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(AM);
//     assert amt == 0;
// }

////////////////////////////////////////////////////////////////////////////////
// Blackbox tests for RemoveExpiredBlood
// Warning: They take a long time to verify, even with just two Blood objects...

// method TestRemoveExpiredBlood1()
// {
//     var inv := new BloodInventory();
//     var amt;

//     var blood1 := new Blood(AP, "Bob",   1, "Hospital A");
//     inv.AddBlood(blood1);
//     var blood2 := new Blood(AP, "Rason", 2, "Hospital B");
//     inv.AddBlood(blood2);

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


// method TestRemoveExpiredBlood6()
// {
//     var inv := new BloodInventory();

//     var blood1 := new Blood(AP, "Bob",   1, "Hospital A");
//     inv.AddBlood(blood1);
//     var blood2 := new Blood(BP, "Rason", 2, "Hospital B");
//     inv.AddBlood(blood2);

//     inv.Show();
//     inv.RemoveExpiredBlood(44);
//     inv.Show();
// }

////////////////////////////////////////////////////////////////////////////////
// Blackbox tests for RequestOneType
// Note: This test took 8-9 minutes to verify on CSE Dafny 1.9.7.

// method TestRequestOneType()
// {
//     var inv := new BloodInventory();
//     var amt;

//     var blood1 := new Blood(AP, "Bob",     1, "Hospital A");
//     inv.AddBlood(blood1);
//     var blood2 := new Blood(AP, "Rason",   1, "Hospital A");
//     inv.AddBlood(blood2);
//     var blood3 := new Blood(AP, "Michael", 1, "Hospital A");
//     inv.AddBlood(blood3);
//     var blood4 := new Blood(BP, "Lucas",   1, "Hospital A");
//     inv.AddBlood(blood4);
//     var blood5 := new Blood(BP, "Kevin",   1, "Hospital A");
//     inv.AddBlood(blood5);
//     var blood6 := new Blood(BP, "John",    1, "Hospital A");
//     inv.AddBlood(blood6);
//     var blood7 := new Blood(BP, "Andrew",  1, "Hospital A");
//     inv.AddBlood(blood7);

//     var req1 := Request(AP, 2);
//     var res1 := inv.RequestOneType(req1);
//     assert res1[..] == [blood1, blood2];

//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 4;
//     amt := inv.GetBloodTypeCount(OP);
//     assert amt == 0;

//     var req2 := Request(BP, 1);
//     var res2 := inv.RequestOneType(req2);
//     assert res2[..] == [blood4];

//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 3;
//     amt := inv.GetBloodTypeCount(OP);
//     assert amt == 0;

//     var req3 := Request(BP, 3);
//     var res3 := inv.RequestOneType(req3);
//     assert res3[..] == [blood5, blood6, blood7];

//     amt := inv.GetBloodTypeCount(AP);
//     assert amt == 1;
//     amt := inv.GetBloodTypeCount(BP);
//     assert amt == 0;
//     amt := inv.GetBloodTypeCount(OP);
//     assert amt == 0;
// }

////////////////////////////////////////////////////////////////////////////////
// Blackbox tests for RequestBatch

