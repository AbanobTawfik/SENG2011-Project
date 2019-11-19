
datatype BloodType = AP | BP | OP | ABP | AM | BM | OM | ABM

predicate validBloodType(bloodType: BloodType)
{
    bloodType in [AP, BP, OP, ABP, AM, BM, OM, ABM]
}

class Blood
{
    var bloodType: BloodType;
    var donorName: string;
    var dateDonated: int;
    var locationAcquired: string;
    
    predicate Valid()
        reads this;
    {
        validBloodType(bloodType)
    }

    constructor(bloodType:        BloodType,
                donorName:        string,
                dateDonated:      int,
                locationAcquired: string)
        modifies this;
        // requires validBloodType(bloodType);
        ensures  Valid();
        ensures  this.bloodType == bloodType;
        ensures  this.donorName == donorName;
        ensures  this.dateDonated == dateDonated;
        ensures  this.locationAcquired == locationAcquired;
    {
        this.bloodType := bloodType;
        this.donorName := donorName;
        this.dateDonated := dateDonated;
        this.locationAcquired := locationAcquired;
    }

    function method GetBloodType(): BloodType
        reads this;
    {
        bloodType
    }

    function method GetDonorName(): string
        reads this;
    {
        donorName
    }

    function method GetDateDonated(): int
        reads this;
    {
        dateDonated
    }

    function method GetLocationAcquired(): string
        reads this;
    {
        locationAcquired
    }

    predicate method IsExpired(currentDate: int)
        reads this;
    {
        currentDate > dateDonated + 42
    }

    method PrettyPrint()
        requires Valid();
        ensures  Valid();
    {
        print "Blood from:  ", donorName,   "\n",
              "Received on: ", dateDonated, "\n",
              "Blood type:  ", bloodType,   "\n";
    }

} // end of Blood class

method TestBlood()
{
    var bobsBlood := new Blood(AM, "Bob", 12, "Prince Wales Hospital");
    
    assert bobsBlood.GetBloodType() == AM;
    assert bobsBlood.GetDonorName() == "Bob";
    assert bobsBlood.GetDateDonated() == 12;
    bobsBlood.PrettyPrint();

    assert bobsBlood.GetBloodType() == AM;
    assert bobsBlood.GetBloodType() != AP;
}
