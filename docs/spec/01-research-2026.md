# 01. Research: Mathlib and its texts in November 2026

This document gives the facts that the spec rests on. They come from the two reports in `research/sources/`: report A on the state of Mathlib and its releases, and report B on the documentation, the tools and the extraction of declarations. Both are a snapshot of 2026-11-26. The tags give the strength of each fact:

- **[P]** checked against a primary source on 2026-11-26 (the GitHub API, the repository, the live files);
- **[S]** from a secondary source (a paper, a blog, a page that can be out of date);
- **[U]** not checked, or an estimate. Each [U] fact has a milestone at which the project measures it.

## 1.1 The library

| Fact | Value | Tag | Report |
|---|---|---|---|
| Latest Lean stable | v4.36.0, 2026-11-16 | P | A §1.1 |
| Latest Lean RC | v4.37.0-rc1, 2026-11-18 | P | A §1.1 |
| Latest Mathlib stable tag | `v4.36.0` = `fc4f59e577` | P | A §1.2 |
| Mathlib `master` | `b9019de30e`, on v4.37.0-rc1, 263 commits after v4.36.0 | P | A §0 |
| `.lean` files in `Mathlib/` | 8,737 | P | A §0 |
| Lines | 2,518,855 | P | A §2 |
| Declarations of Mathlib in the docs index | 332,173: 246,930 theorems, 44,961 defs, 31,095 instances, 4,782 constructors, 2,033 classes, 1,707 structures, 340 opaques, 325 inductives | P | B §0 |
| Definitions and theorems on the stats page | 142,208 and 296,731 (a different count: the page counts `def` and `theorem` commands, with auxiliary declarations) | P | A §2 |
| Growth | about 36k lines, 130 files and 800 commits a month | P | A §2.2 |
| Module churn | about 120 new and 32 removed or renamed module paths between two stable tags | P | A §5.5 |
| Top-level folders | 31, with `Algebra` 1,407 files, `CategoryTheory` 1,140, `Analysis` 820, `RingTheory` 736, `Topology` 709, `Data` 663, `Tactic` 423 | P | A §3 |
| Dependency graph | 308,129 declarations, 8.4 million edges, 7,563 modules, at an earlier snapshot | S | B §0 |

The number that the spec uses for the size of the library is **about 330k declarations in about 8,740 modules** (04.7). About 75% are theorems, and most of them are API lemmas: `simp` lemmas, `_iff` forms, left and right forms, additive and multiplicative twins. The depth model of 04 is built for that shape.

### The curated lists

Mathlib keeps four lists in `docs/` that map mathematics to declarations. Mathlib's CI checks their names (`scripts/yaml_check.py`), so they are a reliable seed for the E3 lists (04.4) and for the concept ids (05.4).

