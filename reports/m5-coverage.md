# The C-E3 measure at M5

This report gives C-E3 for the whole library, as the acceptance of M5 asks (spec 15, row M5). It also sets again the plan for the E3 candidates that have no E3 text.

## How the numbers are made

`mlib coverage -book` reads the front matter of each section of tamnd/mathlib-handbook that is not `planned` (mathlib-agent#26). A name in an `explains: E3` list has an E3 treatment. A module has a home when a section lists it in `modules`. The depth that each declaration needs comes from the rules of spec 04.4.

- Mathlib commit: e54979a532 (the index of the edition).
- Handbook: v0.5.0, with 366 drafted sections in V00 to V07, V09 to V18, V20 and V34.
- The record is `records/coverage.json`, with the date 2026-11-27.

## The numbers

The table gives the volumes that have text, and the whole library. The other volumes have no text yet, so all their numbers are 0%. V00 has only 3 declarations and no E3 candidate, so it is not in the table.

| Volume | Declarations | E3 candidates | C-home | C-depth | C-E3 |
|---|---|---|---|---|---|
| V01 | 5,002 | 60 | 38% | 35% | 7% |
| V02 | 7,978 | 124 | 42% | 40% | 11% |
| V03 | 12,412 | 132 | 30% | 27% | 11% |
| V04 | 21,777 | 329 | 23% | 16% | 7% |
| V05 | 24,928 | 377 | 19% | 17% | 4% |
| V06 | 12,225 | 228 | 27% | 26% | 12% |
| V07 | 11,967 | 432 | 32% | 30% | 8% |
| V09 | 15,250 | 536 | 10% | 9% | 4% |
| V10 | 8,612 | 534 | 30% | 28% | 6% |
| V11 | 4,132 | 252 | 86% | 80% | 15% |
| V12 | 7,355 | 351 | 35% | 33% | 9% |
| V13 | 20,493 | 489 | 27% | 24% | 8% |
| V14 | 8,617 | 198 | 67% | 63% | 8% |
| V15 | 6,632 | 249 | 56% | 51% | 6% |
| V16 | 13,515 | 593 | 27% | 26% | 7% |
| V17 | 4,095 | 110 | 76% | 69% | 20% |
| V18 | 13,872 | 419 | 52% | 46% | 11% |
| V20 | 4,358 | 224 | 77% | 73% | 23% |
| V34 | 7,451 | 82 | 5% | 1% | 0% |
| All | 335,808 | 8,225 | 21% | 18% | 6% |

The whole library has 8,225 E3 candidates, and 478 of them (6%) have an E3 treatment.

## Where the E3 candidates come from

| Rule of 04.4 | Candidates | With E3 text | Share |
|---|---|---|---|
| In a curated list (overview, undergrad, 100, 1000) | 936 | 222 | 24% |
| A class or a structure at the top of the used-by ranking | 21 | 4 | 19% |
| A name under a "Main results" heading of its module docstring | 7,268 | 252 | 3% |

The names under a "Main results" heading are 88% of the candidates. A module docstring often lists all the main declarations of the file, and many of these are technical steps of one proof. The drafts give E3 text to the theorems that a student reads first, and these are mostly in the curated lists.

## The plan for the rest

1. The curated lists and the top classes (957 names) stay E3 with no exception. Each volume that has text gets an E3 pass before its release: the pass adds the names of its modules to `explains: E3` where a section proves them, and writes a section where none does. The target is 100% for these names at the release of each volume.
2. For a name under a "Main results" heading, the E3 pass of the volume either gives E3 text, or lowers the name with a reason in the front matter, as 04.4 allows (`lower: {Foo.bar: "a technical step of the proof of Foo.baz"}`). A lowered name needs E2 text. The pass does not lower a name that a curated list has.
3. The coverage record gets the two parts of C-E3 apart: the curated part and the docstring part. The release rule of 12.6 uses the curated part. The docstring part goes to 100% at G4 (M8), with the lowered names counted as done.
4. The measure runs again at each edition. The weekly report gives C-E3 for each volume that has text.

At the present rate of about 1.3 E3 names a section, the drafts do not reach the docstring part. So the E3 pass of item 2 is a separate task in the queue of the writer and the reviewer, with an estimate of one hour of review for each 20 names.
