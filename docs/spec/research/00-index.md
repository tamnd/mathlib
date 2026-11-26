# Research index

Two research reports support spec 2148. Both were checked on 2026-11-26. They are in `research/sources/`, about 100 KB in total. Each report uses the same tags:
- [P]: a primary source that was seen in the check (the GitHub API, the repository file, the live documentation files);
- [S]: a secondary source (a paper, a blog, a page that can be out of date);
- [U]: unverified, or an estimate. Check it or measure it before any use.

| Report | File | Lines | Scope |
|---|---|---|---|
| A | `A-mathlib-state-and-release.md` | 489 | the releases of Lean and Mathlib, the tags and branches; the size and growth of Mathlib; the directory tree; the curated lists; the update mechanisms for downstream projects; the deprecation policy; the large changes of 2025 and 2026; the implications for a project that tracks the latest |
| B | `B-docs-tools-extraction.md` | 329 | the existing human texts and the gap; doc-gen4 and its output files; the extraction tools; search tools and informalization datasets; blueprint tools; the book build tools; the licences |

## Ten facts that shape the spec

1. **The latest is v4.36.0, and `master` is past it** (A §0, §1). Lean v4.36.0 and the Mathlib tag `v4.36.0` = `fc4f59e577` came out on 2026-11-16. `master` is `b9019de30e` on v4.37.0-rc1, 263 commits later. The sibling pin v4.35.0 is about 1,100 commits behind. The first edition is v4.36.0 (05).
2. **About 330k declarations in about 8,740 modules** (B §0, A §0). 246,930 theorems, 44,961 definitions, 31,095 instances. Most are API lemmas. This is why the handbook has four depths and a Catalogue (04, 06.4).
3. **One Lean minor a month; a tag is a snapshot of `master`** (A §1). Stable tags do not change and have a cache; RCs can repeat. Editions follow stable tags only (05.2).
4. **Deprecations are deleted after about 6 months** (A §5.4). A workflow on the 15th of each month deletes aliases and module shims older than 6 months. The edge must never fall more than about 5 months behind, and the project keeps its own rename table (05.3, 05.4).
5. **`downstream-reports` gives the last known good and the first known bad commit** (A §5.2, §5.3). PFR follows `master` with it every 6 hours. The daily bump of the companion copies that workflow (05.3).
6. **Some breaks have no alias** (A §5.5, §7.3). Removed structure fields and private imports break with no hint. The build failure and the FKB commit are the only signal (05.4, class `silent`).
7. **The library is changing form** (A §6). The module system with `requiresModuleSystem`, `grind`, the `Basic/` folder (about 1,000 files may move), `@[to_dual]`, Verso docstrings. The companion is `module` files, and sections are keyed by names and concept ids, not paths (05.4, 10.2).
8. **The curated lists are checked seeds** (A §4, §7.3). `overview.yaml` (504), `undergrad.yaml` (562), `100.yaml` (100), `1000.yaml` (1,199) and `Wanted/`. Mathlib's CI checks their names. They give the E3 lists and the concept ids (04.4, 05.4).
9. **The docs site already gives every name, docstring and source link as JSON** (B §2). `declaration-data.bmp` and `header-data.bmp` need no build. They lack types as terms, hashes and dependency edges, so the project still writes its own index program (10.5).
10. **No textbook of the mathematics of Mathlib exists** (B §1). MIL is a tutorial, the Phrasebook is a how-to, the Mathlib Manual is archived, and the Mathlib Initiative does not plan one. The handbook is a complement to them (01.3).

## Where each spec document draws on the reports

| Doc | Main reports |
|---|---|
| 01 research | A, B |
| 03 the library | A §3, §6 |
| 04 coverage | A §2, §4; B §0 |
| 05 tracking | A §1, §5, §6, §7 |
| 06 volumes | A §3, §4 |
| 09 the map | A §4, §7.3; B §2 |
| 10 the companion | A §5.1, §6.1; B §3, §6 |
| 11 the agent | B §3, §4 |
| 12 the builder | B §6, §7 |
| 16 open questions | A §7.5; B "Risks" |

## Items to measure or recheck

These items are [U] in the reports and change numbers in the spec:

1. The time and memory of `scripts/Index.lean` on the whole of Mathlib (10.5; M0).
2. The size of an index asset, raw and compressed (08.4; M0).
3. The pages, tokens and review hours per section, on V00, V05 and V13 (04.7, 11.6; M1).
4. The round-trip pass rate of the E1 sentences, with and without the LeanSearch seed (14.3, Q-10; M1).
5. The record count and the error rate of the LeanSearch v2 corpus (B §4).
6. The new declarations per month, from the drift records (15.2; M1).
7. Whether `bump/v4.X.0` stays on `mathlib4` and the community page is updated (A §1.4).
8. The release date of Lean v4.37.0, which opens the second edition (A §1.1).
9. The licence and glyph coverage of JuliaMono (Q-08).
10. Whether any textbook of the library has started since the search of 2026-11-26 (B §1).