| File | Entries | Use in the spec | Tag |
|---|---|---|---|
| `docs/overview.yaml` | 504 | the E3 seed for every volume; the concept ids | P |
| `docs/undergrad.yaml` | 562, of which about 133 are marked missing | path U of 06.6; the `<?missing?>` lists | P |
| `docs/100.yaml` | 100, of which 78 are done | E3 in the volume of each theorem | P |
| `docs/1000.yaml` | 1,199, of which 220 are in Mathlib, with Wikidata Q-ids | E3 for those in Mathlib; concept ids | P |
| `Wanted/**/*.lean` | 17 files of `proof_wanted` (since #42284, 2026-08-11) | the `<?missing?>` lists | P |

### The changes of 2025 and 2026

The handbook is written for the library of 2026, not for the library that most tutorials describe. Report A §6 lists the changes. Those that change what the text says:

1. **The module system.** Every Mathlib file starts with `module` and `public import` since #31786 (2025-11-19). Since #41950 (2026-09-28) Mathlib sets `requiresModuleSystem`, and non-module downstream projects get a warning [P]. Passes that make `public import`s private (#46228, 639 imports, 2026-11-21) change what a file can see [P]. V00 explains the file header; the companion uses `module` files (10.2).
2. **`grind`.** An SMT-style tactic in core since Lean v4.22. Thousands of Mathlib proofs use it [S]. `CC` is removed. V34 has a chapter on it.
3. **`Basic/`.** A new top-level folder (#39703, 2026-08-26) for basic predicates and types. 52 files have moved from `Data/` and `Logic/` so far, and about 1,000 more could follow [P]. The volume map is by prefix and includes `Basic/` (09.2).
4. **`@[to_dual]`.** A translation attribute for order duality, next to `@[to_additive]`, on a common `Translate/` base [P]. V01 explains both.
5. **Verso docstrings.** 1,352 files use `doc.verso` since #45031 (October 2026) [P]. The index program reads both kinds (10.5).
6. **The release infrastructure.** The nightly-testing fork is retired (November 2026). `bump/v4.X.0` now lives on `mathlib4`. The `downstream-reports` service and the `hopscotch` tool are new [P]. 05.3 uses them.

## 1.2 How Mathlib is released and how projects follow it

1. One Lean minor version a month, stable near the middle of the month, the next RC within about three days [P, A §1.1]. v4.29 to v4.30 took two months, so the cadence is not exact.
2. A Mathlib tag is the first `master` commit on the new toolchain. No fix goes back into a tag [P, A §1.3].
3. Every `master` commit and every tag has an olean cache [P, A §5.1].
4. Deprecated aliases and `deprecated_module` shims are deleted after about 6 months, by a workflow on the 15th of each month [P, A §5.4]. No written policy page was found; the 6 months come from the workflow defaults and the pull request titles.
5. About 1,172 files contain `deprecated (since` and about 154 contain `deprecated_module` [P, approximate, A §5.4].

The flagship downstream projects follow Mathlib in two ways [P, A §5.3]:

| Project | Strategy |
|---|---|
| PFR | automatic: `downstream-reports` `track-incompatibility` with `open-pr: true`, every 6 hours, on `master` |
| FLT | by hand, about weekly, to `master` and tags, with a record of each Mathlib pull request that broke it |
| Carleson | by hand, at each release |
| PrimeNumberTheoremAnd, physlib | pinned to each stable tag, bumped within days |

The tools for a downstream bump [P, A §5.2]:

| Tool | What it does |
|---|---|
| `downstream-reports` | builds the registered downstream projects against `master` twice a day; bisects a failure to the last known good and the first known bad commit; composite actions `bump-to-latest`, `open-bump-pr`, `query-latest`, `track-incompatibility`; 36 entries |
| `mathlib-update-action` | steps through the tags in order, then `master`; `intermediate_releases: all, latest, stable, master` |
| `lean-update` | a general `lake update`, build and pull request |
| `hopscotch` | steps or bisects a range of commits; proposes fixes for `deprecated_module` shims |

05 builds the tracking mechanism from these facts.

## 1.3 The texts that exist, and the gap

| Text | What it is | Licence | Tag |
|---|---|---|---|
| *Mathematics in Lean* (Avigad, Massot) | a tutorial on the use of Mathlib, 13 topics, at v4.34.0 | text CC BY 4.0, code Apache-2.0 | P |
| *Theorem Proving in Lean 4* | the type theory and the language, almost no Mathlib | Apache-2.0 | P |
| *Functional Programming in Lean* | Lean as a programming language | CC BY 4.0 | P |
| *The Mechanics of Proof* (Macbeth) | a first course in proof | all rights reserved | P |
| Natural Number Game | a game on Peano arithmetic | Apache-2.0 | P |
| *Formalising Mathematics* (Buzzard) | a course; the last edition is 2024 | Apache-2.0 | P |
| *A Lean companion to Analysis I* (Tao) | Lean versions of the definitions, theorems and exercises of one book | Apache-2.0 | P |
| Lean Language Reference | the language manual, with a tactic reference | Apache-2.0 | P |
| Mathlib Manual | project set-up and tactics; **archived on 2026-02-04** | Apache-2.0 | P |
| Mathlib Phrasebook | "how do I say ... in Mathlib", 23 chapters; it does not explain why | **no licence** | P |
| Module docstrings and library notes | the "Main definitions" and "Main results" of each file; about 35 library notes | Apache-2.0 | P |
| doc-gen4 pages | one page per module, a signature and a docstring per declaration | Apache-2.0 | P |
| LeanSearch, LeanExplore, Herald | one-line machine informalizations of declarations | Apache-2.0 (code and the LeanSearch and Herald data) | P |

The Mathlib Initiative roadmap for October 2026 to March 2027 plans tactic documentation, the Verso migration of docstrings, 50 Phrasebook entries and the autoformalization of 20 textbooks. It does not plan a textbook of the mathematics of Mathlib [P, B §1].

**The gap.** Each existing text is a tutorial on the use of Lean, a language manual, a how-to, a companion to one outside book, generated documentation, or one-line machine text. No text sets out, area by area, the mathematics that Mathlib has, in the way of a graduate textbook: the definitions with their motivation, the main theorems with proofs, examples, and the links between the parts, all tied to the real declaration names [P for the list above; U for the absence beyond a web search on 2026-11-26]. That gap is the goal of 02.

The handbook is a complement, not a rival:
- it links to MIL for the use of Lean and to the Phrasebook for how-tos;
- V00 is the only part that teaches Lean, and it points to TPIL and MIL;
- the project tells the community on Zulip what it is doing before the first release (15, M0), so that it is not seen as a machine-made copy of their work.

## 1.4 The tools for extraction and build

### Extraction

| Source | Gives | Lacks | Tag |
|---|---|---|---|
| doc-gen4 `declaration-data.bmp` (5.9 MB gzip) | every name, kind, doc link, module, import graph, instances | types, docstrings | P |
| doc-gen4 `header-data.bmp` (62 MB gzip, 1.2 GB raw) | every docstring, the signature as HTML with links, a source link pinned to a commit with a line range | the `Expr`, the dependency edges | P |
| doc-gen4 SQLite `api-docs.db` | a clean table of every declaration | not published; types as BLOBs | P |
| `lean4export` | kernel terms as NDJSON | docstrings, ranges | P |
| jixia | declarations, symbols, a reference graph, proof states | its last release is v4.28.0-rc1; it lags Mathlib | P |
| LeanDojo | traced theorems | deprecated; v2 is for training | P |
| Pantograph, `repl` | a machine REPL | | P |
| Lean metaprogramming | `env.constants`, `findDeclarationRanges?`, `findDocString?`, `collectAxioms`, `getDeprecatedNewName`: all that the index needs, in about 100 lines | | P |
| `crossrefs.json` | the `@[stacks]` and Wikidata tags of Mathlib declarations | | P |

The spec uses two tiers (08.4, 10.5):
- **the doc-gen4 JSON** as a cheap source that needs no build: names, kinds, docstrings and source links, refreshed every 8 hours by the Mathlib docs build. It is the fallback of 05.8;
- **the project's own `scripts/Index.lean`**, built on the Lean metaprogramming API, for what the JSON does not have: type hashes, value hashes, deprecation targets, attributes and the uses graph, at the same commit as the companion.

The doc-gen4 build of the Mathlib docs takes about 24 minutes on the community's own runner and runs every 8 hours [P]. A cold run needs a large machine [U, measured at M0].

### Checks

`leanchecker` is in core since Lean v4.28 and replays the kernel. `lake comparator` and `lake check` are in core since v4.35 and check that a module proves given statements with given axioms. `#print axioms` lists the axioms of a declaration. `checkdecls` (Massot) is the pattern for the name check of `mlhb check` [P, B §3, §5].

### Search

Loogle has a JSON API and updates to the latest Mathlib every 6 hours. LeanSearch v2 has a semantic search API. Moogle is probably dead [U]. The roles use Loogle on a local index only (11.2), so that no project data goes to an outside service.

### Seeds for the E1 sentences

The LeanSearch v2 corpus (Apache-2.0, 332 MB, one record per declaration of v4.28.0-rc1, with an informal name and a description in LaTeX) is the best ready seed [P]. Herald is a second one (Apache-2.0, 580k statements) [P]. They are not textbook text, and they have errors [S]. The spec allows them as an input to the informalizer, never as output: every E1 sentence is written by the informalizer and passes the checks of 14.3. Q-10 asks whether to use the seed at all.

### Build of the books

| Option | For | Against | Tag |
|---|---|---|---|
| Verso | every snippet elaborated; hovers; the community standard (TPIL, FP in Lean, the Reference) | no EPUB output; prose in Lean files is hard for the writer pipeline; tied to the toolchain | P |
| SubVerso | the highlighted JSON of anchored Lean, for any renderer; tested on every Lean release | its format is not a public API | P |
| pandoc, LaTeX, Tectonic | the pipeline of the sibling handbooks; EPUB 3 with MathML | no Lean grammar in skylighting or KDE | P |
| `minted` | | needs shell escape, which Tectonic does not allow | P |

The spec uses the pipeline of the sibling handbooks with SubVerso tokens turned into LaTeX macros and HTML spans (12.5), as Verso's own `HighlightedToTex` does. A `lean4.xml` KDE grammar is written as a fallback for Lean text that is not checked, for example in the Notes and history part.

## 1.5 The licences

| Material | Licence | What the handbook does | Tag |
|---|---|---|---|
| Mathlib code and docstrings | Apache-2.0, no NOTICE file | quotes signatures and docstrings; names Mathlib, its licence and the commit on the copyright page; ships a `NOTICE` and the licence text | P |
| The handbook text | CC BY 4.0 | the LICENSE says that CC BY 4.0 applies to the text except the quoted Mathlib material | P (the precedent of MIL) |
| The map records | CC0 | | |
| MIL text | CC BY 4.0 | may be adapted with attribution; the spec prefers a link | P |
| *Mechanics of Proof*, the Phrasebook, verso-blueprint | all rights reserved or no licence | never copied | P |
| LeanSearch and Herald data | Apache-2.0 | input only; attributed in `NOTICE` if used | P |
| Text written with a model | depends on the provider and the place [U] | every section has a human editor in `reviewed_by`, and the editors are credited | U |

Short quotations of signatures may not be protected at all [U, legal opinion]. The spec does not rely on that and gives the attribution anyway. Q-09 asks the Mathlib maintainers what form of attribution they want.

## 1.6 What the research changes in the plan

1. **Track `master`, print at tags.** The library moves too fast for a book pinned to one tag, and the deletion of deprecations after 6 months sets a hard limit on how far behind a project can be. 05 follows.
2. **The size is known.** About 330k declarations is too many for prose on each. The depth model of 04 and the Catalogue of 06.4 follow.
3. **The seeds are good.** The curated lists, the module docstrings and the `crossrefs.json` give the E3 lists, the section plans and the concept ids without guesswork.
4. **The infrastructure of the community does most of the bump.** `downstream-reports` gives the LKG and the FKB, so the project writes no bisect of its own.
5. **No book does this.** The gap is real, and the handbook is a complement to MIL and the Phrasebook.
6. **Start at v4.36.0, not v4.35.0.** The sibling pin is about 1,100 commits behind. The first edition is the v4.36.0 edition.
