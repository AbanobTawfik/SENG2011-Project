include "BloodInventory.dfy"
include "Alert.dfy"
datatype request = bloodRequest(bloodType: string, volume: int)

method Request(batchRequest:array<request>, bloodInventory: BloodInventory)
requires batchRequest != null
requires bloodInventory != null
requires bloodInventory.GetArrayVerification() != null
requires forall i :: 0 <= i < bloodInventory.GetArrayVerification().Length ==> (bloodInventory.GetArrayVerification()[i] != null)
requires forall i :: 0 <= i < batchRequest.Length ==> (validBloodType(batchRequest[i].bloodType))
requires bloodInventory.GetArrayVerification().Length < bloodInventory.GetSizeVerificaiton()
requires forall i :: 0 <= i < batchRequest.Length ==> (batchRequest[i].volume >= bloodInventory.GetBloodCountForBloodTypeVerification(batchRequest[i].bloodType, bloodInventory.GetSizeVerificaiton()))
{

}