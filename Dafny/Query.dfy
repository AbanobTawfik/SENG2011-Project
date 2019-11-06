include "BloodInventory.dfy"

// filter by type
method SelectBloodByType(bloodInventory: BloodInventory, bloodType: string) returns (resultArray: array<Blood>)

{

}

// filter by age
// assuming the start and end dates are integers
method SelectBloodInAgeRange(bloodInventory: BloodInventory, start: int, end: int) returns (resultArray: array<Blood>)

{

}

// count blood by type
// can just call count method inside blood inventory
method CountBloodByType(bloodInventory: BloodInventory, bloodType: string) returns (count: int)

{

}

// we can also combine these functions with the filter + sort to allow user to alter their resulted query, but this is just the building blocks