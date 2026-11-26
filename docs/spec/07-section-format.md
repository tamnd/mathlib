# 07. The section: how one piece of Mathlib is taught

This document fixes the form of a section of the handbook. The volumes are in 06. The builder that checks this form is `mlhb` (12).

The handbook is a mathematics textbook. Its subject is the mathematics that Mathlib contains, in the form that Mathlib gives it. An expert writes it for a student. The expert explains each definition, proves each main theorem on paper, computes examples, and then shows how Mathlib says the same thing. The Lean code is the evidence that the text is about the real library. It is never the main text.

## 7.1 The reader and the voice

- **The reader** knows the mathematics of the volumes that the section requires, and nothing of Lean beyond Volume 0. The reader of Volume 1 knows first-year calculus and linear algebra, and has seen proofs.
- **The voice** is that of a good lecturer. The lecturer says why a definition has its form, which hypotheses matter and why, where a student usually goes wrong, and what the theorem is good for. The lecturer gives full proofs of the main results, as a textbook does, not proof sketches.
- **Two languages, kept apart.** Each section has a mathematical text and a Mathlib text. The mathematical text is complete without the Mathlib text: a reader who skips every Mathlib box still has a textbook. The Mathlib text says how the library encodes the mathematics, and where the encoding differs from the textbook.
- **Style.** ASD-STE100, as in the sibling handbooks: short sentences, active voice, no "we", no em dash and no en dash, math in `$...$`, names with several authors joined by a hyphen (Cauchy-Schwarz). The banned word list of `shb` and `mhb` is copied into `mlhb`.

## 7.2 The unit: a section covers a set of Mathlib declarations

A section is the unit of writing, review and coverage.
- Its front matter lists the Mathlib **modules** it covers (for example `Mathlib.Topology.Compactness.Compact`) and the **declarations** it explains at each depth (04.3).
- Each declaration of Mathlib has exactly one **home section**, the section that explains it at the highest depth. Other sections may mention it.
- A section covers between 5 and 150 declarations at depth E1 or higher. A Mathlib file with more is split over several sections. Several small files can share one section.

## 7.3 The parts of a section

A section of a main volume has these parts, as `###` headings, in this order. `mlhb check` faults a missing part or a wrong order. A part marked "may omit" can be absent when the section kind allows it (7.4).

1. **Overview.** One to three paragraphs: what the section is about, why it matters, what the reader can do after it. It names the main theorem in words.
2. **Definitions.** Each definition in mathematical form, with a number (Definition 3.2.1). After each one:
   - *Remarks*: why this form, equivalent forms, the common mistake;
   - a **Mathlib box** (7.5).
3. **Theorems and proofs.** Each main result as a numbered statement with its hypotheses in full, then a proof in the textbook style. A long proof starts with a plan of its steps. After the proof, the Mathlib box says how the library proves it: the route, the key lemmas, where the Lean proof differs from the paper proof, and why (for example, Mathlib proves the result for filters and gets the sequence form as a corollary).
4. **Examples.** At least two. One example computes something. One example shows that a hypothesis is needed (a counterexample when it is dropped). Each example that Mathlib can state has a checked Lean form in `tamnd/mathlib-lean` (10.3). The text shows it in a Lean block that the builder includes from the checked file. It is never pasted.
5. **The library around it.** The API of the section, as families, not one by one: "for every bundled morphism `f` there are lemmas `map_add`, `map_zero` and `map_sum`". This part explains the declarations at depth E1 and E0 (04.3) in prose: the naming pattern, the simp normal form, the coercions, the instances that the reader gets for free. It ends with a pointer to the reference table (part 8). May omit, in a guide section.
6. **Exercises.** Four to twelve, graded (A) routine, (B) needs an idea, (C) hard, and (L) for an exercise in Lean. Each (L) exercise is a file in `tamnd/mathlib-lean` with `sorry` in the statement file and a full proof in the solution file (10.4). The solutions of (A), (B) and (C) are in the solutions appendix of the volume. May omit, in a survey section.
7. **Notes and history.** Who proved what and when; the standard references (with the locations: Rudin, *Principles*, Theorem 3.44); the history of the result in Mathlib (the file, the first contributors from the authors line of the file header, notable refactors). This part does not copy the commit log.
8. **Reference.** A table that the builder generates (7.6). One row per declaration of the section at depth E1 and higher, and one row per family at depth E0. The writer does not write this table.

