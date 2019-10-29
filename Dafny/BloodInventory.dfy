include "Blood.dfy"
class BloodInventory
{
    var bloodInventory: array<Blood>;
    var bloodInventoryCover: array<string>;
    var threshold: int;
    var alert: bool;

    predicate Valid()
    reads this
    requires bloodInventoryCover != null
    {
        alert ==> (threshold >= CountByBloodType("A+")) 
    } 

    // function CountByBloodType(bloodType:string): int
    // requires bloodInventoryCover != null
    // reads this
    // ensures CountByBloodType(bloodType) == CheckIndexForBloodType(bloodType,  bloodInventoryCover.Length - 1)
    // {
    //     CheckIndexForBloodType(bloodType,  bloodInventoryCover.Length - 1)
    // }

    // function CheckIndexForBloodType(bloodType: string, index: int): int
    // requires bloodInventoryCover != null
    // requires index < bloodInventoryCover.Length
    // reads this
    // decreases index
    // ensures (index < 0) ==> (CheckIndexForBloodType(bloodType, index) == 0)
    // ensures (index >= 0 && (bloodInventoryCover[index] == bloodType)) ==> (CheckIndexForBloodType(bloodType, index) == CheckIndexForBloodType(bloodType, index - 1) + 1) 
    // ensures (index >= 0 && (bloodInventoryCover[index] != bloodType)) ==> (CheckIndexForBloodType(bloodType, index) == CheckIndexForBloodType(bloodType, index - 1)) 
    // {
    //     if index < 0 
    //     then
    //         0
    //     else
    //         if bloodInventoryCover[index] == bloodType
    //         then
    //             CheckIndexForBloodType(bloodType, index - 1) + 1
    //         else
    //             CheckIndexForBloodType(bloodType, index - 1)
    // }
} // end of BloodInventory class