
// predicate HasNoDuplicates<T>(a: array<T>)
//     reads a;
//     requires a != null;
// {
//     forall i, j | 0 <= i <= j < a.Length :: a[i] == a[j] ==> i == j
// }

// predicate HasNoDuplicatesSeq<T>(a: seq<T>)
// {
//     forall i, j | 0 <= i <= j < |a| :: a[i] == a[j] ==> i == j
// }

// predicate HasDuplicates<T>(a: array<T>)
//     reads a;
//     requires a != null;
// {
//     exists i, j | 0 <= i < j < a.Length :: a[i] == a[j]
// }

// predicate HasDuplicatesSeq<T>(a: seq<T>)
// {
//     exists i, j | 0 <= i < j < |a| :: a[i] == a[j]
// }

predicate HasDuplicates<T>(a: array<T>)
    reads a;
    requires a != null;
{
    exists i | 0 <= i < a.Length :: multiset(a[..])[a[i]] > 1
}

lemma ArrayLemmaA<T>(a: array<T>, b: array<T>)
    requires a != null;
    requires b != null;
    requires multiset(b[..]) <= multiset(a[..]);
    requires HasDuplicates(b);
    ensures  HasDuplicates(a);
{

}