### Where the human text goes and where the generated text goes

| Part | Written by | Checked by |
|---|---|---|
| 1 to 4, 6, 7 | the writer role, then a person (14) | `mlhb check`; a reviewer |
| Lean blocks in 2 to 6 | the exampler and exerciser roles | `lake build` of `tamnd/mathlib-lean` at the edition commit |
| 5 | the writer role, from the family records of the map (09.4) | `mlhb check`: each family is real at the edition commit |
| 8 | `mlhb`, from the index and the informal records (09.3) | the informal records have passed their checks (14.3) |

## 7.4 The kinds of sections

| Kind | Use | Parts |
|---|---|---|
| `theory` | the normal case: definitions and theorems with proofs | all eight |
| `api` | a file that is mostly lemmas about a known object (for example `Finset.sum` lemmas) | 1, 5, 6, 8, and 2 to 4 for the few main results |
| `instance` | a file that builds instances (for example `Real` is a complete ordered field) | 1, 3, 4, 8 |
| `tactic` | a tactic or a metaprogram of `Mathlib/Tactic` | 1, "What it does", "How to use it", "What it cannot do", 4, 6, 8 |
| `survey` | a volume introduction, a chapter on design, a map of an area | 1, free text, 7 |
| `guide` | Volume 0 | free |

## 7.5 The Mathlib box

A Mathlib box follows a definition or a theorem. It is a fenced div:

```markdown
::: mathlib
`Metric.isCompact_iff_isClosed_bounded` · `Mathlib.Topology.MetricSpace.Bounded`

In a proper metric space, a set is compact if and only if it is closed and bounded.
Mathlib states it for a `ProperSpace`, not only for $\mathbb{R}^n$. The class
`ProperSpace` says that closed balls are compact, and $\mathbb{R}^n$ is an instance.

<?decl Metric.isCompact_iff_isClosed_bounded?>
:::
```

- The first line gives the Lean name and the module. The builder makes the name a link to the declaration page of the site (13) and to the Mathlib documentation of the edition.
- The prose says, in a few sentences, how the Lean form differs from the text form: generality, hypotheses that are classes, bundled or unbundled form, junk values (for example `x / 0 = 0` in a field, `Real.sqrt (-1) = 0`, `Nat.sub` truncates), and the coercions that the reader sees.
- `<?decl Name?>` is replaced at build time by the signature of the declaration at the edition commit, pretty-printed by Lean and highlighted (12.5). The writer never types the signature. So a change of the signature in Mathlib changes the book at the next build, and a change of meaning shows in the drift report (05.5).

## 7.6 The reference table

For each declaration at depth E1 or higher the builder prints one row:

| Column | Source |
|---|---|
| Lean name | the index (09.3) |
| Kind | `def`, `theorem`, `structure`, `class`, `instance`, `abbrev`, `inductive` |
| Statement in words | the informal record of the declaration (09.3), one or two sentences |
| Depth and place | E3 or E2 with the number of the statement in the text (Theorem 3.2.4), or E1 |
| Attributes | `simp`, `ext`, `instance`, `continuity`, `fun_prop` and the others that change how the reader uses it |

For a family at depth E0 the row gives the pattern (`Finset.sum_*_distrib`), the number of members and one example member. In the PDF the table is in small type at the end of the section. In the EPUB and on the site it is a list. The full table of the whole library, in Mathlib order, is the Catalogue (06.4).

## 7.7 Front matter

```yaml
---
title: Compactness in metric spaces
kind: theory
modules:
  - Mathlib.Topology.MetricSpace.Bounded
  - Mathlib.Topology.MetricSpace.Sequences
explains:
  E3: [Metric.isCompact_iff_isClosed_bounded, IsCompact.isSeqCompact]
  E2: [Metric.isCompact_iff_totallyBounded_complete]
  E1: auto           # all other declarations of the modules not homed elsewhere
families: [Metric.isCompact_*, Bornology.IsBounded.*]
requires: [V13.C02, V13.C04]
reads_with: ["Rud76 §2.C", "Mun00 §28"]
lean: [MathlibHandbook/V13/C05/Examples.lean, MathlibHandbook/V13/C05/Exercises.lean]
mathlib: 3f1c2e9a7b        # the commit the section was last checked against
status: drafted
drafted_by: writer@claude-opus-5-5
reviewed_by: []
---
```

