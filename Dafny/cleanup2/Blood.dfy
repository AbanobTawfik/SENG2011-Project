

predicate validBloodType(bloodType: string)
{
    bloodType in ["A+", "B+", "O+", "AB+", "A-", "B-", "O-", "AB-"]
}

class Blood
{
    var bloodType: string;
    var donorName: string;
    var dateDonated: int;
    var locationAcquired: string;
    
    predicate Valid()
        reads this;
    {
        validBloodType(bloodType)
    }

    constructor(bloodType: string,
                donorName: string,
                dateDonated: int,
                locationAcquired: string)
        modifies this;
        requires validBloodType(bloodType);
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

    function method GetBloodType(): string
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
    var bobsBlood := new Blood("A-", "Bob", 12, "Prince Wales Hospital");
    
    assert bobsBlood.GetBloodType() == "A-";
    assert bobsBlood.GetDonorName() == "Bob";
    assert bobsBlood.GetDateDonated() == 12;
    bobsBlood.PrettyPrint();

    // assert bobsBlood.GetBloodType() == "A-";
    // assert bobsBlood.GetBloodType() != "A+";

    // // Query
    // var inv := new Blood[4];
    // inv[0] := new Blood("B+", "Ava", 9);
    // inv[1] := new Blood("A-", "Bob", 12);
    // inv[2] := new Blood("O+", "Cal", 12);
    // inv[3] := new Blood("AB+", "Deb", 13);
    
    // // (currently only seems to work with the last item in the inv)
    // // maybe change bloodType to an enumeration?
    // var r := queryBloodByType(inv, "AB+");
    // assert r.Length == 1;
    // assert r[0].GetDonorName() == "Deb";
    
    // assert countBloodByDate(inv, 10, 12) == 2;
    // assert countBloodByType(inv, "AB+") == 1;
    // print "\nQuery successful\n";
}