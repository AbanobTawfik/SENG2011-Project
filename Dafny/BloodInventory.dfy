include "Blood.dfy"
class BloodInventory
{
    var bloodInventory: array<Blood>;
    var threshold: int;
    var alert: bool;

    predicate Valid()
    reads this
    {
        
    } 
} // end of BloodInventory class