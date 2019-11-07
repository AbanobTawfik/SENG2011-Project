/* Querying
 *
 * Queries an array of blood objects by attribute.
 */

include "Blood.dfy"
include "Filtering.dfy"

method queryBloodByType(inv: array<Blood>, bloodType: string) returns (result: array<Blood>)
requires inv != null
ensures result != null
ensures result.Length == Matches(inv, inv.Length, (b: Blood) requires b != null reads b => b.GetBloodType() == bloodType)
ensures result[..] == VerifyFilter(inv, inv.Length, (b: Blood) requires b != null reads b => b.GetBloodType() == bloodType)
{ result := Filter(inv, (b: Blood) requires b != null reads b => b.GetBloodType() == bloodType); }

method queryBloodByAge(inv: array<Blood>, start: int, end: int) returns (result: array<Blood>)
requires inv != null
ensures result != null
ensures result.Length == Matches(inv, inv.Length, (b: Blood) requires b != null reads b => start <= b.GetDateDonated() <= end)
ensures result[..] == VerifyFilter(inv, inv.Length, (b: Blood) requires b != null reads b => start <= b.GetDateDonated() <= end)
{ result := Filter(inv, (b: Blood) requires b != null reads b => start <= b.GetDateDonated() <= end); }

function method countBloodByType(inv: array<Blood>, bloodType: string): int
reads inv
requires inv != null
reads set i | 0 <= i < inv.Length :: inv[i]
{ Matches(inv, inv.Length, (b: Blood) requires b != null reads b => b.GetBloodType() == bloodType) }
