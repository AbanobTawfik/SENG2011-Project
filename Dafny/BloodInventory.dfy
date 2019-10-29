include "Blood.dfy"
class BloodInventory
{
    var bloodInventory: array<Blood>;
    var threshold: int;
    var alert: bool;

    predicate Valid()
    reads this
    requires bloodInventory != null
    {
        alert ==> (threshold >= CountByBloodType("A+")) 
    } 

    function CountByBloodType(bloodType:string): int
    requires bloodInventory != null
    reads this
    ensures CountByBloodType(bloodType) == CheckIndexForBloodType(bloodType,  bloodInventory.Length - 1)
    {
        CheckIndexForBloodType(bloodType,  bloodInventory.Length - 1)
    }

    function CheckIndexForBloodType(bloodType: string, index: int): int
    requires bloodInventory != null
    requires index < bloodInventory.Length
    reads this
    decreases index
    ensures (index < 0) ==> (CheckIndexForBloodType(bloodType, index) == 0)
    // ensures (index >= 0 && (bloodInventory[index].GetBloodType() == bloodType)) ==> (CheckIndexForBloodType(bloodType, index) == CheckIndexForBloodType(bloodType, index - 1) + 1) 
    // ensures (index >= 0 && (bloodInventory[index].GetBloodType() != bloodType)) ==> (CheckIndexForBloodType(bloodType, index) == CheckIndexForBloodType(bloodType, index - 1)) 
    {
        if index < 0 
        then
            0
        else
            if bloodInventory[index].GetBloodType() == bloodType
            then
                CheckIndexForBloodType(bloodType, index - 1) + 1
            else
                CheckIndexForBloodType(bloodType, index - 1)
    }
} // end of BloodInventory class