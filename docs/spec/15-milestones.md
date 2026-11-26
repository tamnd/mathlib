# 15. Milestones

Each milestone has a goal, exit criteria and a release. The four repositories release the same version at the same time. A patch release (v0.1.1) marks a set of merged pull requests inside a milestone. A minor or major release closes a milestone. A tool can check each exit criterion, or a named person signs it. The dates are targets set on 2026-11-26. The levels G1 to G6 are those of 02.3, the volumes V00 to V34 those of 06.2, the coverage numbers those of 04.5, and the editions those of 05.6.

Each milestone after M0 also has a standing criterion: **the edition of each stable Mathlib tag in the milestone came out within 14 days of the tag** (05.6). A missed edition does not stop the milestone, but the milestone report says why it was missed.

| Milestone | Target | Goal | Exit criteria | Release |
|---|---|---|---|---|
| M0 | 2026-12-20 | the repositories, the index, the sync, the site skeleton | the four repositories exist (after the owner confirms, 00 decision 1, Q-01); `tamnd/mathlib-lean` is `module` files, builds at the LKG of `master` with the daily bump of 05.3 running, and is registered in `downstream-reports` or runs the fallback (Q-11); `scripts/Index.lean` runs on the self-hosted runner and its first index asset is on `tamnd/mathlib`, with the time and memory measured (10.5); `mlib index fetch`, `mlib sync`, `mlib coverage`, `mlib volumes check` and `mlib site build` work; `blueprint/volumes.yaml` gives every module of `Mathlib/` a home volume (`mlib volumes orphans` is empty); the depth of every declaration computed (G1 in part); mathlib.tamnd.com shows `/decl/`, `/module/`, `/area/`, `/coverage/` and `/drift/`; the edge build of the site runs daily; the post on the Lean Zulip and the letters to the Mathlib maintainers (Q-09) and to the area reviewers (14.5) sent | v0.1.0 of the four repositories |
| M1 | 2027-02-28 | the voice, the guide volumes, the first measurements | V00, V01 and V34 drafted and `checked`, with every Mathlib box passing the checker; the section plans of V00 to V07 and V13 accepted; the informalizer has written and checked the E1 records of V01 to V05 and V13, with the round-trip pass rate and the human sample rate (14.3) measured; the families of `to_additive`, `to_dual`, `simps` and the map-operation pattern accepted (09.4); three full sections drafted in each of V05 and V13, and the measured pages, tokens and review hours per section written to `reports/` (04.7, 11.6); the page plan of 06.2 and the budget redone from the measurements; the evaluation sets of 11.7 in use; the first editions: v4.36.0 (2026-12) and the next tag, with the edition log of 05.7 | v0.2.0: V00 released, V01 and V34 as `-draft`; the Catalogue volumes C01 to C05 and C13 |
| M2 | 2027-05-31 | the first undergraduate volumes | V01, V34 released; V02, V03, V04, V05 drafted and `checked`; V05 and V13 have their reviewer (14.5); the E1 records of Part I to Part III at 100% (C-depth at E1); the refresher has cleared at least three months of drift with C-fresh at least 95% at each edition; the first patch release from a reader report (14.6) | v0.3.0: V00, V01, V34 released; V02 to V05 as `-draft`; the Catalogue of Parts I to III |
| M3 | 2027-09-30 | the undergraduate core (path U) | V02 to V07, V13 and V15 released; the reading path U of 06.6 complete in print and on the site; `/teach/` with path U as a course and the exercises by grade; G2 met: every declaration of the library has an E1 sentence or an E0 family that passes 14.3, and the full Catalogue is released | v0.4.0; the full Catalogue |
| M4 | 2028-01-31 | the first graduate year, first half | V09, V11, V14, V16 and V18 released; V10, V12, V17, V20 drafted; five areas with an outside reviewer | v0.5.0 |
| M5 | 2028-05-31 | the core textbook (G3) | V00 to V12 released (G3), with V14 to V18 and V20; the paths A, N and G of 06.6 in print; C-E3 measured for the whole library and the plan for the rest redone | v1.0.0 |
| M6 | 2028-10-31 | geometry and categories | V19, V21, V22, V23, V24, V30, V31 released; V25, V26, V29, V32, V33 drafted | v1.1.0 |
| M7 | 2029-03-31 | the higher structures | V25, V26, V27, V29, V32, V33 released; V28 drafted; paths T and C of 06.6 in print | v1.2.0 |
| M8 | 2029-07-31 | the whole textbook (G4) | V28 released, so V00 to V34 are all out; C-E3 at 100% for the library at the edition commit; the twelve-month count of G5 started at M3 or before | v2.0.0 |
| M9 | open | true to the latest and used (G5, G6) | twelve editions in a row that meet G5 (05.7); the handbook cited from Mathlib docstrings or the Mathlib website as a reading for an area; ten volumes with an outside reviewer | v2.x, one minor release per edition |

