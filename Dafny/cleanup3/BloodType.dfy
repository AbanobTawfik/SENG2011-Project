
datatype BloodType = AP | BP | OP | ABP | AM | BM | OM | ABM

predicate method validBloodType(bloodType: BloodType)
{
    bloodType in [AP, BP, OP, ABP, AM, BM, OM, ABM]
}
