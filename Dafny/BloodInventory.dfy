include "Blood.dfy"
class BloodInventory
{
    var bloodInventory: array<Blood>;
    ghost var shadowBloodInventory: array<string>;
    var threshold: int;
    var alert: bool;

    predicate Valid()
    requires shadowBloodInventory != null
    requires bloodInventory != null
    requires forall i :: 0 <= i < bloodInventory.Length ==> (bloodInventory[i] != null)
    reads this, this.shadowBloodInventory, this.bloodInventory, set i | 0 <= i < bloodInventory.Length :: bloodInventory[i]
    {
        shadowBloodInventory.Length == bloodInventory.Length &&
        forall i :: 0 <= i < shadowBloodInventory.Length ==> validBloodType(shadowBloodInventory[i]) && 
        forall i  :: 0 <= i < shadowBloodInventory.Length ==> shadowBloodInventory[i] == bloodInventory[i].GetDonorName() && 
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["A+"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["A-"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["B+"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["B-"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["O+"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["O-"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["AB+"]) &&
        alert ==> (threshold >= multiset(shadowBloodInventory[..])["AB-"])
    } 

} // end of BloodInventory class

predicate validBloodType(bloodType: string)
{
        bloodType == "A+" || bloodType == "A-" || bloodType == "B+" || bloodType == "B-" ||
        bloodType == "O+" || bloodType == "O-" || bloodType == "AB+" || bloodType == "AB-"
}