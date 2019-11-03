include "BloodInventory.dfy"
include "Alert.dfy"
datatype request = bloodRequest(bloodType: string, volume: int)

method Request(batchRequest:array<request>, bloodInventory: BloodInventory) returns(requestResult: array<Blood>)
requires batchRequest != null
requires bloodInventory != null
requires bloodInventory.GetArrayVerification() != null
requires forall i :: 0 <= i < bloodInventory.GetArrayVerification().Length ==> (bloodInventory.GetArrayVerification()[i] != null)
requires forall i :: 0 <= i < batchRequest.Length ==> (validBloodType(batchRequest[i].bloodType))
requires bloodInventory.GetArrayVerification().Length < bloodInventory.GetSizeVerificaiton()
requires forall i :: 0 <= i < batchRequest.Length ==> (batchRequest[i].volume >= bloodInventory.GetBloodCountForBloodTypeVerification(batchRequest[i].bloodType, bloodInventory.GetSizeVerificaiton()))
ensures bloodInventory == old(bloodInventory)
ensures forall i :: 0 <= i < batchRequest.Length ==> (batchRequest[i].volume == GetCountOfBloodTypeInArray(requestResult, batchRequest[i].bloodType, requestResult.Length - 1))
{
    
}

function GetCountOfBloodTypeInArray(a: array<Blood>, bloodType: string, indexToCountTo: int): int
requires a != null
requires forall i :: 0 <= i < a.Length ==> (a[i] != null)
reads a
requires indexToCountTo < a.Length
requires validBloodType(bloodType)
{
    if indexToCountTo < 0
    then
        0
    else
        if a[indexToCountTo].GetBloodType() == bloodType
        then
            1 + GetCountOfBloodTypeInArray(a, bloodType, indexToCountTo - 1)
        else
            GetCountOfBloodTypeInArray(a, bloodType, indexToCountTo - 1)
}