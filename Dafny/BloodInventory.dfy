include "Blood.dfy"
class BloodInventory
{
    var bloodInventory: array<Blood>;
    var threshold: int;
    var alert: bool;

    predicate Valid()
    requires bloodInventory != null
    reads this, this.bloodInventory, set i | 0 <= i < bloodInventory.Length :: bloodInventory[i] 

    {
        alert ==> (threshold >= CountByBloodType("A+")) 
    } 

    function CountByBloodType(bloodType:string): int
    requires bloodInventory != null
    reads this, this.bloodInventory, set i | 0 <= i < bloodInventory.Length :: bloodInventory[i] 
    // ensures CountByBloodType(bloodType) == CheckIndexForBloodType(bloodType,  bloodInventory.Length - 1)
    {
        CheckIndexForBloodType(bloodType,  bloodInventory.Length - 1)
    }

    function CheckIndexForBloodType(bloodType: string, index: int): int
    requires bloodInventory != null
    requires 0 <= index < bloodInventory.Length
    requires bloodInventory[index] != null
    requires (bloodInventory[index].GetBloodType() == "A+" || bloodInventory[index].GetBloodType() == "A-" || bloodInventory[index].GetBloodType() == "B+" || bloodInventory[index].GetBloodType() == "B-" ||
              bloodInventory[index].GetBloodType() == "O+" || bloodInventory[index].GetBloodType() == "O-" || bloodInventory[index].GetBloodType() == "AB+" || bloodInventory[index].GetBloodType() == "AB-")
    reads this, this.bloodInventory, set i | 0 <= i < bloodInventory.Length :: bloodInventory[i] 
    decreases index
    // ensures (index < 0) ==> (CheckIndexForBloodType(bloodType, index) == 0)
    // ensures (index >= 0 && (bloodInventory[index].GetBloodType() == bloodType)) ==> (CheckIndexForBloodType(bloodType, index) == CheckIndexForBloodType(bloodType, index - 1) + 1) 
    // ensures (index >= 0 && (bloodInventory[index].GetBloodType() != bloodType)) ==> (CheckIndexForBloodType(bloodType, index) == CheckIndexForBloodType(bloodType, index - 1)) 
    {
        if index == 0 
        then
            if bloodInventory[index].GetBloodType() == bloodType
            then
                1
            else
                0
        else
            if bloodInventory[index].GetBloodType() == bloodType
            then
                CheckIndexForBloodType(bloodType, index - 1) + 1
            else
                CheckIndexForBloodType(bloodType, index - 1)
    }
} // end of BloodInventory class