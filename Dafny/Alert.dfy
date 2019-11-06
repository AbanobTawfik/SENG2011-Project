include "BloodInventory.dfy"
class Alert
{
    method CheckForAlert(threshold: int, countForBloodType: int) returns (alert: bool)
    ensures alert == (threshold >= countForBloodType)
    {
        alert := (threshold >= countForBloodType);
    }
} // end of Alert class