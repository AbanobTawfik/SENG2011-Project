/* Querying and Sorting
 *
 * From QueryBloodInventory.dfy and SortBloodInventory.dfy
 */

// Returns a new array containing only blood objects of a specific blood type.
// Taken directly from QueryBloodInventory.dfy
export function filterByType(inv: any, bloodType: string): any {
  return Filtering.Filter(inv, b => b.bloodType == bloodType);
}

// Returns a new array containing only blood objects in a specified date range.
// `start` and `end` must be in Unix time format (use Date.parse()).
// Taken directly from QueryBloodInventory.dfy
export function filterByDate(inv: any, start: number, end: number): any {
  return Filtering.Filter(inv, b => start <= Date.parse(b.dateDonated) && Date.parse(b.dateDonated) <= end);
}

// Returns a new array containing only blood objects of `min` <= age <= `max` (in days).
export function filterByAge(inv: any, min: number, max: number): any {
  return Filtering.Filter(inv, b => {
    var age = (Date.now() - Date.parse(b.dateDonated)) / (1000*60*60*24) | 0
    return ((!min || min <= age) && (!max || age <= max))
  });
}

// Sort inventory in place by bloodType.
export function sortByType(inv: any, desc?: boolean) {
  sortInventory(inv, desc ? SortByTypeDesc : SortByTypeAsc);
}

// Sort inventory in place by dateProduced.
export function sortByDate(inv: any, desc?: boolean) {
  sortInventory(inv, desc ? SortByDateDesc : SortByDateAsc);
}

enum BloodType { APlus, AMinus,
      BPlus, BMinus,
      OPlus, OMinus,
      ABPlus, ABMinus }

function sortInventory(inv: any, module: any) {

  const map = {
    "A+":   BloodType.APlus,
    "A-":   BloodType.AMinus,
    "B+":   BloodType.BPlus,
    "B-":   BloodType.BMinus,
    "AB+":  BloodType.ABPlus,
    "AB-":  BloodType.ABMinus,
    "O+":   BloodType.OPlus,
    "O-":   BloodType.OMinus,
  }
  // Convert bloodType strings to enumeration form, and dateDonated to days ago
  inv.forEach(item => {
    item.bloodType = map[item.bloodType];
    item.timeProduced = Date.parse(item.dateDonated); // Converts to Unix time
  })

  // Sort using the specified Dafny-verified merge sort module
  module.BloodInventorySort(inv);

  // Revert bloodType enumerations back to strings
  inv.forEach(item => {
    item.bloodType = Object.keys(map).find(key => map[key] == item.bloodType);
    delete item.timeProduced
  })
}

/**
 * Taken directly from Filtering.dfy
 */
module Filtering {

  export function Filter<T>(a: Array<T>, test: (T) => boolean): Array<T>
  {
    // Determine the total length of the resulting array
    var count = 0; var i = 0;
    while (i < a.length)
    {
      if (test(a[i])) { count = count + 1; }
      i = i + 1;
    }
    var b = new Array<T>(count);
    // Copy the filtered elements to the new resulting array
    var j = 0; i = 0;
    while (i < a.length)
    {
      if (test(a[i]))
      {
        b[j] = a[i];
        j = j + 1;
      }
      i = i + 1;
    }
    return b;
  }
}

/**
 * Taken directly from SortBloodInventory.dfy
 */
module SortByTypeAsc {

  function refineBloodType(a: BloodType): number
  {
    switch (a) {
      case BloodType.APlus:   { return 0 }
      case BloodType.AMinus:  { return 1 }
      case BloodType.BPlus:   { return 2 }
      case BloodType.BMinus:  { return 3 }
      case BloodType.ABPlus:  { return 4 }
      case BloodType.ABMinus: { return 5 }
      case BloodType.OPlus:   { return 6 }
      case BloodType.OMinus:  { return 7 }
    }
  }

  function compareBloodTypeLt(a: BloodType, b: BloodType): boolean
  {
    return refineBloodType(a) < refineBloodType(b);
  }

  interface BloodItem { bloodType: BloodType, timeProduced: number }

  function compareBloodItemLt(a: BloodItem, b: BloodItem): boolean
  {
    if (compareBloodTypeLt(a.bloodType, b.bloodType)) return true
    else {
      if (compareBloodTypeLt(b.bloodType, a.bloodType))
        return false
      else return a.timeProduced < b.timeProduced
    }
  }

  function compareBloodItemLe(a: BloodItem, b: BloodItem): boolean
  {
    return compareBloodItemLt(a, b)
    || (
           !compareBloodItemLt(a, b)
        && !compareBloodItemLt(b, a)
    )
  }

  export function BloodInventorySort(inv: Array<BloodItem>)
  {
    MergeSort(inv);
  }

  /* -------------------------- */
  /* - Modified MergeSort.dfy - */
  /* -------------------------- */

