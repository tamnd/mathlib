# 04. Coverage: what "all of Mathlib" means

The goal is a handbook that explains every definition, theorem, proof and example of Mathlib. Mathlib has several hundred thousand declarations (01.1), and it grows by several thousand each month. A book that gives a page to each declaration would be longer than any person could read, and it would be stale before it was printed. This document turns "every" into a rule that a tool can measure, and that is still honest.

## 4.1 The rule in one paragraph

Every declaration of Mathlib at the edition commit has a home section, and every home section explains it at one of four depths. The main definitions and theorems get a full textbook treatment (E3). Their supporting results get a statement and a short proof (E2). Every other named declaration gets a sentence in words in the reference table of its section (E1). The mechanical lemmas (simp lemmas, coercion lemmas, instances, `_iff` and `_def` forms) are explained as families with a naming pattern (E0). A declaration with no home, or a home that does not explain it at its required depth, is a coverage fault. The site and the release notes give the coverage numbers of each edition, and the release of a volume needs full coverage of its modules.

## 4.2 The units

| Unit | What it is | Source |
|---|---|---|
| Module | one Lean file of `Mathlib/`, for example `Mathlib.Analysis.Calculus.MeanValue` | the import graph of the edition commit |
| Declaration | one constant of the environment that a user can name | the index (09.3), with the filter of 4.6 |
| Family | a set of declarations that share a pattern and a meaning, for example the `map_*` lemmas of a bundled hom class | the family records (09.4) |
| Section | one file of the handbook; it covers modules and homes declarations (07.2) | the handbook front matter |
| Volume | a book (06) | `volume.yaml` |

Each module has exactly one **home volume**, from the volume map `blueprint/volumes.yaml` (09.2). The map assigns a module by its path prefix, with explicit exceptions. A new module at a known prefix has a home volume at once. A new prefix is a fault until a person adds it to the map.

## 4.3 The four depths

| Depth | Name | What the reader gets | Who writes it | Checked by |
|---|---|---|---|---|
| E3 | full | the statement in standard notation with a number; a full proof on paper; at least one example; a Mathlib box; exercises | writer role, then a person | checker role; reviewer |
| E2 | stated | the statement with a number; a proof of a few lines or a proof idea with a reference; a Mathlib box or a line in the table | writer role | checker role; reviewer |
| E1 | named | one or two sentences in words in the reference table: what it says, with the hypotheses that matter | informalizer role (11.3) | the fidelity checks of 14.3 |
| E0 | family | the family pattern explained in part 5 of the section; the declaration is a member | writer role, from the family record | `mlhb check`: the pattern matches |

E3 and E2 are the textbook. E1 and E0 are the reference that makes "every" true. A reader who wants the mathematics reads E3 and E2. A reader who meets an unknown name in a Lean file finds its home section and its sentence on the site (13.3).

## 4.4 Which declarations get which depth

The depth of a declaration is computed, then a person can change it in the front matter of its section. The rule, in order:

1. **E3 candidates.** A declaration is a candidate for E3 if one of these holds:
   - it is in one of Mathlib's curated lists: `docs/overview.yaml`, `docs/undergrad.yaml`, `docs/100.yaml`, `docs/1000.yaml` (01.1);
   - it is named under a heading "Main definitions", "Main results", "Main statements" or "Main theorems" of the module docstring of its file. Most Mathlib files have such a docstring;
   - it is a `structure` or a `class` that other modules extend or use as a hypothesis, with a rank in the top 2% of the dependency graph (09.5).
2. **E2 candidates.** A theorem that is not E3 and is used by at least five other declarations outside its own module, or that has a docstring with a name ("the Bolzano-Weierstrass theorem"), or that an E3 proof in the handbook cites.
3. **E0.** A declaration that matches a family record (09.4): the `simp` lemmas of the form `f (g x) = h x` for a coercion or a constructor; the `@[simps]` projections; the `_iff`, `_def`, `_apply`, `_eq`, `_mk`, `coe_*`, `map_*`, `mem_*` lemmas of a set or a structure; the `@[to_additive]` twins (the additive twin of an E3 or E2 declaration has the same depth as its source, and the text names both); instances that only combine other instances; auxiliary definitions whose names end in `Aux` or `_aux`.
4. **E1.** All other declarations.

The tool writes the computed depth to `records/depth.json` (09.3). The handbook front matter can raise a declaration to E3 or E2. It can lower a declaration only with a reason in the front matter, for example `lower: {Foo.bar: "a technical step of the proof of Foo.baz"}`.

