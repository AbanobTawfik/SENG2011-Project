
datatype BloodType = AP | BP | OP | ABP | AM | BM | OM | ABM

predicate validBloodType(bloodType: BloodType)
{
    bloodType in [AP, BP, OP, ABP, AM, BM, OM, ABM]
}
