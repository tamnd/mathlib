# 08. Architecture

## 8.1 The four repositories

| Repository | Content | Language | Licence |
|---|---|---|---|
| `tamnd/mathlib` | the map: the volume map, the section plan, the family records, the depth overrides, the records that tools write (index summaries, coverage, drift, editions), the paper and book records, the spec, the site sources | YAML, JSON, Markdown | CC BY 4.0 for text, CC0 for records |
| `tamnd/mathlib-lean` | the Lean package `MathlibHandbook`: the checked examples, the exercises and their solutions, the extraction programs (index, families, signatures, highlighting), the bump workflow | Lean 4 | Apache-2.0 |
| `tamnd/mathlib-agent` | `mlib`, the toolchain: index, sync, coverage, queue, roles, site | Go | MIT |
| `tamnd/mathlib-handbook` | the text of the volumes and `mlhb`, the builder of PDF, EPUB and HTML | Markdown, Python, Lua, LaTeX | CC BY 4.0 for text, MIT for the builder |

The names follow the sibling projects: tamnd/singularity with singularity-lean, singularity-agent and singularity-handbook, and tamnd/mmp with mmp-lean, mmp-agent and mmp-handbook. Three facts differ.
- `tamnd/mathlib` is not a fork of `leanprover-community/mathlib4`. Its README says so in its first line. Q-01 (16) asks whether the name confuses users of GitHub search, and gives `tamnd/mathlib-map` as the fallback.
- The Lean root is `MathlibHandbook`, never `Mathlib`. A second root named `Mathlib` cannot share a workspace with Mathlib.
- The commands are `mlib` (agent) and `mlhb` (handbook builder). `mhb` is taken by mmp-handbook. Q-02 records the alternatives.

The site is `mathlib.tamnd.com` (13).

## 8.2 The data flows

```
leanprover-community/mathlib4 (master, tags)
        │  daily: lake update; lake exe cache get; lake build
        ▼
tamnd/mathlib-lean ── scripts/Index.lean ─► index-<commit>.jsonl.zst  (every declaration)
        │             scripts/Families.lean ─► families-<commit>.json
        │             scripts/Highlight.lean ─► hl-<commit>/ (SubVerso JSON of examples)
        │             lake build MathlibHandbook ─► build log, axioms of examples
        ▼
tamnd/mathlib-agent: mlib sync ──────► tamnd/mathlib records/: drift/<date>.json, depth.json,
        │                                coverage.json, editions.json, queue state
        │  mlib queue / mlib agent run <role>
        ▼
roles (informalizer, writer, exampler, exerciser, checker, refresher)
        │  pull requests to mathlib-handbook, mathlib-lean, mathlib (informal records)
        ▼
people review  ──►  tamnd/mathlib-handbook: mlhb check; mlhb build ─► PDF, EPUB, HTML
        │
        ▼
mlib site build ─► mathlib.tamnd.com  (edge: daily; edition: monthly)
GitHub releases ─► the books of each edition
```

## 8.3 The six flows

1. **Bump.** A daily workflow in `tamnd/mathlib-lean` moves the Mathlib dependency to the head of `master`, builds the package, and runs the extraction programs. It opens a pull request with the new manifest and a summary of the drift (05.3). The pull request merges by itself when the build is green and the drift has no `breaking` item. Otherwise the refresher role works on it.
2. **Sync.** `mlib sync` reads the new index and the last one, writes the drift record, recomputes the depth and the coverage, and marks the affected sections `stale` in a pull request to the handbook (05.5).
3. **Write.** `mlib queue` ranks the work of each role (11.5). `mlib agent run` runs one role on one item and records the run. Each run gives a pull request. A run never pushes to `main`.
4. **Check.** Each pull request runs the mechanical checks: `lake build` for Lean, `mlhb check` for text, `mlib check` for records. The checker role reads the text against the declarations (14.2).
5. **Review.** A person reads a section and sets `reviewed`. The site shows who reviewed what (13).
6. **Release.** On the first business day after each Mathlib tag, the edition workflow (05.6) builds all volumes against the tag, publishes the GitHub releases of the volumes that pass the release rule, and publishes the edition of the site.

## 8.4 Where the big data lives

The index of every declaration is too large for git: several hundred thousand records with types and docstrings, about 0.5 to 1 GB as JSON, about 60 to 120 MB compressed [U, measured at M0]. So:
- each index is an asset of a GitHub release of `tamnd/mathlib`, named `index-<date>-<commit>`, compressed with zstd, with a SHA-256 file;
- git holds only the summaries: `records/modules.json` (one row per module, with counts by kind and depth), `records/depth.json` (the depth of each declaration whose depth is not the default for its kind, keyed by name), and the drift records, which are small;
- the informal records (the E1 sentences, 09.3) are in git, as one JSONL file per home volume, so that people can review them in pull requests;
- the site reads the latest index asset at build time.

The doc-gen4 output of the Mathlib docs site is a second, cheap source (01.4). `declaration-data.bmp` (5.9 MB compressed) and `header-data.bmp` (62 MB compressed) give every name, kind, docstring, signature as HTML and source link, and the Mathlib docs build refreshes them every 8 hours. `mlib index fetch -docgen` reads them with no Lean build. They have no type terms, no hashes, no deprecation targets and no uses graph, so the project's own index (10.5) is still the source of the drift. The doc-gen4 data is the fallback for a day on which the index program fails (05.8), and the source of the links to the Mathlib documentation.

Q-06 asks whether to keep the indexes in a separate repository with Git LFS instead.

## 8.5 Shared code with the sibling projects

| Part | Source | Change |
|---|---|---|
| `mlhb` | `mhb` of mmp-handbook | adds the Mathlib boxes, the `<?decl?>` and `<?lean?>` directives, the reference tables, the coverage check, the Catalogue builder, the edition names |
| `mlib` | `mmp` of mmp-agent | drops the audit, claim and lab commands; adds `sync`, `coverage`, `family`, `informal`, `edition` |
| site | the site of mmp-agent | adds the declaration pages and the drift pages |
| Lean export | `scripts/Export.lean` of mmp-lean | widens from one namespace to the whole of Mathlib; adds docstrings, attributes, deprecation targets, type hashes and the uses graph |
| workflows | the build, check and scorecard workflows of the sibling repositories | adds the bump and edition workflows |
