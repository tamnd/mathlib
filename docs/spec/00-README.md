# Spec 2148: The Mathlib Handbook

A textbook of all the mathematics in Mathlib, written by an expert for a student, true to the latest Mathlib, with PDF and EPUB releases for each edition.

Written 2026-11-26. This is a design spec. It follows the sibling specs of tamnd/singularity and tamnd/mmp (2161, 2161mmp) in its form and its tools. The research behind it is in `research/sources/` (reports A and B, about 100 KB, index in `research/00-index.md`).

## The project in one paragraph

Four repositories:
- `tamnd/mathlib`: the map of the library for the handbook. It holds the volume map, the section plans, the families, the E1 sentences, and the records that tools write: the index summaries, the drift, the coverage and the editions. It is not a fork of Mathlib;
- `tamnd/mathlib-lean`: the Lean package `MathlibHandbook`, with the checked examples, the exercises and their solutions, the extraction programs, and the daily bump against Mathlib `master`;
- `tamnd/mathlib-agent`: `mlib`, the toolchain and the model roles;
- `tamnd/mathlib-handbook`: the text of 35 volumes (V00 to V34) and a generated Catalogue, and `mlhb`, the builder of the PDF, the EPUB and the HTML.

The handbook explains every declaration of Mathlib, about 330k of them, at a depth that fits its role (04):
- E3, the main definitions and theorems: full textbook treatment, a proof on paper, examples that Lean checks, exercises;
- E2: stated, with a short proof or a proof idea;
- E1: one sentence in words, checked against the type;
- E0: explained as a member of a family, such as the `to_additive` twins.

Each section has a mathematical text that a reader can read alone, and Mathlib boxes that say how the library states the same thing and where it differs from the textbooks (07). The text follows Mathlib `master` each day. Each stable Mathlib tag gives an edition, and only editions are printed (05). Everything is published at https://mathlib.tamnd.com.

## What changed in 2026

1. **Mathlib is large and moves fast.** 8,737 files, 2.5 million lines and about 330k declarations on 2026-11-26. It grows by about 800 commits and 36k lines a month, and about 25 module paths disappear each month (01.1).
2. **The latest is v4.36.0, and `master` is already past it.** Lean v4.36.0 and the Mathlib tag `v4.36.0` (`fc4f59e577`) came out on 2026-11-16. `master` is on v4.37.0-rc1, 263 commits later. The sibling projects pin v4.35.0, about 1,100 commits behind (05.1).
3. **Deprecations last about 6 months.** A Mathlib workflow deletes deprecated aliases and module shims each month on the 15th. A text that falls more than about 5 months behind loses the hints that say where a name went (05.3).
4. **The community has the tools to follow `master`.** The `downstream-reports` service gives the last known good and the first known bad commit of a downstream project twice a day. PFR follows `master` with it every 6 hours (01.2, 05.3).
5. **The library changed form.** The module system (`module`, `public import`) since late 2025, `grind`, the `Basic/` folder, `@[to_dual]` and Verso docstrings (01.1). Most tutorials show the library before these changes.
6. **No textbook of the library exists.** *Mathematics in Lean* teaches the use of Mathlib in 13 topics. The Phrasebook gives how-tos and says that it does not explain why. The Mathlib Manual was archived in February 2026. The Mathlib Initiative plans docstrings and autoformalization, not a textbook (01.3).

## The documents

| Doc | Title | Read it for |
|---|---|---|
| [01](01-research-2026.md) | Research: Mathlib and its texts in November 2026 | the facts: the size, the releases, the existing texts and the gap, the tools, the licences |
| [02](02-the-goal.md) | The goal | the levels G1 to G6, the meaning of "all", non-goals, what would show the plan is wrong |
| [03](03-the-library.md) | Mathlib as mathematics | the foundation, the design ideas, the areas, the conventions that surprise a mathematician, what Mathlib does not have |
| [04](04-coverage-model.md) | Coverage | the depths E0 to E3, which declaration gets which depth, the coverage numbers, size and cost |
| [05](05-tracking-latest.md) | Tracking the latest Mathlib | edge and edition, the daily bump, the drift classes, the rename harvest, the stale marks, the edition workflow |
| [06](06-the-volumes.md) | The volumes | V00 to V34, their main theorems and examples, the Catalogue, the dependencies, the reading paths, the order of writing |
| [07](07-section-format.md) | The section | the reader and the voice, the eight parts, the Mathlib box, the reference table, the front matter, a worked example |
| [08](08-architecture.md) | Architecture | the four repositories, the data flows, the six flows, where the big data lives |
| [09](09-mathlib-repo.md) | `tamnd/mathlib` | the layout of the map, the volume map, the index and the informal records, the families, the graph |
| [10](10-mathlib-lean.md) | `tamnd/mathlib-lean` | the layout, the Lean rules, the examples and exercises, the index program, the pins |
| [11](11-mathlib-agent.md) | `tamnd/mathlib-agent` | `mlib`, Lean access, the roles, the prompts, the queue, the budget, the evaluation |
| [12](12-mathlib-handbook.md) | `tamnd/mathlib-handbook` | `mlhb`, the checks, the directives, Lean in print, editions and releases, the licence |
| [13](13-site.md) | The site | the pages, the declaration page, edge and edition |
| [14](14-quality.md) | Quality | the faults T1 to T10, the checks of a section and of an E1 sentence, reviewers, errors after release |
| [15](15-milestones.md) | Milestones | M0 (2026-12-20) to M9, exit criteria, the budget |
| [16](16-open-questions.md) | Open questions | Q-01 to Q-24, and the questions for the maintainers and the reviewers |
| [research/](research/00-index.md) | The research reports | A the state of Mathlib and its releases, B the documentation, tools and extraction |

