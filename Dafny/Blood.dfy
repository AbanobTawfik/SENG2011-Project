class Blood
{
    // add more fields if need be
    var bloodType: string;
    var donorName: string;
    // string for date?
    var dateDonated: string;
    
    // blood must be of valid type
    predicate Valid()
    reads this
    {
        (bloodType == "A+" || bloodType == "A-" || bloodType == "B+" || bloodType == "B-" ||
         bloodType == "O+" || bloodType == "O-" || bloodType == "AB+" || bloodType == "AB-")
    }

    constructor(cbloodType: string, cdonorName: string, cdateDonated: string)
    modifies this
    requires (cbloodType == "A+" || cbloodType == "A-" || cbloodType == "B+" || cbloodType == "B-" ||
         cbloodType == "O+" || cbloodType == "O-" || cbloodType == "AB+" || cbloodType == "AB-")
    ensures Valid()
    ensures bloodType == cbloodType && donorName == cdonorName && dateDonated == cdateDonated
    {
        bloodType := cbloodType;
        donorName := cdonorName;
        dateDonated := cdateDonated;
    }

    method GetBloodType() returns (cbloodType: string)
    requires Valid() ensures Valid()
    ensures cbloodType == bloodType
    {
        cbloodType := bloodType;
    }

    method GetDonorName() returns (cdonorName: string)
    requires Valid() ensures Valid()
    ensures cdonorName == donorName
    {
        cdonorName := donorName;
    }

    method GetDateDonated() returns (cdateDonated: string)
    requires Valid() ensures Valid()
    ensures cdateDonated == dateDonated
    {
        cdateDonated := dateDonated;
    }

    method PrettyPrint()
    requires Valid() ensures Valid()
    {
        print "Blood from: ", donorName, "\nreceived on: ", dateDonated, "\nBlood Type: ", bloodType;
    }
} // end of Blood class

method Main()
{
    var bobsBlood := new Blood("A-", "bob", "16/06/1997");
    var bobsBloodType, bobsName, dateBobDonatedBlood;
    
    bobsBloodType := bobsBlood.GetBloodType();
    assert bobsBloodType == "A-";

    bobsName := bobsBlood.GetDonorName();
    assert bobsName == "bob";

    dateBobDonatedBlood := bobsBlood.GetDateDonated();
    assert dateBobDonatedBlood == "16/06/1997";
    
    bobsBlood.PrettyPrint();
}