The informalizer and the family role run ahead of the writer (06.7). The planner works one milestone ahead: the section plans of the volumes of M(n+1) are accepted during M(n).

## 15.1 What can slip and what cannot

- **The tracking mechanism (M0) cannot slip.** The daily bump, the index, the sync and the stale marks are what makes the handbook a text of the latest Mathlib and not a book of one tag. A volume written before the sync works would have no `mathlib` commit to be true at.
- **The measurements of M1 cannot slip.** The page plan, the budget and the dates of M2 to M8 are first estimates (04.7, 06.2, 11.6). M1 measures them on V00, V05 and V13, and the dates of M2 to M8 are set again in the M1 report.
- **G2 (M3) is engineering.** It needs the informalizer, the family role and the checks of 14.3, not reviewers. If the round-trip pass rate stays below 85% after two prompt revisions, the response of 02.6 applies.
- **The order of the volumes can change.** The queue of 11.5 follows the reader demand. A volume with an outside reviewer who is ready can move before one that has none.
- **The graduate volumes depend on reviewers.** A volume is released only with a `full` review of every E3 section (14.5). If no reviewer answers for an area, the volume stays as a `-draft` with the coverage numbers on its first page, and the milestone report says so.
- **Large Mathlib refactors can stop a volume.** When more than 10% of the E3 sections of a volume go stale in a month (05.8), the volume leaves the next edition as a draft. The milestone that has it slips by one edition, not more.

## 15.2 The budget

- **Agent budget.** It starts at 200 dollars a day, as in the sibling projects (11.6). The first full pass is in the order of 3 to 4 billion tokens. At M1 the owner sets the budget again from the measured tokens per section and per E1 record.
- **The spread of the spend.** M0 to M3 spend most on the informalizer and the round trip (G2). M2 to M8 spend most on the writer and the checker. After M8 the spend is the refresher, the porter and the informalizer for new declarations: about 3,000 new declarations a month [U, measured from the drift records at M1].
- **Machines.**
  - The self-hosted runner for the index program, the bump and the edition builds: 32 to 64 GB of memory and 100 GB of disk (10.5) [U, measured at M0]. It is the largest machine cost.
  - The site and the edge builds run on the hosted runners and the Cloudflare Worker of the sibling sites.
  - The REPL sandbox for the hard exercises (11.2) runs on the same runner.
- **People.** The reviews are the limit of the plan. The plan assumes one reviewer for each volume of Parts I to III by M4, and the owner for the guide volumes and the style. The letters of M0 ask for them. If fewer answer, the volumes release later. The exit criteria do not change.
- **The cost of staying fresh.** After the first pass, each month costs the refresher work of about 800 Mathlib commits. M2 measures it: the refresher items, their tokens and the review minutes for each edition. If it is more than a third of the monthly budget, the response of 02.6 applies: only E3 names in the text, the rest in the generated reference tables.
