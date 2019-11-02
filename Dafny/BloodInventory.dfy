include "Blood.dfy"
class BloodInventory
{
    var bloodInventory: array<Blood>;
    ghost var shadowBloodInventory: seq<string>;
    var threshold: int;

    predicate Valid()
    requires bloodInventory != null
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    reads this, this`shadowBloodInventory, this.bloodInventory, set i | 0 <= i < bloodInventory.Length :: bloodInventory[i]
    {
        |shadowBloodInventory| == bloodInventory.Length &&
        forall i :: 0 <= i < |shadowBloodInventory| ==> validBloodType(shadowBloodInventory[i]) && 
        forall i  :: 0 <= i < |shadowBloodInventory| ==> shadowBloodInventory[i] == bloodInventory[i].GetBloodType()
    } 

    constructor()
    modifies this
    ensures bloodInventory != null
    ensures forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures shadowBloodInventory == []
    ensures fresh(bloodInventory)
    ensures bloodInventory.Length == 0
    ensures threshold == 0
    ensures Valid()
    {
        bloodInventory := new Blood[0];
        shadowBloodInventory := [];
        threshold := 0;
    }

    method ModifyThreshold(newThreshold: int)
    modifies this`threshold
    requires newThreshold >= 0
    requires bloodInventory != null
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures bloodInventory != null
    ensures forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures threshold == newThreshold
    requires Valid() ensures Valid()
    {
        threshold := newThreshold;
    }

    function GetBloodCountForBloodTypeVerification(bloodType: string, indexToCountTo: int ): int
    reads this
    requires  0 <= indexToCountTo <= |shadowBloodInventory|
    requires validBloodType(bloodType)
    {
        multiset(shadowBloodInventory[0..indexToCountTo])[bloodType]
    }

    method GetBloodCountForBloodTypeExecution(bloodType: string) returns (count: int)
    requires validBloodType(bloodType)
    requires bloodInventory != null
    requires bloodInventory.Length == |shadowBloodInventory|
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i].GetBloodType() == shadowBloodInventory[i])
    ensures bloodInventory != null
    ensures forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures bloodInventory == old(bloodInventory)
    ensures count == GetBloodCountForBloodTypeVerification(bloodType, bloodInventory.Length)
    requires Valid() ensures Valid()
    {
        count := 0;
        var i := 0;

        while i < bloodInventory.Length
        invariant 0 <= i <= bloodInventory.Length
        invariant count == GetBloodCountForBloodTypeVerification(bloodType, i)
        {
            if(bloodInventory[i].GetBloodType() == bloodType)
            {
                count := count + 1;
            }
            i := i + 1;
        }
    }

    method AddBlood(blood: Blood) returns (b: bool)
    modifies this, this.bloodInventory
    requires bloodInventory != null
    requires blood != null
    requires validBloodType(blood.GetBloodType())
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures bloodInventory != null
    ensures forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures bloodInventory.Length == old(bloodInventory.Length) + 1
    ensures forall i :: 0 <= i < old(bloodInventory.Length) ==> (bloodInventory[i] == old(bloodInventory[i]))
    ensures shadowBloodInventory == old(shadowBloodInventory) + [blood.GetBloodType()]
    ensures bloodInventory[old(bloodInventory.Length)] == blood
    requires Valid() ensures Valid()
    {
        var addedToInventory: array<Blood> := new Blood[bloodInventory.Length + 1];
        forall i | 0 <= i < bloodInventory.Length
        {
            addedToInventory[i] := bloodInventory[i];
        }
        // add the new blood to the inventory
        addedToInventory[bloodInventory.Length] := blood;
        bloodInventory := addedToInventory;
        shadowBloodInventory := shadowBloodInventory + [blood.GetBloodType()];
    }

    method removeBlood(bloodType: string) returns (b: bool)
    modifies this, this.bloodInventory
    requires bloodInventory != null
    requires bloodInventory.Length > 0
    requires |shadowBloodInventory| > 0
    requires validBloodType(bloodType)
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures bloodInventory != null 
    ensures forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures bloodInventory.Length == old(bloodInventory.Length) - 1
    ensures forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] == old(bloodInventory[i]))
    ensures shadowBloodInventory == old(shadowBloodInventory)[0..|old(shadowBloodInventory)| - 1]
    requires Valid() ensures Valid()
    {
        var removedFromInventory : array<Blood> := new Blood[bloodInventory.Length - 1];
        forall i | 0 <= i < bloodInventory.Length - 1
        {
            removedFromInventory[i] := bloodInventory[i];
        }
        bloodInventory := removedFromInventory; 
        shadowBloodInventory := shadowBloodInventory[0..|shadowBloodInventory| - 1];
    }

} // end of BloodInventory class

predicate validBloodType(bloodType: string)
{
        bloodType == "A+" || bloodType == "A-" || bloodType == "B+" || bloodType == "B-" ||
        bloodType == "O+" || bloodType == "O-" || bloodType == "AB+" || bloodType == "AB-"
}