## 4.5 The coverage numbers

`mlib coverage` computes, for each edition, each volume and each module:

| Number | Meaning |
|---|---|
| C-home | the share of declarations with a home section |
| C-depth | the share of declarations explained at their required depth or higher |
| C-E3 | the E3 candidates that have an E3 treatment |
| C-fresh | the share of home sections whose `mathlib` commit is at or after the last change to their declarations (07.7) |
| C-review | the share of E3 and E2 text at status `reviewed` |
| C-lean | the share of examples and (L) exercises that build at the edition commit |

The release rule of a volume (12.6): C-home and C-depth are 100% for the modules of the volume, C-lean is 100%, C-fresh is at least 95%, and every chapter is `reviewed`. C-review below 100% for E2 is allowed, and the release notes say how much.

The project goal (02.3) is C-home and C-depth at 100% for the whole library at the edition commit, with C-review at 100% for E3.

## 4.6 Which constants count

The index (09.3) lists every constant of the environment of `import Mathlib`. A constant counts as a declaration of Mathlib when all of these hold:
- its module is in `Mathlib`, not in `Init`, `Std`, `Lean`, `Batteries`, `Aesop`, `Qq`, `ProofWidgets`, `Plausible` or `ImportGraph`;
- it is not an internal detail (`Name.isInternalDetail`), an auxiliary recursor, a `noConfusion`, a `below`, a `brecOn`, a `match_` or `proof_` helper, a `_cstage` or `_spec` constant, or a `.eq_1` equation lemma;
- it is not a deprecated alias (`@[deprecated]`). A deprecated alias is listed under its target, with the date of the deprecation (05.4).

Batteries and the core library are not the subject of the handbook. Volume 1 explains what a Mathlib user needs from them (06.2), and the Catalogue lists the ones that Mathlib uses most, at depth E1.

The tactics of `Mathlib/Tactic` are declarations too, but their meaning is not a type. A tactic counts as covered when its syntax has a home in a `tactic` section (07.4) or in the tactic reference of V34 (06.2). The index reads the syntax declarations and the docstrings of the tactics.

## 4.7 Size and cost

The numbers below are estimates. 01.1 gives the measured size of Mathlib at the first edition. They are checked at milestone M1 (15) on the first three volumes.

| Item | Estimate | Basis |
|---|---|---|
| E3 declarations | 4% to 6% of the total | the curated lists and the "Main results" headings |
| E2 declarations | 10% to 15% | the use threshold of 4.4 |
| E0 declarations | 35% to 45% | the family patterns of 09.4 |
| E1 declarations | the rest, about 40% | |
| Pages of text per E3 declaration | 0.8 | the sister handbooks |
| Pages per E2 declaration | 0.15 | |
| E1 rows per page | 30 | the reference table of 07.6 in small type |

Mathlib has about 332k declarations on 2026-11-26 (01.1). With these numbers and about 4% at E3 and 12% at E2, the written text is 35 volumes and about 17,500 pages (06.2), and the generated Catalogue is a further set of volumes in two columns at about 60 rows a page, about 3,000 pages (06.4). No person reads all of it. The reading paths (06.6) are the product for a learner, and the site is the product for a Lean user.

## 4.8 What "every proof" means

The handbook gives a proof on paper of every E3 theorem and a proof or a proof idea of every E2 theorem. It does not give a paper proof of every E1 lemma. For those, the proof is the Lean proof, and the site links it. This is what a textbook does: it proves its theorems, and it leaves the routine lemmas to the reader with a hint. The handbook says so in Volume 0.

The paper proof follows the standard literature when the Mathlib proof is a formal version of it. When the Mathlib proof takes another route (for example, through filters, through a more general class, or through a different construction), the text gives the standard proof first and then explains the Mathlib route in the Mathlib box. A student must be able to see why both prove the same theorem.

## 4.9 What "every example" means

Mathlib has few examples in the library itself: an `example` is not a declaration, and the test folder `MathlibTest` holds tests, not teaching examples. So the examples of the handbook are new. Each E3 definition has at least two examples and each E3 theorem has at least one. Each example that Lean can state is a checked Lean `example` or `theorem` in `tamnd/mathlib-lean` (10.3). The examples that use `decide`, `norm_num` or `simp` to compute show the reader that the definitions in Mathlib compute what the text says they compute.
