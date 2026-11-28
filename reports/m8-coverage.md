# The C-E3 measure at the start of M8

This report gives C-E3 for the whole library after the first draft of all 35 volumes. M8 needs C-E3 at 100% at the edition commit (spec 15, row M8). The report gives the distance to that goal and the plan for M8.

## How the numbers are made

The method is the same as in `reports/m5-coverage.md`. The new part is the curated part of C-E3 (mathlib-agent#37). It counts only the E3 candidates from a curated list or from the top of the used-by ranking.

- Mathlib commit: e54979a532 (the index of the edition).
- Handbook: v0.8.0, with the first draft of V00 to V34.
- The record is `records/coverage.json`, with the date 2026-11-28.

## The numbers

The column "Curated" gives the curated part of C-E3. V00 has no E3 candidate, so it is not in the table.

| Volume | Declarations | E3 candidates | C-home | C-depth | C-E3 | Curated |
|---|---|---|---|---|---|---|
| V01 | 5,002 | 60 | 38% | 35% | 7% | 0% |
| V02 | 7,978 | 124 | 42% | 40% | 11% | 40% |
| V03 | 12,412 | 132 | 30% | 27% | 11% | 55% |
| V04 | 21,777 | 329 | 23% | 16% | 7% | 25% |
| V05 | 24,928 | 377 | 19% | 17% | 4% | 25% |
| V06 | 12,225 | 228 | 27% | 26% | 12% | 54% |
| V07 | 11,967 | 432 | 32% | 30% | 8% | 38% |
| V08 | 5,928 | 163 | 69% | 66% | 14% | 52% |
| V09 | 15,250 | 536 | 10% | 9% | 4% | 17% |
| V10 | 8,612 | 534 | 30% | 28% | 6% | 50% |
| V11 | 4,132 | 252 | 86% | 80% | 15% | 61% |
| V12 | 7,355 | 351 | 35% | 33% | 9% | 30% |
| V13 | 20,493 | 489 | 27% | 24% | 8% | 27% |
| V14 | 8,617 | 198 | 67% | 63% | 8% | 38% |
| V15 | 6,632 | 249 | 56% | 51% | 6% | 21% |
| V16 | 13,515 | 593 | 27% | 26% | 7% | 45% |
| V17 | 4,095 | 110 | 76% | 69% | 20% | 33% |
| V18 | 13,872 | 419 | 52% | 46% | 11% | 33% |
| V19 | 4,481 | 177 | 66% | 61% | 19% | 37% |
| V20 | 4,358 | 224 | 77% | 73% | 23% | 87% |
| V21 | 1,197 | 55 | 100% | 97% | 51% | 86% |
| V22 | 4,821 | 178 | 98% | 94% | 34% | 52% |
| V23 | 4,795 | 163 | 97% | 92% | 14% | 36% |
| V24 | 34,110 | 180 | 29% | 28% | 11% | 87% |
| V25 | 13,161 | 160 | 38% | 37% | 14% | 60% |
| V26 | 14,280 | 88 | 54% | 53% | 28% | 50% |
| V27 | 8,301 | 85 | 99% | 98% | 19% | 100% |
| V28 | 7,613 | 263 | 100% | 96% | 30% | 100% |
| V29 | 4,974 | 284 | 100% | 96% | 37% | 100% |
| V30 | 8,131 | 384 | 52% | 50% | 26% | 66% |
| V31 | 3,268 | 42 | 98% | 95% | 40% | 85% |
| V32 | 4,442 | 192 | 100% | 97% | 59% | 94% |
| V33 | 5,632 | 92 | 100% | 98% | 42% | 100% |
| V34 | 7,451 | 82 | 5% | 1% | 0% | 0% |
| All | 335,808 | 8,225 | 44% | 41% | 14% | 44% |

At M5, C-E3 was 6% and the curated part was 24%. The drafts of M6 and M7 gave the increase.

## What the numbers show

1. The volumes of M6 and M7 (V21, V22, V27 to V29 and V31 to V33) have a home for almost every module. The writers of these volumes got a list of all the modules of the volume, and each module went into one section.
2. The older volumes have a home for less than half of their modules. V34 (5%), V09 (10%), V05 (19%), V04 (23%) and V24 (29%) are the lowest. Their sections cover the main modules of each area, but many modules have no section.
3. The curated part is at 100% only in V27, V28, V29 and V33. V01 and V34 have no curated candidate with E3 text.
4. The docstring part is far from 100% in all volumes. Most of its names are technical steps of one proof.

## The plan for M8

1. **Homes for all modules.** For each volume with C-home below 95%, a pass gives each module with no home to one section, the same way as for the volumes of M6 and M7. A module that has no place in a section gets a new section. When this pass is complete, C-home is 100% and C-depth follows from the E1 and E0 records.
2. **The E3 pass of the curated part.** For each volume, the pass adds each curated name with an E3 proof in a section to `explains: E3` in the front matter of that section. Where no section proves a curated name, the pass writes the proof. The target is 100% for the curated part.
3. **Lowered names.** `mlib coverage` does not read the `lower` field of 04.4 yet. When it does, a name under a "Main results" heading that a section lowers with a reason counts as done, and it needs E2 text.
4. The measure runs again at the end of each pass and at each edition.
