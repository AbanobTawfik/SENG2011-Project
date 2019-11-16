
class Alert
{
    var alertOn: bool

    predicate Valid()
        reads this;
    {
        true
    }

    constructor()
        modifies this;
        ensures !alertOn;
        ensures Valid();
    {
        alertOn := false;
    }

    method CheckForAlert(threshold: int, countForBloodType: int) returns (alert: bool)
        requires Valid();
        ensures  Valid();
        ensures  alert == (threshold >= countForBloodType);
    {
        alert := (threshold >= countForBloodType);
    }

    function method IsAlertOn(): bool
        reads this;
    {
        alertOn
    }

} // end of Alert class
