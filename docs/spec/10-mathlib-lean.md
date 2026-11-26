# 10. tamnd/mathlib-lean: the checked companion

`tamnd/mathlib-lean` is the Lean package `MathlibHandbook`. It has two jobs:
1. It holds every piece of Lean that the handbook shows: the examples, the exercises and their solutions. Each one builds against the Mathlib of the edition, so no Lean text in a book is unchecked.
2. It holds the programs that read Mathlib: the index, the families, the signatures and the highlighting. They run in the same build, so the records and the examples always describe the same commit.

It adds no new mathematics to the library (02.5).

## 10.1 Layout

| Path | Content |
|---|---|
| `lean-toolchain` | the toolchain of the Mathlib commit in the manifest; the bump workflow changes both together |
| `lakefile.toml` | one dependency, `mathlib`, at `rev = "master"`; the exact commit is in `lake-manifest.json` |
| `MathlibHandbook/V<NN>/C<NN>/Examples.lean` | the examples of one chapter, with anchors (10.3) |
| `MathlibHandbook/V<NN>/C<NN>/Exercises.lean` | the (L) exercises, with `sorry`, in the library `Exercises` that the default build does not import |
| `MathlibHandbook/V<NN>/C<NN>/Solutions.lean` | the solutions, in the default build |
| `MathlibHandbook/Fidelity/` | the round-trip checks of 14.3: for a sample of E1 sentences, a Lean statement written from the sentence alone, proved equal to the declaration |
| `scripts/Index.lean` | the index of 09.3 |
| `scripts/Families.lean` | the family matcher on types (9.4) |
| `scripts/Signatures.lean` | the pretty-printed and highlighted signatures for `<?decl?>` (12.5) |
| `scripts/Highlight.lean` | SubVerso output for the anchored examples (12.5) |
| `scripts/Axioms.lean` | `#print axioms` for every example and solution; a fault if any uses `sorryAx` or another axiom outside the three |
| `.github/workflows/` | `build`, `bump` (05.3), `edition` (05.6), `scorecard` |

## 10.2 Lean rules

1. Every file is a `module` file: it starts with `module`, then `public import` of the Mathlib modules it needs, then the module docstring, then `public section`, as Mathlib's own files do. Mathlib sets `requiresModuleSystem` since #41950, so a non-module package gets a warning and may lose support (01.1). A Mathlib pass that makes a `public import` private can hide a declaration from a file; the build catches it, and the drift has the class `visibility` (05.4).
2. The root is `MathlibHandbook`. Each file imports only the Mathlib modules it needs, never `import Mathlib`, so that the file shows the reader where the declarations live. A test file `MathlibHandbook/All.lean` imports all of them.
3. No `sorry` in the default build. `Exercises.lean` files are in a separate `lean_lib` that is built with `sorry` allowed, so that a statement that no longer elaborates is still caught.
4. No new `axiom`, no `native_decide`, no `implemented_by` in the default build.
5. Every example is a `theorem` or an `example` with an anchor comment `-- anchor: name` and `-- end: name`, so that the builder can cut it out.
6. The style follows the Mathlib style guide and the Mathlib linters, run with `lake lint` where the linter applies outside Mathlib.
7. A name that a solution uses is a public Mathlib name. Private names of Mathlib are not used, since the text cannot point to them.

## 10.3 The examples

An example in the text is

```markdown
<?lean MathlibHandbook/V09/C03/Examples.lean#quintic_root?>
```

and in the Lean file

```lean
-- anchor: quintic_root
/-- `x^5 - x - 1` has a root in `[1, 2]`. -/
example : ∃ c ∈ Set.Icc (1 : ℝ) 2, c ^ 5 - c - 1 = 0 := by
  have h := intermediate_value_Icc (by norm_num : (1 : ℝ) ≤ 2)
    (f := fun x : ℝ => x ^ 5 - x - 1) (by fun_prop)
  exact h ⟨by norm_num, by norm_num⟩
-- end: quintic_root
```

The builder includes the highlighted text between the anchors (12.5). The Lean files of a chapter are written together with the section by the exampler role, in the same pull request. A section and its Lean files merge together or not at all.

## 10.4 The exercises

- An (L) exercise has a statement file and a solution file. The statement file has the same statement with `sorry`.
- `scripts/Exercises.lean` checks that the statement in the exercise file and the statement in the solution file have the same type, by hash, so that an exercise cannot drift from its solution.
- The handbook prints the statement in the exercise list and the solution in the solutions appendix. The site has both, with the solution folded.
- A student can clone the repository, open the exercise files and work in them. The README of the repository is a short guide for that.

## 10.5 The index program

`scripts/Index.lean` extends `scripts/Export.lean` of mmp-lean to the whole library:

```
lake env lean --run scripts/Index.lean <mathlib commit> <date> > index.jsonl
```

- It imports `Mathlib` and walks `env.constants`, with the filter of 04.6.
- It writes the fields of 9.3. It pretty-prints each type with a fixed set of options, so that the text is the same across runs.
- It computes `typeHash` from the type `Expr` after it replaces universe parameter names with their positions and strips `mdata`. Two declarations with the same statement up to renaming of universes get the same hash.
- It reads the `deprecated` attribute to give each deprecated alias its target and its date.
- It computes `valueHash` for each `def` in the same way, from the value.
- It reads the `deprecated_module` shims from the module data, to give each old module its replacement imports (05.4).
- It reads both Markdown and Verso docstrings (1,352 Mathlib files use Verso since #45031) and writes Markdown, as doc-gen4 does (01.1).
- It writes the commit, the toolchain and the date into the first line of each file, so every record says what it describes.
- It writes `proofUses` to a second file, since the proofs are large.
- It runs in parallel over modules with `Task`s, and it needs about 16 to 32 GB of memory and 20 to 60 minutes on a large machine [U, measured at M0]. It runs on a self-hosted runner (15.2), since the GitHub hosted runners have too little memory.

Report B §3 compares this program with doc-gen4, jixia, lean4export and LeanDojo. The project writes its own program because it needs the type hashes, the deprecation targets and the families in one pass, at the same commit as the examples. It reads the doc-gen4 output only to link to the Mathlib documentation.

## 10.6 Upstream

The companion finds three kinds of things that belong in Mathlib:
1. a missing simple lemma that an example needs;
2. a docstring that is wrong or missing;
3. a declaration whose name breaks the naming convention.

The project sends these as pull requests to Mathlib, with a person as the author, and records them in `records/upstream.json` of the map. Until a lemma is in Mathlib, the solution proves it inline. The project never keeps a lemma in the companion for later use by other files.

## 10.7 Pins

| Item | Pin |
|---|---|
| Lean | the toolchain of the Mathlib commit in `lake-manifest.json` |
| Mathlib | `master`, at the last known good commit, bumped every 6 hours (05.3); on 2026-11-26 `master` is `b9019de30e` on v4.37.0-rc1. The edition branches `edition/v4.X.0` are at the Mathlib tag; the first is `edition/v4.36.0` at `fc4f59e577` |
| SubVerso | the version that Mathlib's own documentation uses at the commit, if any; otherwise the latest release |

The sibling projects pin Lean v4.35.0 and Mathlib v4.35.0 (`56a005855e`), about 1,100 commits behind `master`. This project does not share their pin. Its edition branches give a fixed point for a reader who wants one (05.2).
