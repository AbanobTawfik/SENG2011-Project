/* Filtering
 * Lucas and Rason
 *
 * Filters an array of any type, given a specified test.
 */

// Some test filters with integers
predicate method testEven(x: int) { x % 2 == 0 }
predicate method testPositive(x: int) { x > 0 }
predicate method testEnormous(x: int) { x > 9000 }

// Returns a new array containing only those elements that pass a specified test
method Filter<T>(a: array<T>, test: T -> bool) returns (b: array<T>)
    requires a != null;
    requires forall i | 0 <= i < a.Length :: test.requires(a[i]);
    ensures  b != null;
    ensures  b.Length == Matches(a, a.Length, test); // (unnecessary; for performance)
    ensures  b[..] == VerifyFilter(a, a.Length, test);
    ensures  multiset(b[..]) <= multiset(a[..]);
{
    // Determine the total length of the resulting array
    var count, i := 0, 0;
    while i < a.Length
        invariant 0 <= i <= a.Length;
        invariant count == Matches(a, i, test);
    {
        if test(a[i])
        {
            count := count + 1;
        }
        i := i + 1;
    }

    b := new T[count]; // Create an array large enough to hold filtered elements

    // Copy the filtered elements to the new resulting array
    var j := 0; i := 0;
    while i < a.Length
        invariant 0 <= i <= a.Length && 0 <= j <= count;
        invariant j == Matches(a, i, test);
        invariant b[..j] == VerifyFilter(a, i, test);
        invariant multiset(b[..j]) <= multiset(a[..i]);
    {
        // Help prove that j remains within bounds, using proof by contradiction
        assert forall x, y | 0 <= x <= a.Length && 0 <= y <= a.Length ::
            Matches(a, y, test) > Matches(a, x, test) ==> y > x;
        assert Matches(a, i + 1, test) > Matches(a, a.Length, test) ==> i + 1 > a.Length;
        if test(a[i])
        {
            b[j] := a[i];
            j := j + 1;
        }
        i := i + 1;
    }

    assert a[..a.Length] == a[..];
}

// Verifies the number of matches given a specified test and array [0..end).
function method Matches<T>(a: array<T>, end: nat, test: T -> bool): nat
    reads a;
    reads set i, o | 0 <= i < a.Length && o in test.reads(a[i]) :: o;
    requires a != null;
    requires 0 <= end <= a.Length;
    requires forall i | 0 <= i < a.Length :: test.requires(a[i]);
    decreases end;
{
    if end == 0 then
        0
    else if test(a[end - 1]) then
        1 + Matches(a, end - 1, test)
    else
        Matches(a, end - 1, test)
}

// Verifies the filtered array given a specified test and array slice [0..end).
function VerifyFilter<T>(a: array<T>, end: nat, test: T -> bool): seq<T>
    reads a;
    reads set i, o | 0 <= i < a.Length && o in test.reads(a[i]) :: o;
    requires a != null;
    requires 0 <= end <= a.Length;
    requires forall i | 0 <= i < a.Length :: test.requires(a[i]);
    decreases end;
{
    if end == 0 then
        []
    else if test(a[end - 1]) then
        VerifyFilter(a, end - 1, test) + [a[end - 1]]
    else
        VerifyFilter(a, end - 1, test)
}

// method TestFilter()
// {
//     var a := new int[10];
//     a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9] := -1, 2, -5, -4, 1, -2, -3, 3, 0, 4;
//     print "original: ", a[..],  "\n";

//     var a1 := Filter(a, testEven);
//     assert a1[..] == [2, -4, -2, 0, 4];
//     print "even:     ", a1[..], "\n";

//     var a2 := Filter(a, testPositive);
//     assert a2[..] == [2, 1, 3, 4];
//     print "positive: ", a2[..], "\n";

//     var a3 := Filter(a, testEnormous);
//     assert a3[..] == [];
//     print "enormous: ", a3[..], "\n";

//     print "\n";

//     var b := new int[0];
//     print "original: ", b[..],  "\n";
    
//     var b1 := Filter(b, testEven);
//     assert b1[..] == [];
//     print "even:     ", b1[..], "\n";

//     var b2 := Filter(b, testPositive);
//     assert b2[..] == [];
//     print "positive: ", b2[..], "\n";

//     var b3 := Filter(b, testEnormous);
//     assert b3[..] == [];
//     print "enormous: ", b3[..], "\n";
// }
