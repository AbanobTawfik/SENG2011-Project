
include "Blood.dfy"
include "Query.dfy"
include "Request.dfy"

class BloodInventory
{
    var inv: map<BloodType, array<Blood>>; // map of blood types to blood arrays
                                           // (referred to as 'buckets')
    
    var threshold: int;

    ////////////////////////////////////////////////////////////////////////////
    // Valid() and friends

    predicate Valid()
        reads this;

        // reads the blood arrays
        reads if BucketsExist() then
                  set t | validBloodType(t) :: inv[t]
              else
                  {};
        
        // reads the blood objects
        reads if BucketsExist() then
                  set t, i | validBloodType(t) && 0 <= i < inv[t].Length :: inv[t][i]
              else
                  {};
    {
        // blood 'buckets' exist
        (BucketsExist()) &&
        
        // all blood is non-null
        (forall t, i | validBloodType(t) && 0 <= i < inv[t].Length :: inv[t][i] != null) &&

        // all blood is valid
        (forall t, i | validBloodType(t) && 0 <= i < inv[t].Length :: inv[t][i].Valid()) &&

        // all blood is of the correct type
        (forall t, i | validBloodType(t) && 0 <= i < inv[t].Length :: inv[t][i].GetBloodType() == t) &&
        
        // blood 'buckets' are all different
        (forall t, u | validBloodType(t) && validBloodType(u) :: t != u ==> inv[t] != inv[u]) &&

        threshold >= 0
    }

    predicate BucketsExist()
        reads this;
    {
        forall t | validBloodType(t) :: t in inv && inv[t] != null
    }

    predicate AllBucketsEmpty()
        reads this;
        requires BucketsExist();
        reads set t | validBloodType(t) :: inv[t];
    {
        forall t | validBloodType(t) :: inv[t] != null && inv[t].Length == 0
    }

    ////////////////////////////////////////////////////////////////////////////
    // constructor()

    constructor()
        modifies this;
        ensures  Valid();
        ensures  AllBucketsEmpty();
        ensures  forall t | validBloodType(t) :: fresh(inv[t]);
        ensures  threshold == 0;
    {
        var a := new Blood[0];
        var b := new Blood[0];
        var c := new Blood[0];
        var d := new Blood[0];
        var e := new Blood[0];
        var f := new Blood[0];
        var g := new Blood[0];
        var h := new Blood[0];
        
        inv := map[
            AP := a, BP := b, OP := c, ABP := d,
            AM := e, BM := f, OM := g, ABM := h
        ];

        threshold := 0;
    }

    ////////////////////////////////////////////////////////////////////////////
    // Getters

    method GetThreshold() returns (threshold: int)
        requires Valid();
        ensures  Valid();
        ensures  threshold == this.threshold;
    {
        threshold := this.threshold;
    }

    ////////////////////////////////////////////////////////////////////////////
    // Setters

    method ModifyThreshold(threshold: int)
        modifies this`threshold;
        requires Valid();
        requires threshold >= 0;
        ensures  Valid();
        ensures  this.threshold == threshold;
    {
        this.threshold := threshold;
    }

    ////////////////////////////////////////////////////////////////////////////
    // Printing - because there's a little bit of C in all of us

    method Show()
        requires Valid();
        ensures  Valid();
    {
        print "==========================\n";
        print "         Inventory        \n";
        print "==========================\n";

        var ts := [AP, BP, OP, ABP, AM, BM, OM, ABM];
        var i := 0;
        while i < |ts|
        {
            print ts[i], "\n";
            var j := 0;
            while j < inv[ts[i]].Length
            {
                print "\n";
                inv[ts[i]][j].PrettyPrint();
                j := j + 1;
            }
            print "--------------------------\n";
            i := i + 1;
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // GetBloodTypeCount

    method GetBloodTypeCount(bloodType: BloodType) returns (count: int)
        requires validBloodType(bloodType);
        requires Valid();
        ensures  Valid();
        ensures  count == inv[bloodType].Length;
    {
        return inv[bloodType].Length;
    }

    ////////////////////////////////////////////////////////////////////////////
    // Adding Blood

    method AddBlood(blood: Blood)
        modifies this`inv;
        requires Valid();
        requires blood != null;
        requires blood.Valid();
        ensures  Valid();
        ensures  inv[blood.GetBloodType()][..] == old(inv[blood.GetBloodType()][..]) + [blood];
        ensures  fresh(inv[blood.GetBloodType()]);
        // ensure other blood buckets are unchanged
        ensures  forall t | validBloodType(t) && t != blood.GetBloodType() :: inv[t] == old(inv[t]);
        ensures  forall t | validBloodType(t) && t != blood.GetBloodType() :: inv[t].Length == old(inv[t].Length);
        ensures  forall t | validBloodType(t) && t != blood.GetBloodType() :: inv[t][..] == old(inv[t][..]);
    {
        var t := blood.GetBloodType();

        var newBucket := new Blood[inv[t].Length + 1];
        forall i | 0 <= i < inv[t].Length
        {
            newBucket[i] := inv[t][i];
        }
        newBucket[inv[t].Length] := blood;
        inv := inv[t := newBucket];
    }

