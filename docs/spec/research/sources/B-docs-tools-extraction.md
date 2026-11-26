# B. Documentation, tooling and declaration extraction for a Mathlib handbook

Research date: 2026-11-26. Every fact has a source URL next to it. GitHub metadata (stars, last push, licence, latest release) comes from `gh api repos/<owner>/<repo>` and `.../releases/latest`, queried on 2026-11-26; "last push" means the `pushed_at` field. Claims marked **unverified** could not be confirmed from a primary source. Downloads went to `/tmp/mlh-dl-1` and `/tmp/mlh-dl-2` and were only parsed as JSON. No downloaded code was run.

Projects this report feeds: `tamnd/mathlib-handbook` (textbook volumes, PDF and EPUB), `tamnd/mathlib-agent` (Go extractor that drives AI writers) and `tamnd/mathlib-lean` (checked examples and exercises).

---

## 0. Key numbers (snapshot 2026-11-26)

| Quantity | Value | Source |
|---|---|---|
| Mathlib toolchain on `master` | `leanprover/lean4:v4.37.0-rc1` | https://github.com/leanprover-community/mathlib4/blob/master/lean-toolchain |
| Latest Mathlib release tag | `v4.36.0` (2026-11-16) | https://github.com/leanprover-community/mathlib4/releases |
| Mathlib stars | 4,665 | `gh api repos/leanprover-community/mathlib4` |
| Definitions / theorems / contributors (mathlib stats page) | 142,208 / 296,731 / 772 | https://mathlib.org/mathlib_stats.html (the page shows no date) |
| Declarations in the docs search index (all libraries: Lean core, Std, Batteries, Mathlib, …) | 438,962 | parsed from https://leanprover-community.github.io/mathlib4_docs/declarations/declaration-data.bmp (built 2026-11-26 08:33 UTC) |
| Declarations whose doc page lives under `./Mathlib/` | 332,173: 246,930 theorems, 44,961 defs, 31,095 instances, 4,782 constructors, 2,033 classes, 1,707 structures, 340 opaques, 325 inductives | same file, own count |
| Modules in the docs index (all libraries) / Mathlib modules | 11,895 / 8,736 | same file |
| Dependency-network paper | "308,129 declarations, 8.4 million edges, and 7,563 modules" (an earlier snapshot) | https://arxiv.org/abs/2604.24797 |

The handbook's map therefore has about **330k Mathlib declarations**, roughly 75% of them theorems. Most of these are API lemmas (simp lemmas, `_iff`, `_left`/`_right` variants, additive/multiplicative twins). They do not need prose each, but the map must hold all of them.

---

## 1. Existing human-oriented texts

| Text | Scope | Licence | Last update / version | Source |
|---|---|---|---|---|
| **Mathematics in Lean (MIL)**, Avigad and Massot | Tutorial on *using* Mathlib. 13 chapters: Basics, Logic, Sets and Functions, Elementary Number Theory, Discrete Maths, Structures, Hierarchies, Groups and Rings, Linear Algebra, Topology, Differential Calculus, Integration and Measure Theory. HTML via Sphinx, plus PDF. | Text "licensed under CC BY 4.0"; repos Apache-2.0 | Says "Mathematics in Lean v4.34.0", © 2020-2025. User repo last push 2026-10-28; source repo `avigad/mathematics_in_lean_source` last push 2026-10-29. 637 stars. | https://leanprover-community.github.io/mathematics_in_lean/ ; https://github.com/leanprover-community/mathematics_in_lean ; PDF: https://leanprover-community.github.io/mathematics_in_lean/mathematics_in_lean.pdf |
| **Theorem Proving in Lean 4 (TPIL)**, Avigad, de Moura, Kong, Ullrich | Dependent type theory, tactics, inductive types, type classes, axioms. Almost no Mathlib. | Repo Apache-2.0 | Targets Lean 4.33.0. Last push 2026-11-23. Built with Verso (section links use the `Verso.Genre.Manual` domain). | https://lean-lang.org/theorem_proving_in_lean4/ ; https://github.com/leanprover/theorem_proving_in_lean4 |
| **Functional Programming in Lean**, Christiansen | Lean as a programming language | Text CC BY 4.0 (`LICENSE-ASSETS`). Original "released by Microsoft Corporation in 2023 under a Creative Commons Attribution 4.0"; changes © 2023-2025 Lean FRO | Ported to Verso. Last push 2026-11-23. | https://github.com/leanprover/fp-lean |
| **The Mechanics of Proof**, Macbeth | Intro-to-proof course (Fordham Math 2001): calculation, parity, logic, induction, number theory, functions, sets, relations. Sphinx HTML. | **"© Copyright 2022-2024, Heather Macbeth. All rights reserved."** No licence file in repo. | Last push 2024-12-09 | https://hrmacbeth.github.io/math2001/ ; https://github.com/hrmacbeth/math2001 |
| **Natural Number Game (NNG4)** | Interactive game deriving Peano arithmetic | Apache-2.0 | Last push 2026-11-24. Hosted on the Lean Game Server. | https://github.com/leanprover-community/NNG4 ; https://adam.math.hhu.de/#/g/hhu-adam/NNG4 |
| **Formalising Mathematics** (Buzzard, Imperial) | Final-year/MSc course. The notes have three parts: (A) section notes, (B) CS topics, (C) a tactic list. | Repo Apache-2.0 | Latest is the **2024** edition (PDF dated 23 May 2024). Repo last push 2025-03-18. No 2025 or 2026 edition found (**unverified** that none exists). | https://github.com/ImperialCollegeLondon/formalising-mathematics-2024 ; https://www.ma.imperial.ac.uk/~buzzard/xena/formalising-mathematics-2024/formalisingmathematics.pdf |
| **Lean for the Curious Mathematician (LftCM)** | Workshop series. Materials are Lean files, one per session (`1_BasicTactic.lean`, `2_Logic.lean`, …). | per repo | 2025 at ICTS Bengaluru (24 to 27 Apr 2025). 2026 at Cortona, 7 to 11 Sep 2026. | https://github.com/riccardobrasca/LFTCM2026 ; https://amosturchet.github.io/lftcm26/index.html ; https://leanprover-community.github.io/events.html |
| **Glimpse of Lean** (Massot) | Fast tutorial | n/a | n/a | https://github.com/PatrickMassot/GlimpseOfLean (listed at https://leanprover-community.github.io/learn.html) |
| **A Lean companion to "Analysis I"** (Tao) | Translates the definitions, theorems and exercises of Tao's *Analysis I* into Lean. Each section has a Verso page. | Apache-2.0 | Launched 2025-05-31. 1,998 stars. Last push 2026-11-18. | https://terrytao.wordpress.com/2025/05/31/a-lean-companion-to-analysis-i/ ; https://github.com/teorth/analysis |
| **Metaprogramming in Lean 4** | Tactics and metaprogramming | Apache-2.0 | Last push 2026-11-25 | https://github.com/leanprover-community/lean4-metaprogramming-book |
| **Lean Language Reference** (Verso) | Reference manual for the Lean language, not for Mathlib. Has a tactic reference (§14.5) that documents `exact?`/`apply?`. | Apache-2.0 | Last push 2026-11-25 | https://lean-lang.org/doc/reference/latest/ ; https://github.com/leanprover/reference-manual ; https://lean-lang.org/doc/reference/latest/Tactic-Proofs/Tactic-Reference/ |
| **Mathlib Manual** | Project setup tips and tactic docs | Apache-2.0 | **Archived on 2026-02-04.** Content moved to the Mathlib wiki and to `mathlib4_docs/tactics.html`. | https://github.com/leanprover-community/mathlib-manual ; https://leanprover-community.github.io/mathlib-manual/html-multi/ |
| **Mathlib Phrasebook** | How-to guide ("How do I say … using Mathlib?"). Built on the Verso textbook template. 23 topical chapters (additive combinatorics, asymptotics, category theory, filters, Haar measure, Lie algebras, number fields, schemes, …). | **No licence file** (GitHub `license` is null). No licence on the site. | Last push 2026-11-20. 24 stars. | https://github.com/leanprover-community/mathlib-phrasebook ; https://leanprover-community.github.io/mathlib-phrasebook/ |
| **Mathlib overview / undergrad / 100 / 1000 theorems pages** | YAML-driven lists that map topics to declarations | Apache-2.0 (in mathlib repo) | Copied into the docs build on every run (`overview.yaml`, `undergrad.yaml`, `100.yaml`, `1000.yaml`) | https://github.com/leanprover-community/mathlib4/tree/master/docs ; https://github.com/leanprover-community/mathlib4_docs/blob/main/.github/workflows/docs.yaml |
| **Library notes** | `library_note «name» /-- doc -/` creates a declaration `LibraryNote.«name»` whose docstring holds the note. There are about 35 hits for `library_note` in mathlib4 (GitHub code search, approximate). The old `notes.html` page of the Lean 3 docs no longer exists under `mathlib4_docs/notes.html` (HTTP 404). | Apache-2.0 | n/a | https://github.com/leanprover-community/batteries/blob/main/Batteries/Util/LibraryNote.lean |
| **Module docstrings** (`/-! … -/`) | Every Mathlib file has a header docstring with "Main definitions / Main results", rendered by doc-gen4 at the top of each module page. This is the closest thing to per-topic prose that exists today. | Apache-2.0 | live | e.g. https://leanprover-community.github.io/mathlib4_docs/Mathlib/Algebra/Group/Basic.html |