**Reading order.**
- Mathematicians and reviewers: 02, 03, 06, 07, 14.
- Engineers: 05, 08, 09, 10, 11, 12, 15.
- The Mathlib community: 01.3, 02.5, 05, 12.8, 16.1.
- Everyone: 00, 02, 16.

## Decisions made in this spec

1. **Four repositories with the names of the request,** after the owner confirms. `tamnd/mathlib` is the map, not a fork: its README says so in its first line (Q-01).
2. **The Lean root is `MathlibHandbook`, never `Mathlib`.** Two roots named `Mathlib` cannot share a workspace (08.1).
3. **The commands are `mlib` and `mlhb`.** `mhb` is taken by mmp-handbook (Q-02).
4. **"Every declaration" means four depths.** Every declaration has a home section and an explanation, but only the main ones get a textbook treatment. The depth comes from rules and the curated lists of Mathlib, and people override it with a reason (04).
5. **The text follows `master`; the print follows the stable tags.** The companion bumps through the last known good commit every 6 hours. An edition is cut at each stable tag `v4.X.0`, never at an RC, and is named by the tag (05.2).
6. **The first edition is v4.36.0.** The project does not take the v4.35.0 pin of the sibling projects (05.3, 10.7).
7. **Drift is found by type hash, and renames by the deprecation records.** The tools rewrite names and modules. A change of meaning marks the section `stale` and goes to the refresher role with a person to accept it (05.4, 05.5).
8. **Sections are keyed by declaration names and concept ids, not by file paths,** so the ongoing moves of `Data/` and `Logic/` to `Basic/` change no text (05.4).
9. **A textbook first, Lean second.** Each section is complete without its Mathlib boxes. Lean blocks come from checked files by anchor and are never pasted (07).
10. **The examples and exercises are new and checked.** Mathlib has almost no examples. The companion holds them, and Lean checks them at each bump (10).
11. **Text that says what the library does not say is the main fault.** The checker gets the Lean types from the index, not from the writer. E1 sentences pass a round trip to Lean, a critic and a human sample (14).
12. **The pipeline of the sibling handbooks,** with SubVerso tokens for the Lean in print, so there is no shell escape (12.5).
13. **Licences.** Text CC BY 4.0, records CC0, Lean Apache-2.0, tools MIT. Quoted Mathlib material stays Apache-2.0, with a `NOTICE` and the commit on each copyright page (12.8).
14. **Style.** ASD-STE100: short sentences, active voice, no "we", no em or en dashes.

## The first four weeks (milestone M0, 2026-12-20)

1. Create the four repositories, after the owner confirms the names (Q-01, Q-02). Copy the skeletons of mmp, mmp-lean, mmp-agent and mmp-handbook, with the names of 08.1.
2. Write `tamnd/mathlib-lean` as `module` files on the LKG of `master`. Add the bump workflow of 05.3: register in `downstream-reports` after a post on Zulip (Q-11), or start with `mathlib-update-action`.
3. Write `scripts/Index.lean` from the `Export.lean` of mmp-lean. Run it on the self-hosted runner, measure the time and the memory, and upload the first index asset (10.5).
4. Write `mlib index fetch`, `mlib sync`, `mlib coverage` and `mlib volumes`. Write `blueprint/volumes.yaml` from 06.2 until `mlib volumes orphans` is empty.
5. Copy the site skeleton from mmp-agent. Deploy `/decl/`, `/module/`, `/area/`, `/coverage/` and `/drift/` to mathlib.tamnd.com, with the daily edge build.
6. Run the planner role on V00, V01 and V34, and start the informalizer on V01 and V05 (15, M1).
7. Send the post on the Lean Zulip and the letter to the Mathlib maintainers (16.1), and the first letters to area reviewers (16.2).
8. Open the v4.36.0 edition: the branch `edition/v4.36.0` of the companion at `fc4f59e577`, and the record in `records/editions.json` (05.6).
