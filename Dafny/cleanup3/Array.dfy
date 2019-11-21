
method Concat<T>(a: array<T>, b: array<T>) returns (res: array<T>)
    requires a != null;
    requires b != null;
    ensures  res != null;
    ensures  fresh(res);
    ensures  res.Length == a.Length + b.Length;
    ensures  res[..a.Length] == a[..];
    ensures  res[a.Length..] == b[..];
{
    res := new T[a.Length + b.Length];
    forall i | 0 <= i < a.Length
    {
        res[i] := a[i];
    }
    forall i | 0 <= i < b.Length
    {
        res[i + a.Length] := b[i];
    }
}
