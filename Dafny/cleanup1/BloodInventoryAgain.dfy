
include "Array.dfy"
include "Blood.dfy"
include "Query.dfy"
include "Request.dfy"
include "Search.dfy"

class BloodInventory
{
    var inventory: array<Blood>;
    var threshold: int;

    predicate Valid()
        reads this`threshold;
        reads this`inventory;
        reads this.inventory;
        reads if inventory != null then
                  set i | 0 <= i < inventory.Length :: inventory[i]
              else
                  {};
    {
        threshold >= 0    &&
        inventory != null &&
        forall i | 0 <= i < inventory.Length :: (inventory[i] != null &&
                                                 inventory[i].Valid())
    }

    constructor()
        modifies this;
        ensures  Valid();
    {
        inventory := new Array[0];
        threshold := 0;
    }

    method ModifyThreshold(threshold: int)
        modifies this`threshold;
        requires Valid();
        requires threshold >= 0;
        ensures  Valid();
        ensures  this.threshold == threshold;
    {
        this.threshold := threshold;
    }

    method GetBloodTypeCount(bloodType: string) returns (count: int)
        requires validBloodType(bloodType);
        requires Valid();
        ensures  Valid();
        ensures  count == countBloodByType(inventory, bloodType);
    {
        count := 0;
        var i := 0;
        while i < inventory.Length
            invariant 0 <= i <= inventory.Length;
            invariant count == countBloodByTypeUpTo(inventory, i, bloodType);
        {
            if (inventory[i].GetBloodType() == bloodType)
            {
                count := count + 1;
            }
            i := i + 1;
        }
    }

    method RemoveExpiredBlood(currentDate: int)
        modifies this`inventory;
        requires Valid();
        ensures  Valid();
        ensures  inventory[..] == getNonExpiredBloodSeq(old(inventory), currentDate);
    {
        inventory := getNonExpiredBlood(inventory, currentDate);
        LemmaA(inventory, old(inventory));
    }

    method AddBlood(blood: Blood)
        modifies this`inventory;
        requires Valid();
        requires blood != null;
        requires blood.Valid();
        ensures  Valid();
        ensures  inventory[..] == old(inventory[..]) + [blood];
        ensures  fresh(inventory);
    {
        var newInventory: array<Blood> := new Blood[inventory.Length + 1];
        forall i | 0 <= i < inventory.Length
        {
            newInventory[i] := inventory[i];
        }

        newInventory[inventory.Length] := blood;
        inventory := newInventory;
    }

    method RemoveBloodAtIndex(index: int) returns (blood: Blood)
        modifies this`inventory;
        requires Valid();
        requires 0 <= index < inventory.Length;
        ensures  Valid();
        ensures  blood == old(inventory[index]);
        ensures  inventory[..] == old(inventory[..index] + inventory[index + 1..]);
        ensures  multiset(inventory[..] + [blood]) == multiset(old(inventory[..]));
        ensures  fresh(inventory);
    {
        var newInventory := new Blood[inventory.Length - 1];
        blood := inventory[index];
        
        forall i | 0 <= i < index
        {
            newInventory[i] := inventory[i];
        }
        forall i | index < i < inventory.Length
        {
            newInventory[i - 1] := inventory[i];
        }

        inventory := newInventory;

        assert old(inventory[..index]) + old([inventory[index]]) + old(inventory[index + 1..]) == old(inventory[..]);
    }

    method RemoveBlood(bloodType: string) returns (blood: Blood)
        modifies this`inventory;
        requires Valid();
        requires validBloodType(bloodType);
        requires inventory.Length > 0;
        requires exists i | 0 <= i < inventory.Length :: inventory[i].GetBloodType() == bloodType;
        ensures  Valid();
        ensures  blood != null;
        ensures  blood.GetBloodType() == bloodType;
        ensures  multiset(inventory[..] + [blood]) == multiset(old(inventory[..]));
    {
        var index := FindBloodType(inventory, bloodType);
        blood := RemoveBloodAtIndex(index);
    }

    // method RemoveBloodBatch(bloodType: string, amount: int) returns (batch: array<Blood>)
    //     modifies this`inventory;
    //     requires Valid();
    //     requires validBloodType(bloodType);
    //     requires amount > 0;
    //     requires countBloodByType(inventory, bloodType) > amount;
    //     ensures  Valid();
    //     ensures  batch != null;
    //     ensures  forall i | 0 <= i < batch.Length :: batch[i] != null;
    //     ensures  forall i | 0 <= i < batch.Length :: batch[i].GetBloodType() == bloodType;
    //     ensures  multiset(inventory[..] + batch[..]) == multiset(old(inventory[..]));
    // {
    //     batch := new Blood[amount];

    //     var i := 0;
    //     while i < amount
    //         invariant 0 <= i <= amount;
    //         invariant batch != null;
    //         invariant Valid();
    //         invariant forall j | 0 <= j < i :: batch[j] != null;
    //         invariant forall j | 0 <= j < i :: batch[j].GetBloodType() == bloodType;
    //         invariant multiset(inventory[..] + batch[..i]) == multiset(old(inventory[..]));
    //     {
    //         batch[i] := RemoveBlood(bloodType);
    //         i := i + 1;
    //     }
    // }

    // method Request(batchRequest: array<request>) returns (blood: array<Blood>)
    //     // modifies this`inventory;
    //     requires Valid();
    //     requires batchRequest != null;
    //     requires batchRequest.Length > 0;
    //     requires forall i | 0 <= i < batchRequest.Length :: validBloodType(batchRequest[i].bloodType) && batchRequest[i].volume > 0;
    //     ensures  Valid();
    // {
    //     var i := 0;
    //     while i < batchRequest.Length
    //         invariant 0 <= i <= batchRequest.Length;
    //     {
    //         var count := 0;
    //         while count < batchRequest[i].volume
    //             invariant 0 <= count <= batchRequest[i].volume
    //         {
    //             count := count + 1;
    //         }
    //         i := i + 1;
    //     }
    // }

    
} // end of BloodInventory class

////////////////////////////////////////////////////////////////////////////////
// Lemmas

// Prove that if A is a subset of B and all elements of B satisfy some property,
// then all elements of A also satisfy that property.

lemma LemmaA(a: array<Blood>, b: array<Blood>)
    requires a != null;
    requires b != null;
    requires multiset(a[..]) <= multiset(b[..]);
    requires forall i | 0 <= i < b.Length :: b[i] != null;
    requires forall i | 0 <= i < b.Length :: b[i].Valid();
    ensures  forall i | 0 <= i < a.Length :: a[i] != null;
    ensures  forall i | 0 <= i < a.Length :: a[i].Valid();
{
    LemmaA1(a[..], b[..]);
}

lemma LemmaA1(a: seq<Blood>, b: seq<Blood>)
    requires multiset(a) <= multiset(b);
    requires forall i | 0 <= i < |b| :: b[i] != null;
    requires forall i | 0 <= i < |b| :: b[i].Valid();
    ensures  forall i | 0 <= i < |a| :: a[i] != null;
    ensures  forall i | 0 <= i < |a| :: a[i].Valid();
{
    LemmaA2(multiset(a), multiset(b));
    assert forall i | i in multiset(a) :: i != null;
}

lemma LemmaA2(a: multiset<Blood>, b: multiset<Blood>)
    requires a <= b;
    requires forall i | i in b :: i != null;
    requires forall i | i in b :: i.Valid();
    ensures  forall i | i in a :: i != null;
    ensures  forall i | i in a :: i.Valid();
{

}
