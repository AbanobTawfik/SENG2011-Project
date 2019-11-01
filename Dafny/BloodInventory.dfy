include "Blood.dfy"
class BloodInventory
{
    var bloodInventory: array<Blood>;
    ghost var shadowBloodInventory: seq<string>;
    var threshold: int;
    var alert: bool;

    predicate Valid()
    requires bloodInventory != null
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    reads this, this`shadowBloodInventory, this.bloodInventory, set i | 0 <= i < bloodInventory.Length :: bloodInventory[i]
    {
        |shadowBloodInventory| == bloodInventory.Length &&
        forall i :: 0 <= i < |shadowBloodInventory| ==> validBloodType(shadowBloodInventory[i]) && 
        forall i  :: 0 <= i < |shadowBloodInventory| ==> shadowBloodInventory[i] == bloodInventory[i].GetBloodType() && 
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["A+"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["A-"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["B+"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["B-"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["O+"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["O-"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["AB+"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["AB-"])
    } 

    method AddBlood(blood: Blood) returns (b: bool)
    modifies this, this`threshold, this`shadowBloodInventory, this.bloodInventory
    requires bloodInventory != null
    requires blood != null
    requires validBloodType(blood.GetBloodType())
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    ensures bloodInventory.Length == old(bloodInventory.Length) + 1
    ensures forall i :: 0 <= i < old(bloodInventory.Length) ==> (bloodInventory[i] == old(bloodInventory[i]))
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

} // end of BloodInventory class

predicate validBloodType(bloodType: string)
{
        bloodType == "A+" || bloodType == "A-" || bloodType == "B+" || bloodType == "B-" ||
        bloodType == "O+" || bloodType == "O-" || bloodType == "AB+" || bloodType == "AB-"
}