### Official 2026 to 27 documentation plans

The Mathlib Initiative roadmap (Oct 2026 to Mar 2027) covers documentation under deliverable D3:

- "Every tactic defined in Mathlib now carries documentation conforming to the style guide we wrote with the Lean FRO."
- Q4 2026: "Verso migration advanced".
- Q1 2027: "A large fraction of Mathlib docstrings use Verso", "Phrasebook at 50 entries", and Phrasebook entries "linked from and to module documentation".
- The roadmap names *findability* as the hard problem, because community knowledge is "substantially held in Zulip threads and in the heads of experts".
- D4 (AI) lists "Autoformalizations of 20 textbooks completed and released" (Q4 2026) and a "Model for publishing texts alongside Lean companions" (Q1 2027: a pilot with a publisher).

Source: https://mathlib-initiative.org/roadmap/

The Verso docstring migration is under way in mathlib4, e.g. PR #46424 "manual Verso migration" of `Mathlib/Tactic/Find.lean`, merged around 2026-11-24 (https://github.com/leanprover-community/mathlib4/pull/46424). Related papers: "Growing Mathlib: maintenance of a large scale mathematical library" (Springer 2026, https://link.springer.com/chapter/10.1007/978-3-032-07021-0_4) covers the deprecation system and linters. A 2026 arXiv paper formalises a probability textbook from lecture notes (https://arxiv.org/pdf/2607.27298, not read in detail).

### The gap

Every existing text is one of the following:

- a tutorial on *how to use Lean/Mathlib* (MIL, Mechanics of Proof, NNG, Glimpse, LftCM, Formalising Mathematics);
- a language manual (TPIL, FP in Lean, the Reference);
- a how-to (Phrasebook);
- a companion to one external textbook (Tao's Analysis I);
- machine-generated per-declaration docs (doc-gen4) or one-line LLM informalisations (LeanSearch, LeanExplore, Herald).

**None of them sets out, area by area, the mathematics Mathlib actually contains, the way a graduate textbook would:** definitions with motivation, the main theorems, proof ideas, examples and how the parts connect, all tied to the real declaration names. MIL covers about 13 undergraduate topics and says so; the Phrasebook explicitly refuses to explain *why* ("resist the temptation to explain *why*", from its README). The Mathlib Initiative's roadmap does not plan textbook-style exposition of Mathlib itself; its textbook items are about autoformalising existing books (https://mathlib-initiative.org/roadmap/). Searches for a "Mathlib handbook" or "Mathlib book" in 2025 to 2026 turned up nothing of this kind (web search 2026-11-26; absence is **unverified** beyond that search). The gap is real.

---

## 2. doc-gen4

Repo: https://github.com/leanprover/doc-gen4. Apache-2.0, 178 stars. Last commit 2026-11-18: "chore: bump toolchain to v4.37.0-rc1 (#440)". There are no GitHub releases; you pin a `rev` that matches your toolchain (`main` or `v4.x`), per the README.

### How it works (current architecture, late 2026)

- It is used as a **Lake facet**. You create a nested `docbuild/` project whose `lakefile.toml` requires `doc-gen4` and your library, then run `lake build YourLib:docs`. For Mathlib, run `MATHLIB_NO_CACHE_ON_UPDATE=1 lake update doc-gen4`. Output goes to `docbuild/.lake/build/doc/index.html` and must be served over HTTP, because of the same-origin policy. Lean, Init, Lake and Std are always documented as well. Source: README, https://github.com/leanprover/doc-gen4/blob/main/README.md
- **It now goes through an SQLite database.** The lakefile requires `leansqlite` (https://github.com/leanprover/leansqlite). The per-module facet `docInfo` runs `doc-gen4 single --build <dir> <Module> api-docs.db <srcUri>`, and core is handled by `genCore`. A later `fromDb` command flushes the WAL, loads the linking context, renders HTML in parallel, and writes the search index (https://github.com/leanprover/doc-gen4/blob/main/Main.lean, https://github.com/leanprover/doc-gen4/blob/main/lakefile.lean).
- **DB schema** (`DocGen4/DB/Schema.lean`). Tables include:
  - `modules(name, source_url)`, `module_imports`;
  - `declaration_ranges(module_name, position, start_line, start_column, end_line, end_column, …)`;
  - `declaration_markdown_docstrings`, `declaration_verso_docstrings` (BLOB), `module_docs_markdown`;
  - `name_info(kind, name, type BLOB, sorried, render)`;
  - `axioms`, `internal_names`, `constructors`, `inductives`, `class_inductives`, `opaques`;
  - `definitions(is_unsafe, hints, is_noncomputable)`, `definition_equations`;
  - `instances(class_name)`, `instance_args`, `structures`, ….

  Source: https://github.com/leanprover/doc-gen4/blob/main/DocGen4/DB/Schema.lean. **This DB (`api-docs.db`) is a clean structured extract of every declaration: kind, type, docstring, source range, instances and structure fields.** It is not published on the docs site (`/mathlib4_docs/api-docs.db` returns 404, checked 2026-11-26). You get it by running doc-gen4 yourself. The `type` column is a BLOB (rendered code), not plain text.
- Docstrings: both Markdown and Verso docstrings are supported (`DB/VersoDocString.lean`, and the `verso-moduledocs.yml` workflow) (https://github.com/leanprover/doc-gen4/tree/main/DocGen4/DB).
- Source links: `DOCGEN_SRC=github|file|vscode`, default GitHub (README). Equations for definitions are rendered unless `DISABLE_EQUATIONS=1` (README).
- `/find`: `…/mathlib4_docs/find/?pattern=Nat.add#doc` resolves a name to its page. This is how `docs#Nat.add` on Zulip works (README).

### Output files

`DocGen4/Output.lean` (https://github.com/leanprover/doc-gen4/blob/main/DocGen4/Output.lean) writes:

- one HTML page per module, `Mathlib/Algebra/Group/Basic.html`, with anchors `#DeclName`;
- `declarations/declaration-data-<Module>.bmp` per module, merged into **`declarations/declaration-data.bmp`** (the search index);
- **`declarations/header-data.bmp`** from the `Mathlib:docsHeader` library facet;
- `declarations/backrefs-<Module>.json`, `references.json`/`references.bib` (bibliography), `navbar.html`, `tactics.html`, `find/`.

The `.bmp` extension is a trick so that GitHub Pages serves the files gzip-compressed. The body is plain JSON (stated in https://github.com/leanprover-community/crossref-exports/blob/master/README.md, and confirmed by parsing).

JSON shapes (`DocGen4/Output/ToJson.lean`, https://github.com/leanprover/doc-gen4/blob/main/DocGen4/Output/ToJson.lean), checked against the live files:

- **`declaration-data.bmp`** is `{declarations: {name: {kind, docLink}}, instances: {class: [inst…]}, instancesFor: {type: [inst…]}, modules: {mod: {importedBy: [...], url}}}`. Live: 5.9 MB gzipped, 69.6 MB raw, 438,962 declarations, 11,895 modules.
- **`header-data.bmp`** is `{name: {header: <HTML of signature>, info: {name, kind, doc, docLink, sourceLink, line}}}`. Live: 61.9 MB gzipped, **1.21 GB raw**. Example record (own download):

```json
"ADEInequality.A": {"header": "<div class=\"decl_header\">…(r : ℕ+) : Multiset ℕ+…</div>",
 "info": {"doc": "`A r := {1,1,r}` is a `Multiset ℕ+` …", "kind": "def", "line": 53,
  "docLink": "./Mathlib/NumberTheory/ADEInequality.html#ADEInequality.A",
  "sourceLink": "https://github.com/leanprover-community/mathlib4/blob/348837d3…/Mathlib/NumberTheory/ADEInequality.lean#L53-L59"}}
```

**So the docs site already exposes, for every declaration: the full name, kind, raw Markdown docstring, an HTML signature with every constant hyperlinked, a source link pinned to a commit SHA with a line range, and the module.** This can be downloaded without building anything, which makes it the cheapest seed for `mathlib-agent`. Caveats: the signature is HTML, not a Lean `Expr`, and there are no dependency edges. Strip the tags and keep the `<a href>` targets to get "mentions" edges from the type only.

### Mathlib docs site and URL structure

- Root: https://leanprover-community.github.io/mathlib4_docs/. Module pages are `…/mathlib4_docs/Mathlib/Path/To/Module.html#Fully.Qualified.Name`, plus `…/find/?pattern=<name>#doc`, `…/tactics.html`, `…/mathlib.html` (the interactive import graph, 726 KB), and `…/declarations/{declaration-data,header-data}.bmp`. Checked with `curl -I` on 2026-11-26; all files had `last-modified: Thu, 26 Nov 2026 08:33 to 08:34 GMT`.
- Docs HTML **includes docstrings and source positions**. Every declaration has a "source" link of the form `…/blob/<sha>/Mathlib/Algebra/Group/Basic.lean#L35-L37` (own fetch of `Mathlib/Algebra/Group/Basic.html`).
- External identifiers: Mathlib tags declarations with `@[stacks …]`, Wikidata and similar attributes. `scripts/export_crossrefs.lean` (2026, Johan Commelin) exports them to `crossrefs.json`, published at https://github.com/leanprover-community/crossref-exports (228 KB, updated 2026-11-25). There is a redirect service: `…/crossref-exports/?db=wikidata&id=Q83478#doc`. This is very useful for mapping handbook sections to the Stacks Project and Wikidata. Sources: https://github.com/leanprover-community/mathlib4/blob/master/scripts/export_crossrefs.lean, https://github.com/leanprover-community/crossref-exports

### How the official build is run, and what it costs

The workflow is https://github.com/leanprover-community/mathlib4_docs/blob/main/.github/workflows/docs.yaml. It runs every 8 hours (`cron: '0 */8 * * *'`) on a self-hosted runner labelled `doc-gen`, in these steps:

1. Check out mathlib4.
2. `lake exe cache get`, then `lake build`.
3. Create a dummy `workaround` project with its `lakefile.toml`.
4. `lake build doc-gen4`.
5. `lake exe graph mathlib.html`.
6. `lake build Batteries:docs Qq:docs Aesop:docs ProofWidgets:docs Mathlib:docs Archive:docs Counterexamples:docs docs:docs`, then `lake build Mathlib:docsHeader`.
7. Copy the YAML files.
8. Upload to Pages.

Timings from run 45780349896 on 2026-11-26 (https://github.com/leanprover-community/mathlib4_docs/actions/runs/45780349896):

- cache get: 70 s
- doc-gen4 build: 30 s
- import graph: 24 s
- **generate docs: 23 min 53 s**
- the whole job: about 27 min
- the Pages artifact: 122,473,345 bytes, about **122 MB compressed** (gh API artifact size)

Hardware of the `doc-gen` runner: **unverified**. A cold local run needs a full Mathlib cache (`.lake` for Mathlib plus dependencies takes several GB: **unverified**, no primary figure found) plus the generated site. The site uncompressed is far bigger than 122 MB, since `header-data.bmp` alone is 1.2 GB raw. Plan for **≥ 10 to 20 GB disk and ≥ 30 to 60 min** on a strong workstation (**estimate, unverified**). LeanExplore's own pipeline notes the doc-gen4 step takes "hours on a cold machine" (https://github.com/lean-explore/lean-explore/blob/main/docs/extraction-pipeline.md). doc-gen4 ships a `scripts/bench/mathlib-docs` benchmark that measures the Mathlib docs time (https://github.com/leanprover/doc-gen4/tree/main/scripts/bench/mathlib-docs).

---

## 3. Declaration extraction tools

| Tool | What it outputs | Status / Lean support | Source |
|---|---|---|---|
| **lean4export** | Kernel-level export of every declaration in a module and its transitive dependencies, in **NDJSON** (`format_ndjson.md`). Usage: `lake env …/lean4export Mathlib > out.ndjson`. Options `--export-unsafe`, `--export-mdata`, and `-- decl…` to filter. Gives terms (types and values) for external checkers, but **no docstrings and no source ranges**. | `leanprover` org, Apache-2.0, toolchain `v4.36.0-rc1`, last push 2026-10-14. Used by comparator and external kernels such as nanoda. | https://github.com/leanprover/lean4export |
| **jixia** (BICMR@PKU / FrenzyMath) | Static analysis with plugins: Import, Declaration (source-level info, ranges, args), Symbol (types plus **reference graph**), Elaboration (tactic info), Line (proof state per line), AST. Outputs JSON per file (`-d x.decl.json -s x.sym.json -e … -l …`). Use `-i` for Mathlib. | Apache-2.0, 132 stars, last push 2026-11-03. Latest release `v4.28.0-rc1` (2026-03-12); `main` toolchain v4.29.0. **Must be built with the exact same Lean version** as the target. Release branches run up to `v4.28.0-rc1`, so it lags current Mathlib (v4.37.0-rc1). | https://github.com/frenzymath/jixia |
| **LeanDojo** (original) | Traced repos: theorems, tactic states, premises. Produced LeanDojo Benchmark 4. | MIT. README: "This original LeanDojo library is **deprecated**. Please use LeanDojo-v2". Last release v4.20.0 (2025-06-13). | https://github.com/lean-dojo/LeanDojo |
| **LeanDojo-v2** | End-to-end framework: tracing (`ExtractData.lean`), dataset DB, SFT/GRPO trainers, Pantograph-based provers. Python ≥ 3.11 and a CUDA GPU for training. | MIT, 163 stars, v1.0.9 (2026-04-26), last push 2026-11-04 | https://github.com/lean-dojo/LeanDojo-v2 |
| **Pantograph** | Machine-to-machine REPL. JSON commands `env.catalog`, `env.inspect {"name": …}`, `goal.start`, …. Also an FFI library and a `tomograph` executable. | Apache-2.0, toolchain v4.35.0, last push 2026-11-15 (mirror at `leanprover/Pantograph`). Python bindings: PyPantograph. | https://github.com/leanprover/Pantograph ; https://github.com/leanprover/Pantograph/blob/main/doc/repl.md |
| **leanprover-community/repl** | JSON REPL for running commands and tactics | toolchain v4.37.0-rc1 | https://github.com/leanprover-community/repl |
| **Lean metaprogramming (DIY)** | `env.constants` (all `ConstantInfo`), `Lean.findDeclarationRanges?` (source ranges), `Lean.findDocString?`, `env.getModuleIdxFor?` (owning module), `Lean.collectAxioms`, `Lean.Linter.getDeprecatedNewName` (rename targets). A ~100-line Lean script run with `lake env lean` over `import Mathlib` can dump all of these to JSONL. Mathlib's `scripts/export_crossrefs.lean` is a worked example: it reads `declRangeExt` and `env.getModuleFor?`. | core Lean, always current | https://leanprover-community.github.io/mathlib4_docs/Lean/DeclarationRange.html#Lean.findDeclarationRanges? ; https://leanprover-community.github.io/mathlib4_docs/Lean/DocString.html#Lean.findDocString? ; https://leanprover-community.github.io/mathlib4_docs/Lean/Environment.html#Lean.Environment.constants ; https://leanprover-community.github.io/mathlib4_docs/Lean/Util/CollectAxioms.html#Lean.collectAxioms ; https://leanprover-community.github.io/mathlib4_docs/Lean/Linter/Deprecated.html#Lean.Linter.getDeprecatedNewName ; https://github.com/leanprover-community/mathlib4/blob/master/scripts/export_crossrefs.lean |
| **import-graph** (`lake exe graph`) | Module import DAG as `.dot`, `.pdf` (with graphviz), `.xdot_json` or stand-alone `.html` (nodes link to docs). Options `--from`/`--to`, `--doc-url`. Commands `#find_home for <cmd>`, `#min_imports`, `#norm_imports`, `#show_imports`, `#import_diff`, `#redundant_imports`. `lake exe unused_transitive_imports`. Can parse imports from source without a build (`ImportGraph.Imports.FromSource`). | Apache-2.0, toolchain v4.37.0-rc1, last push 2026-11-20 | https://github.com/leanprover-community/import-graph |
| **Mathlib `scripts/`** | `lint-style.lean` (`lake exe lint-style`), `mk_all` (`lake exe mk_all`), `export_crossrefs.lean`, `dup_decls_report.lean`, `topological_sort.py` (modules in import order, useful for chapter ordering), `fix_deprecations.py`, `create_deprecated_modules.lean`, `parse_shake_output.py`. CI automation scripts moved to `leanprover-community/mathlib-ci`. | live | https://github.com/leanprover-community/mathlib4/blob/master/scripts/README.md |
| **shake** | Unused-import finder, now `lake shake`, built into Lake (`src/lake/Lake/CLI/Shake.lean`) | core | https://github.com/leanprover/lean4/blob/master/src/lake/Lake/CLI/Shake.lean |
| **ProofWidgets4** | Library for interactive infoview widgets (JSX-like, in Lean). Not an extractor; relevant only if the book embeds interactive widgets. | Apache-2.0, v0.0.121 (2026-11-18) | https://github.com/leanprover-community/ProofWidgets4 |
| **`#print axioms`** | Lists the axioms a declaration depends on (backed by `Lean.collectAxioms`). Use it to audit `mathlib-lean` exercises (no `sorryAx`). | core | https://leanprover-community.github.io/mathlib4_docs/Lean/Util/CollectAxioms.html |
| **lean4checker → `leanchecker`** | Replays `.olean` environments through the kernel. **The repo is archived.** "now distributed as `leanchecker` with every Lean toolchain (starting from v4.28.0)": `lake env leanchecker [--fresh] Mathlib`. | archived; core since v4.28.0 | https://github.com/leanprover/lean4checker ; https://github.com/leanprover/lean4/blob/master/src/LeanChecker.lean |
| **comparator → `lake comparator` / `lake check`** | A "trustworthy judge" that checks a solution module proves the challenge statements using only permitted axioms. It sandboxes with landrun, exports with lean4export, and can also check with the nanoda kernel. **Archived.** "merged into core as of Lean release v4.35.0 in the form of `lake comparator` and the accompanying `lake check`". | archived; core since v4.35.0 | https://github.com/leanprover/comparator ; https://github.com/leanprover/lean4/blob/master/src/lake/Lake/CLI/Check.lean |

**Recommendation for `mathlib-agent` (Go).** Don't reimplement Lean parsing in Go. Use these three layers:

- **Tier 0, no build:** download `header-data.bmp` and `declaration-data.bmp` (JSON) from the live docs. That gives names, kinds, docstrings, HTML signatures, SHA-pinned source ranges, the module import graph (`importedBy`) and instances.
- **Tier 1, a Lean helper:** a small Lean executable in `mathlib-lean` (or a `lake env lean` script, like `export_crossrefs.lean`) that emits JSONL with `name`, `module`, `kind`, `range`, `docstring`, `type` (pretty-printed), the `deprecated → newName` map, attributes (`simp`, `instance`, `stacks` tags), and **dependency edges**: constants used in the type and in the value, via `Expr.getUsedConstants`.
- **Tier 2, optional:** jixia or Pantograph for proof-state and tactic-level data, but only for showcase proofs.

Go then only parses JSON.

---

## 4. Search tools and informal-description datasets

### Search engines

| Tool | Kind | API | Status | Source |
|---|---|---|---|---|
| **Loogle** (Breitner, Lean FRO) | Type/pattern search, e.g. `(List.replicate (_ + _) _ = _)`, `Real.sqrt, Real.pi` | Web at https://loogle.lean-lang.org/; **JSON at `/json?q=…`** ("No stability of the format is guaranteed"); CLI `--json`; Zulip bot; VS Code and nvim integration. Upgrades to the latest Mathlib every 6 h. | Apache-2.0, toolchain v4.30.0-rc1 on `main`, last push 2026-07-09. Live: `/json?q=Real.sqrt, Real.pi` returned 55 hits `{name, module, type, doc}` (own query 2026-11-26). | https://github.com/nomeata/loogle |
| **LeanSearch / LeanSearch v2** (FrenzyMath, PKU) | Natural-language semantic search over LLM informalisations. Corpus extracted with jixia; v2 uses Qwen3-Embedding-8B. | `POST https://leansearch.net/search` with `{"query": [..], "num_results": n}`. Returns `name, module_name, kind, signature, type, value, docstring, informal_name, informal_description`. Own query 2026-11-26: "compact subset of Hausdorff is closed" gave `IsCompact.isClosed`. | live. Code Apache-2.0. Papers https://arxiv.org/abs/2403.13310 and https://arxiv.org/abs/2605.13137 | https://github.com/frenzymath/LeanSearch ; https://github.com/frenzymath/LeanSearch-v2 |
| **Moogle** (Morph Labs) | Early LLM semantic search (Nov 2023) | none public | Community blog calls it "somewhat outdated", and says Morph does not seem interested in keeping it current. On 2026-11-26 `www.moogle.ai` did not connect and `moogle.ai` returned 404 (own probe), so it is **probably defunct** (**unverified**). | https://leanprover-community.github.io/blog/posts/searching-for-theorems-in-mathlib/ |
| **LeanExplore** (Asher) | Hybrid BM25 + FAISS + rerank over LLM informalisations. Indexes Mathlib, Batteries, CSLib, FLT, FormalConjectures, PhysLean, Lean, Std, Init. | Python `ApiClient` (`https://www.leanexplore.com/api/v2`), MCP server (hosted endpoint limited to 30 req/min/IP), and a Claude Code/Codex plugin. The `SearchResult` has `name, module, docstring, source_text, source_link, dependencies, informalization`. | Apache-2.0 code, 83 stars, last push 2026-11-25. Paper https://arxiv.org/abs/2506.11085 | https://github.com/lean-explore/lean-explore ; https://github.com/lean-explore/lean-explore/blob/main/docs/data-models.md |
| **Lean Finder** (SFU / Waterloo / UT Austin; ICLR 2026) | Semantic search tuned to user intents (built from Zulip queries). V2 (arXiv 2610.30843) adds query disambiguation and the MathlibQR benchmark. | Self-hostable HTTP server. Corpora for Mathlib v4.19.0, v4.24.0, v4.28.0 on HF `delta-lab-ai/lean-finder`. Public proxy `https://lean-lsp-proxy.leanfinder.workers.dev` (per lean-lsp-mcp docs). | Apache-2.0 badge, last push 2026-05-21 | https://arxiv.org/abs/2510.15940 ; https://github.com/delta-lab-ai/lean-finder ; https://github.com/oOo0oOo/lean-lsp-mcp/blob/main/docs/tools.md |
| **`exact?` / `apply?`** | In-editor library search (formerly `library_search`). Uses `solve_by_elim` for subgoals. Also the `exact?%` term elaborator. | Lean core tactic | core | https://lean-lang.org/doc/reference/latest/Tactic-Proofs/Tactic-Reference/ ; https://lean-lang.org/doc/api/Lean/Meta/Tactic/LibrarySearch.html |
| **lean-lsp-mcp** | MCP server that wraps the Lean LSP and calls LeanSearch, Loogle and Lean Finder | n/a | n/a | https://github.com/oOo0oOo/lean-lsp-mcp/blob/main/docs/tools.md |

### Informal-description datasets (candidate seeds)

| Dataset | Content | Size | Licence | Source |
|---|---|---|---|---|
| **FrenzyMath/lsv2-mathlib-v4.28.0-rc1-jsonl** | "One record per Mathlib v4.28.0-rc1 declaration with the LLM-generated informal description". Fields: `name, module_name, type, kind, signature, value, informal_name, informal_description` (LaTeX math). Example: `AEMeasurable` → "Almost everywhere measurable function …" | 332 MB JSONL (2026-05-18). Record count **unverified**. | **Apache-2.0** | https://huggingface.co/datasets/FrenzyMath/lsv2-mathlib-v4.28.0-rc1-jsonl |
| FrenzyMath/mathlib_informal_v4.19.0 (and v4.16.0) | Earlier LeanSearch informalisations: `module_name, kind, name, start, stop, signature, type, …` | 244 MB | Apache-2.0 | https://huggingface.co/datasets/FrenzyMath/mathlib_informal_v4.19.0 |
| **Herald** (statements, proofs) | NL-FL pairs generated from Mathlib4. Paper: "580k valid statements and 44k NL-FL theorem pairs" | 580k | Apache-2.0 (HF tag). Paper CC BY 4.0. | https://huggingface.co/datasets/FrenzyMath/Herald_statements ; https://arxiv.org/abs/2410.10878 |
| LeanExplore data | Per-declaration `informalization` ("**Title.** …") plus `dependencies` and `source_text`. Rebuilt with doc-gen4 → parse → LLM via OpenRouter → embed. | per release, e.g. `20260127_103630` | Code Apache-2.0. **Data licence not stated** (**unverified**). | https://github.com/lean-explore/lean-explore/blob/main/docs/extraction-pipeline.md |
| Lean Finder corpora | `mathlib4_{19,24,28}_0.jsonl` plus FAISS indexes. Builds on Herald. | n/a | Apache-2.0 (repo badge); per-file **unverified** | https://github.com/delta-lab-ai/lean-finder |
| Lean Workbook / Plus (InternLM) | 57,231 / 82,893 *competition* problems autoformalised. Not Mathlib content, but a possible source of exercises. | n/a | Dataset Apache-2.0. Paper CC BY-NC-ND 4.0. | https://arxiv.org/abs/2406.03847 ; https://huggingface.co/datasets/InternLM/Lean-Workbook |
| FormalML | 4,937 subgoal-completion problems from Optlib and FoML (ML theory) | n/a | "open source" (exact licence **unverified**) | https://arxiv.org/abs/2510.02335 |
| LeanDojo Benchmark 4 | Theorems and proofs traced from mathlib4 | n/a | see Zenodo | https://doi.org/10.5281/zenodo.8040109 |

**Seeding assessment.** The LeanSearch v2 JSONL is the best ready-made seed. It is Apache-2.0, has one entry per declaration, includes informal names and descriptions in LaTeX, and is only about 8 Mathlib releases old. Use it for:

- clustering declarations into handbook sections;
- giving writers draft one-liners and glossary entries;
- drafting the "Lean name ↔ maths name" index.

It is *not* textbook prose: there are no proof ideas, no motivation, and errors are present. LLM-generated, unreviewed text should never be copied verbatim into the book. If any of it is reused, attribute it (Apache-2.0 §4) and review it. Note: whether the outputs of the upstream LLMs carry extra terms of service is **unverified**.

---

## 5. Blueprint tools

- **leanblueprint** (Massot) is a plasTeX plugin, `pip install leanblueprint`. LaTeX macros:
  - `\lean{decl}` gives the Lean names for a statement;
  - `\leanok` marks it formalised;
  - `\uses{label}` adds dependency-graph edges;
  - `\notready`, `\mathlibok`, ….

  Commands: `leanblueprint new|pdf|web|checkdecls|all|serve`. The web output has a dependency graph via `plastexdepgraph`. The PDF lands at `https://user.github.io/repo/blueprint.pdf`. Apache-2.0, 408 stars, last push 2025-12-23. Used by Sphere Eversion, the Liquid Tensor Experiment, FLT-regular, PFR, PrimeNumberTheoremAnd, FLT, Carleson, Sphere Packing, …. Sources: https://github.com/PatrickMassot/leanblueprint ; Tao's tour of the PFR blueprint: https://terrytao.wordpress.com/2023/11/18/formalizing-the-proof-of-pfr-in-lean4-using-blueprint-a-short-tour/
- **checkdecls** (Massot) is a tiny Lean executable. It reads a file of declaration names, imports the workspace's root libraries, and prints "`X is missing.`" for any name with `¬ env.contains`. `leanblueprint checkdecls` uses it in CI so that `\lean{…}` names cannot rot. Apache-2.0, last push 2025-04-02. **This is exactly the pattern the handbook needs for its own `\lean{}`-style references.** Source: https://github.com/PatrickMassot/checkdecls/blob/master/Main.lean
- **How PFR/FLT/Carleson link to Lean:** each blueprint node's `\lean{}` names point to the project's doc-gen4 site. FLT publishes `https://imperialcollegelondon.github.io/FLT/blueprint.pdf` (dated 2026-11-18 per search) and web blueprints with links to docs. Repos: https://github.com/teorth/pfr (last push 2026-11-23), https://github.com/ImperialCollegeLondon/FLT (1,066 stars, v4.35.0), https://github.com/fpvandoorn/carleson (v4.36.0-rc1).
- **Verso Blueprint** (`leanprover/verso-blueprint`) writes blueprints in Verso. It combines informal exposition, links to local or existing Lean declarations, automatic progress tracking (including `sorry`), dependency graphs, and HTML with previews and exported metadata (`lake exe vbp build`, `lake exe vbp query work-queue|metadata`). Reference ports: `ejgallego/verso-flt` and `ejgallego/verso-sphere-packing` on Lean v4.35.0. Carleson is out of the published catalogue while it needs the retired 4.34 line. No licence file (GitHub `license` null). Last push 2026-11-25. Source: https://github.com/leanprover/verso-blueprint
- **Verso Manual genre and templates.** `verso-templates` has starters for books and blogs (https://github.com/leanprover/verso-templates). The Phrasebook uses the "Verso textbook template" (Phrasebook README).

---

## 6. Book build tooling (PDF + EPUB with mathematics and Lean code)

### Verso

- **Verso** (https://github.com/leanprover/verso): Apache-2.0, 416 stars, `v4.37.0-rc1` (2026-11-18), last push 2026-11-26. Its README lists the genres it targets: instructional books (TPIL, FP in Lean, MIL), the Lean reference manual, blueprints, websites and papers. It is "usable for running a website and blog and for writing long-form technical documentation".
- Output: the Manual genre emits `html-multi` and `html-single`, and **TeX via `--with-tex`** (also `--twoside`, `--draft`, `--with-word-count`), per the `VersoManual.lean` CLI (https://github.com/leanprover/verso/blob/main/src/verso-manual/VersoManual.lean). Highlighted Lean is converted to TeX by `Verso/Code/HighlightedToTex.lean`, with keywords in `\textbf` and variables in `\textit` and no minted or shell-escape (https://github.com/leanprover/verso/blob/main/src/verso/Verso/Code/HighlightedToTex.lean). Maths is rendered by KaTeX in HTML.
- **No EPUB output** was found in the Verso tree. A grep of 1,011 paths for "epub" returned nothing. The Lean FRO roadmap describes Verso as producing "PDFs and interactive web pages from a single literate source" (https://lean-lang.org/fro/roadmap/y4-1/). Verso tags track Lean releases (README).
- Pros: every Lean snippet is elaborated, hovers and links to docs come built in, and it is the community standard (TPIL, FP-Lean and the Reference all use it; the MIL source is moving to it, **unverified**). Cons: EPUB would need a custom genre or post-processing of `html-single`. The build is tied to the Lean toolchain. Prose in Lean files is awkward for an AI-writer pipeline.

### SubVerso

https://github.com/leanprover/subverso: Apache-2.0, last push 2026-11-24.

- It extracts **highlighting information**: tokens with kinds, hover types and docstrings, and constant links. It works from ordinary Lean modules, using anchors (`-- ANCHOR: A` … `-- ANCHOR_END: A`).
- CI covers "every Lean release since 4.0.0". The `no-modules` branch is for Lean < 4.25.0.
- The data format is "an implementation detail, not a public API", so read it through SubVerso itself.

**This is the right way to take checked code from `mathlib-lean` into any renderer.** Elaborate the module, export the highlighted JSON for each anchor, then convert it to LaTeX or HTML in Go or in a Lean helper.

### Pandoc + LaTeX (Tectonic)

- `--pdf-engine` accepts `pdflatex, lualatex, xelatex, latexmk, tectonic` (https://pandoc.org/MANUAL.html).
- EPUB: `--math-method` defaults to `mathml`, which is "supported natively by the main web browsers and most e-book readers" (same page). EPUB 3 supports MathML.
- Syntax highlighting: `--syntax-definition` loads a **KDE XML syntax definition**. `--listings` is deprecated, and the listings package "does not support multi-byte encoding". Pandoc's skylighting ships **no Lean grammar**: `skylighting-core/xml` has agda, haskell and idris but no lean (https://github.com/jgm/skylighting/tree/master/skylighting-core/xml). Neither does KDE syntax-highlighting (`data/syntax` has `agda.xml` but no Lean, via the invent.kde.org API, 2026-11-26). **A `lean4.xml` KDE grammar must be written**: small, about 100 keywords plus Unicode, and reusable for HTML, EPUB and LaTeX.

### LaTeX without shell-escape

- `listings` with a Lean language definition. The classic `lstlean.tex` (Avigad 2015, Lean 2/3 keywords, Unicode via `literate=`) is still copied into Lean 4 papers, e.g. https://github.com/fpvandoorn/carleson/blob/master/paper/lstlean.tex and https://github.com/digama0/lean-type-theory. It needs Lean 4 keywords added, and is fragile with Unicode under pdflatex; use LuaLaTeX or XeLaTeX.
- Alternatively, emit `fancyvrb`/`\textbf` markup straight from SubVerso tokens, as Verso does. That is semantic (it knows constants from variables), works without shell-escape, and is robust. **Recommended.**
- minted needs Pygments and `-shell-escape`. Pygments does have a Lean lexer (**unverified** quality for Lean 4).

### Quarto and mdBook

- Quarto books output HTML, PDF, Typst, Word, EPUB and more. EPUB `html-math-method: mathml` is documented (https://quarto.org/docs/reference/formats/epub.html, https://quarto.org/docs/books/). Quarto is pandoc underneath, so it has the same Lean-grammar gap.
- **mdBook** has no built-in PDF. It needs third-party backends: mdbook-pdf (headless Chrome), mdbook-pandoc (LaTeX PDF and EPUB), mdbook-typst, mdbook-epub (https://github.com/rust-lang/mdBook/issues/815, https://lib.rs/crates/mdbook-pandoc).

**Suggested pipeline for the handbook.** Write the source in Markdown with LaTeX maths. The Go tool `mathlib-agent` assembles chapters, and Lean snippets come by anchor from `mathlib-lean`. Highlighting comes from SubVerso JSON, converted to:

- LaTeX macros, fed to pandoc → LuaLaTeX or Tectonic → PDF;
- HTML spans, fed to pandoc → EPUB3 with MathML.

Ship a custom `lean4.xml` KDE grammar as a fallback for code that is not checked. Keep a Verso build as an optional third output, for an interactive web edition, if the team wants hovers.

---

## 7. Licences

- **Mathlib** is Apache-2.0. The LICENSE is at the repo root and there is **no NOTICE file** (root listing 2026-11-26). Each file header says "Released under Apache 2.0 license as described in the file LICENSE." (https://github.com/leanprover-community/mathlib4/blob/master/LICENSE). Batteries, doc-gen4, Verso, SubVerso, import-graph, Loogle, jixia, LeanSearch and LeanExplore code are Apache-2.0 too. LeanDojo is MIT.
- **What Apache-2.0 requires when you redistribute the Work or derivative works "in any medium"** (§4): (a) give recipients a copy of the licence; (b) modified files carry prominent change notices; (c) keep copyright, patent, trademark and attribution notices; (d) include NOTICE contents, if there is a NOTICE, and there is none. You may add your own copyright statement and license your *modifications* differently (§4, last paragraph). Source: https://www.apache.org/licenses/LICENSE-2.0
- **Quoting Mathlib statements and docstrings in a CC BY 4.0 book.** The book's own prose can be CC BY 4.0. Verbatim Mathlib code and docstrings stay under Apache-2.0, and that is compatible in practice:
  - add a front-matter notice: "Lean code and docstrings quoted from Mathlib © the Mathlib contributors, Apache-2.0, <commit SHA>";
  - include or link the Apache-2.0 text;
  - keep author attributions (Mathlib's `CITATION.md` and file headers);
  - mark quoted code distinctly, for example a licence note per code-listing style;
  - state in the book's LICENSE file that "CC BY 4.0 applies to the text except quoted Mathlib material, which is under Apache-2.0".

  Short quotations of signatures are arguably not even copyrightable, or fall under quotation exceptions (**legal opinion, unverified**). The precedents are MIL itself (text CC BY 4.0, Lean code Apache-2.0, https://leanprover-community.github.io/mathematics_in_lean/) and FP in Lean (CC BY 4.0 text, https://github.com/leanprover/fp-lean).
- **Third-party texts:** Mechanics of Proof is "All rights reserved", so do not copy from it. The Phrasebook and verso-blueprint have **no licence file**; treat them as all rights reserved until one is added. The TPIL and Reference repos are Apache-2.0. MIL text is CC BY 4.0, so it can be adapted with attribution.
- **Datasets:** the FrenzyMath HF datasets are Apache-2.0. Lean Workbook data is Apache-2.0 (its paper is CC BY-NC-ND, which does not affect the data). LeanExplore data licence: **unverified**.
- **AI-written text:** copyrightability and ToS for LLM output differ by provider and jurisdiction (**unverified, outside scope**). Practical rule: every chapter goes through human review and is credited to its human editors.

---

## Implications for the handbook project

### Reuse (don't build)

1. **Declaration map, tier 0.** Download `header-data.bmp` (62 MB gz / 1.2 GB raw) and `declaration-data.bmp` (5.9 MB gz) from the live docs every release. Together they give name, kind, docstring, HTML signature, SHA-pinned source range, module, import graph and instances for all of the roughly 332k Mathlib declarations, with no Lean build. `mathlib-agent` (Go) can stream-parse them.
2. **Per-module prose.** Module docstrings (`/-! -/`, with their "Main definitions / Main results" sections) and the ~35 library notes are the natural skeleton for each handbook section.
3. **Curriculum skeleton.** `docs/overview.yaml`, `undergrad.yaml`, `100.yaml` and `1000.yaml` (topic → declaration lists), plus `scripts/topological_sort.py` and `lake exe graph` for chapter order.
4. **External anchors.** `crossrefs.json` (Stacks and Wikidata tags), to cite the Stacks Project and to cross-check that the handbook's maths names are right.
5. **Seed informalisations.** The LeanSearch v2 JSONL (Apache-2.0, v4.28.0-rc1), for clustering, glossary and first-draft one-liners only. Runtime lookup for writers: LeanSearch `POST /search`, Loogle `/json`, and the LeanExplore MCP or plugin.
6. **Verification.** In core Lean: `lake env leanchecker`, `lake check`/`lake comparator` (≥ v4.35), and `#print axioms` for `mathlib-lean`. A `checkdecls`-style job for every Lean name cited in the book.
7. **Highlighting.** SubVerso anchors and highlight JSON for checked snippets. Verso's `HighlightedToTex` as a reference design for LaTeX output.
8. **Style precedents.** MIL (CC BY 4.0) for pedagogy. Tao's Analysis I companion for the "book + Lean exercises with `sorry`" format. The Phrasebook for what *not* to duplicate. Link to it rather than repeat its how-tos.

### Build

1. **`mathlib-agent` extractor.** Wraps tier 0 and adds a tier-1 Lean helper (in `mathlib-lean`) that dumps JSONL with types, docstrings, ranges, attributes, `deprecated→newName` and **dependency edges** (used constants in type and value). None of the public sources give a clean edge list plus docstrings in one stable format. doc-gen4's SQLite DB is close, but it is not published and its types are BLOBs.
2. **A stable ID and rename layer.** Key each declaration by `(name, module, sha, range)`. On every Mathlib bump, diff the maps and follow `@[deprecated]` aliases (`Lean.Linter.getDeprecatedNewName`) to repoint references automatically. Flag removed names.
3. **Coverage tracker.** Map every declaration to a handbook section with a status: `explained` / `mentioned-in-table` / `api-lemma-auto-listed` / `not-yet`. Most of the 247k theorems should be auto-listed in "API tables", not given prose.
4. **Lean-aware book toolchain.** Markdown + LaTeX maths → pandoc → LuaLaTeX/Tectonic PDF and EPUB3 + MathML. A custom KDE `lean4.xml` grammar. A SubVerso-to-LaTeX/HTML converter for checked snippets. Optionally a Verso web edition later.
5. **Writer and reviewer harness.** Prompts get the section's declarations, module docstrings, source excerpts and seed informalisations. Outputs must cite exact Lean names, which `checkdecls` validates. Every example in the text must exist as an anchored, compiled snippet in `mathlib-lean`.

### Risks

- **Scale.** About 332k Mathlib declarations, ~8.7k modules, and 8.4M dependency edges (per arXiv 2604.24797). "Explain ALL of Mathlib" has to mean *every important* definition and theorem, with the rest auto-tabulated. Otherwise the project will not finish.
- **Churn and renames.** Mathlib releases roughly monthly (v4.36.0 on 2026-11-16; `master` already on v4.37.0-rc1), and names are deprecated and moved all the time, which is why there is a deprecation system (Springer "Growing Mathlib"). Each volume must pin a Mathlib SHA and rerun `checkdecls` and the `mathlib-lean` build per release.
- **Toolchain lock-step.** jixia, Loogle, LeanDojo, Pantograph and Lean Finder all lag Mathlib by several versions (jixia's last release is v4.28.0-rc1; LeanDojo is deprecated at v4.20). Depend only on core Lean APIs plus doc-gen4 JSON, which follow Mathlib on every build.
- **Format instability.** doc-gen4 just moved to SQLite; the `.bmp` JSON shape, the SubVerso data format ("not a public API") and Loogle JSON ("No stability … guaranteed") can all change. Isolate them behind adapters with fixture tests.
- **AI-written explanations.** Errors in the maths, in Lean names, and in the mismatch between Mathlib's generality and the textbook statement (typeclass assumptions, junk values such as `x/0 = 0`, `Nat` subtraction). Every chapter needs expert human review, a mechanical check of names and snippets, and a correction process. The informalisation datasets contain unreviewed LLM text and must not go into the book verbatim.
- **Overlap and community perception.** The Phrasebook, MIL and the Mathlib Initiative's documentation work (D3) are active. Position the handbook as a complement: explanatory and textbook-like, linking out to MIL and the Phrasebook. Coordinate on Zulip, so it is not seen as an AI-generated duplicate.
- **Licensing.** Keep quoted Mathlib material clearly marked as Apache-2.0. Don't draw on Mechanics of Proof, the Phrasebook or verso-blueprint text (no licence or all rights reserved). Attribute any adapted MIL text (CC BY 4.0).
- **Build cost.** Building docs locally is optional thanks to the live JSON. Building `mathlib-lean` against each Mathlib needs the Mathlib cache (several GB, **unverified**). A full doc-gen4 run takes about 24 min on the community's dedicated runner and hours on a cold machine.