  function MergeSort(a: Array<BloodItem>)
  {
    if (a.length == 0) {
      return;
    }
    DoMergeSort(a, 0, a.length);
  }

  function DoMergeSort(a: Array<BloodItem>, l: number, r: number)
  {
    if (l == r - 1) {
      return;
    }
    var m = (l + r) / 2 | 0;

    DoMergeSort(a, l, m);
    DoMergeSort(a, m, r);
    Merge(a, l, m, r);
  }

  function Merge(a: Array<BloodItem>, l: number, m: number, r: number)
  {
    var b = new Array<BloodItem>(a.length);
    var i = l;
    var j = m;
    var k = l;

    while (i < m || j < r)
    {
      if (i == m) {
        b[k] = a[j];
        j = j + 1;
      } else if (j == r) {
        b[k] = a[i];
        i = i + 1;
      } else if (compareBloodItemLe(a[i], a[j])) {
        b[k] = a[i];
        i = i + 1;
      } else {
        b[k] = a[j];
        j = j + 1;
      }
      k = k + 1;
    }
    // Copy sorted items from b back to a
    i = l;
    while (i < r)
    {
      a[i] = b[i];
      i = i + 1;
    }
  }
}

/**
 * SortBloodInventory.dfy but with the bloodType comparison inverted
 */
module SortByTypeDesc {

  function refineBloodType(a: BloodType): number
  {
    switch (a) {
      case BloodType.APlus:   { return 0 }
      case BloodType.AMinus:  { return 1 }
      case BloodType.BPlus:   { return 2 }
      case BloodType.BMinus:  { return 3 }
      case BloodType.ABPlus:  { return 4 }
      case BloodType.ABMinus: { return 5 }
      case BloodType.OPlus:   { return 6 }
      case BloodType.OMinus:  { return 7 }
    }
  }

  function compareBloodTypeLt(a: BloodType, b: BloodType): boolean
  {
    return refineBloodType(a) > refineBloodType(b); // inverted!
  }

  interface BloodItem { bloodType: BloodType, timeProduced: number }

  function compareBloodItemLt(a: BloodItem, b: BloodItem): boolean
  {
    if (compareBloodTypeLt(a.bloodType, b.bloodType)) return true
    else {
      if (compareBloodTypeLt(b.bloodType, a.bloodType))
        return false
      else return a.timeProduced < b.timeProduced
    }
  }

  function compareBloodItemLe(a: BloodItem, b: BloodItem): boolean
  {
    return compareBloodItemLt(a, b)
    || (
           !compareBloodItemLt(a, b)
        && !compareBloodItemLt(b, a)
    )
  }

  export function BloodInventorySort(inv: Array<BloodItem>)
  {
    MergeSort(inv);
  }

  /* -------------------------- */
  /* - Modified MergeSort.dfy - */
  /* -------------------------- */

  function MergeSort(a: Array<BloodItem>)
  {
    if (a.length == 0) {
      return;
    }
    DoMergeSort(a, 0, a.length);
  }

  function DoMergeSort(a: Array<BloodItem>, l: number, r: number)
  {
    if (l == r - 1) {
      return;
    }
    var m = (l + r) / 2 | 0;

    DoMergeSort(a, l, m);
    DoMergeSort(a, m, r);
    Merge(a, l, m, r);
  }

  function Merge(a: Array<BloodItem>, l: number, m: number, r: number)
  {
    var b = new Array<BloodItem>(a.length);
    var i = l;
    var j = m;
    var k = l;

    while (i < m || j < r)
    {
      if (i == m) {
        b[k] = a[j];
        j = j + 1;
      } else if (j == r) {
        b[k] = a[i];
        i = i + 1;
      } else if (compareBloodItemLe(a[i], a[j])) {
        b[k] = a[i];
        i = i + 1;
      } else {
        b[k] = a[j];
        j = j + 1;
      }
      k = k + 1;
    }
    // Copy sorted items from b back to a
    i = l;
    while (i < r)
    {
      a[i] = b[i];
      i = i + 1;
    }
  }
}

/**
 * SortBloodInventory.dfy but comparing timeProduced instead
 */
module SortByDateAsc {

  function refineBloodType(a: BloodType): number
  {
    switch (a) {
      case BloodType.APlus:   { return 0 }
      case BloodType.AMinus:  { return 1 }
      case BloodType.BPlus:   { return 2 }
      case BloodType.BMinus:  { return 3 }
      case BloodType.ABPlus:  { return 4 }
      case BloodType.ABMinus: { return 5 }
      case BloodType.OPlus:   { return 6 }
      case BloodType.OMinus:  { return 7 }
    }
  }

  function compareBloodTypeLt(a: BloodType, b: BloodType): boolean
  {
    return refineBloodType(a) < refineBloodType(b);
  }

  interface BloodItem { bloodType: BloodType, timeProduced: number }

