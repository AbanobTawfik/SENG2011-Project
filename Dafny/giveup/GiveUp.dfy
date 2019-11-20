    ////////////////////////////////////////////////////////////////////////////

    // method Request(req: array<Request>) returns (res: array<Blood>)
    //     modifies this`inv;
    //     requires Valid();
    //     requires req != null;
    //     requires forall i | 0 <= i < req.Length :: validBloodType(req[i].bloodType)
    //                                             && 0 < req[i].volume <= inv[req[i].bloodType].Length;
    //     requires forall i, j | 0 <= i < j < req.Length :: req[i].bloodType != req[j].bloodType;
    //     ensures  Valid();
    //     ensures  forall i | 0 <= i < req.Length :: fresh(inv[req[i].bloodType])
    //                                             && inv[req[i].bloodType][..] == old(inv[req[i].bloodType][req[i].volume..]);
    //     ensures  res != null;
    //     ensures  res.Length == cumulativeVolume(req, req.Length);
    //     ensures  fresh(res);
    //     ensures  forall i | 0 <= i < req.Length :: res[cumulativeVolume(req, i)..cumulativeVolume(req, i + 1)]
    //                                             == old(inv[req[i].bloodType][..req[i].volume]);
    //     ensures  forall i | 0 <= i < res.Length :: res[i] != null;

    //     // ensure other blood buckets are unchanged
    //     ensures  forall t | validBloodType(t) && (forall i | 0 <= i < req.Length :: req[i].bloodType != t)
    //                      :: inv[t] == old(inv[t])
    //                      && inv[t][..] == old(inv[t][..]);
    // {
    //     var resmap := RequestManyTypes(req);

    //     res := new Blood[cumulativeVolume(req, req.Length)];
    //     var i := 0;
    //     while i < req.Length
    //         invariant 0 <= i <= req.Length;
    //         invariant Valid();
    //         invariant req[..] == old(req[..]);
    //         invariant forall j | 0 <= j < req.Length :: fresh(inv[req[j].bloodType])
    //                                                  && inv[req[j].bloodType][..] == old(inv[req[j].bloodType][req[j].volume..]);
    //         invariant res != null;
    //         invariant fresh(res);
    //         invariant res.Length == cumulativeVolume(req, req.Length);
    //         invariant forall t | validBloodType(t) :: res != inv[t];

    //         invariant forall i | 0 <= i < req.Length
    //                       :: req[i].bloodType in resmap
    //                       && resmap[req[i].bloodType] != null
    //                       && fresh(resmap[req[i].bloodType])
    //                       && resmap[req[i].bloodType][..] == old(inv[req[i].bloodType][..req[i].volume])
    //                       && resmap[req[i].bloodType].Length == req[i].volume
    //                       && fresh(inv[req[i].bloodType])
    //                       && inv[req[i].bloodType][..] == old(inv[req[i].bloodType][req[i].volume..])
    //                       && forall t | validBloodType(t) :: resmap[req[i].bloodType] != inv[t];
            
    //         invariant forall j | 0 <= j < i :: res[cumulativeVolume(req, j)..cumulativeVolume(req, j + 1)]
    //                                         == old(inv[req[j].bloodType][..req[j].volume]);

    //         // ensure other blood buckets are unchanged
    //         invariant forall t | validBloodType(t) && (forall i | 0 <= i < req.Length :: req[i].bloodType != t)
    //                           :: inv[t] == old(inv[t])
    //                           && inv[t][..] == old(inv[t][..]);
    //     {
    //         forall j | 0 <= j < resmap[req[i].bloodType].Length
    //         {
    //             res[cumulativeVolume(req, i) + j] := resmap[req[i].bloodType][j];
    //         }
    //         i := i + 1;
    //     }
    // }

    ////////////////////////////////////////////////////////////////////////////

    method Request(req: array<Request>) returns (res: array<Blood>)
        modifies this`inv;
        requires Valid();
        requires req != null;
        requires forall i | 0 <= i < req.Length :: validBloodType(req[i].bloodType)
                                                && 0 < req[i].volume <= inv[req[i].bloodType].Length;
        requires forall i, j | 0 <= i < j < req.Length :: req[i].bloodType != req[j].bloodType;
        ensures  Valid();
        // ensures  forall i | 0 <= i < req.Length :: fresh(inv[req[i].bloodType])
        //                                         && inv[req[i].bloodType][..] == old(inv[req[i].bloodType][req[i].volume..]);
        // ensures  res != null;
        // ensures  res.Length == cumulativeVolume(req, req.Length);
        // ensures  fresh(res);
        // ensures  forall i | 0 <= i < req.Length :: res[cumulativeVolume(req, i)..cumulativeVolume(req, i + 1)]
        //                                                == old(inv[req[i].bloodType][..req[i].volume]);
        // ensures  forall i | 0 <= i < res.Length :: res[i] != null;

        // // ensure other blood buckets are unchanged
        // ensures  forall t | validBloodType(t) && (forall i | 0 <= i < req.Length :: req[i].bloodType != t)
        //                  :: inv[t] == old(inv[t])
        //                  && inv[t][..] == old(inv[t][..]);
    {
        var resmap := RequestManyTypes(req);

        res := new Blood[cumulativeVolume(req, req.Length)];
        var r := 0;
        var i := 0;
        while i < req.Length
            invariant 0 <= i <= req.Length;
            invariant r == cumulativeVolume(req, i);
            invariant Valid();
            invariant req[..] == old(req[..]);
            invariant forall k | 0 <= k < req.Length :: fresh(inv[req[k].bloodType])
                                                     && inv[req[k].bloodType][..] == old(inv[req[k].bloodType][req[k].volume..]);
            invariant res != null;
            invariant fresh(res);
            invariant res.Length == cumulativeVolume(req, req.Length);
            invariant forall t | t in inv :: res != inv[t];

            invariant forall k | 0 <= k < req.Length
                              :: req[k].bloodType in resmap
                              && resmap[req[k].bloodType] != null
                              && fresh(resmap[req[k].bloodType])
                              && resmap[req[k].bloodType][..] == old(inv[req[k].bloodType][..req[k].volume])
                              && resmap[req[k].bloodType].Length == req[k].volume
                              && fresh(inv[req[k].bloodType])
                              && inv[req[k].bloodType][..] == old(inv[req[k].bloodType][req[k].volume..])
                              && forall t | t in inv :: resmap[req[k].bloodType] != inv[t];
            
            // invariant forall j | 0 <= j < i :: res[cumulativeVolume(req, j)..cumulativeVolume(req, j + 1)]
            //                                 == old(inv[req[j].bloodType][..req[j].volume]);

            // ensure other blood buckets are unchanged
            invariant forall t | validBloodType(t) && (forall i | 0 <= i < req.Length :: req[i].bloodType != t)
                              :: inv[t] == old(inv[t])
                              && inv[t][..] == old(inv[t][..]);
        {
            var j := 0;
            while j < resmap[req[i].bloodType].Length
                invariant 0 <= j <= resmap[req[i].bloodType].Length;
                invariant r == cumulativeVolume(req, i) + j;
                invariant Valid();

                invariant req[..] == old(req[..]);
                invariant forall k | 0 <= k < req.Length :: fresh(inv[req[k].bloodType])
                                                         && inv[req[k].bloodType][..] == old(inv[req[k].bloodType][req[k].volume..]);
                invariant res != null;
                invariant fresh(res);
                invariant res.Length == cumulativeVolume(req, req.Length);
                invariant forall t | t in inv :: res != inv[t];

                invariant forall k | 0 <= k < req.Length
                                  :: req[k].bloodType in resmap
                                  && resmap[req[k].bloodType] != null
                                  && fresh(resmap[req[k].bloodType])
                                  && resmap[req[k].bloodType][..] == old(inv[req[k].bloodType][..req[k].volume])
                                  && resmap[req[k].bloodType].Length == req[k].volume
                                  && fresh(inv[req[k].bloodType])
                                  && inv[req[k].bloodType][..] == old(inv[req[k].bloodType][req[k].volume..])
                                  && forall t | t in inv :: resmap[req[k].bloodType] != inv[t];
                
                // invariant forall j | 0 <= j < i :: res[cumulativeVolume(req, j)..cumulativeVolume(req, j + 1)]
                //                                 == old(inv[req[j].bloodType][..req[j].volume]);

                // ensure other blood buckets are unchanged
                invariant forall t | validBloodType(t) && (forall i | 0 <= i < req.Length :: req[i].bloodType != t)
                                  :: inv[t] == old(inv[t])
                                  && inv[t][..] == old(inv[t][..]);
            {
                res[r] := resmap[req[i].bloodType][j];
                r := r + 1;
                j := j + 1;
            }
            i := i + 1;
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    // method Request(req: array<Request>) returns (res: array<Blood>)
    //     modifies this`inv;
    //     requires Valid();
    //     requires req != null;
    //     requires forall i | 0 <= i < req.Length :: validBloodType(req[i].bloodType)
    //                                             && 0 < req[i].volume <= inv[req[i].bloodType].Length;
    //     requires forall i, j | 0 <= i < j < req.Length :: req[i].bloodType != req[j].bloodType;
    //     ensures  Valid();
    //     ensures  forall i | 0 <= i < req.Length :: fresh(inv[req[i].bloodType])
    //                                             && inv[req[i].bloodType][..] == old(inv[req[i].bloodType][req[i].volume..]);
    //     ensures  res != null;
    //     ensures  res.Length == cumulativeVolume(req, req.Length);
    //     ensures  fresh(res);
    //     // ensures  forall i | 0 <= i < req.Length :: res[cumulativeVolume(req, i)..cumulativeVolume(req, i + 1)]
    //     //                                                == old(inv[req[i].bloodType][..req[i].volume]);
    //     // ensures  forall i | 0 <= i < res.Length :: res[i] != null;

    //     // ensure other blood buckets are unchanged
    //     ensures  forall t | validBloodType(t) && (forall i | 0 <= i < req.Length :: req[i].bloodType != t)
    //                      :: inv[t] == old(inv[t])
    //                      && inv[t][..] == old(inv[t][..]);
    // {
    //     var resmap := RequestManyTypes(req);

    //     res := new Blood[cumulativeVolume(req, req.Length)];
    //     var i := 0;
    //     while i < req.Length
    //         invariant 0 <= i <= req.Length;
    //         invariant Valid();
    //         invariant req[..] == old(req[..]);
    //         invariant forall j | 0 <= j < req.Length :: fresh(inv[req[j].bloodType])
    //                                                  && inv[req[j].bloodType][..] == old(inv[req[j].bloodType][req[j].volume..]);
    //         invariant res != null;
    //         invariant fresh(res);
    //         invariant res.Length == cumulativeVolume(req, req.Length);
    //         invariant forall t | validBloodType(t) :: res != inv[t];

    //         invariant forall j | 0 <= j < i :: res[cumulativeVolume(req, j)..cumulativeVolume(req, j + 1)]
    //                                                == old(inv[req[j].bloodType][..req[j].volume]);
    //         invariant forall j | 0 <= j < cumulativeVolume(req, i) :: res[j] != null;
            
    //         // ensure other blood buckets are unchanged
    //         invariant forall t | validBloodType(t) && (forall i | 0 <= i < req.Length :: req[i].bloodType != t)
    //                           :: inv[t] == old(inv[t])
    //                           && inv[t][..] == old(inv[t][..]);
    //     {
    //         forall j | 0 <= j < resmap[req[i].bloodType].Length
    //         {
    //             res[cumulativeVolume(req, i) + j] := resmap[req[i].bloodType][j];
    //         }
    //         i := i + 1;
    //     }
    // }