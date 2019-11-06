include "BloodInventory.dfy"
class Alert
{
    var alertOn: bool

    predicate Valid()
    reads this
    {
        true
    }

    constructor()
    modifies this
    ensures !alertOn
    ensures Valid()
    {
        alertOn := false;
    }

    method CheckForAlert(threshold: int, countForBloodType: int) returns (alert: bool)
    ensures alert == (threshold >= countForBloodType)
    {
        alert := (threshold >= countForBloodType);
    }

    method FixAlertState(bloodInventory: BloodInventory, bloodType: string)
    requires bloodInventory != null
    requires bloodInventory.GetArrayVerification() != null
    requires bloodInventory.VerifyLengths()
    requires forall i :: 0 <= i < bloodInventory.GetArrayVerification().Length ==> (bloodInventory.GetArrayVerification()[i] != null)
    requires forall i :: 0 <= i < bloodInventory.GetArrayVerification().Length ==> (validBloodType(bloodInventory.GetArrayVerification()[i].GetBloodType()))
    requires forall i :: 0 <= i < bloodInventory.GetArrayVerification().Length ==> (bloodInventory.GetArrayVerification()[i].GetBloodType() == bloodInventory.GetShadowArray()[i])
    ensures bloodInventory !=  null
    ensures bloodInventory.GetArrayVerification() !=  null
    requires validBloodType(bloodType)
    ensures validBloodType(bloodType)
    ensures bloodInventory.GetThreshold() < bloodInventory.GetBloodCountForBloodTypeVerification(bloodType, bloodInventory.GetArrayVerification().Length - 1)
    {
        var currentCount := bloodInventory.GetBloodCountForBloodTypeExecution(bloodType);
        var threshold := bloodInventory.GetThreshold();
        var sizeOfInventory := bloodInventory.GetSize();
        while currentCount < threshold
        invariant currentCount <= threshold
        invariant bloodInventory.GetBloodCountForBloodTypeVerification(bloodType, sizeOfInventory) == threshold - (threshold - currentCount)
        {
            var emergencyDonor := new Blood(bloodType, "EMERGENCY DONOR", 0);
            var  check := bloodInventory.AddBlood(emergencyDonor);
            currentCount := currentCount + 1;
        }
    }
} // end of Alert class