
include "Blood.dfy"

method FindBloodType(a: array<Blood>, bloodType: string) returns (index: int)
    requires a != null;
    requires forall i | 0 <= i < a.Length :: a[i] != null && a[i].Valid();
    requires validBloodType(bloodType);
    ensures  -1 <= index < a.Length;
    ensures  index == -1 <==> (index == -1 && forall i | 0 <= i < a.Length :: a[i].GetBloodType() != bloodType);
    ensures  index >= 0 <==> (exists i | 0 <= i < a.Length :: a[i].GetBloodType() == bloodType);
    ensures  index >= 0 ==> (a[index].GetBloodType() == bloodType && forall i | 0 <= i < index :: a[i].GetBloodType() != bloodType);
    ensures  a[..] == old(a[..]);
{
    index := -1;
    var i := 0;
    while i < a.Length
        invariant 0 <= i <= a.Length;
        invariant forall j | 0 <= j < i :: a[j].GetBloodType() != bloodType;
        invariant index == -1;
    {
        if a[i].GetBloodType() == bloodType
        {
            index := i;
            return;
        }
        i := i + 1;
    }
}
