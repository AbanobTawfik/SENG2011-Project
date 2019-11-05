/* Filtering
 * Lucas and Rason
 *
 * Currently filters an array of integers given a specified test.
 * Can later extend to filter blood objects by blood type.
 */

// Some sample filters with integers
predicate method testEven(x: int) { x % 2 == 0 }
predicate method testPositive(x: int) { x > 0 }
predicate method testEnormous(x: int) { x > 9000 }

method Main()
{
  var a := new int[10];
  a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9] := -1, 2, -5, -4, 1, -2, -3, 3, 0, 4;
  print "original: ", a[..], "\n";
  
  var b := Filter(a, testEven);
  assert b[..] == [2, -4, -2, 0, 4];
  print "even    : ", b[..], "\n";
  
  b := Filter(a, testPositive);
  assert b[..] == [2, 1, 3, 4];
  print "positive: ", b[..], "\n";
  
  b := Filter(a, testEnormous);
  assert b[..] == [];
  print "enormous: ", b[..], "\n";
  
  a := new int[0];
  print "\noriginal: ", b[..], "\n";
  
  b := Filter(a, testEven);
  assert b[..] == [];
  print "even    : ", b[..], "\n";
}

// Returns a new array containing only those elements that pass a specified test
method Filter(a: array<int>, test: int -> bool) returns (b: array<int>)
requires a != null
requires forall i :: test.requires(i) && |test.reads(i)| == 0
ensures b != null
ensures b.Length == Matches(a, a.Length, test) // (unnecessary; for performance)
ensures b[..] == VerifyFilter(a, a.Length, test)
{
  // Determine the total length of the resulting array
  var count, i := 0, 0;
  while i < a.Length
  invariant 0 <= i <= a.Length && count == Matches(a, i, test)
  {
    if test(a[i]) { count := count + 1; }
    i := i + 1;
  }
  b := new int[count]; // Create an array large enough to hold filtered elements
  
  // Copy the filtered elements to the new resulting array
  var j := 0; i := 0;
  while i < a.Length
  invariant 0 <= i <= a.Length && 0 <= j <= count
  invariant j == Matches(a, i, test)
  invariant b[..j] == VerifyFilter(a, i, test)
  {
    // Help prove that j remains within bounds, using proof by contradiction
    assert forall x,y | 0 <= x <= a.Length && 0 <= y <= a.Length ::
        Matches(a, y, test) > Matches(a, x, test) ==> y > x;
    // ((test(a[i]) && j == count) ==> Matches(a, i+1, test) == Matches(a, a.Length, test) + 1)
    assert Matches(a, i+1, test) > Matches(a, a.Length, test) ==> i+1 > a.Length;
    if test(a[i])
    {
      b[j] := a[i];
      j := j + 1;
    }
    i := i + 1;
  }
}

// Verifies the number of matches given a specified test and array [0..end).
function Matches(a: array<int>, end: nat, test: int -> bool): nat
reads a
requires a != null
requires end <= a.Length
requires forall i :: test.requires(i) && |test.reads(i)| == 0
decreases end // (fails asserts without this, does anyone know why?)
{
  if end < 1 then 0
  else  Matches(a, end-1, test) + (if test(a[end-1]) then 1 else 0)
}

// Verifies the filtered array given a specified test & array slice [0..end).
function VerifyFilter(a: array<int>, end: nat, test: int -> bool): seq<int>
reads a
requires a != null
requires end <= a.Length
requires forall i :: test.requires(i) && |test.reads(i)| == 0
decreases end
{
  if end < 1 then []
  else VerifyFilter(a, end-1, test) + (if test(a[end-1]) then [a[end-1]] else [])
}