  function compareBloodItemLt(a: BloodItem, b: BloodItem): boolean
  {
    if (a.timeProduced > b.timeProduced) return true // using timeProduced!
    else {
      if (b.timeProduced > a.timeProduced)
        return false
      else return compareBloodTypeLt(a.bloodType, b.bloodType)
    }
  }

  function compareBloodItemLe(a: BloodItem, b: BloodItem): boolean
  {
    return compareBloodItemLt(a, b)
    || (
           !compareBloodItemLt(a, b)
        && !compareBloodItemLt(b, a)
    )
  }

  export function BloodInventorySort(inv: Array<BloodItem>)
  {
    MergeSort(inv);
  }

  /* -------------------------- */
  /* - Modified MergeSort.dfy - */
  /* -------------------------- */

  function MergeSort(a: Array<BloodItem>)
  {
    if (a.length == 0) {
      return;
    }
    DoMergeSort(a, 0, a.length);
  }

  function DoMergeSort(a: Array<BloodItem>, l: number, r: number)
  {
    if (l == r - 1) {
      return;
    }
    var m = (l + r) / 2 | 0;

    DoMergeSort(a, l, m);
    DoMergeSort(a, m, r);
    Merge(a, l, m, r);
  }

  function Merge(a: Array<BloodItem>, l: number, m: number, r: number)
  {
    var b = new Array<BloodItem>(a.length);
    var i = l;
    var j = m;
    var k = l;

    while (i < m || j < r)
    {
      if (i == m) {
        b[k] = a[j];
        j = j + 1;
      } else if (j == r) {
        b[k] = a[i];
        i = i + 1;
      } else if (compareBloodItemLe(a[i], a[j])) {
        b[k] = a[i];
        i = i + 1;
      } else {
        b[k] = a[j];
        j = j + 1;
      }
      k = k + 1;
    }
    // Copy sorted items from b back to a
    i = l;
    while (i < r)
    {
      a[i] = b[i];
      i = i + 1;
    }
  }
}

/**
 * SortBloodInventory.dfy but using inverted timeProduced comparison instead
 */
module SortByDateDesc {

  function refineBloodType(a: BloodType): number
  {
    switch (a) {
      case BloodType.APlus:   { return 0 }
      case BloodType.AMinus:  { return 1 }
      case BloodType.BPlus:   { return 2 }
      case BloodType.BMinus:  { return 3 }
      case BloodType.ABPlus:  { return 4 }
      case BloodType.ABMinus: { return 5 }
      case BloodType.OPlus:   { return 6 }
      case BloodType.OMinus:  { return 7 }
    }
  }

  function compareBloodTypeLt(a: BloodType, b: BloodType): boolean
  {
    return refineBloodType(a) < refineBloodType(b);
  }

  interface BloodItem { bloodType: BloodType, timeProduced: number }

  function compareBloodItemLt(a: BloodItem, b: BloodItem): boolean
  {
    if (a.timeProduced < b.timeProduced) return true // using inverted timeProduced!
    else {
      if (b.timeProduced < a.timeProduced)
        return false
      else return compareBloodTypeLt(a.bloodType, b.bloodType)
    }
  }

  function compareBloodItemLe(a: BloodItem, b: BloodItem): boolean
  {
    return compareBloodItemLt(a, b)
    || (
           !compareBloodItemLt(a, b)
        && !compareBloodItemLt(b, a)
    )
  }

  export function BloodInventorySort(inv: Array<BloodItem>)
  {
    MergeSort(inv);
  }

  /* -------------------------- */
  /* - Modified MergeSort.dfy - */
  /* -------------------------- */

  function MergeSort(a: Array<BloodItem>)
  {
    if (a.length == 0) {
      return;
    }
    DoMergeSort(a, 0, a.length);
  }

  function DoMergeSort(a: Array<BloodItem>, l: number, r: number)
  {
    if (l == r - 1) {
      return;
    }
    var m = (l + r) / 2 | 0;

    DoMergeSort(a, l, m);
    DoMergeSort(a, m, r);
    Merge(a, l, m, r);
  }

  function Merge(a: Array<BloodItem>, l: number, m: number, r: number)
  {
    var b = new Array<BloodItem>(a.length);
    var i = l;
    var j = m;
    var k = l;

    while (i < m || j < r)
    {
      if (i == m) {
        b[k] = a[j];
        j = j + 1;
      } else if (j == r) {
        b[k] = a[i];
        i = i + 1;
      } else if (compareBloodItemLe(a[i], a[j])) {
        b[k] = a[i];
        i = i + 1;
      } else {
        b[k] = a[j];
        j = j + 1;
      }
      k = k + 1;
    }
    // Copy sorted items from b back to a
    i = l;
    while (i < r)
    {
      a[i] = b[i];
      i = i + 1;
    }
  }
}