    ////////////////////////////////////////////////////////////////////////////
    // RemoveExpiredBlood

    method RemoveExpiredBloodByType(bloodType: BloodType, currentDate: int)
        modifies this`inv;
        requires validBloodType(bloodType);
        requires Valid();
        ensures  Valid();
        ensures  inv[bloodType] != old(inv[bloodType]);
        ensures  fresh(inv[bloodType]);
        ensures  inv[bloodType][..] == getNonExpiredBloodSeq(old(inv[bloodType]), currentDate);
        ensures  forall t | validBloodType(t) && t != bloodType ::
                     inv[t] == old(inv[t]) && inv[t][..] == old(inv[t][..]);
    {
        var nonExpired := getNonExpiredBlood(inv[bloodType], currentDate);
        inv := inv[bloodType := nonExpired];

        LemmaA(inv[bloodType], old(inv[bloodType]), bloodType);
    }

    method RemoveExpiredBlood(currentDate: int)
        modifies this`inv;
        requires Valid();
        ensures  Valid();
        ensures  forall t | validBloodType(t) :: inv[t][..] == getNonExpiredBloodSeq(old(inv[t]), currentDate)
    {
        var types := {AP, BP, OP, ABP, AM, BM, OM, ABM};
        var typesLeft := types;

        while typesLeft != {}
            decreases typesLeft;
            invariant forall t :: validBloodType(t) <==> t in types;
            invariant forall t | t  in typesLeft :: validBloodType(t);
            invariant Valid();
            invariant forall t | t !in typesLeft && validBloodType(t) :: inv[t][..] == getNonExpiredBloodSeq(old(inv[t]), currentDate);
            invariant forall t | t  in typesLeft && validBloodType(t) :: inv[t] == old(inv[t]);
            invariant forall t | t  in typesLeft && validBloodType(t) :: inv[t][..] == old(inv[t][..]);
        {
            var t :| t in typesLeft;
            RemoveExpiredBloodByType(t, currentDate);
            typesLeft := typesLeft - {t};
        }
    }

    ////////////////////////////////////////////////////////////////////////////
    // Remove Blood

    method RemoveBlood(bloodType: BloodType) returns (blood: Blood)
        modifies this`inv;
        requires Valid();
        requires inv[bloodType].Length > 0;
        ensures  Valid();
        ensures  blood != null;
        ensures  blood.Valid();
        ensures  blood.GetBloodType() == bloodType;
        ensures  inv[bloodType][..] == old(inv[bloodType][1..]);
        ensures  fresh(inv[bloodType]);
        // ensure other blood buckets are unchanged
        ensures  forall t | validBloodType(t) && t != blood.GetBloodType() ::
                     inv[t] == old(inv[t]) &&
                     inv[t].Length == old(inv[t].Length) &&
                     inv[t][..] == old(inv[t][..]);
    {
        var t := bloodType;
        blood := inv[t][0];

        var newBucket := new Blood[inv[t].Length - 1];
        forall i | 1 <= i < inv[t].Length
        {
            newBucket[i - 1] := inv[t][i];
        }
        inv := inv[t := newBucket];
    }

    ////////////////////////////////////////////////////////////////////////////
    // Request Fulfilment

    // NOTE:    It is assumed that Vampire staff will remove expired blood daily
    //          from the inventory. So, the inventory will never contain expired
    //          blood.
    method RequestOneType(req: Request) returns (blood: array<Blood>)
        modifies this`inv;
        requires Valid();
        requires validBloodType(req.bloodType);
        requires 0 < req.volume <= inv[req.bloodType].Length;
        ensures  Valid();
        ensures  blood != null;
        ensures  fresh(blood);
        ensures  blood[..] == old(inv[req.bloodType][..req.volume]);
        ensures  inv[req.bloodType][..] == old(inv[req.bloodType][req.volume..]);
        ensures  fresh(inv[req.bloodType]);
        // ensure other blood buckets are unchanged
        ensures  forall t | validBloodType(t) && t != req.bloodType ::
                     inv[t] == old(inv[t]) &&
                     inv[t].Length == old(inv[t].Length) &&
                     inv[t][..] == old(inv[t][..]);
    {
        var t := req.bloodType;

        blood := new Blood[req.volume];
        var newBucket := new Blood[inv[t].Length - req.volume];
        forall i | 0 <= i < req.volume
        {
            blood[i] := inv[t][i];
        }
        forall i | req.volume <= i < inv[t].Length
        {
            newBucket[i - req.volume] := inv[t][i];
        }
        inv := inv[t := newBucket];
    }

