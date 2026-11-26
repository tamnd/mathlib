# 02. The goal

## 2.1 The goal in one sentence

Write the mathematics of Mathlib as a series of textbooks, from an expert to a student, that explains every definition and theorem of the library at a depth that fits its role, proves the main theorems on paper, computes examples that Lean checks, and stays true to the latest Mathlib by a mechanism that finds each change and repairs the text, with PDF and EPUB releases for each edition.

## 2.2 Why now

1. **Mathlib is the largest single body of checked mathematics, and almost nobody can read it.** It covers most of an undergraduate degree and large parts of graduate algebra, analysis, topology, number theory, category theory and probability (01.1, 03). The only human-facing texts are tutorials on Lean (*Mathematics in Lean*, *Theorem Proving in Lean*), the docstrings, and the generated documentation (01.3). None of them teaches the mathematics of the library as a textbook does. A student who wants to know what Mathlib knows about Sobolev spaces or about Dedekind domains must read Lean source.
2. **The mathematics of Mathlib is not the mathematics of the textbooks.** It is more general (filters in place of sequences, `ConditionallyCompleteLinearOrder` in place of $\mathbb{R}$, bundled morphism classes), and it has conventions that surprise a mathematician (junk values, truncated subtraction, `Set` and `Finset` as different objects). A book that explains the textbook mathematics and the Mathlib form side by side does not exist.
3. **Models can now write good mathematical prose, and Lean can check the claims that matter.** The sibling handbooks (singularity, langlands, mmp) show that a writer role with a checked Lean companion produces drafts that a reviewer can fix in hours, not days. Here the source is better than for the research handbooks: every statement already exists in a checked form, so the fidelity question is narrower (14.3).
4. **The library changes every day, so a printed book is stale at once.** A handbook of Mathlib is only useful if it tracks the library. The tools to do that exist: the Lean environment can be read in full, Mathlib keeps deprecated aliases for renamed declarations, and the monthly tags give fixed points (05). No other book about a software library has had a way to stay true, and this one can.
5. **The sibling projects give the tools.** The map, the builder, the agent roles, the site and the release workflow come from tamnd/singularity and tamnd/mmp (08). This project changes the subject and adds the tracking.

## 2.3 Levels of success

The levels are independent. The site reports each one (13.2).

| Level | Name | What it means | Measured by |
|---|---|---|---|
| G1 | The map of the library | every module of Mathlib at the edition commit has a home volume and a home section; every declaration has a computed depth; the index, the families and the dependency graph are public | C-home of 04.5 at 100% for the planned sections |
| G2 | Every declaration in words | every declaration has an E1 sentence or an E0 family that passes the fidelity checks of 14.3; the Catalogue (06.4) is released | C-depth at E1 at 100% |
| G3 | The core textbook | Volumes 0 to 12 (06.2, the undergraduate core and the first graduate year) are `reviewed` and released as PDF and EPUB | releases; C-review |
| G4 | The whole textbook | all volumes of 06.2 are released, and C-E3 is 100% for the library | releases; C-E3 |
| G5 | True to the latest | for twelve months in a row, each monthly edition comes out within 14 days of its Mathlib tag with C-fresh at least 95%, and the edge build of the site (05.2) is never more than 7 days behind Mathlib `master` | the edition log (05.7) |
| G6 | Used | the handbook is cited in Mathlib docstrings or the Mathlib website as a reading for an area, and the site has an outside reviewer for at least ten volumes | links; reviewer list |

G1 and G2 are engineering with a known end: they need the index and the informalizer role. G3 and G4 are the main work and need people to review. G5 is the property that makes the project different from a book. G6 depends on others.

## 2.4 The meaning of "all"

The request is to write all the handbook volumes and to explain every definition, theorem, proof and example. The spec reads it as four commitments.

1. **Every declaration has a home and an explanation.** The coverage rule of 04 makes this exact. "Every" includes the E1 sentence and the E0 family, which are short on purpose.
2. **Every main theorem has a proof on paper.** E3 theorems get full proofs, E2 theorems get proofs or proof ideas (04.8). An E1 lemma is proved by its Lean proof.
3. **Every main definition has examples, and the examples are new.** Mathlib has almost no examples in the library (04.9). The handbook writes them, and Lean checks them.
4. **All of the library, not a selection.** The volumes of 06 cover every top-level folder of `Mathlib/`, including the parts that a curriculum would skip (`Mathlib/Computability`, `Mathlib/ModelTheory`, `Mathlib/Condensed`, `Mathlib/Tactic`). The order of the volumes is a teaching order, not the order of the folders.

"All" also covers the reader below the library: Volume 0 teaches enough Lean to read the Mathlib boxes, and Volume 1 teaches the conventions of Mathlib (03.4) before any mathematics.

## 2.5 Non-goals

1. **Not a Lean tutorial.** *Mathematics in Lean* and *Theorem Proving in Lean* teach how to write proofs in Lean. The handbook teaches mathematics and how Mathlib states it. Volume 0 is the only Lean course, and it points to those books for more.
2. **Not a replacement for the Mathlib documentation.** The generated docs give every signature. The handbook gives the meaning and the proofs, and it links to the docs of the edition.
3. **Not new mathematics in Lean.** `tamnd/mathlib-lean` holds examples, exercises and solutions. It does not grow the library. A useful lemma that the project finds missing goes to Mathlib as a pull request (10.6), not into the companion package.
4. **Not a fork of Mathlib.** The name `tamnd/mathlib` is the map repository of this project. It holds records about Mathlib and no copy of its code (09.1, 16 Q-01).
5. **Not the core library or Batteries.** They are covered only as far as Mathlib users need them (04.6).
6. **Not a frozen book.** A release is a snapshot of a rolling text. The project does not promise that a printed edition stays correct for a later Mathlib.

## 2.6 What would show the plan is wrong

| Signal | What it would mean | Response |
|---|---|---|
| The E1 sentences fail the round-trip check (14.3) for more than 15% of a sample after two prompt revisions | the informalizer cannot state Mathlib declarations in words well enough | E1 for that area becomes the signature with a template sentence; human writing for E3 only |
| A volume takes more than three times its planned review hours | the writer drafts are too weak, or the plan is too wide | cut the volume to E3 and E2 of the curated lists; leave the rest to the Catalogue |
| More than 10% of the E3 sections go `stale` in a month | Mathlib moves faster than the refresher can follow, or the sections bind too tightly to the Lean names | loosen the binding (only E3 names in the text, the rest in the generated table); slow the edition cadence to two months |
| No outside reviewer answers the letters of M0 by M2 (15) | the reviews depend on the owner alone | release the core volumes as `checked` drafts, with a clear mark; ask the Lean community channels again |
| Mathlib starts its own book of the mathematics of the library | the project duplicates work | offer the text and the tools to that effort under its licence (12.8) |
| The cost of the writer and informalizer roles is above the budget of 15.2 by M2 | the plan is too expensive | E1 by template for E0-like E1 declarations; slow the volume plan |
