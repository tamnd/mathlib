# mathlib

A map of Mathlib for The Mathlib Handbook. This is not a fork of Mathlib.

Mathlib is the mathematical library of the Lean theorem prover. Its home is [leanprover-community/mathlib4](https://github.com/leanprover-community/mathlib4). This repository has no copy of Mathlib and no Lean code. It holds what the handbook project decides about Mathlib and what its tools record about it: the volume map, the section plans, the families, the depth of each declaration, the coverage, the drift of the library over time and the editions.

The Mathlib Handbook is a textbook of all the mathematics in Mathlib, written by mathematicians for students. It is true to the latest Mathlib, and it comes as PDF, EPUB and HTML books. The site is https://mathlib.tamnd.com.

## The repositories

| Repository | Content |
|---|---|
| mathlib (this repository) | the map: the volume map, the section plans, the records, the spec and the pages of the site |
| [mathlib-lean](https://github.com/tamnd/mathlib-lean) | the Lean package `MathlibHandbook`: the examples, the exercises, the solutions and the programs that read Mathlib |
| [mathlib-agent](https://github.com/tamnd/mathlib-agent) | `mlib`, the toolchain: the index, the sync, the coverage, the drift and the site |
| [mathlib-handbook](https://github.com/tamnd/mathlib-handbook) | the text of the 35 volumes and `mlhb`, the builder of the PDF, EPUB and HTML books |

## How the handbook stays true to the latest Mathlib

1. The companion mathlib-lean follows Mathlib `master` at the last commit that is known to build. A workflow moves it each day.
2. At each move, a Lean program writes the index of Mathlib: each declaration with its kind, its module, its type hash and its docstring.
3. `mlib sync` compares the new index with the last one. A renamed declaration gets its new name in the text. A changed declaration marks its section `stale` for repair.
4. Each stable Mathlib tag `v4.X.0` gives an edition. Only editions are printed. The first edition is v4.36.0.

The details are in spec 05.

## Status

The project is at milestone M0: the repositories, the index, the sync and the site skeleton. No volume is released yet. The work goes in milestones. Each milestone has a tracking issue with the label `milestone`. The plan is in `docs/spec/15-milestones.md`.

| Milestone | Target | Goal | Release |
|---|---|---|---|
| M0 | 2026-12-20 | the repositories, the index, the sync, the site skeleton | v0.1.0 |
| M1 | 2027-02-28 | the voice, the guide volumes, the first measurements | v0.2.0 |
| M2 | 2027-05-31 | the first undergraduate volumes | v0.3.0 |
| M3 | 2027-09-30 | the undergraduate core, and every declaration at E1 | v0.4.0 |
| M4 | 2028-01-31 | the first graduate year, first half | v0.5.0 |
| M5 | 2028-05-31 | the core textbook | v1.0.0 |
| M6 | 2028-10-31 | geometry and categories | v1.1.0 |
| M7 | 2029-03-31 | the higher structures | v1.2.0 |
| M8 | 2029-07-31 | the whole textbook | v2.0.0 |
| M9 | open | true to the latest and used | v2.x |

The dates are targets. A patch release marks a set of merged pull requests inside a milestone. A minor or major release closes a milestone. The four repositories release the same version at the same time.

## Layout

| Path | Content |
|---|---|
| `docs/spec/` | the spec: the research of 2026, the goal, the library, the coverage, the tracking, the volumes, the section, the architecture and the milestones |
| `docs/spec/research/` | the research reports A and B, with their sources |
| `blueprint/milestones.yaml` | the milestones M0 to M9, with their dates and releases |
| `records/` | the records that tools write: the modules, the depths, the coverage, the drift and the editions |
| `reports/` | the milestone and edition reports |

## Licence

The text is CC BY 4.0 (`LICENSES/CC-BY-4.0.txt`). The records in `records/` are CC0 1.0 (`LICENSES/CC0-1.0.txt`). Names and docstrings of Mathlib in the records come from Mathlib under Apache-2.0.
