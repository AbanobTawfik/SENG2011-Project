

predicate validBloodType(bloodType: string)
{
    bloodType == "A+" || bloodType == "B+" || bloodType == "O+" || bloodType == "AB+" ||
    bloodType == "A-" || bloodType == "B-" || bloodType == "O-" || bloodType == "AB-"
}

class Blood
{
    var bloodType: string;
    var donorName: string;
    var dateDonated: int;
    
    predicate Valid()
        reads this;
    {
        validBloodType(bloodType)
    }

    constructor(bloodType: string, donorName: string, dateDonated: int)
        modifies this;
        requires validBloodType(bloodType);
        ensures  Valid();
        ensures  this.bloodType == bloodType;
        ensures  this.donorName == donorName;
        ensures  this.dateDonated == dateDonated;
    {
        this.bloodType := bloodType;
        this.donorName := donorName;
        this.dateDonated := dateDonated;
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

// method TestBlood()
// {
//     var bobsBlood := new Blood("A-", "Bob", 12);
    
//     assert bobsBlood.GetBloodType() == "A-";
//     assert bobsBlood.GetDonorName() == "Bob";
//     assert bobsBlood.GetDateDonated() == 12;
//     bobsBlood.PrettyPrint();

//     // // Query
//     // var inv := new Blood[4];
//     // inv[0] := new Blood("B+", "Ava", 9);
//     // inv[1] := new Blood("A-", "Bob", 12);
//     // inv[2] := new Blood("O+", "Cal", 12);
//     // inv[3] := new Blood("AB+", "Deb", 13);
    
//     // // (currently only seems to work with the last item in the inv)
//     // // maybe change bloodType to an enumeration?
//     // var r := queryBloodByType(inv, "AB+");
//     // assert r.Length == 1;
//     // assert r[0].GetDonorName() == "Deb";
    
//     // assert countBloodByDate(inv, 10, 12) == 2;
//     // assert countBloodByType(inv, "AB+") == 1;
//     // print "\nQuery successful\n";
// }
