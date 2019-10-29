include "Blood.dfy"
class BloodInventory
{
    var bloodInventory: array<Blood>;
    ghost var shadowBloodInventory: array<string>;
    var threshold: int;
    var alert: bool;

    predicate Valid()
    requires shadowBloodInventory != null
    reads this, this.shadowBloodInventory
    {
        forall i :: 0 <= i < shadowBloodInventory.Length ==> validBloodType(shadowBloodInventory[i]) && 
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