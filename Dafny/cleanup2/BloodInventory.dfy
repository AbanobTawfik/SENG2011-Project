
include "Blood.dfy"
include "Query.dfy"

class BloodInventory
{
    var inv: map<string, array<Blood>>; // map of blood types to blood arrays
                                        // (referred to as 'buckets')
    
    ghost var amt: map<string, int>;

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

        // amounts of blood match
        (forall t | validBloodType(t) :: inv[t].Length == amt[t]) &&

        threshold >= 0
    }

    predicate BucketsExist()
        reads this;
    {
        forall t | validBloodType(t) :: t in inv && t in amt && inv[t] != null
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
            "A+" := a, "B+" := b, "O+" := c, "AB+" := d,
            "A-" := e, "B-" := f, "O-" := g, "AB-" := h
        ];

        amt := map[
            "A+" := 0, "B+" := 0, "O+" := 0, "AB+" := 0,
            "A-" := 0, "B-" := 0, "O-" := 0, "AB-" := 0
        ];

        threshold := 0;
    }

    ////////////////////////////////////////////////////////////////////////////
    // Modify Threshold

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
    // GetBloodTypeCount

    method GetBloodTypeCount(bloodType: string) returns (count: int)
        requires validBloodType(bloodType);
        requires Valid();
        ensures  Valid();
        ensures  count == amt[bloodType];
    {
        return inv[bloodType].Length;
    }

    ////////////////////////////////////////////////////////////////////////////
    // RemoveExpiredBlood

    method RemoveExpiredBloodByType(bloodType: string, currentDate: int)
        modifies this`amt;
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
        amt := amt[bloodType := nonExpired.Length];

        LemmaA(inv[bloodType], old(inv[bloodType]), bloodType);
    }

    method RemoveExpiredBlood(currentDate: int)
        modifies this`inv;
        modifies this`amt;
        requires Valid();
        ensures  Valid();
        ensures  forall t | validBloodType(t) :: inv[t][..] == getNonExpiredBloodSeq(old(inv[t]), currentDate)
    {
        var types := {"A+", "B+", "O+", "AB+", "A-", "B-", "O-", "AB-"};
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
    // Adding Blood

    method AddBlood(blood: Blood)
        modifies this`inv;
        modifies this`amt;
        requires Valid();
        requires blood != null;
        requires blood.GetBloodType() == "A+";
        requires blood.Valid();
        ensures  Valid();
        ensures  inv["A-"].Length == old(inv["A-"].Length);
        // only one blood bucket is changed
        ensures  inv[blood.GetBloodType()][..] == old(inv[blood.GetBloodType()][..]) + [blood];
        ensures  fresh(inv[blood.GetBloodType()]);
        ensures  forall t | validBloodType(t) && t != blood.GetBloodType() :: inv[t] == old(inv[t]);
        ensures  forall t | validBloodType(t) && t != blood.GetBloodType() :: inv[t].Length == old(inv[t].Length);
        ensures  forall t | validBloodType(t) && t != blood.GetBloodType() :: inv[t][..] == old(inv[t][..]);
    {
        assert   blood.GetBloodType() == "A+";
        assert   blood.GetBloodType() != "A-";

        var t := blood.GetBloodType();

        assert   t == "A+";
        assert   t != "A-";

        var newBucket: array<Blood> := new Blood[inv[t].Length + 1];
        forall i | 0 <= i < inv[t].Length
        {
            newBucket[i] := inv[t][i];
        }
        newBucket[inv[t].Length] := blood;
        inv := inv[t := newBucket];
        amt := amt[t := amt[t] + 1];
    }

    ////////////////////////////////////////////////////////////////////////////
    // Remove Blood


}

////////////////////////////////////////////////////////////////////////////////
// Lemma A

// Prove that if A is a subset of B and all elements of B satisfy some property,
// then all elements of A also satisfy that property.

lemma LemmaA(a: array<Blood>, b: array<Blood>, t: string)
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

lemma LemmaA1(a: seq<Blood>, b: seq<Blood>, t: string)
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

lemma LemmaA2(a: multiset<Blood>, b: multiset<Blood>, t: string)
    requires a <= b;
    requires forall i | i in b :: i != null;
    requires forall i | i in b :: i.Valid();
    requires forall i | i in b :: i.GetBloodType() == t;
    ensures  forall i | i in a :: i != null;
    ensures  forall i | i in a :: i.Valid();
    ensures  forall i | i in a :: i.GetBloodType() == t;
{

}

////////////////////////////////////////////////////////////////////////////////

method Main()
{
    var inv := new BloodInventory();
    var amt;
    
    amt := inv.GetBloodTypeCount("A+");
    assert amt == 0;
    amt := inv.GetBloodTypeCount("A-");
    assert amt == 0;

    var blood1 := new Blood("A+", "Bob",  5, "Prince Wales Hospital");
    inv.AddBlood(blood1);
    amt := inv.GetBloodTypeCount("A+");
    assert amt == 1;
    amt := inv.GetBloodTypeCount("A-");
    assert amt == 0;

    var blood2 := new Blood("A+", "Amy", 10, "Westmead Hospital");
    inv.AddBlood(blood2);
    amt := inv.GetBloodTypeCount("A+");
    assert amt == 2;

    

    print amt, '\n';

    inv.AddBlood(blood2);
    // amt := inv.GetBloodTypeCount("B+");
    // assert amt == 1;
    print amt, '\n';
}

