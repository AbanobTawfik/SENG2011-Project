/* Filtering
 * Lucas and Rason
 *
 * Currently filters an array of integers given a specified test.
 * Can later extend to filter blood objects by blood type.
 */

// Some sample tests with integers
predicate method testEven(x: int) { x % 2 == 0 }
predicate method testPositive(x: int) { x > 0 }
// (must be function methods for some reason, does anyone know why?)

method Main()
{
  var a := new int[10];
  a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9] := -1, 2, -5, -4, 1, -2, -3, 3, 0, 4;
  print "original: ", a[..], "\n";

  var b := Filter(a, testEven);
  print "even    : ", b[..], "\n"; assert b.Length == 5;

  b := Filter(a, testPositive);
  print "positive: ", b[..], "\n"; assert b.Length == 4;
}

// Returns a new array containing only those elements that pass a specified test
method Filter(a: array<int>, test: int -> bool) returns (b: array<int>)
requires a != null
requires forall i :: test.requires(i) && |test.reads(i)| == 0
ensures b != null
ensures b.Length == Matches(a, a.Length, test);
{
  var matches := 0;
  var i := 0;
  while i < a.Length
  invariant 0 <= i <= a.Length && matches == Matches(a, i, test)
  {
    if test(a[i]) { matches := matches + 1; }
    i := i + 1;
  }
  b := new int[matches];

  // TODO: still thinking about how to properly verify below
  i := 0;
  var j := 0;
  while i < a.Length && j < matches
  {
    if test(a[i])
    {
      b[j] := a[i];
      j := j + 1;
    }
    i := i + 1;
  }
}

// Verifies the number of matches given a specified array and test function.
function Matches(a: array<int>, top: nat, test: int -> bool): int
reads a
requires a != null
requires top <= a.Length
requires forall i :: test.requires(i) && |test.reads(i)| == 0
decreases top // (fails asserts without this, does anyone know why?)
{
  if top < 1 then 0 else
    (if test(a[top-1]) then 1 else 0) + Matches(a, top-1, test)
}