- `modules` and `explains` give the coverage (04). `E1: auto` lets the builder take all the declarations of the modules that have no other home.
- `mathlib` is the commit at which a person or a role last read the section against the library. `mlhb check` warns when the drift report (05.5) has a change to a declaration of the section after that commit, and the section goes to status `stale` (7.8).
- `requires` uses volume and chapter ids. `mlhb paths` builds the reading graph from it.
- `reads_with` uses the keys of `books/` (as in mmp-handbook) with a location.

## 7.8 Status

A section has one of the statuses `planned`, `drafted`, `checked`, `reviewed` and `stale`.

| Status | Meaning | Who sets it |
|---|---|---|
| `planned` | the front matter only, from the plan of the volume | `mlhb new` |
| `drafted` | the text is written; the Lean files build | the writer role |
| `checked` | an independent model and the mechanical checks of 14.2 pass; every (L) exercise has a solution that builds | the checker role, `mlhb check` |
| `reviewed` | a person has read it against the library at the commit `mathlib` | a person; the name goes in `reviewed_by` |
| `stale` | a declaration it explains has changed in Mathlib since `mathlib` (05.5), or a name it uses is gone | `mlib sync` |

A `stale` section goes back to `checked` when the refresher role (11.3) updates it and the checks pass. It goes back to `reviewed` only if the change is small (a rename, a new implicit argument) and a person signs the diff, or the person reads it again. A chapter has the lowest status of its sections. A volume is released when all its chapters are `reviewed` (12.6).

## 7.9 A worked example

The section below is the model that the writer prompt quotes (11.4). It is short, but it has every part.

````markdown
## The intermediate value theorem

### Overview

A continuous function on an interval takes every value between two of its values.
This is the first theorem in which the completeness of $\mathbb{R}$ meets continuity.
Mathlib proves a more general fact: a continuous image of a connected set is connected,
and the connected subsets of $\mathbb{R}$ are the intervals.

### Theorems and proofs

**Theorem (intermediate value theorem).** Let $a \le b$ and let $f : [a,b] \to \mathbb{R}$
be continuous. For every $y$ between $f(a)$ and $f(b)$ there is $c \in [a,b]$ with $f(c) = y$.

*Proof.* Assume $f(a) \le y \le f(b)$. Let $S = \{x \in [a,b] : f(x) \le y\}$ ...
$\square$

::: mathlib
`intermediate_value_Icc` · `Mathlib.Topology.Order.IntermediateValue`

Mathlib states the theorem for a domain that is a densely ordered, conditionally
complete linear order with the order topology, and for a codomain that is any linear
order with a closed order topology. So it holds for $\mathbb{R}$ and fails for
$\mathbb{Q}$, which is not complete. The conclusion is the set inclusion
`Icc (f a) (f b) ⊆ f '' Icc a b`, not "for every $y$". The function needs only
`ContinuousOn f (Icc a b)`, not continuity on all of $\mathbb{R}$.

<?decl intermediate_value_Icc?>
:::

### Examples

**Example.** $x^5 - x - 1$ has a root in $[1, 2]$ ...

<?lean MathlibHandbook/V09/C03/Examples.lean#quintic_root?>

**Example (the hypothesis is needed).** On $\mathbb{Q}$, $f(x) = x^2 - 2$ ...

### The library around it

The file has the four forms `intermediate_value_Icc`, `intermediate_value_Icc'`,
`intermediate_value_uIcc`, `intermediate_value_Ioo` ...

### Exercises

1. (A) ...
2. (L) `MathlibHandbook/V09/C03/Exercises.lean#fixed_point` ...

### Notes and history

Bolzano (1817), Cauchy (1821) ...

### Reference

<?reference?>
````

The writer prompt also quotes a bad draft of the same section, with the faults that the checker role (11.3) must catch: a Mathlib box that gives the wrong hypotheses, a pasted signature, a proof sketch in place of a proof, and an example with no Lean form.
