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
    reads this, this.bloodInventory
    requires bloodInventory != null
    requires indexToCountTo < bloodInventory.Length
    requires validBloodType(bloodType)
    {
        if indexToCountTo < 0 || bloodInventory[indexToCountTo] == null
        then 
            0
        else
            if bloodInventory[indexToCountTo].GetBloodType() == bloodType
            then
                1 + GetBloodCountForBloodTypeVerification(bloodType, indexToCountTo - 1)
            else
                GetBloodCountForBloodTypeVerification(bloodType, indexToCountTo - 1)

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
    ensures count == GetBloodCountForBloodTypeVerification(bloodType, bloodInventory.Length - 1)
    requires Valid() ensures Valid()
    {
        count := 0;
        var i := 0;

        while i < bloodInventory.Length
        invariant 0 <= i <= bloodInventory.Length
        invariant count == GetBloodCountForBloodTypeVerification(bloodType, i - 1)
        {
            if(bloodInventory[i].GetBloodType() == bloodType)
            {
                count := count + 1;
            }
            i := i + 1;
        }
    }

    function GetSizeVerificaiton(): int
    requires bloodInventory != null
    reads this, this.bloodInventory
    {
        bloodInventory.Length
    }

    function GetArrayVerification(): array<Blood>
    reads this
    {
        bloodInventory
    }

    method GetSize() returns (count: int)
    requires bloodInventory != null
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures bloodInventory != null
    ensures forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures count == bloodInventory.Length
    requires Valid() ensures Valid()
    {
        count := bloodInventory.Length;
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

    method removeBlood(bloodType: string) returns (blood: Blood, indexOfRemoval: int)
    modifies this, this.bloodInventory
    requires bloodInventory != null
    requires bloodInventory.Length > 0
    requires |shadowBloodInventory| > 0
    requires validBloodType(bloodType)
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    requires exists i :: 0 <= i < bloodInventory.Length && bloodInventory[i].GetBloodType() == bloodType
    ensures bloodInventory != null 
    ensures forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures blood == null ==> !(exists i :: 0 <= i < bloodInventory.Length && bloodInventory[i].GetBloodType() == bloodType)
    ensures blood == null ==> bloodInventory.Length == old(bloodInventory.Length) 
    ensures blood == null ==> indexOfRemoval == -1
    ensures blood != null ==> bloodInventory.Length == old(bloodInventory.Length) - 1
    ensures blood != null ==> blood.GetBloodType() == bloodType
    ensures blood != null && (0 <= indexOfRemoval < bloodInventory.Length) ==> shadowBloodInventory == old(shadowBloodInventory)[..indexOfRemoval] + old(shadowBloodInventory)[indexOfRemoval + 1..]
    ensures blood != null && (0 <= indexOfRemoval < bloodInventory.Length) ==> ((forall i :: 0 <= i < indexOfRemoval ==> bloodInventory[i] == old(bloodInventory[i])) && 
                                                                               (forall i :: indexOfRemoval < i < bloodInventory.Length ==> bloodInventory[i - 1] == old(bloodInventory[i])))
    // neeed to fix this to explain what happens to the array
    // ensures forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] == old(bloodInventory[i]))
    // ensures shadowBloodInventory == old(shadowBloodInventory)[0..|old(shadowBloodInventory)| - 1]
    requires Valid() ensures Valid()
    {
        blood := null;
        indexOfRemoval := -1;
        var removedFromInventory : array<Blood> := new Blood[bloodInventory.Length - 1];
        var i := 0;        
        while i < bloodInventory.Length
        invariant 0 <= i <= bloodInventory.Length
        invariant forall j :: 0 <= j < i ==> (bloodInventory[j].GetBloodType() != bloodType) 
        {
            if(bloodInventory[i].GetBloodType() == bloodType)
            {
                // we will remove it from the array
                shadowBloodInventory := shadowBloodInventory[..i] + shadowBloodInventory[i+1..];
                blood := bloodInventory[i];
                indexOfRemoval := i;
                var addLower := 0;
                var addUpper := i;
                forall k | 0 <= k < i 
                {
                    removedFromInventory[k] := bloodInventory[k];
                }
                forall k | i < k < bloodInventory.Length 
                {
                    removedFromInventory[k - 1] := bloodInventory[k];
                }
                bloodInventory := removedFromInventory;
                return;
            }
            i := i + 1;
        }

    }

} // end of BloodInventory class

predicate validBloodType(bloodType: string)
{
        bloodType == "A+" || bloodType == "A-" || bloodType == "B+" || bloodType == "B-" ||
        bloodType == "O+" || bloodType == "O-" || bloodType == "AB+" || bloodType == "AB-"
}