    method RequestManyTypes(req: array<Request>) returns (res: map<BloodType, array<Blood>>)
        modifies this`inv;
        requires Valid();
        requires req != null;
        requires forall i | 0 <= i < req.Length :: validBloodType(req[i].bloodType)
                                                && 0 < req[i].volume <= inv[req[i].bloodType].Length;
        requires forall i, j | 0 <= i < j < req.Length :: req[i].bloodType != req[j].bloodType;
        ensures  Valid();
        ensures  forall i | 0 <= i < req.Length :: req[i].bloodType in res
                                                && res[req[i].bloodType] != null
                                                && fresh(inv[req[i].bloodType])
                                                && res[req[i].bloodType][..] == old(inv[req[i].bloodType][..req[i].volume])
                                                && inv[req[i].bloodType][..] == old(inv[req[i].bloodType][req[i].volume..])
                                                && fresh(res[req[i].bloodType]);
        
        // ensure other blood buckets are unchanged
        ensures  forall t | validBloodType(t) && (forall i | 0 <= i < req.Length :: req[i].bloodType != t)
                         :: inv[t] == old(inv[t])
                         && inv[t][..] == old(inv[t][..]);
    {
        res := map[];

        var i := 0;
        while i < req.Length
            invariant 0 <= i <= req.Length;
            invariant Valid();
            invariant req[..] == old(req[..]);
            invariant forall j | i <= j < req.Length :: 0 < req[j].volume <= inv[req[j].bloodType].Length;
            invariant forall j | i <= j < req.Length :: inv[req[j].bloodType][..] == old(inv[req[j].bloodType][..]);
            invariant forall j | 0 <= j < i :: req[j].bloodType in res
                                            && res[req[j].bloodType] != null
                                            && fresh(inv[req[j].bloodType])
                                            && res[req[j].bloodType][..] == old(inv[req[j].bloodType][..req[j].volume])
                                            && inv[req[j].bloodType][..] == old(inv[req[j].bloodType][req[j].volume..])
                                            && fresh(res[req[j].bloodType]);
            
            // ensure other blood buckets are unchanged
            invariant forall t | validBloodType(t) && (forall i | 0 <= i < req.Length :: req[i].bloodType != t)
                              :: inv[t] == old(inv[t])
                              && inv[t][..] == old(inv[t][..]);
        {
            var blood := RequestOneType(req[i]);
            res := res[req[i].bloodType := blood];
            i := i + 1;
        }
    }
}

////////////////////////////////////////////////////////////////////////////////
// Lemma A

// Prove that if A is a subset of B and all elements of B satisfy some property,
// then all elements of A also satisfy that property.

lemma LemmaA(a: array<Blood>, b: array<Blood>, t: BloodType)
    requires a != null;
    requires b != null;
    requires multiset(a[..]) <= multiset(b[..]);
    requires forall i | 0 <= i < b.Length :: b[i] != null;
    requires forall i | 0 <= i < b.Length :: b[i].Valid();
    requires forall i | 0 <= i < b.Length :: b[i].GetBloodType() == t;
    ensures  forall i | 0 <= i < a.Length :: a[i] != null;
    ensures  forall i | 0 <= i < a.Length :: a[i].Valid();
    ensures  forall i | 0 <= i < a.Length :: a[i].GetBloodType() == t;
{
    LemmaA1(a[..], b[..], t);
}

lemma LemmaA1(a: seq<Blood>, b: seq<Blood>, t: BloodType)
    requires multiset(a) <= multiset(b);
    requires forall i | 0 <= i < |b| :: b[i] != null;
    requires forall i | 0 <= i < |b| :: b[i].Valid();
    requires forall i | 0 <= i < |b| :: b[i].GetBloodType() == t;
    ensures  forall i | 0 <= i < |a| :: a[i] != null;
    ensures  forall i | 0 <= i < |a| :: a[i].Valid();
    ensures  forall i | 0 <= i < |a| :: a[i].GetBloodType() == t;
{
    LemmaA2(multiset(a), multiset(b), t);
    assert forall i | i in multiset(a) :: i != null;
}

lemma LemmaA2(a: multiset<Blood>, b: multiset<Blood>, t: BloodType)
    requires a <= b;
    requires forall i | i in b :: i != null;
    requires forall i | i in b :: i.Valid();
    requires forall i | i in b :: i.GetBloodType() == t;
    ensures  forall i | i in a :: i != null;
    ensures  forall i | i in a :: i.Valid();
    ensures  forall i | i in a :: i.GetBloodType() == t;
{

}
