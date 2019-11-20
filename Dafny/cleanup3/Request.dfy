
include "BloodType.dfy"

datatype Request = Request(bloodType: BloodType, volume: int)

function method cumulativeVolume(req: array<Request>, upTo: int): int
    reads req;
    requires req != null;
    requires 0 <= upTo <= req.Length;
    requires forall i | 0 <= i < req.Length :: req[i].volume > 0;
    ensures  cumulativeVolume(req, upTo) >= 0;
{
    if upTo == 0 then
        0
    else
        req[upTo - 1].volume + cumulativeVolume(req, upTo - 1)
}

method TestCumulativeVolume()
{
    var req := new Request[5];
    req[0] := Request(AP, 3);
    req[1] := Request(BP, 1);
    req[2] := Request(OP, 4);
    req[3] := Request(AM, 1);
    req[4] := Request(BM, 5);

    assert cumulativeVolume(req, 0) ==  0;
    assert cumulativeVolume(req, 1) ==  3;
    assert cumulativeVolume(req, 2) ==  4;
    assert cumulativeVolume(req, 3) ==  8;
    assert cumulativeVolume(req, 4) ==  9;
    assert cumulativeVolume(req, 5) == 14;    
}
